
CREATE OR REPLACE FUNCTION calculate_total(price integer, quantity integer)
RETURNS integer AS
$$
BEGIN
   RETURN price * quantity;
END;
$$
LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION find_distance(p1 point, p2 point)
RETURNS numeric AS
$$
BEGIN
   RETURN sqrt(power(p1[0]-p2[0], 2) + power(p1[1]-p2[1], 2));
END;
$$
LANGUAGE plpgsql;

drop function find_distance;

select find_distance(point(1, 6), point(2, 10));


alter table invoice add column updated_at timestamp;


create or replace function trigger_set_timestamp()
returns trigger as
$$
begin
	new.updated_at = NOW();
	return new;
end
$$ language plpgsql;


CREATE TRIGGER set_timestamp
BEFORE UPDATE ON invoice
FOR EACH ROW
EXECUTE FUNCTION trigger_set_timestamp();

-- Test invoice updated_at trigger
select * from invoice;
update invoice set customer_address_id = 2 where id = 1;



-- Customer address default value trigger function
CREATE OR REPLACE FUNCTION set_default_customer_address()
RETURNS TRIGGER AS $$
DECLARE address_count INT;
BEGIN
    IF NEW.is_default THEN
        -- If the new address is set as default, update other addresses for the same customer to not be default
        UPDATE customer_address
        SET is_default = false
        WHERE customer_id = NEW.customer_id AND id <> NEW.id;
    ELSE
        -- If the new address is not set as default, check if it's the first address for the customer
        SELECT COUNT(*) INTO address_count
        FROM customer_address
        WHERE customer_id = NEW.customer_id;

        IF address_count = 0 THEN
            NEW.is_default := true; -- Set as default if it's the first address
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create the trigger
CREATE TRIGGER before_insert_customer_address
BEFORE INSERT ON customer_address
FOR EACH ROW
EXECUTE FUNCTION set_default_customer_address();


insert into customer_address (customer_id, city, address_line, coordinate, is_default)
values (default, 1, 'shiraz', 'Maaliabad', point(3, 4), true);


insert into customer_address 
values (default, 3, 'shiraz', 'Maaliabad', point(3, 4), false)
, (default, 2, 'tehran', 'unvaresh', point(33, 44), false);


