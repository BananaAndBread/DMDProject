--
-- PostgreSQL database dump
--

-- Dumped from database version 10.6
-- Dumped by pg_dump version 10.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: cars; Type: TABLE; Schema: public; Owner: dmd_project
--

CREATE TABLE public.cars (
    id integer NOT NULL,
    color character varying(32) NOT NULL,
    plate_number character varying(32) NOT NULL,
    launch_date timestamp without time zone,
    type_of_car_id integer
);


ALTER TABLE public.cars OWNER TO dmd_project;

--
-- Name: cars_id_seq; Type: SEQUENCE; Schema: public; Owner: dmd_project
--

CREATE SEQUENCE public.cars_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cars_id_seq OWNER TO dmd_project;

--
-- Name: cars_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dmd_project
--

ALTER SEQUENCE public.cars_id_seq OWNED BY public.cars.id;


--
-- Name: charges; Type: TABLE; Schema: public; Owner: dmd_project
--

CREATE TABLE public.charges (
    id integer NOT NULL,
    car_id integer NOT NULL,
    cs_id integer NOT NULL,
    start_time timestamp without time zone NOT NULL
);


ALTER TABLE public.charges OWNER TO dmd_project;

--
-- Name: charges_id_seq; Type: SEQUENCE; Schema: public; Owner: dmd_project
--

CREATE SEQUENCE public.charges_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.charges_id_seq OWNER TO dmd_project;

--
-- Name: charges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dmd_project
--

ALTER SEQUENCE public.charges_id_seq OWNED BY public.charges.id;


--
-- Name: charging_stations; Type: TABLE; Schema: public; Owner: dmd_project
--

CREATE TABLE public.charging_stations (
    id integer NOT NULL,
    price_per_second double precision NOT NULL,
    amount_of_available_sockets integer NOT NULL,
    time_of_charging double precision NOT NULL
);


ALTER TABLE public.charging_stations OWNER TO dmd_project;

--
-- Name: charging_stations_has_type_of_plug; Type: TABLE; Schema: public; Owner: dmd_project
--

CREATE TABLE public.charging_stations_has_type_of_plug (
    charging_station_id integer NOT NULL,
    type_of_plug_id integer NOT NULL
);


ALTER TABLE public.charging_stations_has_type_of_plug OWNER TO dmd_project;

--
-- Name: charging_stations_id_seq; Type: SEQUENCE; Schema: public; Owner: dmd_project
--

CREATE SEQUENCE public.charging_stations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.charging_stations_id_seq OWNER TO dmd_project;

--
-- Name: charging_stations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dmd_project
--

ALTER SEQUENCE public.charging_stations_id_seq OWNED BY public.charging_stations.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: dmd_project
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    price numeric(20,2) NOT NULL,
    pick_up_time timestamp without time zone,
    creation_time timestamp without time zone NOT NULL,
    dropoff_time timestamp without time zone,
    car_id integer NOT NULL,
    user_id integer NOT NULL,
    pick_up_lat double precision NOT NULL,
    pick_up_long double precision NOT NULL,
    car_location_upon_order_creation_lat double precision NOT NULL,
    car_location_upon_order_creation_long double precision NOT NULL,
    dropoff_lat double precision NOT NULL,
    dropoff_long double precision NOT NULL
);


ALTER TABLE public.orders OWNER TO dmd_project;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: dmd_project
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_id_seq OWNER TO dmd_project;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dmd_project
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: dmd_project
--

CREATE TABLE public.payments (
    id integer NOT NULL,
    price integer NOT NULL,
    order_id integer
);


ALTER TABLE public.payments OWNER TO dmd_project;

--
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: dmd_project
--

CREATE SEQUENCE public.payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payments_id_seq OWNER TO dmd_project;

--
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dmd_project
--

ALTER SEQUENCE public.payments_id_seq OWNED BY public.payments.id;


--
-- Name: provider_has_car_part; Type: TABLE; Schema: public; Owner: dmd_project
--

CREATE TABLE public.provider_has_car_part (
    provider_id integer NOT NULL,
    type_car_part_id integer NOT NULL,
    number integer NOT NULL
);


ALTER TABLE public.provider_has_car_part OWNER TO dmd_project;

--
-- Name: providers; Type: TABLE; Schema: public; Owner: dmd_project
--

CREATE TABLE public.providers (
    id integer NOT NULL,
    name character varying(32) NOT NULL,
    phone_number character varying(32) NOT NULL
);


ALTER TABLE public.providers OWNER TO dmd_project;

--
-- Name: providers_id_seq; Type: SEQUENCE; Schema: public; Owner: dmd_project
--

CREATE SEQUENCE public.providers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.providers_id_seq OWNER TO dmd_project;

--
-- Name: providers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dmd_project
--

ALTER SEQUENCE public.providers_id_seq OWNED BY public.providers.id;


--
-- Name: repair_used_car_part; Type: TABLE; Schema: public; Owner: dmd_project
--

CREATE TABLE public.repair_used_car_part (
    repair_id integer NOT NULL,
    type_car_part_id integer NOT NULL,
    number integer NOT NULL
);


ALTER TABLE public.repair_used_car_part OWNER TO dmd_project;

--
-- Name: repairs; Type: TABLE; Schema: public; Owner: dmd_project
--

CREATE TABLE public.repairs (
    id integer NOT NULL,
    workshop_id integer,
    car_id integer,
    repair_start_time timestamp without time zone NOT NULL,
    repair_finish_time timestamp without time zone
);


ALTER TABLE public.repairs OWNER TO dmd_project;

--
-- Name: repairs_id_seq; Type: SEQUENCE; Schema: public; Owner: dmd_project
--

CREATE SEQUENCE public.repairs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.repairs_id_seq OWNER TO dmd_project;

--
-- Name: repairs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dmd_project
--

ALTER SEQUENCE public.repairs_id_seq OWNED BY public.repairs.id;


--
-- Name: types_of_car_parts; Type: TABLE; Schema: public; Owner: dmd_project
--

CREATE TABLE public.types_of_car_parts (
    id integer NOT NULL,
    name character varying(32) NOT NULL,
    price double precision NOT NULL
);


ALTER TABLE public.types_of_car_parts OWNER TO dmd_project;

--
-- Name: types_of_car_parts_id_seq; Type: SEQUENCE; Schema: public; Owner: dmd_project
--

CREATE SEQUENCE public.types_of_car_parts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.types_of_car_parts_id_seq OWNER TO dmd_project;

--
-- Name: types_of_car_parts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dmd_project
--

ALTER SEQUENCE public.types_of_car_parts_id_seq OWNED BY public.types_of_car_parts.id;


--
-- Name: types_of_cars; Type: TABLE; Schema: public; Owner: dmd_project
--

CREATE TABLE public.types_of_cars (
    id integer NOT NULL,
    name character varying(32) NOT NULL
);


ALTER TABLE public.types_of_cars OWNER TO dmd_project;

--
-- Name: types_of_cars_id_seq; Type: SEQUENCE; Schema: public; Owner: dmd_project
--

CREATE SEQUENCE public.types_of_cars_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.types_of_cars_id_seq OWNER TO dmd_project;

--
-- Name: types_of_cars_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dmd_project
--

ALTER SEQUENCE public.types_of_cars_id_seq OWNED BY public.types_of_cars.id;


--
-- Name: types_of_plugs; Type: TABLE; Schema: public; Owner: dmd_project
--

CREATE TABLE public.types_of_plugs (
    id integer NOT NULL,
    type character varying(32) NOT NULL
);


ALTER TABLE public.types_of_plugs OWNER TO dmd_project;

--
-- Name: types_of_plugs_id_seq; Type: SEQUENCE; Schema: public; Owner: dmd_project
--

CREATE SEQUENCE public.types_of_plugs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.types_of_plugs_id_seq OWNER TO dmd_project;

--
-- Name: types_of_plugs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dmd_project
--

ALTER SEQUENCE public.types_of_plugs_id_seq OWNED BY public.types_of_plugs.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: dmd_project
--

CREATE TABLE public.users (
    id integer NOT NULL,
    address_lat double precision NOT NULL,
    address_long double precision NOT NULL,
    full_name character varying(32) NOT NULL,
    username character varying(32) NOT NULL,
    phone_number character varying(32) NOT NULL,
    email character varying(32) NOT NULL
);


ALTER TABLE public.users OWNER TO dmd_project;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: dmd_project
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO dmd_project;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dmd_project
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: workshop_has_type_of_car_part; Type: TABLE; Schema: public; Owner: dmd_project
--

CREATE TABLE public.workshop_has_type_of_car_part (
    workshop_id integer NOT NULL,
    type_car_part_id integer NOT NULL
);


ALTER TABLE public.workshop_has_type_of_car_part OWNER TO dmd_project;

--
-- Name: workshops; Type: TABLE; Schema: public; Owner: dmd_project
--

CREATE TABLE public.workshops (
    id integer NOT NULL,
    creation_time timestamp without time zone NOT NULL,
    location_lat double precision NOT NULL,
    location_long double precision NOT NULL
);


ALTER TABLE public.workshops OWNER TO dmd_project;

--
-- Name: workshops_id_seq; Type: SEQUENCE; Schema: public; Owner: dmd_project
--

CREATE SEQUENCE public.workshops_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.workshops_id_seq OWNER TO dmd_project;

--
-- Name: workshops_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dmd_project
--

ALTER SEQUENCE public.workshops_id_seq OWNED BY public.workshops.id;


--
-- Name: cars id; Type: DEFAULT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.cars ALTER COLUMN id SET DEFAULT nextval('public.cars_id_seq'::regclass);


--
-- Name: charges id; Type: DEFAULT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.charges ALTER COLUMN id SET DEFAULT nextval('public.charges_id_seq'::regclass);


--
-- Name: charging_stations id; Type: DEFAULT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.charging_stations ALTER COLUMN id SET DEFAULT nextval('public.charging_stations_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: payments id; Type: DEFAULT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.payments ALTER COLUMN id SET DEFAULT nextval('public.payments_id_seq'::regclass);


--
-- Name: providers id; Type: DEFAULT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.providers ALTER COLUMN id SET DEFAULT nextval('public.providers_id_seq'::regclass);


--
-- Name: repairs id; Type: DEFAULT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.repairs ALTER COLUMN id SET DEFAULT nextval('public.repairs_id_seq'::regclass);


--
-- Name: types_of_car_parts id; Type: DEFAULT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.types_of_car_parts ALTER COLUMN id SET DEFAULT nextval('public.types_of_car_parts_id_seq'::regclass);


--
-- Name: types_of_cars id; Type: DEFAULT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.types_of_cars ALTER COLUMN id SET DEFAULT nextval('public.types_of_cars_id_seq'::regclass);


--
-- Name: types_of_plugs id; Type: DEFAULT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.types_of_plugs ALTER COLUMN id SET DEFAULT nextval('public.types_of_plugs_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: workshops id; Type: DEFAULT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.workshops ALTER COLUMN id SET DEFAULT nextval('public.workshops_id_seq'::regclass);


--
-- Data for Name: cars; Type: TABLE DATA; Schema: public; Owner: dmd_project
--

COPY public.cars (id, color, plate_number, launch_date, type_of_car_id) FROM stdin;
1	red	AN5025	2018-11-09 18:25:42	1
2	blue	asdf508	2018-11-09 18:25:42	2
3	violet	plate_number3	2018-11-09 18:25:42	3
\.


--
-- Data for Name: charges; Type: TABLE DATA; Schema: public; Owner: dmd_project
--

COPY public.charges (id, car_id, cs_id, start_time) FROM stdin;
1	1	1	2018-11-10 08:25:42
2	2	1	2018-11-10 08:25:42
3	1	1	2018-11-10 08:26:42
4	1	1	2018-11-10 08:26:42
5	1	1	2018-11-10 08:59:42
6	1	1	2015-11-10 08:59:42
7	3	1	2018-12-10 08:59:42
\.


--
-- Data for Name: charging_stations; Type: TABLE DATA; Schema: public; Owner: dmd_project
--

COPY public.charging_stations (id, price_per_second, amount_of_available_sockets, time_of_charging) FROM stdin;
1	1	5	60
2	20	5	60
\.


--
-- Data for Name: charging_stations_has_type_of_plug; Type: TABLE DATA; Schema: public; Owner: dmd_project
--

COPY public.charging_stations_has_type_of_plug (charging_station_id, type_of_plug_id) FROM stdin;
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: dmd_project
--

COPY public.orders (id, price, pick_up_time, creation_time, dropoff_time, car_id, user_id, pick_up_lat, pick_up_long, car_location_upon_order_creation_lat, car_location_upon_order_creation_long, dropoff_lat, dropoff_long) FROM stdin;
1	123.00	2018-11-09 18:31:42	2018-11-09 18:25:42	2018-11-09 19:25:42	1	1	0	0	1	0	0	0
2	123.00	2018-11-10 18:31:42	2018-11-10 18:25:42	2018-11-10 19:25:42	1	1	0	0	2	0	0	0
3	123.00	2018-11-10 18:31:42	2018-11-10 18:25:42	2018-11-10 19:25:42	2	1	0	0	23	27	65	94
4	123.00	2018-11-10 08:31:42	2018-11-10 08:25:42	2018-11-10 09:25:42	1	1	0	0	23	27	65	94
5	123.00	2018-11-10 08:31:42	2018-11-10 08:25:42	2018-11-10 09:25:42	1	2	0	0	5	0	0	0
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: dmd_project
--

COPY public.payments (id, price, order_id) FROM stdin;
1	500	1
\.


--
-- Data for Name: provider_has_car_part; Type: TABLE DATA; Schema: public; Owner: dmd_project
--

COPY public.provider_has_car_part (provider_id, type_car_part_id, number) FROM stdin;
\.


--
-- Data for Name: providers; Type: TABLE DATA; Schema: public; Owner: dmd_project
--

COPY public.providers (id, name, phone_number) FROM stdin;
\.


--
-- Data for Name: repair_used_car_part; Type: TABLE DATA; Schema: public; Owner: dmd_project
--

COPY public.repair_used_car_part (repair_id, type_car_part_id, number) FROM stdin;
1	1	1
1	2	1
1	3	1
2	1	1
3	1	1
4	4	1
5	3	2
5	1	1
6	5	4
6	6	6
\.


--
-- Data for Name: repairs; Type: TABLE DATA; Schema: public; Owner: dmd_project
--

COPY public.repairs (id, workshop_id, car_id, repair_start_time, repair_finish_time) FROM stdin;
1	1	1	2018-12-10 08:25:42	2018-12-10 08:26:43
2	1	1	2015-12-10 08:59:42	2015-12-10 09:00:43
3	1	2	2018-12-10 08:25:42	2018-12-10 08:26:43
4	2	1	2015-12-10 08:59:42	2015-12-10 09:00:43
5	2	1	2015-12-10 08:59:42	2015-12-10 09:00:43
6	1	3	2015-12-10 08:59:42	2015-12-10 08:59:42
\.


--
-- Data for Name: types_of_car_parts; Type: TABLE DATA; Schema: public; Owner: dmd_project
--

COPY public.types_of_car_parts (id, name, price) FROM stdin;
1	car_part_name1	1
2	car_part_name2	121
3	car_part_name3	121
4	car_part_name4	121
5	car_part_name5	1
6	car_part_name6	1
\.


--
-- Data for Name: types_of_cars; Type: TABLE DATA; Schema: public; Owner: dmd_project
--

COPY public.types_of_cars (id, name) FROM stdin;
1	type of car 1
2	type of car 2
3	type of car 3
\.


--
-- Data for Name: types_of_plugs; Type: TABLE DATA; Schema: public; Owner: dmd_project
--

COPY public.types_of_plugs (id, type) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: dmd_project
--

COPY public.users (id, address_lat, address_long, full_name, username, phone_number, email) FROM stdin;
1	121	131	full_name1	username1	phone_number1	email1
2	121	131	full_name2	username2	phone_number2	email2
3	121	131	full_name3	username3	phone_number3	email3
\.


--
-- Data for Name: workshop_has_type_of_car_part; Type: TABLE DATA; Schema: public; Owner: dmd_project
--

COPY public.workshop_has_type_of_car_part (workshop_id, type_car_part_id) FROM stdin;
\.


--
-- Data for Name: workshops; Type: TABLE DATA; Schema: public; Owner: dmd_project
--

COPY public.workshops (id, creation_time, location_lat, location_long) FROM stdin;
1	2015-12-10 08:25:42	212	212
2	2018-11-07 08:25:42	313	59
\.


--
-- Name: cars_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dmd_project
--

SELECT pg_catalog.setval('public.cars_id_seq', 203, true);


--
-- Name: charges_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dmd_project
--

SELECT pg_catalog.setval('public.charges_id_seq', 7, true);


--
-- Name: charging_stations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dmd_project
--

SELECT pg_catalog.setval('public.charging_stations_id_seq', 122, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dmd_project
--

SELECT pg_catalog.setval('public.orders_id_seq', 205, true);


--
-- Name: payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dmd_project
--

SELECT pg_catalog.setval('public.payments_id_seq', 201, true);


--
-- Name: providers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dmd_project
--

SELECT pg_catalog.setval('public.providers_id_seq', 100, true);


--
-- Name: repairs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dmd_project
--

SELECT pg_catalog.setval('public.repairs_id_seq', 106, true);


--
-- Name: types_of_car_parts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dmd_project
--

SELECT pg_catalog.setval('public.types_of_car_parts_id_seq', 216, true);


--
-- Name: types_of_cars_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dmd_project
--

SELECT pg_catalog.setval('public.types_of_cars_id_seq', 103, true);


--
-- Name: types_of_plugs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dmd_project
--

SELECT pg_catalog.setval('public.types_of_plugs_id_seq', 90, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dmd_project
--

SELECT pg_catalog.setval('public.users_id_seq', 203, true);


--
-- Name: workshops_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dmd_project
--

SELECT pg_catalog.setval('public.workshops_id_seq', 202, true);


--
-- Name: cars cars_pkey; Type: CONSTRAINT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.cars
    ADD CONSTRAINT cars_pkey PRIMARY KEY (id);


--
-- Name: charges charges_pkey; Type: CONSTRAINT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.charges
    ADD CONSTRAINT charges_pkey PRIMARY KEY (id);


--
-- Name: charging_stations_has_type_of_plug charging_stations_has_type_of_plug_pkey; Type: CONSTRAINT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.charging_stations_has_type_of_plug
    ADD CONSTRAINT charging_stations_has_type_of_plug_pkey PRIMARY KEY (charging_station_id, type_of_plug_id);


--
-- Name: charging_stations charging_stations_pkey; Type: CONSTRAINT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.charging_stations
    ADD CONSTRAINT charging_stations_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: provider_has_car_part provider_has_car_part_pkey; Type: CONSTRAINT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.provider_has_car_part
    ADD CONSTRAINT provider_has_car_part_pkey PRIMARY KEY (provider_id, type_car_part_id);


--
-- Name: providers providers_pkey; Type: CONSTRAINT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.providers
    ADD CONSTRAINT providers_pkey PRIMARY KEY (id);


--
-- Name: repair_used_car_part repair_used_car_part_pkey; Type: CONSTRAINT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.repair_used_car_part
    ADD CONSTRAINT repair_used_car_part_pkey PRIMARY KEY (repair_id, type_car_part_id);


--
-- Name: repairs repairs_pkey; Type: CONSTRAINT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.repairs
    ADD CONSTRAINT repairs_pkey PRIMARY KEY (id);


--
-- Name: types_of_car_parts types_of_car_parts_pkey; Type: CONSTRAINT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.types_of_car_parts
    ADD CONSTRAINT types_of_car_parts_pkey PRIMARY KEY (id);


--
-- Name: types_of_cars types_of_cars_pkey; Type: CONSTRAINT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.types_of_cars
    ADD CONSTRAINT types_of_cars_pkey PRIMARY KEY (id);


--
-- Name: types_of_plugs types_of_plugs_pkey; Type: CONSTRAINT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.types_of_plugs
    ADD CONSTRAINT types_of_plugs_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: workshop_has_type_of_car_part workshop_has_type_of_car_part_pkey; Type: CONSTRAINT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.workshop_has_type_of_car_part
    ADD CONSTRAINT workshop_has_type_of_car_part_pkey PRIMARY KEY (workshop_id, type_car_part_id);


--
-- Name: workshops workshops_pkey; Type: CONSTRAINT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.workshops
    ADD CONSTRAINT workshops_pkey PRIMARY KEY (id);


--
-- Name: cars cars_type_of_car_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.cars
    ADD CONSTRAINT cars_type_of_car_id_fkey FOREIGN KEY (type_of_car_id) REFERENCES public.types_of_cars(id);


--
-- Name: charges charges_car_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.charges
    ADD CONSTRAINT charges_car_id_fkey FOREIGN KEY (car_id) REFERENCES public.cars(id);


--
-- Name: charges charges_cs_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.charges
    ADD CONSTRAINT charges_cs_id_fkey FOREIGN KEY (cs_id) REFERENCES public.charging_stations(id);


--
-- Name: charging_stations_has_type_of_plug charging_stations_has_type_of_plug_charging_station_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.charging_stations_has_type_of_plug
    ADD CONSTRAINT charging_stations_has_type_of_plug_charging_station_id_fkey FOREIGN KEY (charging_station_id) REFERENCES public.charging_stations(id);


--
-- Name: charging_stations_has_type_of_plug charging_stations_has_type_of_plug_type_of_plug_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.charging_stations_has_type_of_plug
    ADD CONSTRAINT charging_stations_has_type_of_plug_type_of_plug_id_fkey FOREIGN KEY (type_of_plug_id) REFERENCES public.types_of_plugs(id);


--
-- Name: orders orders_car_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_car_id_fkey FOREIGN KEY (car_id) REFERENCES public.cars(id);


--
-- Name: orders orders_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: payments payments_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- Name: provider_has_car_part provider_has_car_part_provider_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.provider_has_car_part
    ADD CONSTRAINT provider_has_car_part_provider_id_fkey FOREIGN KEY (provider_id) REFERENCES public.providers(id);


--
-- Name: provider_has_car_part provider_has_car_part_type_car_part_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.provider_has_car_part
    ADD CONSTRAINT provider_has_car_part_type_car_part_id_fkey FOREIGN KEY (type_car_part_id) REFERENCES public.types_of_car_parts(id);


--
-- Name: repair_used_car_part repair_used_car_part_repair_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.repair_used_car_part
    ADD CONSTRAINT repair_used_car_part_repair_id_fkey FOREIGN KEY (repair_id) REFERENCES public.repairs(id);


--
-- Name: repair_used_car_part repair_used_car_part_type_car_part_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.repair_used_car_part
    ADD CONSTRAINT repair_used_car_part_type_car_part_id_fkey FOREIGN KEY (type_car_part_id) REFERENCES public.types_of_car_parts(id);


--
-- Name: repairs repairs_car_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.repairs
    ADD CONSTRAINT repairs_car_id_fkey FOREIGN KEY (car_id) REFERENCES public.cars(id);


--
-- Name: repairs repairs_workshop_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.repairs
    ADD CONSTRAINT repairs_workshop_id_fkey FOREIGN KEY (workshop_id) REFERENCES public.workshops(id);


--
-- Name: workshop_has_type_of_car_part workshop_has_type_of_car_part_type_car_part_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.workshop_has_type_of_car_part
    ADD CONSTRAINT workshop_has_type_of_car_part_type_car_part_id_fkey FOREIGN KEY (type_car_part_id) REFERENCES public.types_of_car_parts(id);


--
-- Name: workshop_has_type_of_car_part workshop_has_type_of_car_part_workshop_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dmd_project
--

ALTER TABLE ONLY public.workshop_has_type_of_car_part
    ADD CONSTRAINT workshop_has_type_of_car_part_workshop_id_fkey FOREIGN KEY (workshop_id) REFERENCES public.workshops(id);


--
-- PostgreSQL database dump complete
--

