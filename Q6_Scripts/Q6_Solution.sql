drop table if exists  student_tests;
create table student_tests
(
    test_id int,
    marks int
);
insert into student_tests
values(100, 55);
insert into student_tests
values(101, 55);
insert into student_tests
values(102, 60);
insert into student_tests
values(103, 58);
insert into student_tests
values(104, 40);
insert into student_tests
values(105, 50);



-- Solution INCLUDING the first test marks
select test_id, marks
from(select *,
        lead(marks,1,marks) over(order by test_id) as lead,
        lag(marks,1,marks) over(order by test_id) as lag
    from student_tests) x
where marks = lead or (marks = lead and marks > lag) or (marks > lead and marks> lag)


-- Solution EXCLUDING the first test marks
select test_id, marks
from(select *,
        lead(marks,1,marks) over(order by test_id) as lead,
        lag(marks,1,marks) over(order by test_id) as lag
    from student_tests) x
where (marks = lead and marks > lag) or (marks > lead and marks> lag)

--select test_id,marks from(select *,
--lag(marks) over(order by test_id) as lag
--from student_tests)x
--where marks > lag