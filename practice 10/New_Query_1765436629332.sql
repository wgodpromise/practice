CREATE TABLE Projects (
    project_id SERIAL PRIMARY KEY,
    project_name VARCHAR(255) NOT NULL
 -- Пример: 'Алексеев, Борисов, Васильева'
);

CREATE TABLE team_members (
    member_id SERIAL PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL,
    project_id INT,
    Foreign Key (project_id) REFERENCES Projects(project_id)
);

CREATE TABLE EquipmentRentals (
    client_id INT,
    equipment_id INT,
    client_name VARCHAR(255),    -- Имя клиента
    client_email VARCHAR(255),   -- Email клиента
    equipment_name VARCHAR(255), -- Название оборудования
    rental_date DATE,            -- Дата аренды
    PRIMARY KEY (client_id, equipment_id)
);

CREATE TABLE Clients (
    client_id SERIAL PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL,
    client_email VARCHAR(50) NOT NULL UNIQUE

);

CREATE TABLE clients_equipment (
    client_equipment_id SERIAL PRIMARY KEY,
    client_id INT NOT NULL,
    equipment_id INT NOT NULL,
    rental_date DATE NOT NULL,
    Foreign Key (client_id) REFERENCES Clients(client_id),
    Foreign Key (equipment_id) REFERENCES Equipment(equipment_id)
);

CREATE TABLE Equipment (
    equipment_id SERIAL PRIMARY KEY,
    equipment_name VARCHAR(50) NOT NULL
);

CREATE TABLE StudentGrades (
    student_id INT,
    course_id INT,
    student_name VARCHAR(255),
    course_professor VARCHAR(255),
    assignments_and_grades TEXT, -- Пример содержимого: '{"Quiz 1": 85, "Midterm": 92, "Essay": 88}'
    PRIMARY KEY (student_id, course_id)
);

CREATE TABLE Students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(50) NOT NULL
);

CREATE TABLE Courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR (50) NOT NULL,
    student_id INT,
    professor_id INT,
    Foreign Key (student_id) REFERENCES Students(student_id),
    Foreign Key (professor_id) REFERENCES Professors(professor_id)
);

CREATE TABLE Professors (
    professor_id SERIAL PRIMARY KEY,
    professor_name VARCHAR(50) NOT NULL
);

CREATE TABLE Grades (
    assignments_id SERIAL PRIMARY KEY,
    assignments_name VARCHAR (50) NOT NULL,
    student_id INT,
    grade SMALLINT,
    Foreign Key (student_id) REFERENCES Students(student_id)
)
