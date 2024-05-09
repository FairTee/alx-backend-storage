-- Script Description:
-- This SQL script creates an index named idx_name_first on the table names to index
-- only the first letter of the name column.

-- Create Index idx_name_first
CREATE INDEX idx_name_first ON names (LEFT(name, 1));
