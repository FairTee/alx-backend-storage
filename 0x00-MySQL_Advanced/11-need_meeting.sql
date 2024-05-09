-- Script Description:
-- This SQL script creates a view named need_meeting that lists all students 
-- who have a score under 80 (strict) and either have no last_meeting date 
-- or have a last_meeting date more than 1 month ago.

-- Create View need_meeting
CREATE VIEW need_meeting AS
SELECT name
FROM students
WHERE (score < 80 AND (last_meeting IS NULL OR last_meeting < DATE_SUB(CURDATE(), INTERVAL 1 MONTH)));
