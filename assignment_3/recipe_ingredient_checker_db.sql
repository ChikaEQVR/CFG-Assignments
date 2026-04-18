-- Normalise the database by splitting the data out in tables where appropriate and not containing any duplicate data.

-- Keep in your code all commands you used to set up your database, tables and all demo queries.
-- You can comment out queries you do not want to be auto run

-- Create database with at least 3 tables with several columns, use good naming conventions

CREATE DATABASE recipe_ingredient_checker;

USE recipe_ingredient_checker;

-- Link tables using primary and foreign keys effectively
-- Use at least 3 different data types while creating tables
-- Use at least 2 constraints while creating tables, not including primary key or foreign key

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
	UNIQUE (ingredient_type)
);

CREATE TABLE units (
	unit_id INT AUTO_INCREMENT PRIMARY KEY,
	unit_abbreviation CHAR(5) NOT NULL,
	CONSTRAINT uc_units
	UNIQUE (unit_abbreviation)
);

CREATE TABLE ingredients (
	ingredient_id INT AUTO_INCREMENT PRIMARY KEY,
	ingredient_name VARCHAR(255) NOT NULL,
	ingredient_type_id INT,
	CONSTRAINT uc_fk_ingredients
	UNIQUE (ingredient_name),
	FOREIGN KEY (ingredient_type_id) REFERENCES ingredients_types(ingredient_type_id)	
);

CREATE TABLE recipes (
	recipe_id INT AUTO_INCREMENT PRIMARY KEY,
	recipe_name VARCHAR(255) NOT NULL,
	ingredient_id INT NOT NULL,
	ingredient_quantity DECIMAL(10,2) NOT NULL,
	unit_id INT NOT NULL,
	prep_time TIME,
	cooking_time TIME,
	cooking_date DATE,
	cookbook_id INT,
	CONSTRAINT fk_recipes
	FOREIGN KEY (ingredient_id) REFERENCES ingredients(ingredient_id),
	FOREIGN KEY (unit_id) REFERENCES units(unit_id),
	FOREIGN KEY (cookbook_id) REFERENCES cookbooks(cookbook_id)
);

CREATE TABLE stocks (
	stock_id INT AUTO_INCREMENT PRIMARY KEY,
	ingredient_id INT NOT NULL,
	-- stock_name VARCHAR(255) NOT NULL,
	stock_quantity DECIMAL(10,2),
	unit_id INT NOT NULL,
	is_available BOOLEAN,
	CONSTRAINT fk_stocks
	-- UNIQUE (stock_name),
	FOREIGN KEY (ingredient_id) REFERENCES ingredients(ingredient_id),
	FOREIGN KEY (unit_id) REFERENCES units(unit_id)
);


-- Populate the database with at least 8 rows of mock data per table.
-- The data does not need to be real or accurate
-- Use at least 3 queries to insert data

-- Not including primary keys as it will be auto_cremated
INSERT INTO cookbooks (
	cookbook_title, chef_first_name, chef_last_name, published_date
	)
VALUES 
	('Ottolenghi Test Kitchen Shelf Love', 'Yotam', 'Ottolenghi', '2021-10-14'),
	('Ottolenghi SIMPLE', 'Yotam', 'Ottolenghi', '2018-10-04'),
	('MEZCLA', 'Ixta', 'Belfrage', '2022-07-14'),
	('Taverna', 'Georgina', 'Hayden', '2023-06-22'),
	('Basics To Brilliance Kids', 'Donna', 'Hay', '2018-10-18'),
	('Stirring Slowly', 'Georgina', 'Hayden', '2023-03-02'),
	('James Every Day', 'James', 'Martin', '2017-09-07'),
	('From The Oven To The Table', 'Diana', 'Henry', '2019-09-05'),
	('Delias Happy Christmas', 'Delia', 'Smith', '2009-10-01')
;

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

INSERT INTO ingredients (ingredient_name, ingredient_type_id)
VALUES 
	('onion',3),
	('garlic clove',3),
	('coriander',7),
	('berbere spice',8),
	('tomato paste',10),
	('honey',10),
	('apple cider vinegar',10),
	('olive oil',9),
	('carrots',3),
	('tinned chickpeas',10),
	('chicken thigh',1),
	('oranges',4),
	('salt',12),
	('black pepper',8),
	('salmon fillet',2),
	('zaatar',8),
	('sumac',8),
	('baby spinach',3),
	('tahini',10),
	('lemon juice',4),
	('basmati rice',5),
	('unsalted butter',6),
	('boiling water',13),
	('mint',7),
	('feta',6),
	('pitted green olives',13),
	('pomegranate seeds',4),
	('walnut',11),
	('pomegranate molasses',10),
	('cherry tomato',3),
	('shallots',3),
	('thyme',7),
	('cinnamon stick',8),
	('potato',3),
	('flaked salt',12),
	('tinned tuna',2),
	('chives',7),
	('basil',7),
	('double cream',6),
	('Parmesan',6),
	('tomato',3),
	('orange',4),
	('filo',5),
	('caster sugar',10),
	('Greek yoghurt',6),
	('egg',6),
	('baking powder',10),
	('vanilla extract',10),
	('wholemeal spelt flour',5),
	('plain flour',5),
	('ground cinnamon',8),
	('maple syrup',10),
	('milk',6),
	('frozen blueberry',4),
	('ginger',3),
	('green chilli',3),
	('aubergine',3),
	('spring onion',3),
	('lime',4),
	('tamarind paste',10),
	('miso',10),
	('Dijon mustard',10),
	('pork joint',1),
	('chicken stock',10),
	('balsamic vinegar',10),
	('tinned butter beans',10),
	('butter',6),
	('parsley',7),
	('oregano',7),
	('dill',7),
	('fennel bulb',3),
	('fennel seeds',8),
	('chilli flake',8),
	('salt flake',12),
	('dried mushroom',3),
	('mushroom',3),
	('celery',3),
	('leek',3),
	('bay leaves',7),
	('vegetable stock',10),
	('small mushroom',3),
	('single cream',6),
	('dry sherry',13)
;

-- DELETE FROM ingredients; -- to delete all the data in the table
-- SELECT * FROM ingredients;
ALTER TABLE ingredients AUTO_INCREMENT = 1; -- to reset increment number to start from 1

ALTER TABLE recipes AUTO_INCREMENT = 1;
INSERT INTO recipes (
	recipe_name, 
	ingredient_id, 
	ingredient_quantity, 
	unit_id,
	prep_time,
	cooking_time,
	cooking_date,
	cookbook_id
	)
VALUES 
	('Berbere spiced chicken',3,1,7,'00:25:00','01:25:00','2025-10-12',1),
	('Berbere spiced chicken',3,6,8,'00:25:00','01:25:00','2025-10-12',1),
	('Berbere spiced chicken',7,45,1,'00:25:00','01:25:00','2025-10-12',1),
	('Berbere spiced chicken',8,2.5,6,'00:25:00','01:25:00','2025-10-12',1),
	('Berbere spiced chicken',10,2,6,'00:25:00','01:25:00','2025-10-12',1),
	('Berbere spiced chicken',10,2.5,6,'00:25:00','01:25:00','2025-10-12',1),
	('Berbere spiced chicken',10,3,6,'00:25:00','01:25:00','2025-10-12',1),
	('Berbere spiced chicken',9,90,6,'00:25:00','01:25:00','2025-10-12',1),
	('Berbere spiced chicken',3,800,1,'00:25:00','01:25:00','2025-10-12',1),
	('Berbere spiced chicken',10,2,10,'00:25:00','01:25:00','2025-10-12',1),
	('Berbere spiced chicken',1,8,7,'00:25:00','01:25:00','2025-10-12',1),
	('Berbere spiced chicken',4,3,7,'00:25:00','01:25:00','2025-10-12',1),
	('Berbere spiced chicken',12,0.1,5,'00:25:00','01:25:00','2025-10-12',1),
	('Berbere spiced chicken',8,0.1,5,'00:25:00','01:25:00','2025-10-12',1),
	('Zaatar salmon',2,4,7,'00:05:00','00:20:00','2025-11-27',1),
	('Zaatar salmon',8,2,6,'00:05:00','00:20:00','2025-11-27',1),
	('Zaatar salmon',8,2,5,'00:05:00','00:20:00','2025-11-27',1),
	('Zaatar salmon',9,60,3,'00:05:00','00:20:00','2025-11-27',1),
	('Zaatar salmon',3,250,1,'00:05:00','00:20:00','2025-11-27',1),
	('Zaatar salmon',10,90,1,'00:05:00','00:20:00','2025-11-27',1),
	('Zaatar salmon',3,3,8,'00:05:00','00:20:00','2025-11-27',1),
	('Zaatar salmon',4,3.5,6,'00:05:00','00:20:00','2025-11-27',1),
	('Zaatar salmon',7,1.5,11,'00:05:00','00:20:00','2025-11-27',1),
	('Zaatar salmon',12,0.1,5,'00:05:00','00:20:00','2025-11-27',1),
	('Zaatar salmon',8,0.1,5,'00:05:00','00:20:00','2025-11-27',1),
	('Baked mint rice',5,400,1,'00:05:00','00:25:00','2025-11-27',2),
	('Baked mint rice',6,50,1,'00:05:00','00:25:00','2025-11-27',2),
	('Baked mint rice',13,800,3,'00:05:00','00:25:00','2025-11-27',2),
	('Baked mint rice',7,50,1,'00:05:00','00:25:00','2025-11-27',2),
	('Baked mint rice',6,150,1,'00:05:00','00:25:00','2025-11-27',2),
	('Baked mint rice',12,0.1,5,'00:05:00','00:25:00','2025-11-27',2),
	('Baked mint rice',8,0.1,5,'00:05:00','00:25:00','2025-11-27',2),
	('Baked mint rice',13,40,1,'00:05:00','00:25:00','2025-11-27',2),
	('Baked mint rice',4,90,1,'00:05:00','00:25:00','2025-11-27',2),
	('Baked mint rice',11,50,1,'00:05:00','00:25:00','2025-11-27',2),
	('Baked mint rice',9,3,6,'00:05:00','00:25:00','2025-11-27',2),
	('Baked mint rice',10,1,6,'00:05:00','00:25:00','2025-11-27',2),
	('Baked mint rice',3,1,8,'00:05:00','00:25:00','2025-11-27',2),
	('Baked rice with tomato and garlic',3,800,1,'00:15:00','01:45:00','2026-03-26',2),
	('Baked rice with tomato and garlic',3,12,8,'00:15:00','01:45:00','2026-03-26',2),
	('Baked rice with tomato and garlic',3,220,7,'00:15:00','01:45:00','2026-03-26',2),
	('Baked rice with tomato and garlic',7,25,11,'00:15:00','01:45:00','2026-03-26',2),
	('Baked rice with tomato and garlic',7,3,5,'00:15:00','01:45:00','2026-03-26',2),
	('Baked rice with tomato and garlic',8,4,7,'00:15:00','01:45:00','2026-03-26',2),
	('Baked rice with tomato and garlic',9,100,3,'00:15:00','01:45:00','2026-03-26',2),
	('Baked rice with tomato and garlic',5,300,1,'00:15:00','01:45:00','2026-03-26',2),
	('Baked rice with tomato and garlic',13,600,3,'00:15:00','01:45:00','2026-03-26',2),
	('Baked rice with tomato and garlic',12,0.1,5,'00:15:00','01:45:00','2026-03-26',2),
	('Baked rice with tomato and garlic',8,0.1,5,'00:15:00','01:45:00','2026-03-26',2),
	('TV chips',3,1,2,'00:10:00','00:55:00','2026-04-04',3),
	('TV chips',9,3,6,'00:10:00','00:55:00','2026-04-04',3),
	('TV chips',12,2,5,'00:10:00','00:55:00','2026-04-04',3),
	('TV chips',2,160,10,'00:10:00','00:55:00','2026-04-04',3),
	('TV chips',7,5,1,'00:10:00','00:55:00','2026-04-04',3),
	('TV chips',7,5,1,'00:10:00','00:55:00','2026-04-04',3),
	('TV chips',8,0.1,5,'00:10:00','00:55:00','2026-04-04',3),
	('TV chips',3,0.5,7,'00:10:00','00:55:00','2026-04-04',3),
	('TV chips',4,2,6,'00:10:00','00:55:00','2026-04-04',3),
	('TV chips',12,0.5,5,'00:10:00','00:55:00','2026-04-04',3),
	('TV chips',6,60,3,'00:10:00','00:55:00','2026-04-04',3),
	('TV chips',6,15,1,'00:10:00','00:55:00','2026-04-04',3),
	('TV chips',3,1,8,'00:10:00','00:55:00','2026-04-04',3),
	('TV chips',3,2,7,'00:10:00','00:55:00','2026-04-04',3),
	('Portokalopita',4,2,7,'01:30:00','01:20:00','2026-04-02',4),
	('Portokalopita',5,500,1,'01:30:00','01:20:00','2026-04-02',4),
	('Portokalopita',10,400,1,'01:30:00','01:20:00','2026-04-02',4),
	('Portokalopita',8,1,7,'01:30:00','01:20:00','2026-04-02',4),
	('Portokalopita',9,200,3,'01:30:00','01:20:00','2026-04-02',4),
	('Portokalopita',6,250,1,'01:30:00','01:20:00','2026-04-02',4),
	('Portokalopita',6,5,7,'01:30:00','01:20:00','2026-04-02',4),
	('Portokalopita',10,1,5,'01:30:00','01:20:00','2026-04-02',4),
	('Portokalopita',10,1,5,'01:30:00','01:20:00','2026-04-02',4),
	('Blueberry muffins',5,140,1,'00:10:00','00:30:00','2026-04-15',5),
	('Blueberry muffins',5,150,1,'00:10:00','00:30:00','2026-04-15',5),
	('Blueberry muffins',10,1,5,'00:10:00','00:30:00','2026-04-15',5),
	('Blueberry muffins',8,1,5,'00:10:00','00:30:00','2026-04-15',5),
	('Blueberry muffins',6,1,7,'00:10:00','00:30:00','2026-04-15',5),
	('Blueberry muffins',9,160,3,'00:10:00','00:30:00','2026-04-15',5),
	('Blueberry muffins',10,1,5,'00:10:00','00:30:00','2026-04-15',5),
	('Blueberry muffins',10,180,3,'00:10:00','00:30:00','2026-04-15',5),
	('Blueberry muffins',6,80,3,'00:10:00','00:30:00','2026-04-15',5),
	('Blueberry muffins',4,375,1,'00:10:00','00:30:00','2026-04-15',5),
	('Roasted aubergine',3,15,1,'00:10:00','01:00:00','2026-04-10',6),
	('Roasted aubergine',3,4,8,'00:10:00','01:00:00','2026-04-10',6),
	('Roasted aubergine',3,2,7,'00:10:00','01:00:00','2026-04-10',6),
	('Roasted aubergine',3,2,7,'00:10:00','01:00:00','2026-04-10',6),
	('Roasted aubergine',3,200,7,'00:10:00','01:00:00','2026-04-10',6),
	('Roasted aubergine',3,4,7,'00:10:00','01:00:00','2026-04-10',6),
	('Roasted aubergine',7,50,1,'00:10:00','01:00:00','2026-04-10',6),
	('Roasted aubergine',4,1,7,'00:10:00','01:00:00','2026-04-10',6),
	('Roasted aubergine',10,1,6,'00:10:00','01:00:00','2026-04-10',6),
	('Roasted aubergine',10,1/2,6,'00:10:00','01:00:00','2026-04-10',6),
	('Roasted aubergine',10,3,6,'00:10:00','01:00:00','2026-04-10',6),
	('Roast pork',10,2,5,'00:10:00','02:00:00','2026-04-17',7),
	('Roast pork',10,2,6,'00:10:00','02:00:00','2026-04-17',7),
	('Roast pork',1,1.3,2,'00:10:00','02:00:00','2026-04-17',7),
	('Roast pork',10,500,3,'00:10:00','02:00:00','2026-04-17',7),
	('Roast pork',10,2,6,'00:10:00','02:00:00','2026-04-17',7),
	('Roast pork',10,1,10,'00:10:00','02:00:00','2026-04-17',7),
	('Roast pork',6,20,1,'00:10:00','02:00:00','2026-04-17',7),
	('Roast pork',7,10,11,'00:10:00','02:00:00','2026-04-17',7),
	('Roast pork',7,5,1,'00:10:00','02:00:00','2026-04-17',7),
	('Roast pork',7,5,1,'00:10:00','02:00:00','2026-04-17',7),
	('Roast pork',7,5,1,'00:10:00','02:00:00','2026-04-17',7),
	('Roast pork',12,0.1,5,'00:10:00','02:00:00','2026-04-17',7),
	('Roast pork',8,0.1,5,'00:10:00','02:00:00','2026-04-17',7),
	('Baked Fennel',3,4,7,'00:10:00','00:40:00','2026-02-20',8),
	('Baked Fennel',9,3,6,'00:10:00','00:40:00','2026-02-20',8),
	('Baked Fennel',3,2,8,'00:10:00','00:40:00','2026-02-20',8),
	('Baked Fennel',8,3,5,'00:10:00','00:40:00','2026-02-20',8),
	('Baked Fennel',8,3,5,'00:10:00','00:40:00','2026-02-20',8),
	('Baked Fennel',12,0.1,5,'00:10:00','00:40:00','2026-02-20',8),
	('Baked Fennel',8,0.1,5,'00:10:00','00:40:00','2026-02-20',8),
	('Baked Fennel',6,25,1,'00:10:00','00:40:00','2026-02-20',8),
	('Wild mushroom & walnut soup',3,25,1,'00:20:00','01:45:00','2025-12-22',9),
	('Wild mushroom & walnut soup',13,275,3,'00:20:00','01:45:00','2025-12-22',9),
	('Wild mushroom & walnut soup',6,75,1,'00:20:00','01:45:00','2025-12-22',9),
	('Wild mushroom & walnut soup',3,110,1,'00:20:00','01:45:00','2025-12-22',9),
	('Wild mushroom & walnut soup',3,2,7,'00:20:00','01:45:00','2025-12-22',9),
	('Wild mushroom & walnut soup',3,2,7,'00:20:00','01:45:00','2025-12-22',9),
	('Wild mushroom & walnut soup',3,1,7,'00:20:00','01:45:00','2025-12-22',9),
	('Wild mushroom & walnut soup',3,1,7,'00:20:00','01:45:00','2025-12-22',9),
	('Wild mushroom & walnut soup',7,2,7,'00:20:00','01:45:00','2025-12-22',9),
	('Wild mushroom & walnut soup',7,1.5,5,'00:20:00','01:45:00','2025-12-22',9),
	('Wild mushroom & walnut soup',3,2,8,'00:20:00','01:45:00','2025-12-22',9),
	('Wild mushroom & walnut soup',10,2,4,'00:20:00','01:45:00','2025-12-22',9),
	('Wild mushroom & walnut soup',3,225,1,'00:20:00','01:45:00','2025-12-22',9),
	('Wild mushroom & walnut soup',11,110,1,'00:20:00','01:45:00','2025-12-22',9),
	('Wild mushroom & walnut soup',6,75,3,'00:20:00','01:45:00','2025-12-22',9),
	('Wild mushroom & walnut soup',13,75,3,'00:20:00','01:45:00','2025-12-22',9),
	('Wild mushroom & walnut soup',4,10,3,'00:20:00','01:45:00','2025-12-22',9)
;

ALTER TABLE recipes AUTO_INCREMENT = 1;
INSERT INTO stocks (ingredient_id, stock_quantity, unit_id, is_available)
VALUES 
	(1, 5, 7, 1),
	(2, 30, 8, 1),
	(3, 200, 1, 1),
	(4, 5, 5, 1),
	(5, 10, 6, 1),
	(6, 1.5, 6, 1),
	(7, 2, 6, 1),
	(8, 500, 3, 1),
	(9, 10, 7, 1),
	(10, 1, 10, 1),
	(11, 10, 7, 1),
	(12, 3, 7, 1),
	(13, 1.5, 5, 1),
	(14, 1, 5, 1),
	(15, 4, 7, 1),
	(16, 2, 5, 1),
	(17, 1.5, 5, 1),
	(18, 250, 1, 1),
	(19, 4, 6, 1),
	(20, 3, 6, 1),
	(21, 300, 1, 1),
	(22, 75, 1, 1),
	(23, 500, 3, 1),
	(24, 30, 1, 1),
	(25, 200, 1, 1),
	(26, 15, 7, 1),
	(27, 80, 1, 1),
	(28, 100, 1, 1),
	(29, 2, 6, 1),
	(30, 12, 7, 1),
	(31, 4, 7, 1),
	(32, 2, 5, 1),
	(33, 2, 7, 1),
	(34, 4, 7, 1),
	(35, 1, 5, 1),
	(36, 200, 1, 1),
	(37, 1, 11, 1),
	(38, 50, 1, 1),
	(39, 200, 3, 1),
	(40, 80, 1, 1),
	(41, 6, 7, 1),
	(42, 4, 7, 1),
	(43, 500, 1, 1),
	(44, 1, 2, 1),
	(45, 250, 1, 1),
	(46, 6, 7, 1),
	(47, 2, 5, 1),
	(48, 1, 5, 1),
	(49, 200, 1, 1),
	(50, 300, 1, 1),
	(51, 1.5, 5, 1),
	(52, 2, 6, 1),
	(53, 300, 3, 1),
	(54, 150, 1, 1),
	(55, 40, 1, 1),
	(56, 3, 7, 1),
	(57, 2, 7, 1),
	(58, 6, 7, 1),
	(59, 3, 7, 1),
	(60, 2, 6, 1),
	(61, 3, 6, 1),
	(62, 2, 5, 1),
	(63, 2, 2, 1),
	(64, 800, 3, 1),
	(65, 3, 6, 1),
	(66, 2, 10, 1),
	(67, 100, 1, 1),
	(68, 30, 1, 1),
	(69, 30, 1, 1),
	(70, 30, 1, 1),
	(71, 2, 7, 1),
	(72, 1.5, 5, 1),
	(73, 1, 5, 1),
	(74, 1, 5, 1),
	(75, 30, 1, 1),
	(76, 250, 1, 1),
	(77, 3, 7, 1),
	(78, 2, 7, 1),
	(79, 3, 7, 1),
	(80, 1, 3, 1),
	(81, 12, 7, 1),
	(82, 200, 3, 1),
	(83, 80, 3, 1)
;

DELETE FROM stocks; -- to delete all the data in the table

INSERT INTO ingredients (ingredient_name, ingredient_type_id)
VALUES ('baked beans', 10);

INSERT INTO ingredients (ingredient_name, ingredient_type_id)
VALUES 
	('worcestershire sauce', 10),
	('bread',5);

INSERT INTO recipes (recipe_name, ingredient_id, ingredient_quantity, unit_id, prep_time, cooking_time, cooking_date)
VALUES 
	('baked beans on toast',  
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
		),
		'00:01:00',
		'00:03:00',
		DATE(NOW())
	),
	('baked beans on toast',  
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
		),
		'00:01:00',
		'00:03:00',
		DATE(NOW())
	),	
	('baked beans on toast',
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
		),
		'00:01:00',
		'00:03:00',
		DATE(NOW())
	);

INSERT INTO stocks (ingredient_id, stock_quantity, unit_id, is_available)
VALUES 
	(
		(	
		SELECT ingredient_id
		FROM ingredients 
		WHERE ingredient_name = 'bread'
		),
		0,
		(
		SELECT unit_id 
		FROM units 
		WHERE unit_abbreviation = 'piece'
		),
		0
	)
	
	UPDATE stocks 
	SET is_available = 1
	WHERE ingredient_id =
		(SELECT ingredient_id
		FROM ingredients 
		WHERE ingredient_name = 'bread')
	;
