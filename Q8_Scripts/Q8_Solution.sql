drop table if exists job_skills;
create table job_skills
(
    row_id int,
    job_role varchar(20),
    skills varchar(20)
);
insert into job_skills
values
    (1, 'Data Engineer', 'SQL');
insert into job_skills
values
    (2, null, 'Python');
insert into job_skills
values
    (3, null, 'AWS');
insert into job_skills
values
    (4, null, 'Snowflake');
insert into job_skills
values
    (5, null, 'Apache Spark');
insert into job_skills
values
    (6, 'Web Developer', 'Java');
insert into job_skills
values
    (7, null, 'HTML');
insert into job_skills
values
    (8, null, 'CSS');
insert into job_skills
values
    (9, 'Data Scientist', 'Python');
insert into job_skills
values
    (10, null, 'Machine Learning');
insert into job_skills
values
    (11, null, 'Deep Learning');
insert into job_skills
values
    (12, null, 'Tableau');


select *
from job_skills;



-- Solution 1 - Using Window function
with
    cte
    as
    
    (
        select *, sum(flag) over(order by row_id) as sum
        from(select *,
                case
when job_role IS NOT NULL then 1
else 0 end as flag
            from job_skills)x
    )

select row_id,
    FIRST_VALUE(job_role) over(partition by sum order by row_id) as job_role, skills
from cte




with cte
as
(select *, sum(flag) over(order by row_id) as sum
from(select *,
        IIF(job_role is not null,1,0) as flag
    from job_skills)x)

select row_id,
    FIRST_VALUE(job_role) over(partition by sum order by row_id) as job_role, skills
from cte