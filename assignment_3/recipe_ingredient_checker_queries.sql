USE recipe_ingredient_checker;

-- Use at least 5 queries to retrieve data
-- Use at least 2 joins
-- Use data sorting for majority of queries with ORDER BY

-- 1. to see all the data in tables
SELECT * FROM cookbooks;
SELECT * FROM ingredients;
SELECT * FROM recipes;
SELECT * FROM stocks;

-- 2. to see a recipe with all the ingredients
SELECT 
	r.recipe_name,
	i.ingredient_name
FROM recipes r JOIN ingredients i 
ON r.ingredient_id = i.ingredient_id
GROUP BY r.recipe_id 
ORDER BY r.recipe_name, i.ingredient_name; -- not writing ASC as it is default setting 

-- 3. to see see if there is a meat recipe availabe
SELECT 
	r.recipe_name, 
	i.ingredient_name, 
	it.ingredient_type 
FROM recipes r JOIN ingredients i
ON r.ingredient_id = i.ingredient_id 
JOIN ingredients_types it 
ON i.ingredient_type_id = it.ingredient_type_id
WHERE i.ingredient_type_id = 
	(SELECT it.ingredient_type_id
	FROM ingredients_types it
	WHERE it.ingredient_type = 'meat');

-- 4. to see which recipe is from which cookbook
SELECT DISTINCT 
	r.recipe_name, 
	c.cookbook_title, 
	CONCAT(c.chef_first_name,' ',c.chef_last_name) AS chef_full_name
FROM cookbooks c JOIN recipes r 
ON c.cookbook_id = r.cookbook_id 
WHERE c.cookbook_id = 1

-- 5. Do I have all the ingredients in stock to make TV chips?
-- If not what ingredients do I need to buy?
SELECT 
	r.recipe_name,
	i.ingredient_name,
	IF(s.is_available = 1, 'Yes','Need to buy') AS stock_availability 
FROM recipes r LEFT JOIN ingredients i 
ON r.ingredient_id = i.ingredient_id 
LEFT JOIN stocks s
ON i.ingredient_id = s.ingredient_id 
WHERE r.recipe_name = 'baked beans on toast'
ORDER BY ingredient_name DESC;



-- Use at least 1 query to delete data

-- Use at least 2 aggregate functions

-- Use at least 2 additional in-built functions 
-- (to the two aggregate functions already counted in previous point)



-- Create and use one stored procedure or function to achieve a goal


-- Provide a creative scenario of use