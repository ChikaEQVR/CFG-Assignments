-- Create a MySQL database with at least 1 table

CREATE DATABASE pocketmoney_db;

USE pocketmoney_db;

CREATE TABLE users (
	user_id INT AUTO_INCREMENT PRIMARY KEY,
	user_name VARCHAR(255) NOT NULL
);

CREATE TABLE accounts (
	account_id INT AUTO_INCREMENT PRIMARY KEY,
	account_name VARCHAR(255) NOT NULL,
	user_id INT NOT NULL,
	created_at DATE,
	CONSTRAINT fk_accounts
	FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE transaction_types (
	transaction_type_id INT AUTO_INCREMENT PRIMARY KEY,
	transaction_type VARCHAR(50),
	CONSTRAINT uc_transaction_types
	UNIQUE (transaction_type)
);

CREATE TABLE transactions (
	transaction_id INT AUTO_INCREMENT PRIMARY KEY,
	account_id INT NOT NULL,
	amount DECIMAL(10,2) NOT NULL,
	transaction_type_id INT NOT NULL,
	description TEXT,
	transaction_date DATE NOT NULL,
	CONSTRAINT fk_transactions
	FOREIGN KEY (account_id) REFERENCES accounts(account_id),
	FOREIGN KEY (transaction_type_id) REFERENCES transaction_types(transaction_type_id)
);

# Create stored procedure to insert values into transactions table

DELIMITER //

CREATE PROCEDURE InsertTransactionValues (
	IN p_account_id INT,
	IN p_amount DECIMAL(10,2),
	IN p_transaction_type VARCHAR(50),
	IN p_description TEXT,
	IN p_transaction_date DATE
	)
	
BEGIN
	INSERT INTO transactions (
		account_id,
		amount,
		transaction_type_id,
		description,
		transaction_date
		)
	VALUES 
		(
			(
			SELECT account_id
			FROM accounts
			WHERE account_id = p_account_id
			),
			p_amount,
			(
			SELECT transaction_type_id
			FROM transaction_types
			WHERE transaction_type = p_transaction_type
			),
			p_description,
			p_transaction_date

		);
	
END //


DELIMITER ;

# Insert values into users table

INSERT INTO users (user_name)
VALUES 
('noah'),
('isla'),
('cian')
;

# Insert values into transaction_types table
INSERT INTO transaction_types (transaction_type)
VALUES 
('allowance'),
('spend'),
('reward'),
('gift'),
('fine'),
('refund')
;

# Insert values into accounts table
INSERT INTO accounts (account_name, user_id, created_at) 
VALUES 
	('noah pocket money', 1, '2026-01-04'),
	('isla pocket money', 2, '2026-01-04'),
	('cian pocket money', 3, '2026-01-04')
;

# Insert values into transactions using InsertTransactionValues(p_account_id, p_amount,p_transaction_type, p_description,p_transaction_date)
CALL InsertTransactionValues(1, 2.00, 'allowance', 'weekly allowance', '2026-01-04');
CALL InsertTransactionValues(2, 2.00, 'allowance', 'weekly allowance', '2026-01-04');
CALL InsertTransactionValues(3, 2.00, 'allowance', 'weekly allowance', '2026-01-04');
CALL InsertTransactionValues(1, 2.00, 'allowance', 'weekly allowance', '2026-01-11');
CALL InsertTransactionValues(2, 2.00, 'allowance', 'weekly allowance', '2026-01-11');
CALL InsertTransactionValues(3, 2.00, 'allowance', 'weekly allowance', '2026-01-11');
CALL InsertTransactionValues(1, 2.00, 'allowance', 'weekly allowance', '2026-01-18');
CALL InsertTransactionValues(2, 2.00, 'allowance', 'weekly allowance', '2026-01-18');
CALL InsertTransactionValues(3, 2.00, 'allowance', 'weekly allowance', '2026-01-18');
CALL InsertTransactionValues(1, 2.00, 'allowance', 'weekly allowance', '2026-01-25');
CALL InsertTransactionValues(2, 2.00, 'allowance', 'weekly allowance', '2026-01-25');
CALL InsertTransactionValues(3, 2.00, 'allowance', 'weekly allowance', '2026-01-25');
CALL InsertTransactionValues(1, 2.00, 'allowance', 'weekly allowance', '2026-02-01');
CALL InsertTransactionValues(2, 2.00, 'allowance', 'weekly allowance', '2026-02-01');
CALL InsertTransactionValues(3, 2.00, 'allowance', 'weekly allowance', '2026-02-01');
CALL InsertTransactionValues(1, 2.00, 'allowance', 'weekly allowance', '2026-02-08');
CALL InsertTransactionValues(2, 2.00, 'allowance', 'weekly allowance', '2026-02-08');
CALL InsertTransactionValues(3, 2.00, 'allowance', 'weekly allowance', '2026-02-08');
CALL InsertTransactionValues(1, 2.00, 'allowance', 'weekly allowance', '2026-02-15');
CALL InsertTransactionValues(2, 2.00, 'allowance', 'weekly allowance', '2026-02-15');
CALL InsertTransactionValues(3, 2.00, 'allowance', 'weekly allowance', '2026-02-15');
CALL InsertTransactionValues(1, 2.00, 'allowance', 'weekly allowance', '2026-02-22');
CALL InsertTransactionValues(2, 2.00, 'allowance', 'weekly allowance', '2026-02-22');
CALL InsertTransactionValues(3, 2.00, 'allowance', 'weekly allowance', '2026-02-22');
CALL InsertTransactionValues(1, 2.00, 'allowance', 'weekly allowance', '2026-03-01');
CALL InsertTransactionValues(2, 2.00, 'allowance', 'weekly allowance', '2026-03-01');
CALL InsertTransactionValues(3, 2.00, 'allowance', 'weekly allowance', '2026-03-01');
CALL InsertTransactionValues(1, 2.00, 'allowance', 'weekly allowance', '2026-03-08');
CALL InsertTransactionValues(2, 2.00, 'allowance', 'weekly allowance', '2026-03-08');
CALL InsertTransactionValues(3, 2.00, 'allowance', 'weekly allowance', '2026-03-08');
CALL InsertTransactionValues(1, 2.00, 'allowance', 'weekly allowance', '2026-03-15');
CALL InsertTransactionValues(2, 2.00, 'allowance', 'weekly allowance', '2026-03-15');
CALL InsertTransactionValues(3, 2.00, 'allowance', 'weekly allowance', '2026-03-15');
CALL InsertTransactionValues(1, 2.00, 'allowance', 'weekly allowance', '2026-03-22');
CALL InsertTransactionValues(2, 2.00, 'allowance', 'weekly allowance', '2026-03-22');
CALL InsertTransactionValues(3, 2.00, 'allowance', 'weekly allowance', '2026-03-22');
CALL InsertTransactionValues(1, 2.00, 'allowance', 'weekly allowance', '2026-03-29');
CALL InsertTransactionValues(2, 2.00, 'allowance', 'weekly allowance', '2026-03-29');
CALL InsertTransactionValues(3, 2.00, 'allowance', 'weekly allowance', '2026-03-29');
CALL InsertTransactionValues(1, 10.00, 'gift', 'holiday pocketmoney from grandma', '2026-03-29');
CALL InsertTransactionValues(2, 10.00, 'gift', 'holiday pocketmoney from grandma', '2026-03-29');
CALL InsertTransactionValues(3, 10.00, 'gift', 'holiday pocketmoney from grandma', '2026-03-29');
CALL InsertTransactionValues(1, 2.00, 'allowance', 'weekly allowance', '2026-04-05');
CALL InsertTransactionValues(2, 2.00, 'allowance', 'weekly allowance', '2026-04-05');
CALL InsertTransactionValues(3, 2.00, 'allowance', 'weekly allowance', '2026-04-05');
CALL InsertTransactionValues(1, 2.00, 'allowance', 'weekly allowance', '2026-04-12');
CALL InsertTransactionValues(2, 2.00, 'allowance', 'weekly allowance', '2026-04-12');
CALL InsertTransactionValues(3, 2.00, 'allowance', 'weekly allowance', '2026-04-12');
CALL InsertTransactionValues(1, 2.00, 'allowance', 'weekly allowance', '2026-04-19');
CALL InsertTransactionValues(2, 2.00, 'allowance', 'weekly allowance', '2026-04-19');
CALL InsertTransactionValues(3, 2.00, 'allowance', 'weekly allowance', '2026-04-19');
