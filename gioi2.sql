
create schema gioi2;
set search_path to gioi2;
CREATE TABLE products (
                          id SERIAL PRIMARY KEY,
                          name VARCHAR(100),
                          price NUMERIC,
                          discount_percent INT
);
INSERT INTO products (name, price, discount_percent)
VALUES
    ('Laptop Dell XPS 13', 25000000, 10),
    ('Chuột Logitech MX Master 3', 1500000, 5),
    ('Bàn phím cơ Keychron K2', 1800000, 15),
    ('Tai nghe Sony WH-1000XM5', 6000000, 20),
    ('Màn hình LG UltraFine 27"', 12000000, 12);

create or REPLACE PROCEDURE  p_calculate_discount(p_id INT, OUT p_final_price NUMERIC)

language plpgsql

as

    $$
declare p_price numeric ; p_discount int; v_effective_discount int ;
begin
   select price ,discount_percent into p_price,p_discount
    from products
where id = p_id;
   IF p_price IS NULL THEN
       RAISE EXCEPTION 'Không tìm thấy sản phẩm với id %', p_id;
   END IF;

   IF p_discount > 50 THEN
       v_effective_discount := 50;
   ELSE
       v_effective_discount := p_discount;
   END IF;

   p_final_price := p_price - (p_price * v_effective_discount / 100);


   UPDATE products
   SET price = p_final_price
   WHERE id = p_id;
END;



$$;

call  p_calculate_discount(1,null);