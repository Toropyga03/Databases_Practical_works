USE bank_system;

-- Добавляем колонку "last_login" в таблицу client
ALTER TABLE client 
ADD COLUMN last_login TIMESTAMP NULL DEFAULT NULL 
COMMENT 'Дата и время последнего входа в систему';
