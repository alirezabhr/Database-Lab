CREATE TABLE customer (
	id SERIAL PRIMARY KEY,
	name varchar(60) not null,
	phone varchar(11) not null unique
);

CREATE TABLE city (
	name varchar(60) PRIMARY KEY
);

CREATE TABLE customer_address (
	id SERIAL PRIMARY KEY,
	customer_id int not null,
	city varchar(60) not null references city(name),
	address_line text not null,
	coordinate point not null,
	CONSTRAINT fk_customer
      FOREIGN KEY(customer_id) 
	  	REFERENCES customer(id)
		ON DELETE CASCADE
);


CREATE TABLE restaurant (
	id SERIAL PRIMARY KEY,
	name varchar(50) not NULL,
	coordinate point not NULL
);

ALTER TABLE restaurant ADD COLUMN profile varchar(300) not null;
ALTER TABLE restaurant ADD COLUMN minimum_purchase int;
ALTER TABLE restaurant ADD COLUMN city varchar(60) not null references city(name);
ALTER TABLE restaurant ADD COLUMN address_line text not null;

CREATE TABLE menu_item (
	id SERIAL PRIMARY KEY,
	restaurant_id int not null references restaurant(id),
	title varchar(40) not NULL,
	ingredient varchar(200),
	image varchar(300) not null,
	price int
);


CREATE TYPE weekday AS ENUM ('Saturday', 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday');



CREATE TABLE restaurant_working_day (
	id serial primary key,
	restaurant_id int references restaurant(id) not null,
	week_day weekday not null
);


Create table restaurant_working_time (
	id serial primary key,
	rwd_id int references restaurant_working_day(id) not null,
	open_at time not null,
	close_at time not null
);



CREATE TABLE delivery_cost (
	id SERIAL PRIMARY KEY,
	restaurant_id int not null references restaurant(id),
	max_radius smallint not null,
	cost smallint not null
);


CREATE TYPE order_status as ENUM ('Ordered', 'Paid', 'Prepared', 'Delivered', 'Failed');


CREATE TABLE restaurant_order (
	id serial primary key,
	ordered_at timestamp not null,
	customer_address_id int references customer_address(id) on delete set null,
	status order_status not null
);



Create table order_item (
	id serial primary key,
	order_id int references restaurant_order(id) not null,
	menu_item_id int not null,
	quantity smallint not null,
	price int not null,
	constraint fk_menu_item
		foreign key (menu_item_id)
		references menu_item(id)
);


Create TABLE review (
	id serial primary key,
	order_item_id int references order_item(id) not null,
	rate smallint not null,
	comment text not null
);

