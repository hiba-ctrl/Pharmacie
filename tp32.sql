/* Necessite cours sur DDL */
\echo Question 2
drop table if exists routes CASCADE;
create table routes (
	route_id text primary key,
	agency_id text,
	route_short_name text,
	route_long_name text,
	route_desc text,
	route_type integer,
	route_url text,
	route_color char(6), /*: chaîne d’au plus n caractères */
	route_text_color char(6),
	route_sort_order integer
	);
/* Le chemin du fichier doit obligatoirement etre entoure de simple cote pas de double cote 
   par defaut \copy utilise le separateur tabulation. */
\COPY routes FROM 'routes.txt' WITH DELIMITER ',' CSV HEADER ;

drop table if exists trips CASCADE;
create table trips (
	route_id text,
	service_id text,
	trip_id text primary key,
	trip_headsign text,
	trip_short_name text,
	direction_id integer,
	block_id integer,
	shape_id integer,
	wheelchair_accessible integer,
	bikes_allowed bool,
	FOREIGN KEY (route_id) REFERENCES routes(route_id)
);

\COPY trips FROM 'trips.txt' WITH DELIMITER ',' CSV HEADER;

drop table if exists stops CASCADE;
create table stops (
	stop_id  text primary key,
	stop_code text,
	stop_name text,
	stop_desc text,
	stop_lon numeric,
	stop_lat numeric,
	zone_id integer,
	stop_url text,
	location_type integer,
	parent_station text,
	stop_timezone text,
	level_id integer,
	wheelchair_boarding integer,
	platform_code text
);
\COPY stops FROM 'stops.txt' WITH DELIMITER ',' CSV HEADER ;

drop table if exists stop_times CASCADE; /*CASCADE car on cree une vue de cette table plus tard */
create table stop_times (
	trip_id text,
	arrival_time char(8),
	departure_time char(8),
	stop_id text,
	stop_sequence integer,
	pickup_type integer,
	drop_off_type integer,
	local_zone_id integer,
	stop_headsign integer,
	timepoint integer,
	PRIMARY KEY (trip_id, stop_id), 
	FOREIGN KEY (trip_id) REFERENCES trips(trip_id), 
	FOREIGN KEY (stop_id) REFERENCES stops(stop_id)
);





























