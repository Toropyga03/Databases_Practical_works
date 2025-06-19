-- TRIGGER для проверки баланса при списании средств
DELIMITER //
CREATE TRIGGER check_balance_before_transaction
BEFORE UPDATE ON account
FOR EACH ROW
BEGIN
    DECLARE error_message VARCHAR(255);
    
    -- Проверка только для дебетовых счетов (кредитные могут уходить в минус)
    IF NEW.balance < 0 AND 
       (SELECT account_type FROM account WHERE account_id = NEW.account_id) = 'current' THEN
        SET error_message = CONCAT('Недостаточно средств на счете: ', NEW.account_number);
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_message;
    END IF;
END//
DELIMITER ;
