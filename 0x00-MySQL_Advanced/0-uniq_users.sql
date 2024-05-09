-- Script Description:
-- This SQL script creates a table called users with the specified attributes.
-- If the table already exists, it won't fail.

-- Create Table Users
CREATE TABLE IF NOT EXISTS users (
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL UNIQUE,
    name VARCHAR(255)
);
