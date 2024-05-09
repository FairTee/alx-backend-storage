-- Script Description:
-- This SQL script creates a stored procedure named ComputeAverageScoreForUser
-- that computes and stores the average score for a student.

-- Create Stored Procedure ComputeAverageScoreForUser
DELIMITER $$
CREATE PROCEDURE ComputeAverageScoreForUser(IN user_id INT)
BEGIN
    DECLARE total_score FLOAT;
    DECLARE total_projects INT;
    
    -- Compute Total Score for the User
    SELECT SUM(score) INTO total_score
    FROM corrections
    WHERE user_id = user_id;
    
    -- Compute Total Projects for the User
    SELECT COUNT(*) INTO total_projects
    FROM corrections
    WHERE user_id = user_id;
    
    -- Calculate Average Score
    IF total_projects > 0 THEN
        UPDATE users
        SET average_score = total_score / total_projects
        WHERE id = user_id;
    END IF;
END$$
DELIMITER ;
