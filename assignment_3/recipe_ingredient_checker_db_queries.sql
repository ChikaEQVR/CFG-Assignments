USE recipe_ingredient_checker_db;

-- Section A.
-- Use at least 5 queries to retrieve data.
-- Use at least 2 joins.
-- Use data sorting for majority of queries with ORDER BY.

-- 1. To see all the data in tables.
SELECT * FROM cookbooks;
SELECT * FROM ingredients;
SELECT * FROM ingredients_types;
SELECT * FROM recipes;
SELECT * FROM recipes_ingredients;
SELECT * FROM stocks;
SELECT * FROM units;

-- 2. To see a specific recipe with all its ingredients.
SELECT 
	r.recipe_name,
	i.ingredient_name 
FROM recipes r JOIN recipes_ingredients ri 
ON r.recipe_id = ri.recipe_id 
JOIN ingredients i 
ON ri.ingredient_id = i.ingredient_id 
WHERE r.recipe_name = 'tv chips'
ORDER BY r.recipe_name ASC, i.ingredient_name DESC
;

-- 3. To see if there are any meat recipes available.
SELECT 
	r.recipe_name,
	i.ingredient_name 
FROM recipes r JOIN recipes_ingredients ri 
ON r.recipe_id = ri.recipe_id 
JOIN ingredients i 
ON ri.ingredient_id = i.ingredient_id
WHERE i.ingredient_type_id = (
		SELECT it.ingredient_type_id 
		FROM ingredients_types it
		WHERE it.ingredient_type = 'meat')
;

-- 4. To see which recipes are from cookbook_id = 1
-- and find out the cookbook title and the chef's full name.
SELECT 
	r.recipe_name, 
	c.cookbook_title, 
	CONCAT(c.chef_first_name,' ',c.chef_last_name) AS chef_full_name
FROM cookbooks c JOIN recipes r 
ON c.cookbook_id = r.cookbook_id 
WHERE c.cookbook_id = 1
ORDER BY r.recipe_name DESC
;

-- 5. Do I have all the ingredients in stock to cook roast pork?
-- If not, what ingredients do I need to buy?
SELECT
	i.ingredient_name,
	IF(s.is_available = 1, "Yes", "Need to buy") AS ingredients_availability
FROM ingredients i JOIN recipes_ingredients ri
ON i.ingredient_id = ri.ingredient_id 
JOIN recipes r
ON ri.recipe_id = r.recipe_id 
JOIN stocks s
ON i.ingredient_id = s.ingredient_id 
WHERE r.recipe_name = 'roast pork'
ORDER BY ingredients_availability
;

-- 6. Find out all the recipes which need garlic cloves.
SELECT 
	r.recipe_name 
FROM recipes_ingredients ri LEFT JOIN ingredients i 
ON ri.ingredient_id = i.ingredient_id 
JOIN recipes r 
ON ri.recipe_id = r.recipe_id 
WHERE i.ingredient_name = 'garlic clove'
;

-- Section B.
-- Use at least 2 aggregate functions.

-- 1. Find out which recipe has the most ingredients.
SELECT 
	r.recipe_name,
	COUNT(ri.ingredient_id) AS total_ingredients
FROM recipes r JOIN recipes_ingredients ri 
ON r.recipe_id = ri.recipe_id 
GROUP BY r.recipe_id
ORDER BY total_ingredients DESC
LIMIT 1
;

-- 2. Find out recipes with less than 10 ingredients.
SELECT
	r.recipe_name,
COUNT(ri.ingredient_id) AS total_ingredients
FROM recipes r JOIN recipes_ingredients ri 
ON r.recipe_id = ri.recipe_id 
GROUP BY r.recipe_id
HAVING total_ingredients < 10
ORDER BY total_ingredients;

-- 3. Find out the total list of ingredients and quantity you need for recipe_id 2 and 4.
--    Also find out the recipe names.

/*
 * GROUP_CONCAT:
 * Aggregation function that combines data from multiple rows into a single string.
 * I needed this function to put multiple recipe names which have the same ingredients
 * when finding out the total quantities of ingredients from 2 recipes.
 * Also unit abbreviation sometimes different between recipes so I wanted to use for that too.
 */

SELECT 
	i.ingredient_name,
	SUM(ri.ingredient_quantity) AS total_qty,
	GROUP_CONCAT(DISTINCT u.unit_abbreviation) AS unit,
	GROUP_CONCAT(DISTINCT r.recipe_name) AS recipes
FROM ingredients i JOIN recipes_ingredients ri 
ON i.ingredient_id = ri.ingredient_id
JOIN units u
ON ri.unit_id = u.unit_id
JOIN recipes r 
ON r.recipe_id = ri.recipe_id
WHERE r.recipe_id = 2 OR r.recipe_id = 4
GROUP BY i.ingredient_type_id, i.ingredient_id;

-- 4. Find out the total list of ingredients and quantity you need for roast pork and baked fennel.
SELECT 
	i.ingredient_name, 
	SUM(ri.ingredient_quantity) AS total_ingredients_qty,
	GROUP_CONCAT(DISTINCT u.unit_abbreviation) AS unit, 
	GROUP_CONCAT(DISTINCT r.recipe_name) AS recipes
FROM recipes_ingredients ri JOIN ingredients i
ON ri.ingredient_id = i.ingredient_id 
JOIN units u
ON ri.unit_id = u.unit_id 
JOIN recipes r 
ON ri.recipe_id = r.recipe_id 
WHERE r.recipe_name = 'roast pork' OR r.recipe_name = 'baked fennel'
GROUP BY i.ingredient_id;

-- Section C.
-- Use at least 2 additional in-built functions.
-- (to the two aggregate functions already counted in previous point)

-- 1. What is the average number of ingredients in each recipe?
SELECT 
	CEILING(AVG(my_count)) AS average_number_of_ingedients	-- to round up the count and show intiger (note: round down is FLOOR())
FROM (
	SELECT COUNT(ingredient_id) AS my_count
	FROM recipes_ingredients
	GROUP BY recipe_id
	) AS my_table	-- neeed to have a temporary table name to complete the select statement
;

 -- Section D.
-- Data modification.
-- Use at least 1 query to delete data.

-- 1. Delete cookbook_id = 10 in cookbooks table.
DELETE FROM cookbooks
WHERE cookbook_id = 10;

-- 2. Update bread & worcestershire sauce quantity to 0 and stocks to not available. 
UPDATE stocks 
	SET 
		stock_quantity = 0, 
		is_available = 0
	WHERE ingredient_id IN (
		(
		SELECT ingredient_id
		FROM ingredients 
		WHERE ingredient_name = 'bread'
		),
		(
		SELECT ingredient_id
		FROM ingredients 
		WHERE ingredient_name = 'worcestershire sauce')
		)
;

-- Section E.
-- Extra queries to check if Section D.2 worked.

-- 1. Do I have all the ingredients in stock to cook baked beans on toast?
-- If not what ingredients do I need to buy?

SELECT 
	r.recipe_name,
	i.ingredient_name,
	CASE 
		WHEN s.is_available = 1 THEN 'Yes'
		WHEN s.is_available IS NULL THEN 'Need to buy'
		ELSE 'Need to buy'
	END AS ingredients_availability
FROM recipes r JOIN recipes_ingredients ri
ON r.recipe_id = ri.recipe_id
JOIN ingredients i 
ON ri.ingredient_id = i.ingredient_id 
JOIN stocks s
ON i.ingredient_id = s.ingredient_id 
WHERE r.recipe_name = 'baked beans on toast'
ORDER BY ingredients_availability;

-- Section F.
-- Create and use one stored procedure or function to achieve a goal.
/*
 * When I inserted additional data to add to the first set of data, 
 * I noticed I was using the same select statments 
 * so I decided to cerate the stored procedures which I can insert values into tables easily.
 */

-- 1. Create store procedure called InsertValuesIntoingredientsTable.
DELIMITER //

CREATE PROCEDURE InsertValuesIntoingredientsTable (
	IN p_ingredient_name VARCHAR(255),
	IN p_ingredient_type VARCHAR(255)
	)
BEGIN 
	INSERT INTO ingredients (ingredient_name, ingredient_type_id)
	VALUES (
		p_ingredient_name,
		(
		SELECT ingredient_type_id
		FROM ingredients_types
		WHERE ingredient_type = p_ingredient_type
		)
	);
END //

DELIMITER ;

-- To call InsertValuesIntoingredientsTable().
CALL InsertValuesIntoingredientsTable ('cheddar cheese','dairy');

-- To delete the procedure.
-- DROP PROCEDURE InsertValuesIntoingredientsTable;

-- To delete ingredient_id 87.
-- DELETE FROM ingredients 
-- WHERE ingredient_id = 87;

-- To reset the auto_increment number to start from 87 again in ingredients table.
-- ALTER TABLE ingredients AUTO_INCREMENT = 87;

-- To check if the stored procedure worked.
SELECT *
FROM ingredients
WHERE ingredient_name = 'cheddar cheese';

-- 2. Create store procedure called InsertRecipeNamePrepTimeCookingTimeIntoRecipesTable().
-- 	  excluding cooking date and coobook_id as it might be from not cookbook or cooking date not decided.
DELIMITER //

CREATE PROCEDURE InsertRecipeNamePrepTimeCookingTimeIntoRecipesTable (
	IN p_recipe_name VARCHAR(255),
	IN p_prep_time TIME,
	IN p_cooking_time TIME
	)
BEGIN
	INSERT INTO recipes (recipe_name, prep_time, cooking_time)
	VALUES 
		(p_recipe_name, p_prep_time, p_cooking_time);
END //

DELIMITER ;

-- To call InsertRecipeNamePrepTimeCookingTimeIntoRecipesTable().
CALL InsertRecipeNamePrepTimeCookingTimeIntoRecipesTable ('baked potato', '00:01:00', '01:00:00');

-- To check if the stored procedure worked.
SELECT *
FROM recipes
WHERE recipe_name = 'baked potato';

-- 3. Create stored procedure called InsertValuesIntoRecipesIngredientsTable to insert values into recipes_ingredients.
DELIMITER //

CREATE PROCEDURE InsertValuesIntoRecipesIngredientsTable (
	IN p_recipe_name VARCHAR(255),
	IN p_ingredient_name VARCHAR(255),
	IN p_quantity DECIMAL(10,2),
	IN p_unit_abbreviation CHAR(5)
	)
BEGIN 
	INSERT INTO recipes_ingredients (recipe_id, ingredient_id, ingredient_quantity, unit_id)
	VALUES 
		(
			(
			SELECT recipe_id
			FROM recipes
			WHERE recipe_name = p_recipe_name
			),
			(
			SELECT ingredient_id
			FROM ingredients 
			WHERE ingredient_name = p_ingredient_name
			),
			p_quantity,
			(
			SELECT unit_id
			FROM units 
			WHERE unit_abbreviation = p_unit_abbreviation
			)
		);
END //

DELIMITER ;

-- To call InsertValuesIntoRecipesIngredientsTable().
CALL InsertValuesIntoRecipesIngredientsTable ('baked potato', 'potato', 1, 'each');
CALL InsertValuesIntoRecipesIngredientsTable ('baked potato', 'baked beans', 0.5, 'tin');
CALL InsertValuesIntoRecipesIngredientsTable ('baked potato', 'cheddar cheese', 15, 'g');

-- To check if the stored procedure worked.
SELECT *
FROM recipes_ingredients
WHERE recipe_id = (
	SELECT recipe_id 
	FROM recipes
	WHERE recipe_name = 'baked potato'
	)
;
