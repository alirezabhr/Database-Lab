-- Retrieve all customers
select * from customer;

-- Retrieve all customers' name and phone
select name, phone from customer;

-- Find the count of customers
select count(*) from customer;

-- Retrieve all customers whose name starts with 's'
select * from customer where name like 's%';


-- Retrieve all customers who have been registered in last month
select * from customer where registered_at between Now()-cast('1 months' as interval) and Now();
select * from customer where registered_at > Now()-cast('1 months' as interval);


-- Retrieve all customers with their addresses
select * from customer, customer_address where customer_address.customer_id = customer.id;
select * from customer join customer_address on customer.id = customer_address.customer_id;


-- Retrieve all customers' id, name, phone and the details of their default address
select customer_id, name, phone, city, address_line, coordinate, is_default
from customer join customer_address on customer.id = customer_address.customer_id;

select customer.*,  city, address_line, coordinate
from customer join customer_address on customer.id = customer_address.customer_id
where is_default=true;


-- Update customers' phone number if their phone does not start with '0'
update customer set phone = '0' || phone
where phone not in (select phone from customer where phone like '0%');


-- Retrieve all customers' id, name, phone and the details of their default address
select order_item.quantity, order_item.price, invoice.status from order_item
join invoice on order_item.order_id = invoice.id
join customer_address on invoice.customer_address_id = customer_address.id
where customer_address.customer_id = 1
order by invoice.ordered_at;


-- Retrieve all restaurants' details and the total number of orders of each
select restaurant.id, restaurant.name, count(order_item.id) as number_of_orders from restaurant
join menu_item on restaurant.id = menu_item.restaurant_id
join order_item on menu_item.id = order_item.menu_item_id
group by restaurant.id, restaurant.name
order by number_of_orders desc, restaurant.name;


-- Find the info of 5 best customers sort by the number of orders for each
select customer.id, customer.name, customer.phone, count(invoice) from customer 
join customer_address on customer.id = customer_address.customer_id
join invoice on customer_address.id = invoice.customer_address_id
group by customer.id, customer.name, customer.phone
order by count desc
limit 5;


-- Find the details and total price of each order
select invoice.id, invoice.status, invoice.ordered_at, sum(order_item.price*order_item.quantity) as total_price
from invoice join order_item on invoice.id = order_item.id
group by invoice.id, invoice.status, invoice.ordered_at
order by total_price desc;


-- Find the details and total price of each successful order 
select invoice.id, invoice.status, invoice.ordered_at, sum(order_item.price*order_item.quantity) as total_price
from invoice join order_item on invoice.id = order_item.id
where invoice.status != 'Failed'
group by invoice.id, invoice.status, invoice.ordered_at
order by total_price desc;


-- Find the details and total price of each successful order which their total price is greater than 20
select invoice.id, invoice.status, invoice.ordered_at, sum(order_item.price*order_item.quantity) as total_price
from invoice join order_item on invoice.id = order_item.id
where invoice.status != 'Failed'
group by invoice.id, invoice.status, invoice.ordered_at
--!!! having total_price > 20
having sum(order_item.price*order_item.quantity) > 20
order by total_price desc;


-- Find the info of 5 best customers sort by the total paid amount of orders
select customer.id, customer.name, customer.phone, sum(invoice) from customer 
join customer_address on customer.id = customer_address.customer_id
join invoice on customer_address.id = invoice.customer_address_id
join order_item on invoice.id = order_item.order_id
group by customer.id, customer.name, customer.phone
order by count desc
limit 5;


-- Retrieve all restaurants and their distances to each customer's default address
select ca.*, restaurant.name, restaurant.coordinate, sqrt(power((ca.coordinate[0]-restaurant.coordinate[0]), 2)+power((ca.coordinate[1]-restaurant.coordinate[1]), 2)) as distance
from (select customer.*,  city, address_line, coordinate
from customer join customer_address on customer.id = customer_address.customer_id
where is_default=true) as ca, restaurant where ca.city = restaurant.city
order by distance;

SELECT 
    ca.*,
    r.name AS restaurant_name,
    r.coordinate,
    SQRT(POWER((ca.coordinate[0] - r.coordinate[0]), 2) + POWER((ca.coordinate[1] - r.coordinate[1]), 2)) AS distance
FROM 
    (
        SELECT 
            c.*,
            ca.city,
            ca.address_line,
            ca.coordinate
        FROM 
            customer c
            JOIN customer_address ca ON c.id = ca.customer_id
        WHERE 
            ca.is_default = true
    ) AS ca
    JOIN restaurant r ON ca.city = r.city
ORDER BY distance;


-- Retrieve the nearest restaurant to each customer's default address and their distance
SELECT DISTINCT ON (ca.id)
    ca.id AS customer_address_id,
    c.name AS customer_name,
    r.name AS restaurant_name,
    r.coordinate AS restaurant_coordinate,
    ca.coordinate AS customer_coordinate,
    SQRT(POWER((ca.coordinate[0] - r.coordinate[0]), 2) + POWER((ca.coordinate[1] - r.coordinate[1]), 2)) AS distance
FROM 
    customer c
    JOIN customer_address ca ON c.id = ca.customer_id
    JOIN restaurant r ON ca.city = r.city
WHERE 
    ca.is_default = true
ORDER BY 
    ca.id, distance;


-- Retrieve the second nearest restaurant to each customer's default address and their distance
SELECT
        ca.id AS customer_address_id,
        c.name AS customer_name,
        r.name AS restaurant_name,
        r.coordinate AS restaurant_coordinate,
        ca.coordinate AS customer_coordinate,
        SQRT(POWER((ca.coordinate[0] - r.coordinate[0]), 2) + POWER((ca.coordinate[1] - r.coordinate[1]), 2)) AS distance,
        ROW_NUMBER() OVER (PARTITION BY ca.id ORDER BY SQRT(POWER((ca.coordinate[0] - r.coordinate[0]), 2) + POWER((ca.coordinate[1] - r.coordinate[1]), 2))) AS restaurant_rank
    FROM
        customer c
        JOIN customer_address ca ON c.id = ca.customer_id
        JOIN restaurant r ON ca.city = r.city
    WHERE
        ca.is_default = true;

SELECT * from (SELECT
        ca.id AS customer_address_id,
        c.name AS customer_name,
        r.name AS restaurant_name,
        r.coordinate AS restaurant_coordinate,
        ca.coordinate AS customer_coordinate,
        SQRT(POWER((ca.coordinate[0] - r.coordinate[0]), 2) + POWER((ca.coordinate[1] - r.coordinate[1]), 2)) AS distance,
        ROW_NUMBER() OVER (PARTITION BY ca.id ORDER BY SQRT(POWER((ca.coordinate[0] - r.coordinate[0]), 2) + POWER((ca.coordinate[1] - r.coordinate[1]), 2))) AS near_rank
    FROM
        customer c
        JOIN customer_address ca ON c.id = ca.customer_id
        JOIN restaurant r ON ca.city = r.city
    WHERE ca.is_default = true) as Ranked_Restaurant
	WHERE near_rank=2;









