-- 1
CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(255),
    publisher_name VARCHAR(255),
    publisher_city VARCHAR(50)
);

CREATE TABLE authors (
    author_id INT PRIMARY KEY,
    author_name VARCHAR(255)
);

CREATE TABLE Books_Authors (
    book_id INT,
    author_id INT,
    FOREIGN KEY (book_id) REFERENCES Books (book_id),
    FOREIGN KEY (author_id) REFERENCES Authors (author_id)
);

-- 2
CREATE TABLE cars (
    car_id SERIAL PRIMARY KEY,
    car_model VARCHAR(100),
    car_manufacturer VARCHAR(100)
);

CREATE TABLE Drivers_Cars (
    car_id INT,
    driver_id INT,
    FOREIGN KEY (car_id) REFERENCES Cars (car_id),
    FOREIGN KEY (driver_id) REFERENCES Drivers (driver_id)
);

CREATE TABLE drivers (
    driver_id SERIAL PRIMARY KEY,
    driver_name VARCHAR(50)
);

CREATE TABLE races (
    race_id SERIAL PRIMARY KEY,
    driver_id INT,
    FOREIGN KEY (driver_id) REFERENCES Drivers (driver_id),
    finish_time TIME
);

-- 3
CREATE TABLE RoomBookings (
    booking_time DATETIME,
    room_name VARCHAR(100),
    event_name VARCHAR(255),
    event_type VARCHAR(50)
);

CREATE TABLE Rooms (
    room_id SERIAL PRIMARY KEY,
    room_name VARCHAR(100)
);

CREATE TABLE Eventes (
    event_id SERIAL PRIMARY KEY,
    event_name VARCHAR(255),
    event_type VARCHAR(50)
);

CREATE TABLE Eventes_Booking (
    event_id INT,
    booking_id INT,
    FOREIGN KEY (event_id) REFERENCES Eventes (event_id),
    FOREIGN KEY (booking_id) REFERENCES Booking (booking_id)
);

CREATE TABLE Rooms_Booking (
    room_id INT,
    booking_id INT,
    FOREIGN KEY (room_id) REFERENCES Rooms (room_id),
    FOREIGN KEY (booking_id) REFERENCES Booking (booking_id)
);

CREATE TABLE Booking (
    booking_id SERIAL PRIMARY KEY,
    booking_time DATE
);