
create schema xuatsac1;
set search_path to xuatsac1
;
CREATE TABLE employees (
                           id SERIAL PRIMARY KEY,
                           name VARCHAR(100) NOT NULL,
                           department VARCHAR(50),
                           salary NUMERIC(10,2),
                           bonus NUMERIC(10,2) DEFAULT 0,
                           status VARCHAR(20) DEFAULT 'active'
);

INSERT INTO employees (name, department, salary, status) VALUES
                                                             ('Nguyen Van A', 'HR', 4000, 'active'),
                                                             ('Tran Thi B', 'IT', 6000, 'inactive'),
                                                             ('Tran Thi 3', 'IT', 3000, 'inactive')


                                                            ;



create or  REPLACE PROCEDURE update_employee_status(p_emp_id INT,p_status TEXT )
LANGUAGE plpgsql
as $$
    declare d_salary numeric;


    begin
select salary into d_salary
    from employees
        where id=p_emp_id;

if d_salary is null then
    raise exception 'không tìm thấy id %id', p_emp_id;
   end if;
if d_salary <5000 then
    p_status :='junior';
    elsif d_salary BETWEEN 5000 AND 10000 then
 p_status:= 'Mid-level';
else
        p_status:='Senior';
end if;

update employees set status = p_status
        where id=p_emp_id;







    end;

    $$;

call update_employee_status(1,null);
