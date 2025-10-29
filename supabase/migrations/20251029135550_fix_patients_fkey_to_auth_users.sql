/*
  # Fix Foreign Key to Point to auth.users
  
  1. Changes
    - Drop the existing incorrect foreign key constraint
    - Add correct foreign key constraint pointing to auth.users table
    
  2. Notes
    - The foreign key was incorrectly pointing to a non-existent 'users' table
    - Now it correctly references auth.users(id)
*/

-- Drop the incorrect foreign key constraint
ALTER TABLE patients DROP CONSTRAINT IF EXISTS patients_user_id_fkey;

-- Add the correct foreign key constraint pointing to auth.users
ALTER TABLE patients 
  ADD CONSTRAINT patients_user_id_fkey 
  FOREIGN KEY (user_id) 
  REFERENCES auth.users(id) 
  ON DELETE CASCADE;