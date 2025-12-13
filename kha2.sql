
create schema kha2;
set search_path to kha2;
CREATE TABLE inventory (
                           product_id SERIAL PRIMARY KEY,
                           product_name VARCHAR(100),
                           quantity INT
);
INSERT INTO inventory (product_name, quantity)
VALUES
    ('Laptop Dell XPS 13', 10),
    ('Chuột Logitech MX Master 3', 25),
    ('Bàn phím cơ Keychron K2', 15),
    ('Tai nghe Sony WH-1000XM5', 20),
    ('Màn hình LG UltraFine 27"', 8);
create or REPLACE PROCEDURE check_stock(p_id INT, p_qty INT)
language plpgsql
as $$
    declare current_qty int;
    begin
        select quantity into current_qty from inventory
        where product_id=p_id;

        IF current_qty IS NULL THEN
            RAISE EXCEPTION 'Sản phẩm với id % không tồn tại trong kho', p_id;

        ELSIF current_qty < p_qty THEN
            RAISE EXCEPTION 'Không đủ hàng trong kho. Hiện có % cái, yêu cầu % cái', current_qty, p_qty;
        ELSE
            RAISE NOTICE 'Đủ hàng: hiện có % cái, yêu cầu % cái', current_qty, p_qty;
        END IF;


    end;

    $$;

call check_stock(9,0);
call check_stock(1,0);
call check_stock(1,40);
