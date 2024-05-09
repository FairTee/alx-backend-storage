-- Script Description:
-- This SQL script creates a stored procedure named ComputeAverageWeightedScoreForUser
-- that computes and stores the average weighted score for a student.

-- Create Procedure ComputeAverageWeightedScoreForUser
DELIMITER $$
CREATE PROCEDURE ComputeAverageWeightedScoreForUser(IN user_id INT)
BEGIN
    DECLARE total_score FLOAT;
    DECLARE total_weight FLOAT;
    DECLARE avg_weighted_score FLOAT;
    
    -- Calculate total score and total weight for the user
    SELECT SUM(c.score * p.weight), SUM(p.weight)
    INTO total_score, total_weight
    FROM corrections c
    JOIN projects p ON c.project_id = p.id
    WHERE c.user_id = user_id;
    
    -- Calculate average weighted score
    IF total_weight = 0 THEN
        SET avg_weighted_score = 0;
    ELSE
        SET avg_weighted_score = total_score / total_weight;
    END IF;
    
    -- Update average_score in the users table
    UPDATE users
    SET average_score = avg_weighted_score
    WHERE id = user_id;
    
END$$
DELIMITER ;
