-- Drop existing tables if they exist (in reverse dependency order)
DROP TABLE IF EXISTS land_transfers CASCADE;
DROP TABLE IF EXISTS lands CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- Create users table first (required for foreign keys)
CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  full_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  national_id VARCHAR(50) UNIQUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create lands table
CREATE TABLE IF NOT EXISTS lands (
  id SERIAL PRIMARY KEY,
  land_name VARCHAR(255) NOT NULL,
  location VARCHAR(255) NOT NULL,
  size DECIMAL(10, 2) NOT NULL, -- Size in square meters or acres
  coordinates JSONB, -- Store lat/lng or polygon coordinates
  owner_id INTEGER NOT NULL,
  land_type VARCHAR(100), -- e.g., 'residential', 'commercial', 'agricultural'
  description TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (owner_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Create land_transfers table for audit trail
CREATE TABLE IF NOT EXISTS land_transfers (
  id SERIAL PRIMARY KEY,
  land_id INTEGER NOT NULL,
  from_owner_id INTEGER NOT NULL,
  to_owner_id INTEGER NOT NULL,
  transfer_reason TEXT,
  transfer_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (land_id) REFERENCES lands(id) ON DELETE CASCADE,
  FOREIGN KEY (from_owner_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (to_owner_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_lands_owner_id ON lands(owner_id);
CREATE INDEX IF NOT EXISTS idx_lands_location ON lands(location);
CREATE INDEX IF NOT EXISTS idx_land_transfers_land_id ON land_transfers(land_id);
CREATE INDEX IF NOT EXISTS idx_land_transfers_from_owner ON land_transfers(from_owner_id);
CREATE INDEX IF NOT EXISTS idx_land_transfers_to_owner ON land_transfers(to_owner_id);
