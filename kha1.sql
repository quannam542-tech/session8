create schema kha1;
set search_path to kha1;
CREATE TABLE order_detail (
                              id SERIAL PRIMARY KEY,
                              order_id INT,
                              product_name VARCHAR(100),
                              quantity INT,
                              unit_price NUMERIC
);
INSERT INTO order_detail (order_id, product_name, quantity, unit_price)
VALUES
    (1, 'Laptop Dell XPS 13', 1, 25000000),
    (1, 'Chuột Logitech MX Master 3', 1, 1500000),
    (2, 'Bàn phím cơ Keychron K2', 2, 1800000);
create or REPLACE PROCEDURE  calculate_order_total(order_id_input INT, OUT total NUMERIC)
language plpgsql
as $$
    begin
        SELECT SUM(quantity * unit_price)
        INTO total
        FROM order_detail
        WHERE order_id = order_id_input;


    end;


$$;
call calculate_order_total(1,null);

