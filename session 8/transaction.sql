
alter table review add constraint order_item_unique unique(order_item_id);

insert into review (order_item_id, rate)
values (4, 1);

insert into review (order_item_id, rate)
values (5, 4)
returning *;


insert into review (order_item_id, rate)
values (5, 4)
on conflict (order_item_id)
do update set rate = 4
returning *;


-- SHOW the following in 2 different terminals
begin;
select rate from review where order_item_id = 5;
update review set rate = 7 where order_item_id = 5;
select rate from review where order_item_id = 5;
-- ROLLBACK OR COMMIT
rollback;
commit;


-- Terminal 1
begin;
select rate from review where order_item_id = 5;
update review set rate = 7 where order_item_id = 5;
select rate from review where order_item_id = 5;
rollback;


-- Terminal 2
begin;
select rate from review where order_item_id = 5;
update review set rate = 1 where order_item_id = 5;
select rate from review where order_item_id = 5;
commit;