/*
 * -- Provide a creative scenario of use
 * *** Scenario ***
 * 
 * Database called recipe_ingredient_checker_db was created to check if there are the recipe's ingredients at home or not.
 * Also to find out about the recipes.
 * 
 * Submitting 9 files in total as below:
 * Files for recipe_ingredient_checker_db:
 * file 1: recipe_ingredient_checker_db.sql for crating database and tables
 * file 2: recipe_ingredient_checker_db_queries.sql for 
 * 
 * CSV files used to import data into some tables created in the database.
 * file 3: ingredients_table.csv
 * file 4: recipes_table.csv 
 * file 5: recipes_ingredients_table.csv
 * file 6: stocks_table.csv
 * 
 * Supporting files
 * file 7: recipe_ingredient_checker_old.png - This is old database diagram I initially created.
 * file 8: recipe_ingredient_checker_db.png - This is the final database diagram.
 * file 9: assignment3_recipe_ingredient_checker_database.xlsx - To prepare the database and work on data normalisation.
 *
 */

-- Normalise the database by splitting the data out in tables where appropriate and not containing any duplicate data.
/*
 * I have created a different db but realised the table was not normalised enough so I created the new db I am submitting.
 * The database diagrams are available for old and final databases in separate files.
 * The names of the files:
 * recipe_ingredient_checker_old.png
 * recipe_ingredient_checker_db.png
 * 
 * You can also see how data was prepared in the excel file 'assignment3_recipe_ingredient_checker_database.xlsx'.
 */

-- Keep in your code all commands you used to set up your database, tables and all demo queries.
-- You can comment out queries you do not want to be auto run.

-- 1. Create database with at least 3 tables with several columns, use good naming conventions.

CREATE DATABASE recipe_ingredient_checker_db;

USE recipe_ingredient_checker_db;

-- 2. Create tables.
-- Link tables using primary and foreign keys effectively.
-- Use at least 3 different data types while creating tables.
-- Use at least 2 constraints while creating tables, not including primary key or foreign key.

CREATE TABLE cookbooks (
	cookbook_id INT AUTO_INCREMENT PRIMARY KEY,
	cookbook_title VARCHAR(255),
	chef_first_name VARCHAR(255),
	chef_last_name VARCHAR(255),
	published_date DATE
);

CREATE TABLE ingredients_types (
	ingredient_type_id INT AUTO_INCREMENT PRIMARY KEY,
	ingredient_type VARCHAR(255) NOT NULL,
	CONSTRAINT uc_ingredients_types
	UNIQUE (ingredient_type)  -- setting the unique constraint to avoid duplicate item entries
);

CREATE TABLE units (
	unit_id INT AUTO_INCREMENT PRIMARY KEY,
	unit_abbreviation CHAR(5) NOT NULL,
	CONSTRAINT uc_units
	UNIQUE (unit_abbreviation)	-- setting the unique constraint to avoid duplicate item entries
);

CREATE TABLE ingredients (
	ingredient_id INT AUTO_INCREMENT PRIMARY KEY,
	ingredient_name VARCHAR(255) NOT NULL,
	ingredient_type_id INT,
	CONSTRAINT uc_fk_ingredients
	UNIQUE (ingredient_name),	-- setting the unique constraint to avoid duplicate item entries
	FOREIGN KEY (ingredient_type_id) REFERENCES ingredients_types(ingredient_type_id)	
);

CREATE TABLE recipes (
	recipe_id INT AUTO_INCREMENT PRIMARY KEY,
	recipe_name VARCHAR(255) NOT NULL,
	prep_time TIME,
	cooking_time TIME,
	cooking_date DATE,
	cookbook_id INT,
	CONSTRAINT fk_recipes
	FOREIGN KEY (cookbook_id) REFERENCES cookbooks(cookbook_id)
);

CREATE TABLE recipes_ingredients (
	recipe_id INT NOT NULL,
	ingredient_id INT NOT NULL,
	ingredient_quantity DECIMAL(10,2) NOT NULL,
	unit_id INT NOT NULL,
CONSTRAINT fk_recipes_ingredients
FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id),
FOREIGN KEY (ingredient_id) REFERENCES ingredients(ingredient_id),
FOREIGN KEY (unit_id) REFERENCES units(unit_id)
);

CREATE TABLE stocks (
	stock_id INT AUTO_INCREMENT PRIMARY KEY,
	ingredient_id INT NOT NULL,
	stock_quantity DECIMAL(10,2),
	unit_id INT NOT NULL,
	is_available BOOLEAN,
	CONSTRAINT fk_stocks
	FOREIGN KEY (ingredient_id) REFERENCES ingredients(ingredient_id),
	FOREIGN KEY (unit_id) REFERENCES units(unit_id)
);

-- 3. Insert values into tables.
-- Populate the database with at least 8 rows of mock data per table.
-- The data does not need to be real or accurate.
-- Use at least 3 queries to insert data.

-- Not including primary keys as it will be auto_cremated
INSERT INTO cookbooks (
	cookbook_title, chef_first_name, chef_last_name, published_date
	)
VALUES 
	('ottolenghi test kitchen', 'yotam', 'ottolenghi', '2021-10-14'),
	('ottolenghi simple', 'yotam', 'ottolenghi', '2018-10-04'),
	('mezcla', 'ixta', 'belfrage', '2022-07-14'),
	('taverna', 'georgina', 'hayden', '2023-06-22'),
	('basics to brilliance kids', 'donna', 'hay', '2018-10-18'),
	('stirring slowly', 'georgina', 'hayden', '2023-03-02'),
	('james every day', 'james', 'martin', '2017-09-07'),
	('from the oven to the table', 'diana', 'henry', '2019-09-05'),
	('delias happy christmas', 'delia', 'smith', '2009-10-01')
;

ALTER TABLE ingredients AUTO_INCREMENT = 1; -- to reset increment number to start from 1

INSERT INTO ingredients_types (ingredient_type)
VALUES
	('meat'),
	('seafood'),
	('vegetables'),
	('fruits'),
	('grains'),
	('dairy'),
	('herbs'),
	('spices'),
	('oils & fats'),
	('condiments'),
	('nuts & seeds'),
	('seasoning'),
	('others')
;

INSERT INTO units (unit_abbreviation)
VALUES 
	('g'),
	('kg'),
	('ml'),
	('l'),
	('tsp'),
	('tbsp'),
	('each'),
	('clove'),
	('piece'),
	('tin'),
	('bunch')
;

-- The rest of the tables had large data so I created CSV files from excel and imported values into each tables.
-- The csv files were created from the excel file 'assignment3_recipe_ingredient_checker_database.xlsx'.
/* 
 * The names of the files used
 * ingredients_table.csv
 * recipes_table.csv 
 * recipes_ingredients_table.csv
 * stocks_table.csv
 */

-- 4. Additional insert queries after creating tables and inserting first set of data.

INSERT INTO ingredients (ingredient_name, ingredient_type_id)
VALUES ('baked beans', 10);

INSERT INTO ingredients (ingredient_name, ingredient_type_id)
VALUES 
	('worcestershire sauce', 10),
	('bread',5);

-- continue to do from here change column names
INSERT INTO recipes (recipe_name, prep_time, cooking_time, cooking_date)
VALUES 
	('baked beans on toast', '00:01:00', '00:03:00', DATE(NOW()));

INSERT INTO recipes_ingredients (recipe_id, ingredient_id, ingredient_quantity, unit_id)
VALUES 
	(
		(
		SELECT recipe_id
		FROM recipes
		WHERE recipe_name = 'baked beans on toast'
		),
		(
		SELECT ingredient_id
		FROM ingredients 
		WHERE ingredient_name = 'baked beans'
		),
		0.5,
		(
		SELECT unit_id
		FROM units 
		WHERE unit_abbreviation = 'tin'
		)
	),
	(
		(
		SELECT recipe_id
		FROM recipes
		WHERE recipe_name = 'baked beans on toast'
		),
		(
		SELECT ingredient_id
		FROM ingredients 
		WHERE ingredient_name = 'worcestershire sauce'
		),
		0.5,
		(
		SELECT unit_id
		FROM units 
		WHERE unit_abbreviation = 'tsp'
		)
	),
	(
		(
		SELECT recipe_id
		FROM recipes
		WHERE recipe_name = 'baked beans on toast'
		),
		(
		SELECT ingredient_id
		FROM ingredients 
		WHERE ingredient_name = 'bread'
		),
		1,
		(
		SELECT unit_id
		FROM units 
		WHERE unit_abbreviation = 'piece'
		)
	)
;


INSERT INTO stocks (ingredient_id, stock_quantity, unit_id, is_available)
VALUES 
	(
		(	
		SELECT ingredient_id
		FROM ingredients 
		WHERE ingredient_name = 'bread'
		),
		20,
		(
		SELECT unit_id 
		FROM units 
		WHERE unit_abbreviation = 'piece'
		),
		1
	),
	(
		(	
		SELECT ingredient_id
		FROM ingredients 
		WHERE ingredient_name = 'baked beans'
		),
		2,
		(
		SELECT unit_id 
		FROM units 
		WHERE unit_abbreviation = 'tin'
		),
		1
	),
	(
		(	
		SELECT ingredient_id
		FROM ingredients 
		WHERE ingredient_name = 'worcestershire sauce'
		),
		50,
		(
		SELECT unit_id 
		FROM units 
		WHERE unit_abbreviation = 'tsp'
		),
		1
	)	
;

INSERT INTO cookbooks (cookbook_title, chef_first_name, chef_last_name)
VALUES ('greekish', 'georgina', 'hayden');