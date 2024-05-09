-- Script Description:
-- This SQL script creates a stored procedure named ComputeAverageWeightedScoreForUsers
-- that computes and stores the average weighted score for all students.

-- Create Procedure ComputeAverageWeightedScoreForUsers
DELIMITER $$
CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
    DECLARE user_id_val INT;
    
    -- Declare cursor for iterating over each user
    DECLARE user_cursor CURSOR FOR
        SELECT id
        FROM users;
    
    -- Declare variables to store total score and total weight
    DECLARE total_score FLOAT;
    DECLARE total_weight FLOAT;
    DECLARE avg_weighted_score FLOAT;
    
    -- Open the cursor
    OPEN user_cursor;
    
    -- Loop through each user
    user_loop: LOOP
        -- Fetch the user_id
        FETCH user_cursor INTO user_id_val;
        
        -- If no more rows to fetch, exit the loop
        IF user_id_val IS NULL THEN
            LEAVE user_loop;
        END IF;
        
        -- Calculate total score and total weight for the user
        SELECT SUM(c.score * p.weight), SUM(p.weight)
        INTO total_score, total_weight
        FROM corrections c
        JOIN projects p ON c.project_id = p.id
        WHERE c.user_id = user_id_val;
        
        -- Calculate average weighted score
        IF total_weight = 0 THEN
            SET avg_weighted_score = 0;
        ELSE
            SET avg_weighted_score = total_score / total_weight;
        END IF;
        
        -- Update average_score in the users table
        UPDATE users
        SET average_score = avg_weighted_score
        WHERE id = user_id_val;
        
    END LOOP user_loop;
    
    -- Close the cursor
    CLOSE user_cursor;
    
END$$
DELIMITER ;
