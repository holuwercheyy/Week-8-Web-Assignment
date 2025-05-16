-- Create database
CREATE DATABASE IF NOT EXISTS hotel;
USE hotel;

-- guest table
CREATE TABLE guest(
guest_id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
phone_number VARCHAR(50)
);

-- payment table 
CREATE TABLE payment_status(
payment_id INT PRIMARY KEY AUTO_INCREMENT,
payment_status_name VARCHAR(20) DEFAULT "NOT PAID"
);

-- booking table
CREATE TABLE IF NOT EXISTS booking(
booking_id INT PRIMARY KEY AUTO_INCREMENT,
guest_id INT,
payment_status_id INT,
checkin_date DATETIME DEFAULT CURRENT_TIMESTAMP,
checkout_date DATETIME DEFAULT CURRENT_TIMESTAMP,
num_adults INT,
num_children INT,
booking_amount DECIMAL(10,2) CHECK(booking_amount>0),
FOREIGN KEY(guest_id) REFERENCES guest(guest_id),
FOREIGN KEY(payment_status_id) REFERENCES payment_status(payment_id)
);

-- addon table
CREATE TABLE addon(
addon_id INT PRIMARY KEY AUTO_INCREMENT,
addon_name VARCHAR(100) NOT NULL,
price DECIMAL(10,2)
);

-- booking_addon table
CREATE TABLE booking_addon(
booking_id INT NOT NULL,
addon_id INT NOT NULL,
FOREIGN KEY(booking_id) REFERENCES booking(booking_id),
FOREIGN KEY(addon_id) REFERENCES addon(addon_id) 
);

-- bed_type table
CREATE TABLE bed_type(
bed_type_id INT PRIMARY KEY AUTO_INCREMENT,
bed_type_name VARCHAR(100)
);

-- room_class table 
CREATE TABLE room_class(
room_class_id INT PRIMARY KEY AUTO_INCREMENT,
class_name VARCHAR(100),
base_price DECIMAL(10,2)
);

-- feature table 
CREATE TABLE feature(
feature_id INT PRIMARY KEY AUTO_INCREMENT,
feature_name VARCHAR(100)
);

-- room_class_feature table 
CREATE TABLE room_class_feature(
room_class_id  INT,
feature_id INT,
FOREIGN KEY (room_class_id) REFERENCES room_class(room_class_id),
FOREIGN KEY (feature_id) REFERENCES feature(feature_id)
);

-- room_class_bed_type table
CREATE TABLE room_class_bed_type(
  id INT PRIMARY KEY AUTO_INCREMENT,
  room_class_id INT,
  bed_type_id INT,
  num_beds INT,
  FOREIGN KEY (room_class_id) REFERENCES room_class(room_class_id),
  FOREIGN KEY (bed_type_id) REFERENCES bed_type(bed_type_id)
);

-- room_status table 
CREATE TABLE room_status(
id INT PRIMARY KEY AUTO_INCREMENT,
status_name VARCHAR(100)
);

-- floor table 
CREATE TABLE floor(
floor_id INT PRIMARY KEY AUTO_INCREMENT,
floor_number VARCHAR(5)
);

-- room table
CREATE TABLE room(
room_id INT PRIMARY KEY AUTO_INCREMENT,
room_number VARCHAR(10),
status_id INT,
room_class_id INT,
floor_id INT,
FOREIGN KEY (status_id) REFERENCES room_status(id),
FOREIGN KEY (room_class_id) REFERENCES room_class(room_class_id),
FOREIGN KEY (floor_id) REFERENCES floor(floor_id)
);

-- booking_room table 
CREATE TABLE booking_room(
booking_id INT,
room_id INT,
FOREIGN KEY (booking_id) REFERENCES booking(booking_id),
FOREIGN KEY (room_id) REFERENCES room(room_id)
);