CREATE TABLE Students (
    student_id SERIAL PRIMARY KEY, -- Уникальный идентификатор студента
    full_name VARCHAR(255) NOT NULL, -- Полное имя студента
    email VARCHAR(255) UNIQUE NOT NULL, -- Электронная почта студента (должна быть уникальной)
    start_year INT -- Год поступления студента
);

CREATE TABLE Courses (
    course_id SERIAL PRIMARY KEY, -- Уникальный идентификатор курса
    course_name VARCHAR(255) NOT NULL, -- Название курса
    credits INT CHECK (credits > 0) -- Количество зачетных единиц курса (должно быть больше 0)
);

CREATE TABLE Enrollments (
    student_id INT REFERENCES Students(student_id) ON DELETE CASCADE, -- Ссылка на ID студента (внешний ключ)
    course_id INT REFERENCES Courses(course_id) ON DELETE CASCADE, -- Ссылка на ID курса (внешний ключ)
    grade CHAR(1), -- Оценка студента за курс (например, 'A', 'B', 'C')
    PRIMARY KEY (student_id, course_id)
);

INSERT INTO students VALUES (DEFAULT, 'Алексей Смирнов', 'smirnov@gmail.com', 2021);
INSERT INTO students VALUES (DEFAULT, 'Елена Кузнецова', 'kuznec@mail.ru', 2022);
INSERT INTO students VALUES (DEFAULT, 'Дмитрий Новиков', 'novikov@yandex.ru', 2021);
INSERT INTO students VALUES (DEFAULT, 'Ольга Морозва', 'morozova@outlook.com', 2023);
INSERT INTO courses VALUES (DEFAULT, 'Введение в программирование', 5);
INSERT INTO courses VALUES (DEFAULT, 'Базы данных', 4);
INSERT INTO courses VALUES (DEFAULT, 'Веб-технологии', 4);

INSERT INTO enrollments VALUES (1,2,'A')

INSERT INTO enrollments VALUES (5,2,'B')

INSERT INTO enrollments VALUES (5,3, 'A')

INSERT INTO enrollments VALUES (4,1);
INSERT INTO enrollments VALUES (4,2);
INSERT INTO enrollments VALUES (4,3)

UPDATE students
SET email = 'elena.kuznetsova@newmail.com'
WHERE student_id = (5)

UPDATE enrollments
SET grade =  'A'
WHERE student_id = (4) AND course_id = (1)

DELETE FROM students
where student_id = (3)

select * from students 

select course_name, credits from courses

select * FROM students WHERE start_year = 2021

select course_name FROM courses where credits > 4 

select full_name from students where email = 'elena.kuznetsova@newmail.com'

SELECT * from students where full_name LIKE 'Дмитрий%'

select * from enrollments where grade ISNULL

SELECT * FROM courses ORDER BY course_name

SELECT * FROM students ORDER BY start_year

select * from students WHERE start_year = 2022 ORDER BY full_name 

select * from students

select * from students ORDER BY full_name DESC LIMIT 2