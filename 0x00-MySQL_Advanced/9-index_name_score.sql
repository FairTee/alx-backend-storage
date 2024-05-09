-- Script Description:
-- This SQL script creates an index named idx_name_first_score on the table names to index
-- the first letter of the name column and the score column.

-- Create Index idx_name_first_score
CREATE INDEX idx_name_first_score ON names (LEFT(name, 1), score);
