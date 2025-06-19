-- VIEW для отображения информации о клиентах и их счетах
CREATE VIEW client_accounts_view AS
SELECT 
    c.client_id,
    CONCAT(c.first_name, ' ', c.last_name) AS client_name,
    c.passport_number,
    b.name AS branch_name,
    a.account_number,
    a.account_type,
    a.balance,
    a.currency,
    a.status AS account_status
FROM 
    client c
JOIN 
    branch b ON c.branch_id = b.branch_id
JOIN 
    account a ON c.client_id = a.client_id;
