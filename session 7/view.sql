-- Restaurants with their number of menu items (LEFT JOIN)
select restaurant.id, restaurant.name, count(menu_item.id) as menu_item_count
from restaurant left join menu_item on restaurant.id = menu_item.restaurant_id
group by restaurant.id;



-- Resturants which their rate average is more than 4
CREATE VIEW good_restaurant AS
SELECT restaurant.id,
    restaurant.name,
    restaurant.profile,
    avg(review.rate) AS avg_rate
   FROM restaurant
     JOIN menu_item ON restaurant.id = menu_item.restaurant_id
     JOIN order_item ON menu_item.id = order_item.menu_item_id
     JOIN review ON order_item.id = review.order_item_id
  GROUP BY restaurant.id, restaurant.name, restaurant.profile
HAVING avg(review.rate) >= 4
ORDER BY avg_rate;


select * from good_restaurant;
select name, avg_rate from good_restaurant;


-- CREATE MATERIALIZED VIEW view_name
-- AS
-- query
-- WITH [NO] DATA;

-- DROP MATERIALIZED VIEW view_name;



-- Customers' info with the total paid for their successful invoices
create materialized view customer_info as
select customer.id, customer.name, customer.phone, sum(order_item.price * order_item.quantity) as total_paid
from customer join customer_address on customer.id = customer_address.customer_id
join invoice on customer_address.id = invoice.customer_address_id
join order_item on invoice.id = order_item.invoice_id
where invoice.status != 'Failed' and invoice.ordered_at > Now() - CAST('1 months' as interval)
group by customer.id
having sum(order_item.price * order_item.quantity) > 25
order by total_paid desc, customer.id
with data;

select * from customer_info;
