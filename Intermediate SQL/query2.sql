-- write your queries to insert data here

INSERT INTO client (first_name, last_name, email) VALUES
('Sara', 'Smith', 'smiths@hello.com'),
('Miguel', 'Cabrera', 'mc@hello.com'),
('Bo', "Chan'g", 'bochang@hello.com');

INSERT INTO employee (first_name, last_name, start_date, email) VALUES
('Ananya', 'Jaiswal', '2008-04-10', 'ajaiswal@hello.com'),
('Michael', 'Fern', '2015-07-19', 'michaelf@hello.com'),
('Abdul', 'Rehman', '2018-02-27', 'rehman@hello.com');

INSERT INTO project (cid, title, comments) VALUES
((SELECT id FROM client WHERE first_name = 'Sara' AND last_name = 'Smith'), 'Diamond', 'Should be done by Jan 2019'),
((SELECT id FROM client WHERE first_name = 'Bo' AND last_name = "Chan'g"), "Chan'g", 'Ongoing maintenance'),
((SELECT id FROM client WHERE first_name = 'Miguel' AND last_name = 'Cabrera'), 'The Robinson Project', NULL);

INSERT INTO works_on (eid, pid, due_date) VALUES
((SELECT id FROM employee WHERE first_name = 'Ananya' AND last_name = 'Jaiswal'),
 (SELECT id FROM project WHERE title = "Chan'g"),
 '2020-11-19'),

((SELECT id FROM employee WHERE first_name = 'Michael' AND last_name = 'Fern'),
 (SELECT id FROM project WHERE title = 'The Robinson Project'),
 '2020-12-05'),

((SELECT id FROM employee WHERE first_name = 'Abdul' AND last_name = 'Rehman'),
 (SELECT id FROM project WHERE title = 'Diamond'),
 '2021-01-01');

-- Leave the queries below untouched. These are to test your submission correctly.
select * from project;
select * from client;
select * from employee;
select * from works_on;
