insert into customer (phone, name) values (09213876127, 'reza'), (09127365423, 'sara'), (09346725283, 'gholi');

insert into city values ('shiraz'), ('tehran'), ('mashhad'), ('tabriz');

insert into customer_address (customer_id, city, address_line, coordinate)
values (1, 'shiraz', 'molasadra, mohandesi 2', point(12, 42));

insert into customer_address (customer_id, city, address_line, coordinate)
values (1, 'tehran', 'tajrish', point(16, 38)), (2, 'shiraz', 'farhang shahr', point(1, 2));


insert into restaurant (name, coordinate, profile, city, address_line) values
('zandiye', point(1, 2), 'https://google.com', 'mashhad', 'kuche 2');

insert into customer (id, name, phone) VALUES (6, 'alireza', '09231442154'), (7, 'mamad', '0976213742');

-- Insert data into the 'customer' table
INSERT INTO customer (name, phone) VALUES
  ('John Doe', '1234567890'),
  ('Jane Smith', '9876543210'),
  ('Alice Johnson', '1112223333'),
  ('Bob Williams', '4445556666'),
  ('Eva Davis', '7778889999'),
  ('Michael Brown', '5551112222'),
  ('Sophia Miller', '9998887777'),
  ('Matthew Taylor', '6667778888'),
  ('Olivia Martinez', '3334445555'),
  ('William Jones', '8889990000');

-- Insert data into the 'city' table
INSERT INTO city (name) VALUES
  ('New York'),
  ('Los Angeles'),
  ('Chicago'),
  ('San Francisco'),
  ('Houston'),
  ('Miami'),
  ('Seattle'),
  ('Boston'),
  ('Atlanta'),
  ('Denver');

-- Insert data into the 'customer_address' table
INSERT INTO customer_address (customer_id, city, address_line, coordinate) VALUES
  (1, 'New York', '123 Main St', point(40.7128, -74.0060)),
  (2, 'Los Angeles', '456 Oak St', point(34.0522, -118.2437)),
  (6, 'Chicago', '789 Pine St', point(41.8781, -87.6298)),
  (4, 'San Francisco', '101 Elm St', point(37.7749, -122.4194)),
  (5, 'Houston', '202 Cedar St', point(29.7604, -95.3698)),
  (6, 'Miami', '303 Maple St', point(25.7617, -80.1918)),
  (6, 'Seattle', '404 Birch St', point(47.6062, -122.3321)),
  (8, 'Boston', '505 Walnut St', point(42.3601, -71.0589)),
  (39, 'Atlanta', '606 Cherry St', point(33.7490, -84.3880)),
  (40, 'Denver', '707 Spruce St', point(39.7392, -104.9903));

-- Insert data into the 'restaurant' table
INSERT INTO restaurant (name, coordinate, profile, minimum_purchase, city, address_line) VALUES
  ('Restaurant A', point(40.730610, -73.935242), 'Profile A', 20, 'New York', '123 First St'),
  ('Restaurant B', point(34.052235, -118.243683), 'Profile B', 15, 'Los Angeles', '456 Second St'),
  ('Restaurant C', point(41.878113, -87.629799), 'Profile C', 25, 'Chicago', '789 Third St'),
  ('Restaurant D', point(37.774929, -122.419416), 'Profile D', 30, 'San Francisco', '101 Fourth St'),
  ('Restaurant E', point(29.760427, -95.369804), 'Profile E', 18, 'Houston', '202 Fifth St'),
  ('Restaurant F', point(25.761681, -80.191788), 'Profile F', 22, 'Miami', '303 Sixth St'),
  ('Restaurant G', point(47.606209, -122.332071), 'Profile G', 28, 'Seattle', '404 Seventh St'),
  ('Restaurant H', point(42.360081, -71.058880), 'Profile H', 35, 'Boston', '505 Eighth St'),
  ('Restaurant I', point(33.749001, -84.388031), 'Profile I', 19, 'Atlanta', '606 Ninth St'),
  ('Restaurant J', point(39.739235, -104.990250), 'Profile J', 24, 'Denver', '707 Tenth St');

-- Insert data into the 'menu_item' table
INSERT INTO menu_item (restaurant_id, title, ingredient, image, price) VALUES
  (1, 'Dish 1', 'Ingredient A', 'image1.jpg', 15),
  (1, 'Dish 2', 'Ingredient B', 'image2.jpg', 18),
  (2, 'Dish 3', 'Ingredient C', 'image3.jpg', 22),
  (2, 'Dish 4', 'Ingredient D', 'image4.jpg', 25),
  (3, 'Dish 5', 'Ingredient E', 'image5.jpg', 30),
  (3, 'Dish 6', 'Ingredient F', 'image6.jpg', 16),
  (4, 'Dish 7', 'Ingredient G', 'image7.jpg', 20),
  (4, 'Dish 8', 'Ingredient H', 'image8.jpg', 14),
  (5, 'Dish 9', 'Ingredient I', 'image9.jpg', 28),
  (5, 'Dish 10', 'Ingredient J', 'image10.jpg', 32);

-- Insert data into the 'restaurant_working_day' table
INSERT INTO restaurant_working_day (restaurant_id, week_day) VALUES
  (1, 'Monday'),
  (2, 'Tuesday'),
  (3, 'Wednesday'),
  (4, 'Thursday'),
  (5, 'Friday'),
  (6, 'Saturday'),
  (7, 'Sunday'),
  (8, 'Monday'),
  (9, 'Tuesday'),
  (10, 'Wednesday');

-- Insert data into the 'restaurant_working_time' table
INSERT INTO restaurant_working_time (rwd_id, open_at, close_at) VALUES
  (1, '10:00:00', '18:00:00'),
  (2, '11:00:00', '19:00:00'),
  (3, '09:00:00', '17:00:00'),
  (4, '12:00:00', '20:00:00'),
  (5, '08:00:00', '16:00:00'),
  (6, '15:00:00', '23:00:00'),
  (7, '14:00:00', '22:00:00'),
  (8, '13:00:00', '21:00:00'),
  (9, '16:00:00', '00:00:00'),
  (10, '17:00:00', '01:00:00');

-- Insert data into the 'delivery_cost' table
INSERT INTO delivery_cost (restaurant_id, max_radius, cost) VALUES
  (1, 5, 5),
  (2, 8, 8),
  (3, 10, 10),
  (4, 12, 12),
  (5, 15, 15),
  (6, 18, 18),
  (7, 20, 20);
