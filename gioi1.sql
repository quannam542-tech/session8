create schema gioi1;
set search_path to gioi1;
CREATE TABLE employees (
                           emp_id SERIAL PRIMARY KEY,
                           emp_name VARCHAR(100),
                           job_level INT,
                           salary NUMERIC
);
INSERT INTO employees (emp_name, job_level, salary)
VALUES
    ('Nguyễn Văn An', 1, 8000000),
    ('Trần Thị Bình', 2, 12000000),
    ('Lê Văn Cường', 3, 18000000),
    ('Phạm Thị Dung', 2, 13000000),
    ('Hoàng Văn Em', 4, 25000000);


create or REPLACE PROCEDURE  adjust_salary(p_emp_id INT, OUT p_new_salary NUMERIC)
language plpgsql
as $$
    declare v_salary numeric; v_job_level INT;

    begin
        SELECT job_level, salary
        INTO v_job_level, v_salary
        FROM employees
        WHERE emp_id = p_emp_id;
        IF v_job_level IS NULL THEN
            RAISE EXCEPTION 'Không tìm thấy nhân viên với id %', p_emp_id;
        END IF;


        IF v_job_level = 1 THEN
            p_new_salary := v_salary * 1.05;
        ELSIF v_job_level = 2 THEN
            p_new_salary := v_salary * 1.10;
        ELSIF v_job_level = 3 THEN
            p_new_salary := v_salary * 1.15;
        ELSE
            p_new_salary := v_salary;
        END IF;
        UPDATE employees
        SET salary = p_new_salary
        WHERE emp_id = p_emp_id;

    end;

    $$;


call adjust_salary(1,null);