-- Add vehicle and driver status columns to drivers table
ALTER TABLE drivers ADD COLUMN vehicle_type ENUM('mini','sedan','van') NULL;
ALTER TABLE drivers ADD COLUMN car_name VARCHAR(255) NULL;
ALTER TABLE drivers ADD COLUMN driver_status ENUM('active','inactive','suspended') NOT NULL DEFAULT 'inactive';

-- Backfill driver_status to 'active' for verified drivers if appropriate
UPDATE drivers SET driver_status = 'active' WHERE verification = true;

-- Indexes for potential filtering
CREATE INDEX IF NOT EXISTS idx_drivers_vehicle_type ON drivers(vehicle_type);
CREATE INDEX IF NOT EXISTS idx_drivers_driver_status ON drivers(driver_status);