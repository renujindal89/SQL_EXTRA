CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    OrderAmount DECIMAL(10,2),
    OrderDate DATETIME
);

CREATE TABLE Payments (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    PaymentAmount DECIMAL(10,2),
    PaymentDate DATETIME
);





DELIMITER //

CREATE PROCEDURE CreateOrderAndPay(
    IN cust_id INT,
    IN amount DECIMAL(10,2)
)
BEGIN
    DECLARE order_id INT;
    DECLARE exit handler FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Transaction failed. Rolled back.' AS Message;
    END;

    START TRANSACTION;

    -- Step 1: Insert into Orders
    INSERT INTO Orders (CustomerID, OrderAmount, OrderDate)
    VALUES (cust_id, amount, NOW());

    SET order_id = LAST_INSERT_ID();

    -- Step 2: Insert into Payments
    INSERT INTO Payments (OrderID, PaymentAmount, PaymentDate)
    VALUES (order_id, amount, NOW());

    COMMIT;

    SELECT 'Order and payment completed successfully.' AS Message;
END //

DELIMITER ;
