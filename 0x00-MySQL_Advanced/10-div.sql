-- Script Description:
-- This SQL script creates a function named SafeDiv that divides two numbers 
-- and returns the result, or 0 if the second number is equal to 0.

-- Create Function SafeDiv
DELIMITER $$
CREATE FUNCTION SafeDiv(a INT, b INT)
RETURNS FLOAT
BEGIN
    DECLARE result FLOAT;
    
    IF b = 0 THEN
        RETURN 0;
    ELSE
        SET result = a / b;
        RETURN result;
    END IF;
END$$
DELIMITER ;
