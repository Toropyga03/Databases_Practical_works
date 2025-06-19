USE bank_system;

-- Таблица отделений
CREATE TABLE IF NOT EXISTS branch (
    branch_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(200) NOT NULL,
    phone VARCHAR(20) NOT NULL UNIQUE,
    opening_date DATE NOT NULL
) ENGINE=InnoDB;

-- Таблица клиентов
CREATE TABLE IF NOT EXISTS client (
    client_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_date DATE NOT NULL,
    passport_number VARCHAR(20) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL UNIQUE,
    email VARCHAR(100) UNIQUE,
    registration_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    branch_id INT NOT NULL,
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
) ENGINE=InnoDB;

-- Таблица счетов
CREATE TABLE IF NOT EXISTS account (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    branch_id INT NOT NULL,
    account_number VARCHAR(20) NOT NULL UNIQUE,
    account_type ENUM('current', 'savings', 'credit') NOT NULL,
    balance DECIMAL(15,2) NOT NULL DEFAULT 0.00,
    currency CHAR(3) NOT NULL DEFAULT 'RUB',
    opening_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status ENUM('active', 'blocked', 'closed') NOT NULL DEFAULT 'active',
    FOREIGN KEY (client_id) REFERENCES client(client_id),
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
) ENGINE=InnoDB;

-- Таблица карт
CREATE TABLE IF NOT EXISTS card (
    card_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT NOT NULL,
    card_number VARCHAR(16) NOT NULL UNIQUE,
    card_holder VARCHAR(100) NOT NULL,
    expiry_date DATE NOT NULL,
    cvv VARCHAR(3) NOT NULL,
    pin_code VARCHAR(4) NOT NULL,
    card_type ENUM('debit', 'credit') NOT NULL,
    status ENUM('active', 'blocked', 'expired') NOT NULL DEFAULT 'active',
    issue_date DATE NOT NULL,
    FOREIGN KEY (account_id) REFERENCES account(account_id)
) ENGINE=InnoDB;

-- Таблица транзакций
CREATE TABLE IF NOT EXISTS transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    from_account_id INT,
    to_account_id INT,
    amount DECIMAL(15,2) NOT NULL,
    currency CHAR(3) NOT NULL,
    transaction_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    transaction_type ENUM('transfer', 'withdrawal', 'deposit', 'payment') NOT NULL,
    status ENUM('pending', 'completed', 'failed', 'reversed') NOT NULL,
    description VARCHAR(255),
    FOREIGN KEY (from_account_id) REFERENCES account(account_id),
    FOREIGN KEY (to_account_id) REFERENCES account(account_id)
) ENGINE=InnoDB;

-- Создание индексов
CREATE INDEX idx_client_branch ON client(branch_id);
CREATE INDEX idx_account_client ON account(client_id);
CREATE INDEX idx_account_branch ON account(branch_id);
CREATE INDEX idx_card_account ON card(account_id);
CREATE INDEX idx_transaction_from ON transactions(from_account_id);
CREATE INDEX idx_transaction_to ON transactions(to_account_id);
CREATE INDEX idx_transaction_date ON transactions(transaction_date);
