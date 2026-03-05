CREATE DATABASE IF NOT EXISTS ocean_view_db;
USE ocean_view_db;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('Admin', 'Staff') NOT NULL
);

CREATE TABLE IF NOT EXISTS rooms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(10) UNIQUE NOT NULL,
    room_type VARCHAR(50) NOT NULL,
    price_per_night DECIMAL(10, 2) NOT NULL,
    status ENUM('Available', 'Occupied', 'Maintenance') DEFAULT 'Available'
);

CREATE TABLE IF NOT EXISTS reservations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    res_number VARCHAR(20) UNIQUE NOT NULL,
    guest_name VARCHAR(100) NOT NULL,
    guest_address TEXT,
    guest_phone VARCHAR(20) NOT NULL,
    room_id INT,
    check_in DATE NOT NULL,
    check_out DATE NOT NULL,
    status ENUM('Confirmed', 'Cancelled', 'Completed') DEFAULT 'Confirmed',
    FOREIGN KEY (room_id) REFERENCES rooms(id)
);

CREATE TABLE IF NOT EXISTS bills (
    id INT AUTO_INCREMENT PRIMARY KEY,
    reservation_id INT,
    total_amount DECIMAL(10, 2) NOT NULL,
    issued_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (reservation_id) REFERENCES reservations(id) ON DELETE CASCADE
);

-- Customer self-service tables
CREATE TABLE IF NOT EXISTS customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS customer_bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    room_id INT NOT NULL,
    check_in DATE NOT NULL,
    check_out DATE NOT NULL,
    status ENUM('Pending', 'Reserved', 'Cancelled') DEFAULT 'Pending',
    res_number VARCHAR(20) NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (room_id) REFERENCES rooms(id)
);

DELIMITER //

CREATE PROCEDURE sp_CalculateBill(IN p_res_id INT, OUT p_total DECIMAL(10, 2))
BEGIN
    DECLARE v_days INT;
    DECLARE v_price DECIMAL(10, 2);

    SELECT DATEDIFF(check_out, check_in), r.price_per_night 
    INTO v_days, v_price
    FROM reservations res
    JOIN rooms r ON res.room_id = r.id
    WHERE res.id = p_res_id;

    IF v_days <= 0 THEN
        SET v_days = 1;
    END IF;

    SET p_total = v_days * v_price;
END //

CREATE TRIGGER tr_PreventDoubleBooking
BEFORE INSERT ON reservations
FOR EACH ROW
BEGIN
    DECLARE overlap_count INT;
    
    SELECT COUNT(*) INTO overlap_count
    FROM reservations
    WHERE room_id = NEW.room_id
      AND status = 'Confirmed'
      AND (NEW.check_in < check_out AND NEW.check_out > check_in);
      
    IF overlap_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Room is already booked for the selected dates.';
    END IF;
END //

DELIMITER ;

INSERT INTO users (username, password_hash, role) VALUES 
('admin', 'admin123', 'Admin'),
('staff', 'staff123', 'Staff');
INSERT INTO rooms (room_number, room_type, price_per_night) VALUES 
('101', 'Standard', 100.00),
('102', 'Deluxe', 150.00),
('201', 'Suite', 250.00),
('202', 'Ocean View', 300.00);

-- Run this to add new tables to an existing database (migration):
-- ALTER TABLE customer_bookings ADD COLUMN IF NOT EXISTS res_number VARCHAR(20) NULL;

