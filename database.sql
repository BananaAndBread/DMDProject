DROP TABLE IF EXISTS provider_has_car_part;
DROP TABLE IF EXISTS providers;
DROP TABLE IF EXISTS repair_used_car_part;
DROP TABLE IF EXISTS repairs;
DROP TABLE IF EXISTS workshop_has_type_of_car_part;
DROP TABLE IF EXISTS workshops;
DROP TABLE IF EXISTS types_of_car_parts;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS charges;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS charging_stations_has_type_of_plug;
DROP TABLE IF EXISTS types_of_plugs;
DROP TABLE IF EXISTS charging_stations;
DROP TABLE IF EXISTS cars;
DROP TABLE IF EXISTS types_of_cars;


CREATE TABLE IF NOT EXISTS types_of_cars(
  id SERIAL PRIMARY KEY,
  name VARCHAR(32) NOT NULL
);

CREATE TABLE IF NOT EXISTS cars (
  id SERIAL PRIMARY KEY,
  color VARCHAR (32) NOT NULL,
  plate_number VARCHAR (32) NOT NULL,
  launch_date TIMESTAMP,
  type_of_car_id INTEGER REFERENCES types_of_cars(id)
);

CREATE TABLE IF NOT EXISTS charging_stations (
  id SERIAL PRIMARY KEY,
  price_per_second FLOAT NOT NULL,
  amount_of_available_sockets INT NOT NULL,
  time_of_charging FLOAT NOT NULL
);

CREATE TABLE IF NOT EXISTS types_of_plugs(
  id SERIAL PRIMARY KEY,
  type VARCHAR (32) NOT NULL
);

CREATE TABLE IF NOT EXISTS charging_stations_has_type_of_plug(
  charging_station_id INTEGER REFERENCES charging_stations(id) NOT NULL,
  type_of_plug_id INTEGER REFERENCES types_of_plugs(id) NOT NULL,
  PRIMARY KEY (charging_station_id, type_of_plug_id)
);

CREATE TABLE  IF NOT EXISTS users(
  id SERIAL PRIMARY KEY,
  address_lat FLOAT NOT NULL,
  address_long FLOAT NOT NULL,
  full_name VARCHAR(32) NOT NULL,
  username VARCHAR(32) NOT NULL,
  phone_number VARCHAR(32) NOT NULL,
  email VARCHAR(32) NOT NULL


);

CREATE TABLE IF NOT EXISTS charges (
  id SERIAL PRIMARY KEY,
  car_id INTEGER REFERENCES cars(id) NOT NULL,
  cs_id INTEGER REFERENCES charging_stations(id) NOT NULL,
  start_time TIMESTAMP NOT NUll

);

CREATE TABLE IF NOT EXISTS orders(
  id SERIAL PRIMARY KEY,
  price DECIMAL(20, 2) NOT NULL ,
  pick_up_time TIMESTAMP,
  creation_time TIMESTAMP NOT NULL,
  dropoff_time TIMESTAMP,
  car_id INTEGER REFERENCES cars(id) NOT NULL,
  user_id INTEGER REFERENCES users(id) NOT NULL,
  pick_up_lat FLOAT NOT NULL,
  pick_up_long FLOAT NOT NULL,
  car_location_upon_order_creation_lat FLOAT NOT NULL ,
  car_location_upon_order_creation_long FLOAT NOT NULL,
  dropoff_lat FLOAT NOT NULL,
  dropoff_long FLOAT NOT NULL

);

CREATE TABLE IF NOT EXISTS payments (
  id SERIAL PRIMARY KEY ,
  price INTEGER NOT NULL ,
  order_id INTEGER REFERENCES orders(id)
);

CREATE TABLE IF NOT EXISTS types_of_car_parts (
  id SERIAL PRIMARY KEY,
  name VARCHAR(32) NOT NULL,
  price FLOAT NOT NULL
);

CREATE TABLE IF NOT EXISTS workshops (
  id SERIAL PRIMARY KEY,
  creation_time TIMESTAMP NOT NULL,
  location_lat FLOAT NOT NULL ,
  location_long FLOAT NOT NULL


);


CREATE TABLE IF NOT EXISTS workshop_has_type_of_car_part (
  workshop_id INTEGER REFERENCES workshops(id),
  type_car_part_id INTEGER REFERENCES types_of_car_parts(id),
  PRIMARY KEY (workshop_id, type_car_part_id)
);

CREATE TABLE IF NOT EXISTS repairs (
  id SERIAL PRIMARY KEY,
  workshop_id INTEGER REFERENCES workshops(id),
  car_id INTEGER REFERENCES cars(id),
  repair_start_time TIMESTAMP NOT NULL,
  repair_finish_time TIMESTAMP
);

CREATE TABLE IF NOT EXISTS repair_used_car_part(
  repair_id INTEGER REFERENCES repairs(id),
  type_car_part_id INTEGER REFERENCES types_of_car_parts(id),
  number INTEGER NOT NULL,
  PRIMARY KEY (repair_id, type_car_part_id)
);
CREATE TABLE IF NOT EXISTS providers(
  id SERIAL PRIMARY KEY,
  name VARCHAR(32) NOT NULL,
  phone_number VARCHAR(32) NOT NULL
);
CREATE TABLE IF NOT EXISTS provider_has_car_part(
  provider_id INTEGER REFERENCES providers(id),
  type_car_part_id INTEGER REFERENCES types_of_car_parts(id),
  number INTEGER  NOT NULL,
  PRIMARY KEY (provider_id, type_car_part_id )
);

INSERT INTO types_of_cars (name) VALUES
  ('type of car 1'),
  ('type of car 2'),
  ('type of car 3');
INSERT INTO cars (color, plate_number, launch_date, type_of_car_id) VALUES
  ('red', 'AN5025', TIMESTAMP '2018-11-09 18:25:42', 1),
  ('blue', 'asdf508', TIMESTAMP '2018-11-09 18:25:42',2),
  ('violet', 'plate_number3', TIMESTAMP '2018-11-09 18:25:42', 3);

INSERT INTO users (address_lat, address_long, full_name, username, phone_number, email) VALUES
  (121, 131, 'full_name1', 'username1', 'phone_number1', 'email1' ),
  (121, 131, 'full_name2', 'username2', 'phone_number2', 'email2' ),
  (121, 131, 'full_name3', 'username3', 'phone_number3', 'email3' );


INSERT INTO orders (price, pick_up_time, creation_time, dropoff_time, car_id, user_id, pick_up_lat, pick_up_long,
                    car_location_upon_order_creation_lat, car_location_upon_order_creation_long, dropoff_lat,
                    dropoff_long) VALUES
  (123, TIMESTAMP '2018-11-09 18:31:42', TIMESTAMP '2018-11-09 18:25:42', TIMESTAMP '2018-11-09 19:25:42', 1, 1, 0, 0,
      1, 0, 0, 0),
  (123, TIMESTAMP '2018-11-10 18:31:42', TIMESTAMP '2018-11-10 18:25:42', TIMESTAMP '2018-11-10 19:25:42', 1, 1, 0, 0,
      2, 0, 0, 0),
  (123, TIMESTAMP '2018-11-10 18:31:42', TIMESTAMP '2018-11-10 18:25:42', TIMESTAMP '2018-11-10 19:25:42', 2, 1, 0, 0,
      23, 27, 65, 94),
  (123, TIMESTAMP '2018-11-10 8:31:42', TIMESTAMP '2018-11-10 8:25:42', TIMESTAMP '2018-11-10 9:25:42', 1, 1, 0, 0,
      23, 27, 65, 94),
  (123, TIMESTAMP '2018-11-10 8:31:42', TIMESTAMP '2018-11-10 8:25:42', TIMESTAMP '2018-11-10 9:25:42', 1, 2, 0, 0,
      5, 0, 0, 0);


INSERT INTO charging_stations (price_per_second, amount_of_available_sockets, time_of_charging) VALUES
  (1, 5, 1),
  (20, 5, 60);

INSERT INTO charges (car_id, cs_id, start_time) VALUES
  (1, 1, TIMESTAMP '2018-11-10 8:25:42'),
  (2, 1, TIMESTAMP '2018-11-10 8:25:42'),
  (1, 1, TIMESTAMP '2018-11-10 8:26:42'),
  (1, 1, TIMESTAMP '2018-11-10 8:26:42'),
  (1, 1, TIMESTAMP '2018-11-10 8:59:42'),
  (1, 1, TIMESTAMP '2015-11-10 8:59:42');

INSERT INTO workshops (creation_time, location_lat, location_long) VALUES
 (TIMESTAMP '2015-12-10 8:25:42', 212, 212),
 (TIMESTAMP '2018-11-7 8:25:42', 313, 59);

INSERT INTO repairs (workshop_id, car_id, repair_start_time, repair_finish_time) VALUES
  (1, 1, TIMESTAMP '2018-12-10 8:25:42', TIMESTAMP '2018-12-10 8:26:43'),
  (1, 1, TIMESTAMP '2015-12-10 8:59:42', TIMESTAMP '2015-12-10 9:00:43'),
  (1, 2, TIMESTAMP '2018-12-10 8:25:42', TIMESTAMP '2018-12-10 8:26:43'),
  (2, 1, TIMESTAMP '2015-12-10 8:59:42', TIMESTAMP '2015-12-10 9:00:43'),
  (2, 1, TIMESTAMP '2015-12-10 8:59:42', TIMESTAMP '2015-12-10 9:00:43'),
  (1, 3, TIMESTAMP '2015-12-10 8:59:42', TIMESTAMP '2015-12-10 8:59:42');


INSERT INTO types_of_car_parts(name, price) VALUES
  ('car_part_name1', 1),
  ('car_part_name2', 121),
  ('car_part_name3', 121),
  ('car_part_name4', 121),
  ('car_part_name5', 1),
  ('car_part_name6', 1);

INSERT INTO repair_used_car_part (repair_id, type_car_part_id, number) VALUES
  (1, 1, 1),
  (1, 2, 1),
  (1, 3, 1),
  (2, 1, 1),
  (3, 1, 1),
  (4, 4, 1),
  (5, 3, 2),
  (5, 1, 1),
  (6, 5, 4),
  (6, 6, 6);

INSERT INTO payments (price, order_id) VALUES
  (500, 1);

