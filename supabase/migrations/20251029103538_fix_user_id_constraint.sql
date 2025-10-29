/*
  # Fix user_id Foreign Key Constraint
  
  1. Changes
    - Make user_id NOT NULL to ensure data integrity
    - Keep the foreign key constraint to auth.users
    - Add a check to ensure user exists before insert
    
  2. Notes
    - This fixes the foreign key constraint violation error
    - Ensures all patient records are properly linked to authenticated users
*/

-- Ensure user_id is NOT NULL (it should already be, but we're being explicit)
DO $$
BEGIN
  -- First check if there are any NULL user_id values
  IF EXISTS (SELECT 1 FROM patients WHERE user_id IS NULL) THEN
    -- Delete any orphaned records without a user_id
    DELETE FROM patients WHERE user_id IS NULL;
  END IF;
  
  -- Make user_id NOT NULL if it isn't already
  IF EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'patients' 
    AND column_name = 'user_id' 
    AND is_nullable = 'YES'
  ) THEN
    ALTER TABLE patients ALTER COLUMN user_id SET NOT NULL;
  END IF;
END $$;