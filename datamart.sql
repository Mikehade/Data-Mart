CREATE SCHEMA `datamart`;
USE datamart;


CREATE TABLE country (
		id INT NOT NULL,
        country VARCHAR(50),
        continent VARCHAR(50),
        last_updated DATETIME,
        PRIMARY KEY(id)
        );




CREATE TABLE amenities_after_use (
		id INT UNIQUE NOT NULL,
        kitchen VARCHAR(50),
        air_conditioning VARCHAR(50),
        heating VARCHAR(50),
        washer VARCHAR(50),
        dryer VARCHAR(50),
        internet VARCHAR(50),
        PRIMARY KEY(id)
        );
CREATE TABLE facilities_after_use (
		id INT UNIQUE NOT NULL,
        hot_tub VARCHAR(50),
        ev_charger VARCHAR(50),
        pool VARCHAR(50),
        gym VARCHAR(50),
		free_parking VARCHAR(50),
        PRIMARY KEY(id)
        );

CREATE TABLE entertainment_after_use (
		id INT UNIQUE NOT NULL,
        tv VARCHAR(50),
        sound_system VARCHAR(50),
        projector VARCHAR(50),
        water_front VARCHAR(50),
        beach_front VARCHAR(50),
        PRIMARY KEY(id)
        );


CREATE TABLE security_questions (
	id INT UNIQUE NOT NULL,
    nickname VARCHAR(50),
    pet_name VARCHAR(50),
    birth_city VARCHAR(50),
    PRIMARY KEY(id)
    );


CREATE TABLE post_inspection (
	id INT UNIQUE NOT NULL,
    inspection_date DATETIME,
    amenities_after_use_id INT UNIQUE NOT NULL,
    facilities_after_use_id INT UNIQUE NOT NULL,
    entertainment_after_use_id INT UNIQUE NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(amenities_after_use_id) REFERENCES amenities_after_use(id) ON DELETE CASCADE,
    FOREIGN KEY(facilities_after_use_id) REFERENCES facilities_after_use(id) ON DELETE CASCADE,
    FOREIGN KEY(entertainment_after_use_id) REFERENCES entertainment_after_use(id) ON DELETE CASCADE
    );

CREATE TABLE login_details (
	id INT UNIQUE NOT NULL,
    username VARCHAR(50),
    pass_word VARCHAR(50),
    last_updated VARCHAR(50),
    security_questions_id INT UNIQUE NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(security_questions_id) REFERENCES security_questions(id) ON DELETE CASCADE
    );

CREATE TABLE login (
	id INT UNIQUE NOT NULL,
    email VARCHAR(500),
    phone_number VARCHAR(50),
    create_date DATETIME,
    last_login DATETIME,
    account_status VARCHAR(50),
    verified_status VARCHAR(50),
    login_details_id INT UNIQUE NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(login_details_id) REFERENCES login_details(id) ON DELETE CASCADE
    );

CREATE TABLE staff (
	id INT UNIQUE NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender VARCHAR(50),
    age INT,
    title VARCHAR(50),
    post_inspection_id INT UNIQUE NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(post_inspection_id) REFERENCES post_inspection(id) ON DELETE CASCADE
    );

CREATE TABLE dependents (
	id INT UNIQUE NOT NULL,
    spouse VARCHAR(3),
    children INT,
    infants INT,
    last_update DATETIME,
    PRIMARY KEY(id)
    );

CREATE TABLE address (
	id INT UNIQUE NOT NULL,
    house_no INT,
    street VARCHAR(50),
    postcode INT,
    state VARCHAR(500),
    last_update DATETIME,
    country_id INT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(country_id) REFERENCES country(id)
    );





CREATE TABLE rules (
	id INT UNIQUE NOT NULL,
    pets VARCHAR(50),
    smoking VARCHAR(50),
    PRIMARY KEY(id)
    );

CREATE TABLE reviews (
	id INT UNIQUE NOT NULL,
    stars INT,
    comments VARCHAR(500),
    recommend VARCHAR(3),
    PRIMARY KEY(id)
    );
   
CREATE TABLE entertainment (
		id INT UNIQUE NOT NULL,
        tv VARCHAR(3),
        sound_system VARCHAR(3),
        projector VARCHAR(3),
        water_front VARCHAR(3),
        beach_front VARCHAR(3),
        PRIMARY KEY(id)
        );

CREATE TABLE facilities (
		id INT UNIQUE NOT NULL,
        hot_tub VARCHAR(3),
        ev_charger VARCHAR(3),
        pool VARCHAR(3),
        gym VARCHAR(3),
		free_parking VARCHAR(3),
        entertainment_id INT UNIQUE NOT NULL,
        PRIMARY KEY(id),
        FOREIGN KEY(entertainment_id) REFERENCES entertainment(id) ON DELETE CASCADE
        );

CREATE TABLE amenities (
		id INT UNIQUE NOT NULL,
        kitchen VARCHAR(3),
        air_conditioning VARCHAR(3),
        heating VARCHAR(3),
        washer VARCHAR(3),
        dryer VARCHAR(3),
        internet VARCHAR(3),
        facilities_id INT UNIQUE NOT NULL,
        PRIMARY KEY(id),
        FOREIGN KEY(facilities_id) REFERENCES facilities(id) ON DELETE CASCADE
        );

CREATE TABLE room_owner_address (
		id INT UNIQUE NOT NULL,
        house_no INT,
        street VARCHAR(50),
        postcode INT,
        state VARCHAR(50),
        last_update DATETIME,
        country_id INT NOT NULL,
        PRIMARY KEY(id),
        FOREIGN KEY(country_id) REFERENCES country(id)
        );

CREATE TABLE room_owner (
		id INT UNIQUE NOT NULL,
        first_name VARCHAR(50),
        last_name VARCHAR(50),
        gender VARCHAR(50),
        age INT,
        room_owner_address_id INT UNIQUE NOT NULL,
        PRIMARY KEY(id),
        FOREIGN KEY(room_owner_address_id) REFERENCES room_owner_address(id) ON DELETE CASCADE
        );

CREATE TABLE room_address (
		id INT UNIQUE NOT NULL,
        house_no INT,
        street VARCHAR(50),
        postcode INT,
        state VARCHAR(50),
        country_id INT NOT NULL,
        room_owner_id INT UNIQUE NOT NULL,
        amenities_id INT UNIQUE NOT NULL,
        PRIMARY KEY(id),
        FOREIGN KEY(room_owner_id) REFERENCES room_owner(id) ON DELETE CASCADE,
        FOREIGN KEY(country_id) REFERENCES country(id),
        FOREIGN KEY(amenities_id) REFERENCES amenities(id) ON DELETE CASCADE
        );


CREATE TABLE room (
		id INT UNIQUE NOT NULL,
        home_type VARCHAR(50),
        total_bedrooms INT,
        total_bathrooms INT,
        published_date datetime,
        room_address_id INT UNIQUE NOT NULL,
        rules_id INT UNIQUE NOT NULL,
        PRIMARY KEY(id),
        FOREIGN KEY(room_address_id) REFERENCES room_address(id) ON DELETE CASCADE,
        FOREIGN KEY(rules_id) REFERENCES rules(id) ON DELETE CASCADE
        );


CREATE TABLE payment (
		id INT UNIQUE NOT NULL,
        payment_mode VARCHAR(50),
        price INT,
        discount INT,
        total_price INT,
        payment_status VARCHAR(10),
        reviews_id INT UNIQUE NOT NULL,
        PRIMARY KEY(id),
        FOREIGN KEY(reviews_id) REFERENCES reviews(id) ON DELETE CASCADE
        );


CREATE TABLE reservation (
		id INT UNIQUE NOT NULL,
        reservation_type VARCHAR(50),
        booking_date DATETIME,
        start_date DATETIME,
        end_date DATETIME,
        last_update DATETIME,
        room_id INT UNIQUE NOT NULL,
        payment_id INT UNIQUE NOT NULL,
        PRIMARY KEY(id),
        FOREIGN KEY(room_id) REFERENCES room(id) ON DELETE CASCADE,
        FOREIGN KEY(payment_id) REFERENCES payment(id) ON DELETE CASCADE
        );


CREATE TABLE customer (
	id INTEGER UNIQUE NOT NULL,
    first_name VARCHAR(500),
    last_name VARCHAR(500),
    gender VARCHAR(50),
    age INT,
    job_title VARCHAR(500),
    job_industry VARCHAR(500),
    dependents_id INT UNIQUE NOT NULL,
    address_id INT UNIQUE NOT NULL,
    staff_id INT UNIQUE NOT NULL,
    login_id INT UNIQUE NOT NULL,
    reservation_id INT UNIQUE NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (dependents_id) REFERENCES dependents(id) ON DELETE CASCADE,
    FOREIGN KEY (address_id) REFERENCES address(id) ON DELETE CASCADE,
    FOREIGN KEY (staff_id) REFERENCES staff(id) ON DELETE CASCADE,
    FOREIGN KEY (login_id) REFERENCES login(id) ON DELETE CASCADE,
    FOREIGN KEY (reservation_id) REFERENCES reservation(id) ON DELETE CASCADE
    );
    


#ALTERING TABLES FOR FOREIGN KEYS IN ORDER TO MAINTAIN REFERENTIAL INTEGRITY ON DELETION
ALTER TABLE dependents ADD COLUMN customer_id INT UNIQUE DEFAULT NULL;
ALTER TABLE dependents ADD CONSTRAINT FOREIGN KEY (customer_id) REFERENCES customer(id) ON DELETE CASCADE;

ALTER TABLE address ADD COLUMN customer_id INT UNIQUE DEFAULT NULL;
ALTER TABLE address ADD CONSTRAINT FOREIGN KEY (customer_id) REFERENCES customer(id) ON DELETE CASCADE;

ALTER TABLE staff ADD COLUMN customer_id INT UNIQUE DEFAULT NULL;
ALTER TABLE staff ADD CONSTRAINT FOREIGN KEY (customer_id) REFERENCES customer(id) ON DELETE CASCADE;

ALTER TABLE login ADD COLUMN customer_id INT UNIQUE DEFAULT NULL;
ALTER TABLE login ADD CONSTRAINT FOREIGN KEY (customer_id) REFERENCES customer(id) ON DELETE CASCADE;

ALTER TABLE reservation ADD COLUMN customer_id INT UNIQUE DEFAULT NULL;
ALTER TABLE reservation ADD CONSTRAINT FOREIGN KEY (customer_id) REFERENCES customer(id) ON DELETE CASCADE;

ALTER TABLE login_details ADD COLUMN login_id INT UNIQUE DEFAULT NULL;
ALTER TABLE login_details ADD CONSTRAINT FOREIGN KEY (login_id) REFERENCES login(id) ON DELETE CASCADE;

ALTER TABLE post_inspection ADD COLUMN staff_id INT UNIQUE DEFAULT NULL;
ALTER TABLE post_inspection ADD CONSTRAINT FOREIGN KEY (staff_id) REFERENCES staff(id) ON DELETE CASCADE;

ALTER TABLE amenities_after_use ADD COLUMN post_inspection_id INT UNIQUE DEFAULT NULL;
ALTER TABLE amenities_after_use ADD CONSTRAINT FOREIGN KEY (post_inspection_id) REFERENCES post_inspection(id) ON DELETE CASCADE;

ALTER TABLE facilities_after_use ADD COLUMN post_inspection_id INT UNIQUE DEFAULT NULL;
ALTER TABLE facilities_after_use ADD CONSTRAINT FOREIGN KEY (post_inspection_id) REFERENCES post_inspection(id) ON DELETE CASCADE;

ALTER TABLE entertainment_after_use ADD COLUMN post_inspection_id INT UNIQUE DEFAULT NULL;
ALTER TABLE entertainment_after_use ADD CONSTRAINT FOREIGN KEY (post_inspection_id) REFERENCES post_inspection(id) ON DELETE CASCADE;

ALTER TABLE security_questions ADD COLUMN login_details_id INT UNIQUE DEFAULT NULL;
ALTER TABLE security_questions ADD CONSTRAINT FOREIGN KEY (login_details_id) REFERENCES login_details(id) ON DELETE CASCADE;

ALTER TABLE room ADD COLUMN reservation_id INT UNIQUE DEFAULT NULL;
ALTER TABLE room ADD CONSTRAINT FOREIGN KEY (reservation_id) REFERENCES reservation(id) ON DELETE CASCADE;

ALTER TABLE rules ADD COLUMN room_id INT UNIQUE DEFAULT NULL;
ALTER TABLE rules ADD CONSTRAINT FOREIGN KEY (room_id) REFERENCES room(id) ON DELETE CASCADE;

ALTER TABLE room_address ADD COLUMN room_id INT UNIQUE DEFAULT NULL;
ALTER TABLE room_address ADD CONSTRAINT FOREIGN KEY (room_id) REFERENCES room(id) ON DELETE CASCADE;

ALTER TABLE room_owner ADD COLUMN room_address_id INT UNIQUE DEFAULT NULL;
ALTER TABLE room_owner ADD CONSTRAINT FOREIGN KEY (room_address_id) REFERENCES room_address(id) ON DELETE CASCADE;

ALTER TABLE room_owner_address ADD COLUMN room_owner_id INT UNIQUE DEFAULT NULL;
ALTER TABLE room_owner_address ADD CONSTRAINT FOREIGN KEY (room_owner_id) REFERENCES room_owner(id) ON DELETE CASCADE;

ALTER TABLE payment ADD COLUMN reservation_id INT UNIQUE DEFAULT NULL;
ALTER TABLE payment ADD CONSTRAINT FOREIGN KEY (reservation_id) REFERENCES reservation(id) ON DELETE CASCADE;

ALTER TABLE reviews ADD COLUMN payment_id INT UNIQUE DEFAULT NULL;
ALTER TABLE reviews ADD CONSTRAINT FOREIGN KEY (payment_id) REFERENCES payment(id) ON DELETE CASCADE;

ALTER TABLE facilities ADD COLUMN amenities_id INT UNIQUE DEFAULT NULL;
ALTER TABLE facilities ADD CONSTRAINT FOREIGN KEY (amenities_id) REFERENCES amenities(id) ON DELETE CASCADE;

ALTER TABLE amenities ADD COLUMN room_address_id INT UNIQUE DEFAULT NULL;
ALTER TABLE amenities ADD CONSTRAINT FOREIGN KEY (room_address_id) REFERENCES room_address(id) ON DELETE CASCADE;

ALTER TABLE entertainment ADD COLUMN facilities_id INT UNIQUE DEFAULT NULL;
ALTER TABLE entertainment ADD CONSTRAINT FOREIGN KEY (facilities_id) REFERENCES facilities(id) ON DELETE CASCADE;


#INSERTING INTO COUNTRY TABLE FIRST BECAUSE IT HAS A CN:CM RELATIONSHIP UNLIKE OTHER TABLES
START TRANSACTION;
	INSERT INTO country (id, country, continent, last_updated) VALUES (80, 'USA', 'North America', '2020-06-21 14:28:33');
	INSERT INTO country (id, country, continent, last_updated) VALUES (81, 'Canada', 'North America', '2020-07-22 17:38:33');
    INSERT INTO country (id, country, continent, last_updated) VALUES (82, 'Australia', 'North America', '2020-08-22 17:38:33');
    INSERT INTO country (id, country, continent, last_updated) VALUES (83, 'Nigeria', 'Africa', '2020-08-22 19:34:35');
    INSERT INTO country (id, country, continent, last_updated) VALUES (84, 'Germany', 'Europe', '2020-08-22 19:34:35');
    INSERT INTO country (id, country, continent, last_updated) VALUES (85, 'Poland', 'Europe', '2020-08-22 19:34:35');
    INSERT INTO country (id, country, continent, last_updated) VALUES (86, 'France', 'Europe', '2020-08-22 19:34:36');
    INSERT INTO country (id, country, continent, last_updated) VALUES (87, 'Greece', 'Europe', '2020-08-22 19:34:36');
    INSERT INTO country (id, country, continent, last_updated) VALUES (88, 'Spain', 'Europe', '2020-08-22 19:34:37');
    INSERT INTO country (id, country, continent, last_updated) VALUES (89, 'Benin Republic', 'Africa', '2020-08-22 19:34:37');
    INSERT INTO country (id, country, continent, last_updated) VALUES (90, 'Italy', 'Europe', '2020-08-22 19:34:38');
    INSERT INTO country (id, country, continent, last_updated) VALUES (91, 'Kenya', 'Africa', '2020-08-22 19:34:38');
    INSERT INTO country (id, country, continent, last_updated) VALUES (92, 'Ivory Coast', 'Africa', '2020-08-22 19:34:39');
    INSERT INTO country (id, country, continent, last_updated) VALUES (93, 'Algeria', 'Africa', '2020-08-22 19:34:39');
    INSERT INTO country (id, country, continent, last_updated) VALUES (94, 'Togo', 'Africa', '2020-08-22 19:34:40');
    INSERT INTO country (id, country, continent, last_updated) VALUES (95, 'South Africa', 'Africa', '2020-08-22 19:34:40');
    INSERT INTO country (id, country, continent, last_updated) VALUES (96, 'Tanzania', 'Africa', '2020-08-22 19:34:41');
    INSERT INTO country (id, country, continent, last_updated) VALUES (97, 'Russia', 'Europe', '2020-08-22 19:34:42');
    INSERT INTO country (id, country, continent, last_updated) VALUES (98, 'Denmark', 'Europe', '2020-08-22 19:34:42');
    INSERT INTO country (id, country, continent, last_updated) VALUES (99, 'Haiti', 'North America', '2020-08-22 19:34:43');
COMMIT;



#INSERTING AND UPDATING ROWS USING TRANSACTIONS TO MAINTAIN REFERENTIAL INTEGRITY AND HAVE BETTER HANDLING OF ERRORS
#ROW ONE
START TRANSACTION;
	#INSERT INTO country (id, country, continent, last_updated) VALUES (80, 'USA', 'North America', '2020-06-21 14:28:33');
	INSERT INTO amenities_after_use (id, kitchen, air_conditioning, heating, washer, dryer, internet) VALUES (700, 'good', 'good', 'good', 'good', 'good', 'good');
	INSERT INTO facilities_after_use (id, hot_tub, ev_charger, pool, gym, free_parking) VALUES (800, 'good', 'good', 'good', 'good', 'good');
    INSERT INTO entertainment_after_use (id, tv, sound_system, projector, water_front, beach_front) VALUES (900, 'good', 'good', 'good', 'good', 'good');
    INSERT INTO security_questions (id, nickname, pet_name, birth_city) VALUES (1100, 'Steff', 'bucky', 'North Carolina');
    INSERT INTO post_inspection (id, inspection_date, amenities_after_use_id, facilities_after_use_id, entertainment_after_use_id) VALUES (600, '2020-07-22 10:00:00', 700, 800, 900);
    INSERT INTO login_details (id, username, pass_word, last_updated, security_questions_id) VALUES (1, 'stefan1276', 'stemi72', '2020-06-24 14:12:02', 1100);
    INSERT INTO login (id, email, phone_number, create_date, last_login, account_status, verified_status, login_details_id) VALUES (10000, 'stefanmieke@hotmail.com',
		12435436453, '2020-06-20 11:15:37', '2020-07-14 14:23:47', 'active', 'verified', 1);
	INSERT INTO staff (id, first_name, last_name, gender, age, title, post_inspection_id) VALUES (1000, 'Max', 'Davis', 'Male', 42, 'Partner', 600);
    INSERT INTO dependents (id, spouse, children, infants, last_update) VALUES (10, 'yes', 0, 0, '2020-06-21 14:22:35');
    INSERT INTO address (id, house_no, street, postcode, state, last_update, country_id) VALUES (100, 5, 'broad', 23302, 'New York', '2020-06-22 13:21:50', 80);
    INSERT INTO rules (id, pets, smoking) VALUES (500, 'yes', 'yes');
    INSERT INTO reviews (id, stars, comments, recommend) VALUES (2500, 4, 'great experience', 'yes');
    INSERT INTO entertainment (id, tv, sound_system, projector, water_front, beach_front) VALUES (1700, 'yes', 'yes', 'yes', 'yes', 'yes');
    INSERT INTO facilities (id, hot_tub, ev_charger, pool, gym, free_parking, entertainment_id) VALUES (1600, 'yes', 'yes', 'yes', 'yes', 'yes', 1700);
	INSERT INTO amenities (id, kitchen, air_conditioning, heating, washer, dryer, internet, facilities_id) VALUES (1500, 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 1600);
	INSERT INTO room_owner_address (id, house_no, street, state, postcode, last_update, country_id) VALUES (2000, 25, 'McPhelps', 'Texas', 23203, '2020-01-25 12:00:27', 80);
    INSERT INTO room_owner (id, first_name, last_name, gender, age, room_owner_address_id) VALUES (1300, 'David', 'Sampson', 'Male', 43, 2000);
    INSERT INTO room_address (id, house_no, street, postcode, state, country_id, room_owner_id, amenities_id) VALUES (400, 23, 'McPhelps', 23201, 'Texas', 80, 1300, 1500);
    INSERT INTO room (id, home_type, total_bedrooms, total_bathrooms, published_date, room_address_id, rules_id) VALUES (150, 'entire place', 2, 2, '2020-01-20 11:00:26',
		400, 500);
	INSERT INTO payment (id, payment_mode, price, discount, total_price, payment_status, reviews_id) VALUES (250, 'card', 760, 20, 740, 'paid', 2500);
    INSERT INTO reservation (id, reservation_type, booking_date, start_date, end_date, last_update, room_id, payment_id) VALUES (1, 'instant book', '2020-06-23 11:20:14',
		'2020-06-24 18:00:00', '2020-06-30 17:00:00', '2020-06-23 13:14:20', 150, 250);
    
	INSERT INTO customer (id, first_name, last_name, gender, age, job_title, job_industry, dependents_id, address_id, staff_id, login_id, reservation_id)
		VALUES (1, 'Stefan', 'Mieke', 'male', 36, 'Electrical engineer', 'Manufacturing', 10, 100, 1000, 10000, 1);
COMMIT;

START TRANSACTION;
	UPDATE amenities_after_use SET post_inspection_id = 600 WHERE id = 700;
	UPDATE facilities_after_use SET post_inspection_id = 600 WHERE id = 800;
    UPDATE entertainment_after_use SET post_inspection_id = 600 WHERE id = 900;
    UPDATE security_questions SET login_details_id = 1 WHERE id = 1100;
    UPDATE post_inspection SET staff_id = 1000 WHERE id = 600;
    UPDATE login_details SET login_id = 10000 WHERE id = 1;
    UPDATE login SET customer_id = 1 WHERE id = 10000;
    UPDATE staff SET customer_id = 1 WHERE id = 1000;
    UPDATE dependents SET customer_id = 1 WHERE id = 10;
    UPDATE address SET customer_id = 1 WHERE id = 100;
    UPDATE rules SET room_id = 150 WHERE id = 500;
    UPDATE reviews SET payment_id = 250 WHERE id = 2500;
    UPDATE entertainment SET facilities_id = 1600 WHERE id = 1700;
    UPDATE facilities SET amenities_id = 1500 WHERE id = 1600;
    UPDATE amenities SET room_address_id = 400 WHERE id = 1500;
    UPDATE room_owner_address SET room_owner_id = 1300 WHERE id = 2000;
    UPDATE room_owner SET room_address_id = 400 WHERE id = 1300;
    UPDATE room_address SET room_id = 150 WHERE id = 400;
    UPDATE room SET reservation_id = 1 WHERE id = 150;
    UPDATE payment SET reservation_id = 1 WHERE id = 250;
    UPDATE reservation SET customer_id = 1 WHERE id = 1;
COMMIT;


#ROW TWO
START TRANSACTION;
	#INSERT INTO country (id, country, continent, last_updated) VALUES (81, 'Canada', 'North America', '2020-07-22 17:38:33');
	INSERT INTO amenities_after_use (id, kitchen, air_conditioning, heating, washer, dryer, internet) VALUES (701, 'good', 'good', 'good', 'good', 'good', 'good');
	INSERT INTO facilities_after_use (id, hot_tub, ev_charger, pool, gym, free_parking) VALUES (801, 'good', 'good', 'good', 'good', 'good');
    INSERT INTO entertainment_after_use (id, tv, sound_system, projector, water_front, beach_front) VALUES (901, 'good', 'good', 'good', 'good', 'good');
    INSERT INTO security_questions (id, nickname, pet_name, birth_city) VALUES (1101, 'bicky', 'hunty', 'Ontario');
    INSERT INTO post_inspection (id, inspection_date, amenities_after_use_id, facilities_after_use_id, entertainment_after_use_id) VALUES (601, '2020-07-25 12:00:00', 701, 801, 901);
    INSERT INTO login_details (id, username, pass_word, last_updated, security_questions_id) VALUES (2, 'chickie21', 'chibre234', '2020-07-28 14:12:02', 1101);
    INSERT INTO login (id, email, phone_number, create_date, last_login, account_status, verified_status, login_details_id) VALUES (10001, 'stefanmieke@hotmail.com',
		9123865322, '2020-06-25 14:16:37', '2020-08-14 14:23:47', 'active', 'verified', 2);
	INSERT INTO staff (id, first_name, last_name, gender, age, title, post_inspection_id) VALUES (1001, 'Stephanie', 'Rogers', 'Female', 32, 'Partner', 601);
    INSERT INTO dependents (id, spouse, children, infants, last_update) VALUES (11, 'yes', 1, 0, '2020-07-20 14:22:35');
    INSERT INTO address (id, house_no, street, postcode, state, last_update, country_id) VALUES (101, 10, 'Ajax', 10242, 'Ontario', '2020-07-21 15:21:50', 81);
    INSERT INTO rules (id, pets, smoking) VALUES (501, 'no', 'yes');
    INSERT INTO reviews (id, stars, comments, recommend) VALUES (2501, 5, 'amazing experience', 'yes');
    INSERT INTO entertainment (id, tv, sound_system, projector, water_front, beach_front) VALUES (1701, 'yes', 'yes', 'yes', 'yes', 'yes');
    INSERT INTO facilities (id, hot_tub, ev_charger, pool, gym, free_parking, entertainment_id) VALUES (1601, 'yes', 'yes', 'no', 'yes', 'yes', 1701);
	INSERT INTO amenities (id, kitchen, air_conditioning, heating, washer, dryer, internet, facilities_id) VALUES (1501, 'yes', 'no', 'yes', 'no', 'yes', 'yes', 1601);
	INSERT INTO room_owner_address (id, house_no, street, state, postcode, last_update, country_id) VALUES (2001, 35, 'Calgary', 'Alberta', 10265, '2020-01-25 12:00:27', 81);
    INSERT INTO room_owner (id, first_name, last_name, gender, age, room_owner_address_id) VALUES (1301, 'Samuel', 'Jackson', 'Male', 54, 2001);
    INSERT INTO room_address (id, house_no, street, postcode, state, country_id, room_owner_id, amenities_id) VALUES (401, 33, 'Calgary', 10263, 'Toronto', 81, 1301, 1501);
    INSERT INTO room (id, home_type, total_bedrooms, total_bathrooms, published_date, room_address_id, rules_id) VALUES (151, 'entire place', 3, 3, '2020-02-21 13:00:26',
		401, 501);
	INSERT INTO payment (id, payment_mode, price, discount, total_price, payment_status, reviews_id) VALUES (251, 'card', 650, 10, 640, 'paid', 2501);
    INSERT INTO reservation (id, reservation_type, booking_date, start_date, end_date, last_update, room_id, payment_id) VALUES (2, 'instant book', '2020-07-24 11:20:14',
		'2020-07-25 19:00:00', '2020-07-31 18:00:00', '2021-07-24 15:15:20', 151, 251);
    
	INSERT INTO customer (id, first_name, last_name, gender, age, job_title, job_industry, dependents_id, address_id, staff_id, login_id, reservation_id)
		VALUES (2, 'Chickie', 'Brister', 'Male', 64, 'General Manager', 'Manufacturing', 11, 101, 1001, 10001, 2);
COMMIT;

START TRANSACTION;
	UPDATE amenities_after_use SET post_inspection_id = 601 WHERE id = 701;
	UPDATE facilities_after_use SET post_inspection_id = 601 WHERE id = 801;
    UPDATE entertainment_after_use SET post_inspection_id = 601 WHERE id = 901;
    UPDATE security_questions SET login_details_id = 2 WHERE id = 1101;
    UPDATE post_inspection SET staff_id = 1001 WHERE id = 601;
    UPDATE login_details SET login_id = 10001 WHERE id = 2;
    UPDATE login SET customer_id = 2 WHERE id = 10001;
    UPDATE staff SET customer_id = 2 WHERE id = 1001;
    UPDATE dependents SET customer_id = 2 WHERE id = 11;
    UPDATE address SET customer_id = 2 WHERE id = 101;
    UPDATE rules SET room_id = 151 WHERE id = 501;
    UPDATE reviews SET payment_id = 251 WHERE id = 2501;
    UPDATE entertainment SET facilities_id = 1601 WHERE id = 1701;
    UPDATE facilities SET amenities_id = 1501 WHERE id = 1601;
    UPDATE amenities SET room_address_id = 401 WHERE id = 1501;
    UPDATE room_owner_address SET room_owner_id = 1301 WHERE id = 2001;
    UPDATE room_owner SET room_address_id = 401 WHERE id = 1301;
    UPDATE room_address SET room_id = 151 WHERE id = 401;
    UPDATE room SET reservation_id = 2 WHERE id = 151;
    UPDATE payment SET reservation_id = 2 WHERE id = 251;
    UPDATE reservation SET customer_id = 2 WHERE id = 2;
COMMIT;


#ROW THREE
START TRANSACTION;
	#INSERT INTO country (id, country, continent, last_updated) VALUES (82, 'Australia', 'North America', '2020-08-22 17:38:33');
	INSERT INTO amenities_after_use (id, kitchen, air_conditioning, heating, washer, dryer, internet) VALUES (702, 'good', 'good', 'good', 'good', 'good', 'good');
	INSERT INTO facilities_after_use (id, hot_tub, ev_charger, pool, gym, free_parking) VALUES (802, 'good', 'good', 'good', 'good', 'good');
    INSERT INTO entertainment_after_use (id, tv, sound_system, projector, water_front, beach_front) VALUES (902, 'good', 'good', 'good', 'good', 'good');
    INSERT INTO security_questions (id, nickname, pet_name, birth_city) VALUES (1102, 'docky', 'scotty', 'Wales');
    INSERT INTO post_inspection (id, inspection_date, amenities_after_use_id, facilities_after_use_id, entertainment_after_use_id) VALUES (602, '2020-08-12 12:00:00', 702, 802, 902);
    INSERT INTO login_details (id, username, pass_word, last_updated, security_questions_id) VALUES (3, 'nadock111', 'smith897', '2020-08-04 12:14:02', 1102);
    INSERT INTO login (id, email, phone_number, create_date, last_login, account_status, verified_status, login_details_id) VALUES (10002, 'nancydock@gmail.com',
		7629865723, '2020-06-25 14:16:37', '2020-08-14 14:23:47', 'active', 'verified', 3);
	INSERT INTO staff (id, first_name, last_name, gender, age, title, post_inspection_id) VALUES (1002, 'Karly', 'Matson', 'Female', 37, 'Supervisor', 602);
    INSERT INTO dependents (id, spouse, children, infants, last_update) VALUES (12, 'yes', 1, 1, '2020-08-04 17:20:15');
    INSERT INTO address (id, house_no, street, postcode, state, last_update, country_id) VALUES (102, 56, 'Ballarat', 3089, 'Victoria', '2020-08-05 16:22:40', 82);
    INSERT INTO rules (id, pets, smoking) VALUES (502, 'no', 'no');
    INSERT INTO reviews (id, stars, comments, recommend) VALUES (2502, 3, 'good experience', 'yes');
    INSERT INTO entertainment (id, tv, sound_system, projector, water_front, beach_front) VALUES (1702, 'yes', 'yes', 'yes', 'yes', 'yes');
    INSERT INTO facilities (id, hot_tub, ev_charger, pool, gym, free_parking, entertainment_id) VALUES (1602, 'no', 'yes', 'no', 'yes', 'yes', 1702);
	INSERT INTO amenities (id, kitchen, air_conditioning, heating, washer, dryer, internet, facilities_id) VALUES (1502, 'yes', 'yes', 'yes', 'no', 'yes', 'yes', 1602);
	INSERT INTO room_owner_address (id, house_no, street, state, postcode, last_update, country_id) VALUES (2002, 15, 'Melbourne', 'Victoria', 3009, '2020-02-28 13:10:37', 82);
    INSERT INTO room_owner (id, first_name, last_name, gender, age, room_owner_address_id) VALUES (1302, 'Mandy', 'Quick', 'Male', 62, 2002);
    INSERT INTO room_address (id, house_no, street, postcode, state, country_id, room_owner_id, amenities_id) VALUES (402, 8, 'Melbourne', 3002, 'Victoria', 82, 1302, 1502);
    INSERT INTO room (id, home_type, total_bedrooms, total_bathrooms, published_date, room_address_id, rules_id) VALUES (152, 'entire place', 4, 4, '2020-02-27 14:07:29',
		402, 502);
	INSERT INTO payment (id, payment_mode, price, discount, total_price, payment_status, reviews_id) VALUES (252, 'check', 560, 20, 540, 'paid', 2502);
    INSERT INTO reservation (id, reservation_type, booking_date, start_date, end_date, last_update, room_id, payment_id) VALUES (3, 'instant book', '2020-08-02 11:27:34',
		'2020-08-04 10:00:00', '2020-08-11 09:00:00', '2021-08-03 12:18:29', 152, 252);
    
	INSERT INTO customer (id, first_name, last_name, gender, age, job_title, job_industry, dependents_id, address_id, staff_id, login_id, reservation_id)
		VALUES (3, 'Nancy', 'Docket', 'Male', 56, 'Financial Analyst', 'Financial Services', 12, 102, 1002, 10002, 3);
COMMIT;

START TRANSACTION;
	UPDATE amenities_after_use SET post_inspection_id = 602 WHERE id = 702;
	UPDATE facilities_after_use SET post_inspection_id = 602 WHERE id = 802;
    UPDATE entertainment_after_use SET post_inspection_id = 602 WHERE id = 902;
    UPDATE security_questions SET login_details_id = 3 WHERE id = 1102;
    UPDATE post_inspection SET staff_id = 1002 WHERE id = 602;
    UPDATE login_details SET login_id = 10002 WHERE id = 3;
    UPDATE login SET customer_id = 3 WHERE id = 10002;
    UPDATE staff SET customer_id = 3 WHERE id = 1002;
    UPDATE dependents SET customer_id = 3 WHERE id = 12;
    UPDATE address SET customer_id = 3 WHERE id = 102;
    UPDATE rules SET room_id = 152 WHERE id = 502;
    UPDATE reviews SET payment_id = 252 WHERE id = 2502;
    UPDATE entertainment SET facilities_id = 1602 WHERE id = 1702;
    UPDATE facilities SET amenities_id = 1502 WHERE id = 1602;
    UPDATE amenities SET room_address_id = 402 WHERE id = 1502;
    UPDATE room_owner_address SET room_owner_id = 1302 WHERE id = 2002;
    UPDATE room_owner SET room_address_id = 402 WHERE id = 1302;
    UPDATE room_address SET room_id = 152 WHERE id = 402;
    UPDATE room SET reservation_id = 3 WHERE id = 152;
    UPDATE payment SET reservation_id = 3 WHERE id = 252;
    UPDATE reservation SET customer_id = 3 WHERE id = 3;
COMMIT;


#ROW FOUR
START TRANSACTION;
	#INSERT INTO country (id, country, continent, last_updated) VALUES (83, 'Nigeria', 'Africa', '2020-08-22 19:34:35');
	INSERT INTO amenities_after_use (id, kitchen, air_conditioning, heating, washer, dryer, internet) VALUES (703, 'good', 'good', 'good', 'good', 'good', 'good');
	INSERT INTO facilities_after_use (id, hot_tub, ev_charger, pool, gym, free_parking) VALUES (803, 'good', 'good', 'good', 'good', 'good');
    INSERT INTO entertainment_after_use (id, tv, sound_system, projector, water_front, beach_front) VALUES (903, 'good', 'good', 'good', 'good', 'good');
    INSERT INTO security_questions (id, nickname, pet_name, birth_city) VALUES (1103, 'Emma', 'none', 'Lagos');
    INSERT INTO post_inspection (id, inspection_date, amenities_after_use_id, facilities_after_use_id, entertainment_after_use_id) VALUES (603, '2020-08-24 10:00:00',
		703, 803, 903);
    INSERT INTO login_details (id, username, pass_word, last_updated, security_questions_id) VALUES (4, 'emmany3', 'emalag45', '2020-08-21 13:14:45', 1103);
    INSERT INTO login (id, email, phone_number, create_date, last_login, account_status, verified_status, login_details_id) VALUES (10003, 'emmaolu23@gmail.com',
		0812311124, '2020-08-19 14:18:34', '2020-08-26 15:23:49', 'active', 'verified', 4);
	INSERT INTO staff (id, first_name, last_name, gender, age, title, post_inspection_id) VALUES (1003, 'Kara', 'Wilson', 'Female', 47, 'Supervisor', 603);
    INSERT INTO dependents (id, spouse, children, infants, last_update) VALUES (13, 'yes', 0, 0, '2020-08-21 14:26:18');
    INSERT INTO address (id, house_no, street, postcode, state, last_update, country_id) VALUES (103, 72, 'Ikorodu Road', 104100, 'Lagos', '2020-08-21 13:32:40', 83);
    INSERT INTO rules (id, pets, smoking) VALUES (503, 'yes', 'no');
    INSERT INTO reviews (id, stars, comments, recommend) VALUES (2503, 4, 'nice place', 'yes');
    INSERT INTO entertainment (id, tv, sound_system, projector, water_front, beach_front) VALUES (1703, 'yes', 'yes', 'yes', 'yes', 'yes');
    INSERT INTO facilities (id, hot_tub, ev_charger, pool, gym, free_parking, entertainment_id) VALUES (1603, 'yes', 'yes', 'no', 'yes', 'yes', 1703);
	INSERT INTO amenities (id, kitchen, air_conditioning, heating, washer, dryer, internet, facilities_id) VALUES (1503, 'yes', 'yes', 'yes', 'yes', 'no', 'no', 1603);
	INSERT INTO room_owner_address (id, house_no, street, state, postcode, last_update, country_id) VALUES (2003, 224, 'Campbell Road', 'Michigan', 48012, 
		'2020-02-25 11:15:36', 80);
    INSERT INTO room_owner (id, first_name, last_name, gender, age, room_owner_address_id) VALUES (1303, 'Chris', 'Daniels', 'Male', 52, 2003);
    INSERT INTO room_address (id, house_no, street, postcode, state, country_id, room_owner_id, amenities_id) VALUES (403, 234, 'Campbell Road', 48067, 'Michigan', 
		80, 1303, 1503);
    INSERT INTO room (id, home_type, total_bedrooms, total_bathrooms, published_date, room_address_id, rules_id) VALUES (153, 'entire place', 2, 2, '2020-01-26 12:13:20',
		403, 503);
	INSERT INTO payment (id, payment_mode, price, discount, total_price, payment_status, reviews_id) VALUES (253, 'card', 700, 00, 700, 'paid', 2503);
    INSERT INTO reservation (id, reservation_type, booking_date, start_date, end_date, last_update, room_id, payment_id) VALUES (4, 'instant book', '2020-08-10 13:29:39',
		'2020-08-16 20:00:00', '2020-08-23 19:00:00', '2021-08-11 17:15:21', 153, 253);
    
	INSERT INTO customer (id, first_name, last_name, gender, age, job_title, job_industry, dependents_id, address_id, staff_id, login_id, reservation_id)
		VALUES (4, 'Oluwole', 'Emmanuel', 'Male', 26, 'Telesales Agent', 'Financial Services', 13, 103, 1003, 10003, 4);
COMMIT;

START TRANSACTION;
	UPDATE amenities_after_use SET post_inspection_id = 603 WHERE id = 703;
	UPDATE facilities_after_use SET post_inspection_id = 603 WHERE id = 803;
    UPDATE entertainment_after_use SET post_inspection_id = 603 WHERE id = 903;
    UPDATE security_questions SET login_details_id = 4 WHERE id = 1103;
    UPDATE post_inspection SET staff_id = 1003 WHERE id = 603;
    UPDATE login_details SET login_id = 10003 WHERE id = 4;
    UPDATE login SET customer_id = 4 WHERE id = 10003;
    UPDATE staff SET customer_id = 4 WHERE id = 1003;
    UPDATE dependents SET customer_id = 4 WHERE id = 13;
    UPDATE address SET customer_id = 4 WHERE id = 103;
    UPDATE rules SET room_id = 153 WHERE id = 503;
    UPDATE reviews SET payment_id = 253 WHERE id = 2503;
    UPDATE entertainment SET facilities_id = 1603 WHERE id = 1703;
    UPDATE facilities SET amenities_id = 1503 WHERE id = 1603;
    UPDATE amenities SET room_address_id = 403 WHERE id = 1503;
    UPDATE room_owner_address SET room_owner_id = 1303 WHERE id = 2003;
    UPDATE room_owner SET room_address_id = 403 WHERE id = 1303;
    UPDATE room_address SET room_id = 153 WHERE id = 403;
    UPDATE room SET reservation_id = 4 WHERE id = 153;
    UPDATE payment SET reservation_id = 4 WHERE id = 253;
    UPDATE reservation SET customer_id = 4 WHERE id = 4;
COMMIT;


#ROW FIVE
START TRANSACTION;
	#INSERT INTO country (id, country, continent, last_updated) VALUES (83, 'Nigeria', 'Africa', '2020-08-22 19:34:35');
	INSERT INTO amenities_after_use (id, kitchen, air_conditioning, heating, washer, dryer, internet) VALUES (704, 'good', 'good', 'good', 'good', 'good', 'good');
	INSERT INTO facilities_after_use (id, hot_tub, ev_charger, pool, gym, free_parking) VALUES (804, 'good', 'good', 'good', 'good', 'good');
    INSERT INTO entertainment_after_use (id, tv, sound_system, projector, water_front, beach_front) VALUES (904, 'good', 'damaged', 'good', 'good', 'good');
    INSERT INTO security_questions (id, nickname, pet_name, birth_city) VALUES (1104, 'Manny', 'bush', 'Ogun');
    INSERT INTO post_inspection (id, inspection_date, amenities_after_use_id, facilities_after_use_id, entertainment_after_use_id) VALUES (604, '2020-09-12 09:00:00',
		704, 804, 904);
    INSERT INTO login_details (id, username, pass_word, last_updated, security_questions_id) VALUES (5, 'akanfed234', 'bigaki4567', '2020-09-06 19:14:25', 1104);
    INSERT INTO login (id, email, phone_number, create_date, last_login, account_status, verified_status, login_details_id) VALUES (10004, 'akanke5676@gmail.com',
		0815566688, '2020-08-29 14:18:34', '2020-09-11 17:28:10', 'active', 'verified', 5);
	INSERT INTO staff (id, first_name, last_name, gender, age, title, post_inspection_id) VALUES (1004, 'Brittany', 'Humphrey', 'Female', 32, 'Partner', 604);
    INSERT INTO dependents (id, spouse, children, infants, last_update) VALUES (14, 'no', 0, 0, '2020-08-21 14:26:18');
    INSERT INTO address (id, house_no, street, postcode, state, last_update, country_id) VALUES (104, 45, 'Lekki Road', 105102, 'Lagos', '2020-08-21 13:32:40', 83);
    INSERT INTO rules (id, pets, smoking) VALUES (504, 'no', 'no');
    INSERT INTO reviews (id, stars, comments, recommend) VALUES (2504, 3, 'fair deal', 'no');
    INSERT INTO entertainment (id, tv, sound_system, projector, water_front, beach_front) VALUES (1704, 'no', 'no', 'yes', 'yes', 'yes');
    INSERT INTO facilities (id, hot_tub, ev_charger, pool, gym, free_parking, entertainment_id) VALUES (1604, 'yes', 'yes', 'no', 'yes', 'no', 1704);
	INSERT INTO amenities (id, kitchen, air_conditioning, heating, washer, dryer, internet, facilities_id) VALUES (1504, 'yes', 'no', 'no', 'yes', 'no', 'no', 1604);
	INSERT INTO room_owner_address (id, house_no, street, state, postcode, last_update, country_id) VALUES (2004, 124, 'Broadway', 'New York', 10005, 
		'2020-03-27 11:15:36', 80);
    INSERT INTO room_owner (id, first_name, last_name, gender, age, room_owner_address_id) VALUES (1304, 'Eva', 'Smith', 'Female', 62, 2004);
    INSERT INTO room_address (id, house_no, street, postcode, state, country_id, room_owner_id, amenities_id) VALUES (404, 123, 'Broadway', 10004, 'New York', 
		80, 1304, 1504);
    INSERT INTO room (id, home_type, total_bedrooms, total_bathrooms, published_date, room_address_id, rules_id) VALUES (154, 'shared room', 1, 1, '2020-01-29 13:13:40',
		404, 504);
	INSERT INTO payment (id, payment_mode, price, discount, total_price, payment_status, reviews_id) VALUES (254, 'card', 410, 20, 390, 'paid', 2504);
    INSERT INTO reservation (id, reservation_type, booking_date, start_date, end_date, last_update, room_id, payment_id) VALUES (5, 'instant book', '2020-09-01 12:39:50',
		'2020-09-04 10:00:00', '2020-09-10 09:00:00', '2020-09-03 17:15:21', 154, 254);
    
	INSERT INTO customer (id, first_name, last_name, gender, age, job_title, job_industry, dependents_id, address_id, staff_id, login_id, reservation_id)
		VALUES (5, 'Akande', 'Festus', 'Male', 27, 'Programmer', 'Information Technology', 14, 104, 1004, 10004, 5);
COMMIT;

START TRANSACTION;
	UPDATE amenities_after_use SET post_inspection_id = 604 WHERE id = 704;
	UPDATE facilities_after_use SET post_inspection_id = 604 WHERE id = 804;
    UPDATE entertainment_after_use SET post_inspection_id = 604 WHERE id = 904;
    UPDATE security_questions SET login_details_id = 5 WHERE id = 1104;
    UPDATE post_inspection SET staff_id = 1004 WHERE id = 604;
    UPDATE login_details SET login_id = 10004 WHERE id = 5;
    UPDATE login SET customer_id = 5 WHERE id = 10004;
    UPDATE staff SET customer_id = 5 WHERE id = 1004;
    UPDATE dependents SET customer_id = 5 WHERE id = 14;
    UPDATE address SET customer_id = 5 WHERE id = 104;
    UPDATE rules SET room_id = 154 WHERE id = 504;
    UPDATE reviews SET payment_id = 254 WHERE id = 2504;
    UPDATE entertainment SET facilities_id = 1604 WHERE id = 1704;
    UPDATE facilities SET amenities_id = 1504 WHERE id = 1604;
    UPDATE amenities SET room_address_id = 404 WHERE id = 1504;
    UPDATE room_owner_address SET room_owner_id = 1304 WHERE id = 2004;
    UPDATE room_owner SET room_address_id = 404 WHERE id = 1304;
    UPDATE room_address SET room_id = 154 WHERE id = 404;
    UPDATE room SET reservation_id = 5 WHERE id = 154;
    UPDATE payment SET reservation_id = 5 WHERE id = 254;
    UPDATE reservation SET customer_id = 5 WHERE id = 5;
COMMIT;


#ROW SIX
START TRANSACTION;
	#INSERT INTO country (id, country, continent, last_updated) VALUES (83, 'Nigeria', 'Africa', '2020-08-22 19:34:35');
	INSERT INTO amenities_after_use (id, kitchen, air_conditioning, heating, washer, dryer, internet) VALUES (705, 'good', 'good', 'good', 'good', 'good', 'good');
	INSERT INTO facilities_after_use (id, hot_tub, ev_charger, pool, gym, free_parking) VALUES (805, 'good', 'good', 'good', 'good', 'good');
    INSERT INTO entertainment_after_use (id, tv, sound_system, projector, water_front, beach_front) VALUES (905, 'good', 'damaged', 'good', 'good', 'good');
    INSERT INTO security_questions (id, nickname, pet_name, birth_city) VALUES (1105, 'Holak', 'none', 'Osun');
    INSERT INTO post_inspection (id, inspection_date, amenities_after_use_id, facilities_after_use_id, entertainment_after_use_id) VALUES (605, '2020-09-27 12:00:00',
		705, 805, 905);
    INSERT INTO login_details (id, username, pass_word, last_updated, security_questions_id) VALUES (6, 'Holay98', 'smart20', '2020-09-15 13:14:28', 1105);
    INSERT INTO login (id, email, phone_number, create_date, last_login, account_status, verified_status, login_details_id) VALUES (10005, 'davidholay@hotmail.com',
		08122222222, '2020-09-12 14:18:33', '2020-09-29 17:28:54', 'active', 'verified', 6);
	INSERT INTO staff (id, first_name, last_name, gender, age, title, post_inspection_id) VALUES (1005, 'Erika', 'Schaffer', 'Female', 42, 'Supervisor', 605);
    INSERT INTO dependents (id, spouse, children, infants, last_update) VALUES (15, 'yes', 0, 0, '2020-09-16 17:36:30');
    INSERT INTO address (id, house_no, street, postcode, state, last_update, country_id) VALUES (105, 56, 'Oluyole', 200261, 'Ibadan', '2020-08-21 13:32:40', 83);
    INSERT INTO rules (id, pets, smoking) VALUES (505, 'no', 'no');
    INSERT INTO reviews (id, stars, comments, recommend) VALUES (2505, 5, 'great and relaxing experience', 'yes');
    INSERT INTO entertainment (id, tv, sound_system, projector, water_front, beach_front) VALUES (1705, 'no', 'yes', 'yes', 'yes', 'yes');
    INSERT INTO facilities (id, hot_tub, ev_charger, pool, gym, free_parking, entertainment_id) VALUES (1605, 'yes', 'yes', 'yes', 'yes', 'yes', 1705);
	INSERT INTO amenities (id, kitchen, air_conditioning, heating, washer, dryer, internet, facilities_id) VALUES (1505, 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 1605);
	INSERT INTO room_owner_address (id, house_no, street, state, postcode, last_update, country_id) VALUES (2005, 54, 'Postdamer', 'Berlin', 10782, 
		'2020-03-27 21:25:30', 84);
    INSERT INTO room_owner (id, first_name, last_name, gender, age, room_owner_address_id) VALUES (1305, 'Michaels', 'Staffer', 'Male', 47, 2005);
    INSERT INTO room_address (id, house_no, street, postcode, state, country_id, room_owner_id, amenities_id) VALUES (405, 56, 'Postdamer', 10780, 'Berlin', 
		84, 1305, 1505);
    INSERT INTO room (id, home_type, total_bedrooms, total_bathrooms, published_date, room_address_id, rules_id) VALUES (155, 'Hotel room', 1, 1, '2020-03-09 13:19:20',
		405, 505);
	INSERT INTO payment (id, payment_mode, price, discount, total_price, payment_status, reviews_id) VALUES (255, 'card', 900, 50, 850, 'paid', 2505);
    INSERT INTO reservation (id, reservation_type, booking_date, start_date, end_date, last_update, room_id, payment_id) VALUES (6, 'request book', '2020-09-14 13:50:31',
		'2020-09-19 07:00:00', '2020-09-26 06:00:00', '2020-09-16 19:05:34', 155, 255);
    
	INSERT INTO customer (id, first_name, last_name, gender, age, job_title, job_industry, dependents_id, address_id, staff_id, login_id, reservation_id)
		VALUES (6, 'Olayoke', 'David', 'Male', 31, 'Accountant', 'Financial Services', 15, 105, 1005, 10005, 6);
COMMIT;

START TRANSACTION;
	UPDATE amenities_after_use SET post_inspection_id = 605 WHERE id = 705;
	UPDATE facilities_after_use SET post_inspection_id = 605 WHERE id = 805;
    UPDATE entertainment_after_use SET post_inspection_id = 605 WHERE id = 905;
    UPDATE security_questions SET login_details_id = 6 WHERE id = 1105;
    UPDATE post_inspection SET staff_id = 1005 WHERE id = 605;
    UPDATE login_details SET login_id = 10005 WHERE id = 6;
    UPDATE login SET customer_id = 6 WHERE id = 10005;
    UPDATE staff SET customer_id = 6 WHERE id = 1005;
    UPDATE dependents SET customer_id = 6 WHERE id = 15;
    UPDATE address SET customer_id = 6 WHERE id = 105;
    UPDATE rules SET room_id = 155 WHERE id = 505;
    UPDATE reviews SET payment_id = 255 WHERE id = 2505;
    UPDATE entertainment SET facilities_id = 1605 WHERE id = 1705;
    UPDATE facilities SET amenities_id = 1505 WHERE id = 1605;
    UPDATE amenities SET room_address_id = 405 WHERE id = 1505;
    UPDATE room_owner_address SET room_owner_id = 1305 WHERE id = 2005;
    UPDATE room_owner SET room_address_id = 405 WHERE id = 1305;
    UPDATE room_address SET room_id = 155 WHERE id = 405;
    UPDATE room SET reservation_id = 6 WHERE id = 155;
    UPDATE payment SET reservation_id = 6 WHERE id = 255;
    UPDATE reservation SET customer_id = 6 WHERE id = 6;
COMMIT;


#ROW SEVEN
START TRANSACTION;
	#INSERT INTO country (id, country, continent, last_updated) VALUES (83, 'Nigeria', 'Africa', '2020-08-22 19:34:35');
	INSERT INTO amenities_after_use (id, kitchen, air_conditioning, heating, washer, dryer, internet) VALUES (706, 'good', 'good', 'good', 'good', 'good', 'good');
	INSERT INTO facilities_after_use (id, hot_tub, ev_charger, pool, gym, free_parking) VALUES (806, 'good', 'good', 'good', 'good', 'good');
    INSERT INTO entertainment_after_use (id, tv, sound_system, projector, water_front, beach_front) VALUES (906, 'good', 'damaged', 'good', 'good', 'good');
    INSERT INTO security_questions (id, nickname, pet_name, birth_city) VALUES (1106, 'Sabbaty', 'smurf', 'Texas');
    INSERT INTO post_inspection (id, inspection_date, amenities_after_use_id, facilities_after_use_id, entertainment_after_use_id) VALUES (606, '2020-09-29 10:00:00',
		706, 806, 906);
    INSERT INTO login_details (id, username, pass_word, last_updated, security_questions_id) VALUES (7, 'Thommy268', 'sabath15', '2020-09-19 13:14:21', 1106);
    INSERT INTO login (id, email, phone_number, create_date, last_login, account_status, verified_status, login_details_id) VALUES (10006, 'thomfhoral@hotmail.com',
		15678345670, '2020-09-15 14:11:35', '2020-09-30 17:48:50', 'active', 'verified', 7);
	INSERT INTO staff (id, first_name, last_name, gender, age, title, post_inspection_id) VALUES (1006, 'Uzor', 'Esther', 'Female', 37, 'Partner', 606);
    INSERT INTO dependents (id, spouse, children, infants, last_update) VALUES (16, 'yes', 0, 0, '2020-09-17 19:26:10');
    INSERT INTO address (id, house_no, street, postcode, state, last_update, country_id) VALUES (106, 5, 'Avenue', 10016, 'New York', '2020-08-20 13:22:50', 80);
    INSERT INTO rules (id, pets, smoking) VALUES (506, 'no', 'yes');
    INSERT INTO reviews (id, stars, comments, recommend) VALUES (2506, 5, 'had an amazing time', 'yes');
    INSERT INTO entertainment (id, tv, sound_system, projector, water_front, beach_front) VALUES (1706, 'no', 'yes', 'yes', 'yes', 'yes');
    INSERT INTO facilities (id, hot_tub, ev_charger, pool, gym, free_parking, entertainment_id) VALUES (1606, 'yes', 'no', 'yes', 'yes', 'yes', 1706);
	INSERT INTO amenities (id, kitchen, air_conditioning, heating, washer, dryer, internet, facilities_id) VALUES (1506, 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 1606);
	INSERT INTO room_owner_address (id, house_no, street, state, postcode, last_update, country_id) VALUES (2006, 50, 'Victoria Island', 'Lagos', 104057, 
		'2020-03-30 20:29:37', 83);
    INSERT INTO room_owner (id, first_name, last_name, gender, age, room_owner_address_id) VALUES (1306, 'Alade', 'Segun', 'Male', 60, 2006);
    INSERT INTO room_address (id, house_no, street, postcode, state, country_id, room_owner_id, amenities_id) VALUES (406, 100, 'Victoria Island', 104011, 'Lagos', 
		83, 1306, 1506);
    INSERT INTO room (id, home_type, total_bedrooms, total_bathrooms, published_date, room_address_id, rules_id) VALUES (156, 'Hotel room', 2, 2, '2020-03-15 12:29:45',
		406, 506);
	INSERT INTO payment (id, payment_mode, price, discount, total_price, payment_status, reviews_id) VALUES (256, 'check', 400, 10, 390, 'paid', 2506);
    INSERT INTO reservation (id, reservation_type, booking_date, start_date, end_date, last_update, room_id, payment_id) VALUES (7, 'instant book', '2020-09-17 12:35:20',
		'2020-09-21 18:00:00', '2020-09-28 17:00:00', '2020-09-19 16:10:20', 156, 256);
    
	INSERT INTO customer (id, first_name, last_name, gender, age, job_title, job_industry, dependents_id, address_id, staff_id, login_id, reservation_id)
		VALUES (7, 'Thomas', 'Forsteel', 'Male', 37, 'Youtuber', 'Entertainment', 16, 106, 1006, 10006, 7);
COMMIT;

START TRANSACTION;
	UPDATE amenities_after_use SET post_inspection_id = 606 WHERE id = 706;
	UPDATE facilities_after_use SET post_inspection_id = 606 WHERE id = 806;
    UPDATE entertainment_after_use SET post_inspection_id = 606 WHERE id = 906;
    UPDATE security_questions SET login_details_id = 7 WHERE id = 1106;
    UPDATE post_inspection SET staff_id = 1006 WHERE id = 606;
    UPDATE login_details SET login_id = 10006 WHERE id = 7;
    UPDATE login SET customer_id = 7 WHERE id = 10006;
    UPDATE staff SET customer_id = 7 WHERE id = 1006;
    UPDATE dependents SET customer_id = 7 WHERE id = 16;
    UPDATE address SET customer_id = 7 WHERE id = 106;
    UPDATE rules SET room_id = 156 WHERE id = 506;
    UPDATE reviews SET payment_id = 256 WHERE id = 2506;
    UPDATE entertainment SET facilities_id = 1606 WHERE id = 1706;
    UPDATE facilities SET amenities_id = 1506 WHERE id = 1606;
    UPDATE amenities SET room_address_id = 406 WHERE id = 1506;
    UPDATE room_owner_address SET room_owner_id = 1306 WHERE id = 2006;
    UPDATE room_owner SET room_address_id = 406 WHERE id = 1306;
    UPDATE room_address SET room_id = 156 WHERE id = 406;
    UPDATE room SET reservation_id = 7 WHERE id = 156;
    UPDATE payment SET reservation_id = 7 WHERE id = 256;
    UPDATE reservation SET customer_id = 7 WHERE id = 7;
COMMIT;


#ROW EIGHT
START TRANSACTION;
	#INSERT INTO country (id, country, continent, last_updated) VALUES (83, 'Nigeria', 'Africa', '2020-08-22 19:34:35');
	INSERT INTO amenities_after_use (id, kitchen, air_conditioning, heating, washer, dryer, internet) VALUES (707, 'good', 'good', 'good', 'good', 'good', 'good');
	INSERT INTO facilities_after_use (id, hot_tub, ev_charger, pool, gym, free_parking) VALUES (807, 'good', 'good', 'good', 'good', 'good');
    INSERT INTO entertainment_after_use (id, tv, sound_system, projector, water_front, beach_front) VALUES (907, 'good', 'good', 'good', 'good', 'good');
    INSERT INTO security_questions (id, nickname, pet_name, birth_city) VALUES (1107, 'Lynn', 'none', 'warsaw');
    INSERT INTO post_inspection (id, inspection_date, amenities_after_use_id, facilities_after_use_id, entertainment_after_use_id) VALUES (607, '2020-10-07 09:00:00',
		707, 807, 907);
    INSERT INTO login_details (id, username, pass_word, last_updated, security_questions_id) VALUES (8, 'Maurice01', 'Maurty567', '2020-10-02 12:24:21', 1107);
    INSERT INTO login (id, email, phone_number, create_date, last_login, account_status, verified_status, login_details_id) VALUES (10007, 'mauricelynn@gmail.com',
		90357893378, '2020-09-29 14:33:20', '2020-10-05 13:30:54', 'active', 'verified', 8);
	INSERT INTO staff (id, first_name, last_name, gender, age, title, post_inspection_id) VALUES (1007, 'Lenore', 'Dahlia', 'Female', 47, 'Supervisor', 607);
    INSERT INTO dependents (id, spouse, children, infants, last_update) VALUES (17, 'yes', 1, 0, '2020-10-02 13:36:24');
    INSERT INTO address (id, house_no, street, postcode, state, last_update, country_id) VALUES (107, 3, 'Choiny', 10857, 'Lublin', '2020-10-02 17:29:55', 85);
    INSERT INTO rules (id, pets, smoking) VALUES (507, 'no', 'no');
    INSERT INTO reviews (id, stars, comments, recommend) VALUES (2507, 5, 'Exquisite', 'yes');
    INSERT INTO entertainment (id, tv, sound_system, projector, water_front, beach_front) VALUES (1707, 'no', 'yes', 'yes', 'yes', 'yes');
    INSERT INTO facilities (id, hot_tub, ev_charger, pool, gym, free_parking, entertainment_id) VALUES (1607, 'yes', 'yes', 'yes', 'yes', 'yes', 1707);
	INSERT INTO amenities (id, kitchen, air_conditioning, heating, washer, dryer, internet, facilities_id) VALUES (1507, 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 1607);
	INSERT INTO room_owner_address (id, house_no, street, state, postcode, last_update, country_id) VALUES (2007, 123, 'Rouen', 'Normandy', 24119, 
		'2020-04-20 20:29:37', 86);
    INSERT INTO room_owner (id, first_name, last_name, gender, age, room_owner_address_id) VALUES (1307, 'Grettel', 'Draye', 'Male', 39, 2007);
    INSERT INTO room_address (id, house_no, street, postcode, state, country_id, room_owner_id, amenities_id) VALUES (407, 125, 'Rouen', 24123, 'Normandy', 
		86, 1307, 1507);
    INSERT INTO room (id, home_type, total_bedrooms, total_bathrooms, published_date, room_address_id, rules_id) VALUES (157, 'Entire Place', 2, 2, '2020-04-19 11:45:25',
		407, 507);
	INSERT INTO payment (id, payment_mode, price, discount, total_price, payment_status, reviews_id) VALUES (257, 'card', 350, 10, 340, 'paid', 2507);
    INSERT INTO reservation (id, reservation_type, booking_date, start_date, end_date, last_update, room_id, payment_id) VALUES (8, 'request book', '2020-10-01 09:25:30',
		'2020-10-03 20:00:00', '2020-10-06 19:00:00', '2020-10-02 12:12:34', 157, 257);
    
	INSERT INTO customer (id, first_name, last_name, gender, age, job_title, job_industry, dependents_id, address_id, staff_id, login_id, reservation_id)
		VALUES (8, 'Maurita', 'Lyste', 'Female', 47, 'Social Worker', 'Health', 17, 107, 1007, 10007, 8);
COMMIT;

START TRANSACTION;
	UPDATE amenities_after_use SET post_inspection_id = 607 WHERE id = 707;
	UPDATE facilities_after_use SET post_inspection_id = 607 WHERE id = 807;
    UPDATE entertainment_after_use SET post_inspection_id = 607 WHERE id = 907;
    UPDATE security_questions SET login_details_id = 8 WHERE id = 1107;
    UPDATE post_inspection SET staff_id = 1007 WHERE id = 607;
    UPDATE login_details SET login_id = 10007 WHERE id = 8;
    UPDATE login SET customer_id = 8 WHERE id = 10007;
    UPDATE staff SET customer_id = 8 WHERE id = 1007;
    UPDATE dependents SET customer_id = 8 WHERE id = 17;
    UPDATE address SET customer_id = 8 WHERE id = 107;
    UPDATE rules SET room_id = 157 WHERE id = 507;
    UPDATE reviews SET payment_id = 257 WHERE id = 2507;
    UPDATE entertainment SET facilities_id = 1607 WHERE id = 1707;
    UPDATE facilities SET amenities_id = 1507 WHERE id = 1607;
    UPDATE amenities SET room_address_id = 407 WHERE id = 1507;
    UPDATE room_owner_address SET room_owner_id = 1307 WHERE id = 2007;
    UPDATE room_owner SET room_address_id = 407 WHERE id = 1307;
    UPDATE room_address SET room_id = 157 WHERE id = 407;
    UPDATE room SET reservation_id = 8 WHERE id = 157;
    UPDATE payment SET reservation_id = 8 WHERE id = 257;
    UPDATE reservation SET customer_id = 8 WHERE id = 8;
COMMIT;


#ROW NINE
START TRANSACTION;
	#INSERT INTO country (id, country, continent, last_updated) VALUES (83, 'Nigeria', 'Africa', '2020-08-22 19:34:35');
	INSERT INTO amenities_after_use (id, kitchen, air_conditioning, heating, washer, dryer, internet) VALUES (708, 'good', 'good', 'good', 'good', 'good', 'good');
	INSERT INTO facilities_after_use (id, hot_tub, ev_charger, pool, gym, free_parking) VALUES (808, 'good', 'good', 'good', 'good', 'good');
    INSERT INTO entertainment_after_use (id, tv, sound_system, projector, water_front, beach_front) VALUES (908, 'good', 'good', 'good', 'good', 'good');
    INSERT INTO security_questions (id, nickname, pet_name, birth_city) VALUES (1108, 'none', 'monty', 'bonn');
    INSERT INTO post_inspection (id, inspection_date, amenities_after_use_id, facilities_after_use_id, entertainment_after_use_id) VALUES (608, '2020-10-20 09:00:00',
		708, 808, 908);
    INSERT INTO login_details (id, username, pass_word, last_updated, security_questions_id) VALUES (9, 'Fareiko45', 'Faradert237', '2020-10-10 12:55:31', 1108);
    INSERT INTO login (id, email, phone_number, create_date, last_login, account_status, verified_status, login_details_id) VALUES (10008, 'farrell345@gmail.com',
		95424798090, '2020-10-05 14:20:33', '2020-10-23 13:45:14', 'active', 'verified', 9);
	INSERT INTO staff (id, first_name, last_name, gender, age, title, post_inspection_id) VALUES (1008, 'Danielle', 'Cami', 'Female', 37, 'Partner', 608);
    INSERT INTO dependents (id, spouse, children, infants, last_update) VALUES (18, 'yes', 1, 2, '2020-10-10 13:56:14');
    INSERT INTO address (id, house_no, street, postcode, state, last_update, country_id) VALUES (108, 568, 'Hauptwache', 60480, 'Frankfurt', '2020-10-09 16:39:20', 84);
    INSERT INTO rules (id, pets, smoking) VALUES (508, 'no', 'yes');
    INSERT INTO reviews (id, stars, comments, recommend) VALUES (2508, 4, 'Nice', 'yes');
    INSERT INTO entertainment (id, tv, sound_system, projector, water_front, beach_front) VALUES (1708, 'no', 'yes', 'yes', 'yes', 'yes');
    INSERT INTO facilities (id, hot_tub, ev_charger, pool, gym, free_parking, entertainment_id) VALUES (1608, 'yes', 'yes', 'yes', 'yes', 'yes', 1708);
	INSERT INTO amenities (id, kitchen, air_conditioning, heating, washer, dryer, internet, facilities_id) VALUES (1508, 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 1608);
	INSERT INTO room_owner_address (id, house_no, street, state, postcode, last_update, country_id) VALUES (2008, 19, 'Attiki', 'Thiva', 32205, 
		'2020-05-03 20:34:17', 87);
    INSERT INTO room_owner (id, first_name, last_name, gender, age, room_owner_address_id) VALUES (1308, 'Kim', 'Sampsons', 'Female', 45, 2008);
    INSERT INTO room_address (id, house_no, street, postcode, state, country_id, room_owner_id, amenities_id) VALUES (408, 15, 'Attiki', 32201, 'Thiva', 
		87, 1308, 1508);
    INSERT INTO room (id, home_type, total_bedrooms, total_bathrooms, published_date, room_address_id, rules_id) VALUES (158, 'Entire Place', 3, 3, '2020-04-20 11:34:15',
		408, 508);
	INSERT INTO payment (id, payment_mode, price, discount, total_price, payment_status, reviews_id) VALUES (258, 'card', 1019, 20, 999, 'paid', 2508);
    INSERT INTO reservation (id, reservation_type, booking_date, start_date, end_date, last_update, room_id, payment_id) VALUES (9, 'instant book', '2020-10-07 06:45:10',
		'2020-10-12 09:00:00', '2020-10-12 08:00:00', '2020-10-02 16:23:44', 158, 258);
    
	INSERT INTO customer (id, first_name, last_name, gender, age, job_title, job_industry, dependents_id, address_id, staff_id, login_id, reservation_id)
		VALUES (9, 'Heath', 'Faraday', 'Male', 34, 'Sales Associate', 'Financial Services', 18, 108, 1008, 10008, 9);
COMMIT;

START TRANSACTION;
	UPDATE amenities_after_use SET post_inspection_id = 608 WHERE id = 708;
	UPDATE facilities_after_use SET post_inspection_id = 608 WHERE id = 808;
    UPDATE entertainment_after_use SET post_inspection_id = 608 WHERE id = 908;
    UPDATE security_questions SET login_details_id = 9 WHERE id = 1108;
    UPDATE post_inspection SET staff_id = 1008 WHERE id = 608;
    UPDATE login_details SET login_id = 10008 WHERE id = 9;
    UPDATE login SET customer_id = 9 WHERE id = 10008;
    UPDATE staff SET customer_id = 9 WHERE id = 1008;
    UPDATE dependents SET customer_id = 9 WHERE id = 18;
    UPDATE address SET customer_id = 9 WHERE id = 108;
    UPDATE rules SET room_id = 158 WHERE id = 508;
    UPDATE reviews SET payment_id = 258 WHERE id = 2508;
    UPDATE entertainment SET facilities_id = 1608 WHERE id = 1708;
    UPDATE facilities SET amenities_id = 1508 WHERE id = 1608;
    UPDATE amenities SET room_address_id = 408 WHERE id = 1508;
    UPDATE room_owner_address SET room_owner_id = 1308 WHERE id = 2008;
    UPDATE room_owner SET room_address_id = 408 WHERE id = 1308;
    UPDATE room_address SET room_id = 158 WHERE id = 408;
    UPDATE room SET reservation_id = 9 WHERE id = 158;
    UPDATE payment SET reservation_id = 9 WHERE id = 258;
    UPDATE reservation SET customer_id = 9 WHERE id = 9;
COMMIT;


#ROW TEN
START TRANSACTION;
	#INSERT INTO country (id, country, continent, last_updated) VALUES (83, 'Nigeria', 'Africa', '2020-08-22 19:34:35');
	INSERT INTO amenities_after_use (id, kitchen, air_conditioning, heating, washer, dryer, internet) VALUES (709, 'good', 'good', 'good', 'good', 'good', 'good');
	INSERT INTO facilities_after_use (id, hot_tub, ev_charger, pool, gym, free_parking) VALUES (809, 'good', 'good', 'good', 'good', 'good');
    INSERT INTO entertainment_after_use (id, tv, sound_system, projector, water_front, beach_front) VALUES (909, 'good', 'good', 'good', 'good', 'good');
    INSERT INTO security_questions (id, nickname, pet_name, birth_city) VALUES (1109, 'Erril', 'minty', 'Thiva');
    INSERT INTO post_inspection (id, inspection_date, amenities_after_use_id, facilities_after_use_id, entertainment_after_use_id) VALUES (609, '2020-10-24 08:00:00',
		709, 809, 909);
    INSERT INTO login_details (id, username, pass_word, last_updated, security_questions_id) VALUES (10, 'Erolllar1', 'wtrewuiio', '2020-10-13 11:50:21', 1109);
    INSERT INTO login (id, email, phone_number, create_date, last_login, account_status, verified_status, login_details_id) VALUES (10009, 'errolradage@hotmail.com',
		56453789200, '2020-10-10 14:15:43', '2020-10-23 19:40:10', 'active', 'verified', 10);
	INSERT INTO staff (id, first_name, last_name, gender, age, title, post_inspection_id) VALUES (1009, 'Danielle', 'Paulina', 'Female', 47, 'Superviisor', 609);
    INSERT INTO dependents (id, spouse, children, infants, last_update) VALUES (19, 'yes', 0, 0, '2020-10-14 13:56:34');
    INSERT INTO address (id, house_no, street, postcode, state, last_update, country_id) VALUES (109, 512, 'Odos', 20100, 'Corinth', '2020-10-29 16:38:10', 87);
    INSERT INTO rules (id, pets, smoking) VALUES (509, 'yes', 'yes');
    INSERT INTO reviews (id, stars, comments, recommend) VALUES (2509, 5, 'Great', 'yes');
    INSERT INTO entertainment (id, tv, sound_system, projector, water_front, beach_front) VALUES (1709, 'yes', 'yes', 'yes', 'yes', 'yes');
    INSERT INTO facilities (id, hot_tub, ev_charger, pool, gym, free_parking, entertainment_id) VALUES (1609, 'yes', 'yes', 'yes', 'yes', 'yes', 1709);
	INSERT INTO amenities (id, kitchen, air_conditioning, heating, washer, dryer, internet, facilities_id) VALUES (1509, 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 1609);
	INSERT INTO room_owner_address (id, house_no, street, state, postcode, last_update, country_id) VALUES (2009, 148, 'Newtown', 'Wales', 2615, 
		'2020-05-08 21:24:45', 82);
    INSERT INTO room_owner (id, first_name, last_name, gender, age, room_owner_address_id) VALUES (1309, 'Harlin', 'Parr', 'Female', 46, 2009);
    INSERT INTO room_address (id, house_no, street, postcode, state, country_id, room_owner_id, amenities_id) VALUES (409, 150, 'Newtown', 2617, 'Wales', 
		82, 1309, 1509);
    INSERT INTO room (id, home_type, total_bedrooms, total_bathrooms, published_date, room_address_id, rules_id) VALUES (159, 'Entire Place', 2, 2, '2020-04-26 12:34:45',
		409, 509);
	INSERT INTO payment (id, payment_mode, price, discount, total_price, payment_status, reviews_id) VALUES (259, 'card', 329, 20, 309, 'paid', 2509);
    INSERT INTO reservation (id, reservation_type, booking_date, start_date, end_date, last_update, room_id, payment_id) VALUES (10, 'instant book', '2020-10-12 04:55:10',
		'2020-10-16 09:00:00', '2020-10-22 08:00:00', '2020-10-02 16:23:44', 159, 259);
    
	INSERT INTO customer (id, first_name, last_name, gender, age, job_title, job_industry, dependents_id, address_id, staff_id, login_id, reservation_id)
		VALUES (10, 'Errol', 'Radage', 'Male', 45, 'Nuclear Engineer', 'Manufacturing', 19, 109, 1009, 10009, 10);
COMMIT;

START TRANSACTION;
	UPDATE amenities_after_use SET post_inspection_id = 609 WHERE id = 709;
	UPDATE facilities_after_use SET post_inspection_id = 609 WHERE id = 809;
    UPDATE entertainment_after_use SET post_inspection_id = 609 WHERE id = 909;
    UPDATE security_questions SET login_details_id = 10 WHERE id = 1109;
    UPDATE post_inspection SET staff_id = 1009 WHERE id = 609;
    UPDATE login_details SET login_id = 10009 WHERE id = 10;
    UPDATE login SET customer_id = 10 WHERE id = 10009;
    UPDATE staff SET customer_id = 10 WHERE id = 1009;
    UPDATE dependents SET customer_id = 10 WHERE id = 19;
    UPDATE address SET customer_id = 10 WHERE id = 109;
    UPDATE rules SET room_id = 159 WHERE id = 509;
    UPDATE reviews SET payment_id = 259 WHERE id = 2509;
    UPDATE entertainment SET facilities_id = 1609 WHERE id = 1709;
    UPDATE facilities SET amenities_id = 1509 WHERE id = 1609;
    UPDATE amenities SET room_address_id = 409 WHERE id = 1509;
    UPDATE room_owner_address SET room_owner_id = 1309 WHERE id = 2009;
    UPDATE room_owner SET room_address_id = 409 WHERE id = 1309;
    UPDATE room_address SET room_id = 159 WHERE id = 409;
    UPDATE room SET reservation_id = 10 WHERE id = 159;
    UPDATE payment SET reservation_id = 10 WHERE id = 259;
    UPDATE reservation SET customer_id = 10 WHERE id = 10;
COMMIT;


#ROW ELEVEN
START TRANSACTION;
	#INSERT INTO country (id, country, continent, last_updated) VALUES (83, 'Nigeria', 'Africa', '2020-08-22 19:34:35');
	INSERT INTO amenities_after_use (id, kitchen, air_conditioning, heating, washer, dryer, internet) VALUES (710, 'good', 'good', 'good', 'good', 'good', 'good');
	INSERT INTO facilities_after_use (id, hot_tub, ev_charger, pool, gym, free_parking) VALUES (810, 'good', 'good', 'good', 'good', 'good');
    INSERT INTO entertainment_after_use (id, tv, sound_system, projector, water_front, beach_front) VALUES (910, 'good', 'good', 'good', 'good', 'good');
    INSERT INTO security_questions (id, nickname, pet_name, birth_city) VALUES (1110, 'smart', 'none', 'Ontario');
    INSERT INTO post_inspection (id, inspection_date, amenities_after_use_id, facilities_after_use_id, entertainment_after_use_id) VALUES (610, '2020-10-27 08:00:00',
		710, 810, 910);
    INSERT INTO login_details (id, username, pass_word, last_updated, security_questions_id) VALUES (11, 'smitten467', 'carryert543', '2020-10-19 10:20:10', 1110);
    INSERT INTO login (id, email, phone_number, create_date, last_login, account_status, verified_status, login_details_id) VALUES (10010, 'carrygarrt@gmail.com',
		1453248645, '2020-10-14 08:10:23', '2020-10-28 10:00:50', 'active', 'verified', 11);
	INSERT INTO staff (id, first_name, last_name, gender, age, title, post_inspection_id) VALUES (1010, 'Elizabeth', 'Keen', 'Female', 35, 'Partner', 610);
    INSERT INTO dependents (id, spouse, children, infants, last_update) VALUES (20, 'no', 0, 0, '2020-10-16 13:50:20');
    INSERT INTO address (id, house_no, street, postcode, state, last_update, country_id) VALUES (110, 126, 'Abington Road', 90123, 'Manitoba', '2020-10-17 14:20:00', 81);
    INSERT INTO rules (id, pets, smoking) VALUES (510, 'yes', 'yes');
    INSERT INTO reviews (id, stars, comments, recommend) VALUES (2510, 3, 'Nice', 'no');
    INSERT INTO entertainment (id, tv, sound_system, projector, water_front, beach_front) VALUES (1710, 'yes', 'yes', 'no', 'no', 'no');
    INSERT INTO facilities (id, hot_tub, ev_charger, pool, gym, free_parking, entertainment_id) VALUES (1610, 'yes', 'no', 'yes', 'yes', 'yes', 1710);
	INSERT INTO amenities (id, kitchen, air_conditioning, heating, washer, dryer, internet, facilities_id) VALUES (1510, 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 1610);
	INSERT INTO room_owner_address (id, house_no, street, state, postcode, last_update, country_id) VALUES (2010, 1209, 'Atlantic Ave', 'Florida', 10018, 
		'2020-05-10 23:14:50', 80);
    INSERT INTO room_owner (id, first_name, last_name, gender, age, room_owner_address_id) VALUES (1310, 'Dylan', 'Meaker', 'Female', 35, 2010);
    INSERT INTO room_address (id, house_no, street, postcode, state, country_id, room_owner_id, amenities_id) VALUES (410, 1211, 'Atlantic Ave', 10021, 'Florida', 
		80, 1310, 1510);
    INSERT INTO room (id, home_type, total_bedrooms, total_bathrooms, published_date, room_address_id, rules_id) VALUES (160, 'Shared Room', 1, 1, '2020-04-28 13:34:50',
		410, 510);
	INSERT INTO payment (id, payment_mode, price, discount, total_price, payment_status, reviews_id) VALUES (260, 'card', 500, 20, 480, 'paid', 2510);
    INSERT INTO reservation (id, reservation_type, booking_date, start_date, end_date, last_update, room_id, payment_id) VALUES (11, 'instant book', '2020-10-16 03:25:10',
		'2020-10-20 08:00:00', '2020-10-26 07:00:00', '2020-10-17 16:30:00', 160, 260);
    
	INSERT INTO customer (id, first_name, last_name, gender, age, job_title, job_industry, dependents_id, address_id, staff_id, login_id, reservation_id)
		VALUES (11, 'Cary', 'Garron', 'Male', 37, 'Structural Engineer', 'Construction', 20, 110, 1010, 10010, 11);
COMMIT;

START TRANSACTION;
	UPDATE amenities_after_use SET post_inspection_id = 610 WHERE id = 710;
	UPDATE facilities_after_use SET post_inspection_id = 610 WHERE id = 810;
    UPDATE entertainment_after_use SET post_inspection_id = 610 WHERE id = 910;
    UPDATE security_questions SET login_details_id = 11 WHERE id = 1110;
    UPDATE post_inspection SET staff_id = 1010 WHERE id = 610;
    UPDATE login_details SET login_id = 10010 WHERE id = 11;
    UPDATE login SET customer_id = 11 WHERE id = 10010;
    UPDATE staff SET customer_id = 11 WHERE id = 1010;
    UPDATE dependents SET customer_id = 11 WHERE id = 20;
    UPDATE address SET customer_id = 11 WHERE id = 110;
    UPDATE rules SET room_id = 160 WHERE id = 510;
    UPDATE reviews SET payment_id = 260 WHERE id = 2510;
    UPDATE entertainment SET facilities_id = 1610 WHERE id = 1710;
    UPDATE facilities SET amenities_id = 1510 WHERE id = 1610;
    UPDATE amenities SET room_address_id = 410 WHERE id = 1510;
    UPDATE room_owner_address SET room_owner_id = 1310 WHERE id = 2010;
    UPDATE room_owner SET room_address_id = 410 WHERE id = 1310;
    UPDATE room_address SET room_id = 160 WHERE id = 410;
    UPDATE room SET reservation_id = 11 WHERE id = 160;
    UPDATE payment SET reservation_id = 11 WHERE id = 260;
    UPDATE reservation SET customer_id = 11 WHERE id = 11;
COMMIT;


#ROW TWELVE
START TRANSACTION;
	#INSERT INTO country (id, country, continent, last_updated) VALUES (83, 'Nigeria', 'Africa', '2020-08-22 19:34:35');
	INSERT INTO amenities_after_use (id, kitchen, air_conditioning, heating, washer, dryer, internet) VALUES (711, 'good', 'good', 'good', 'good', 'good', 'good');
	INSERT INTO facilities_after_use (id, hot_tub, ev_charger, pool, gym, free_parking) VALUES (811, 'good', 'good', 'good', 'good', 'good');
    INSERT INTO entertainment_after_use (id, tv, sound_system, projector, water_front, beach_front) VALUES (911, 'good', 'good', 'good', 'good', 'good');
    INSERT INTO security_questions (id, nickname, pet_name, birth_city) VALUES (1111, 'bigarf', 'none', 'biscey');
    INSERT INTO post_inspection (id, inspection_date, amenities_after_use_id, facilities_after_use_id, entertainment_after_use_id) VALUES (611, '2020-10-27 08:00:00',
		711, 811, 911);
    INSERT INTO login_details (id, username, pass_word, last_updated, security_questions_id) VALUES (12, 'gowerplans4', 'Grower657', '2020-11-01 20:10:23', 1111);
    INSERT INTO login (id, email, phone_number, create_date, last_login, account_status, verified_status, login_details_id) VALUES (10011, 'gowergowon45@outloook.com',
		7843275467, '2020-10-29 08:00:13', '2020-11-10 10:00:00', 'active', 'verified', 12);
	INSERT INTO staff (id, first_name, last_name, gender, age, title, post_inspection_id) VALUES (1011, 'Matthews', 'Kaplan', 'Female', 58, 'Supervisor', 611);
    INSERT INTO dependents (id, spouse, children, infants, last_update) VALUES (21, 'yes', 0, 0, '2020-11-04 14:10:20');
    INSERT INTO address (id, house_no, street, postcode, state, last_update, country_id) VALUES (111, 1456, 'Biscey', 01003, 'Valencia', '2020-11-02 13:10:00', 88);
    INSERT INTO rules (id, pets, smoking) VALUES (511, 'no', 'yes');
    INSERT INTO reviews (id, stars, comments, recommend) VALUES (2511, 4, 'Amazing Experience', 'yes');
    INSERT INTO entertainment (id, tv, sound_system, projector, water_front, beach_front) VALUES (1711, 'yes', 'yes', 'no', 'yes', 'yes');
    INSERT INTO facilities (id, hot_tub, ev_charger, pool, gym, free_parking, entertainment_id) VALUES (1611, 'yes', 'yes', 'yes', 'yes', 'yes', 1711);
	INSERT INTO amenities (id, kitchen, air_conditioning, heating, washer, dryer, internet, facilities_id) VALUES (1511, 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 1611);
	INSERT INTO room_owner_address (id, house_no, street, state, postcode, last_update, country_id) VALUES (2011, 11, 'Via Guila', 'Rome', 96011, 
		'2020-05-16 11:40:27', 90);
    INSERT INTO room_owner (id, first_name, last_name, gender, age, room_owner_address_id) VALUES (1311, 'Arne', 'Coraine', 'Male', 39, 2011);
    INSERT INTO room_address (id, house_no, street, postcode, state, country_id, room_owner_id, amenities_id) VALUES (411, 15, 'Via Guila', 96011, 'Rome', 
		90, 1311, 1511);
    INSERT INTO room (id, home_type, total_bedrooms, total_bathrooms, published_date, room_address_id, rules_id) VALUES (161, 'Entire Place', 2, 2, '2020-04-23 16:20:40',
		411, 511);
	INSERT INTO payment (id, payment_mode, price, discount, total_price, payment_status, reviews_id) VALUES (261, 'check', 780, 00, 780, 'paid', 2511);
    INSERT INTO reservation (id, reservation_type, booking_date, start_date, end_date, last_update, room_id, payment_id) VALUES (12, 'request book', '2020-11-01 08:00:16',
		'2020-11-04 07:00:00', '2020-11-07 06:00:00', '2020-11-03 13:00:09', 161, 261);
    
	INSERT INTO customer (id, first_name, last_name, gender, age, job_title, job_industry, dependents_id, address_id, staff_id, login_id, reservation_id)
		VALUES (12, 'Gordan', 'Gower', 'Male', 57, 'Software Engineer', 'Information Technology', 21, 111, 1011, 10011, 12);
COMMIT;

START TRANSACTION;
	UPDATE amenities_after_use SET post_inspection_id = 611 WHERE id = 711;
	UPDATE facilities_after_use SET post_inspection_id = 611 WHERE id = 811;
    UPDATE entertainment_after_use SET post_inspection_id = 611 WHERE id = 911;
    UPDATE security_questions SET login_details_id = 12 WHERE id = 1111;
    UPDATE post_inspection SET staff_id = 1011 WHERE id = 611;
    UPDATE login_details SET login_id = 10011 WHERE id = 12;
    UPDATE login SET customer_id = 12 WHERE id = 10011;
    UPDATE staff SET customer_id = 12 WHERE id = 1011;
    UPDATE dependents SET customer_id = 12 WHERE id = 21;
    UPDATE address SET customer_id = 12 WHERE id = 111;
    UPDATE rules SET room_id = 161 WHERE id = 511;
    UPDATE reviews SET payment_id = 261 WHERE id = 2511;
    UPDATE entertainment SET facilities_id = 1611 WHERE id = 1711;
    UPDATE facilities SET amenities_id = 1511 WHERE id = 1611;
    UPDATE amenities SET room_address_id = 411 WHERE id = 1511;
    UPDATE room_owner_address SET room_owner_id = 1311 WHERE id = 2011;
    UPDATE room_owner SET room_address_id = 411 WHERE id = 1311;
    UPDATE room_address SET room_id = 161 WHERE id = 411;
    UPDATE room SET reservation_id = 12 WHERE id = 161;
    UPDATE payment SET reservation_id = 12 WHERE id = 261;
    UPDATE reservation SET customer_id = 12 WHERE id = 12;
COMMIT;


#ROW THIRTEEN
START TRANSACTION;
	#INSERT INTO country (id, country, continent, last_updated) VALUES (83, 'Nigeria', 'Africa', '2020-08-22 19:34:35');
	INSERT INTO amenities_after_use (id, kitchen, air_conditioning, heating, washer, dryer, internet) VALUES (712, 'good', 'good', 'good', 'good', 'good', 'good');
	INSERT INTO facilities_after_use (id, hot_tub, ev_charger, pool, gym, free_parking) VALUES (812, 'good', 'good', 'good', 'good', 'good');
    INSERT INTO entertainment_after_use (id, tv, sound_system, projector, water_front, beach_front) VALUES (912, 'good', 'damaged', 'good', 'good', 'good');
    INSERT INTO security_questions (id, nickname, pet_name, birth_city) VALUES (1112, 'sterling', 'steff', 'lome');
    INSERT INTO post_inspection (id, inspection_date, amenities_after_use_id, facilities_after_use_id, entertainment_after_use_id) VALUES (612, '2020-11-13 09:00:00',
		712, 812, 912);
    INSERT INTO login_details (id, username, pass_word, last_updated, security_questions_id) VALUES (13, 'manofsteel', 'Syeel96', '2020-11-06 20:23:10', 1112);
    INSERT INTO login (id, email, phone_number, create_date, last_login, account_status, verified_status, login_details_id) VALUES (10012, 'tripforsteel@gmail.com',
		94238645638, '2020-11-25 08:00:56', '2020-11-14 08:00:00', 'active', 'verified', 13);
	INSERT INTO staff (id, first_name, last_name, gender, age, title, post_inspection_id) VALUES (1012, 'Rebekah', 'Gillies', 'Female', 28, 'Agent', 612);
    INSERT INTO dependents (id, spouse, children, infants, last_update) VALUES (22, 'no', 1, 0, '2020-11-06 19:18:28');
    INSERT INTO address (id, house_no, street, postcode, state, last_update, country_id) VALUES (112, 10, 'Km Main', 3200271, 'Houdegbe', '2020-11-05 19:10:34', 89);
    INSERT INTO rules (id, pets, smoking) VALUES (512, 'yes', 'yes');
    INSERT INTO reviews (id, stars, comments, recommend) VALUES (2512, 4, 'I had a good time', 'yes');
    INSERT INTO entertainment (id, tv, sound_system, projector, water_front, beach_front) VALUES (1712, 'yes', 'yes', 'no', 'yes', 'yes');
    INSERT INTO facilities (id, hot_tub, ev_charger, pool, gym, free_parking, entertainment_id) VALUES (1612, 'yes', 'yes', 'yes', 'yes', 'yes', 1712);
	INSERT INTO amenities (id, kitchen, air_conditioning, heating, washer, dryer, internet, facilities_id) VALUES (1512, 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 1612);
	INSERT INTO room_owner_address (id, house_no, street, state, postcode, last_update, country_id) VALUES (2012, 1, 'Choiny', 'Lublin', 20821, 
		'2020-06-01 09:10:30', 85);
    INSERT INTO room_owner (id, first_name, last_name, gender, age, room_owner_address_id) VALUES (1312, 'Goran', 'Quick', 'Female', 28, 2012);
    INSERT INTO room_address (id, house_no, street, postcode, state, country_id, room_owner_id, amenities_id) VALUES (412, 1, 'Choiny', 20821, 'Lublin', 
		85, 1312, 1512);
    INSERT INTO room (id, home_type, total_bedrooms, total_bathrooms, published_date, room_address_id, rules_id) VALUES (162, 'Entire Place', 3, 2, '2020-04-28 19:00:34',
		412, 512);
	INSERT INTO payment (id, payment_mode, price, discount, total_price, payment_status, reviews_id) VALUES (262, 'card', 450, 20, 430, 'paid', 2512);
    INSERT INTO reservation (id, reservation_type, booking_date, start_date, end_date, last_update, room_id, payment_id) VALUES (13, 'instant book', '2020-11-05 09:10:20',
		'2020-11-06 18:00:00', '2020-11-13 17:00:00', '2020-11-05 21:00:59', 162, 262);
    
	INSERT INTO customer (id, first_name, last_name, gender, age, job_title, job_industry, dependents_id, address_id, staff_id, login_id, reservation_id)
		VALUES (13, 'Tripp', 'Steel', 'Male', 52, 'Full-Stack Developer', 'Information Technology', 22, 112, 1012, 10012, 13);
COMMIT;

START TRANSACTION;
	UPDATE amenities_after_use SET post_inspection_id = 612 WHERE id = 712;
	UPDATE facilities_after_use SET post_inspection_id = 612 WHERE id = 812;
    UPDATE entertainment_after_use SET post_inspection_id = 612 WHERE id = 912;
    UPDATE security_questions SET login_details_id = 13 WHERE id = 1112;
    UPDATE post_inspection SET staff_id = 1012 WHERE id = 612;
    UPDATE login_details SET login_id = 10012 WHERE id = 13;
    UPDATE login SET customer_id = 13 WHERE id = 10012;
    UPDATE staff SET customer_id = 13 WHERE id = 1012;
    UPDATE dependents SET customer_id = 13 WHERE id = 22;
    UPDATE address SET customer_id = 13 WHERE id = 112;
    UPDATE rules SET room_id = 162 WHERE id = 512;
    UPDATE reviews SET payment_id = 262 WHERE id = 2512;
    UPDATE entertainment SET facilities_id = 1612 WHERE id = 1712;
    UPDATE facilities SET amenities_id = 1512 WHERE id = 1612;
    UPDATE amenities SET room_address_id = 412 WHERE id = 1512;
    UPDATE room_owner_address SET room_owner_id = 1312 WHERE id = 2012;
    UPDATE room_owner SET room_address_id = 412 WHERE id = 1312;
    UPDATE room_address SET room_id = 162 WHERE id = 412;
    UPDATE room SET reservation_id = 13 WHERE id = 162;
    UPDATE payment SET reservation_id = 13 WHERE id = 262;
    UPDATE reservation SET customer_id = 13 WHERE id = 13;
COMMIT;


#ROW FOURTEEN
START TRANSACTION;
	#INSERT INTO country (id, country, continent, last_updated) VALUES (83, 'Nigeria', 'Africa', '2020-08-22 19:34:35');
	INSERT INTO amenities_after_use (id, kitchen, air_conditioning, heating, washer, dryer, internet) VALUES (713, 'good', 'good', 'good', 'good', 'good', 'good');
	INSERT INTO facilities_after_use (id, hot_tub, ev_charger, pool, gym, free_parking) VALUES (813, 'good', 'good', 'good', 'good', 'good');
    INSERT INTO entertainment_after_use (id, tv, sound_system, projector, water_front, beach_front) VALUES (913, 'good', 'damaged', 'good', 'good', 'good');
    INSERT INTO security_questions (id, nickname, pet_name, birth_city) VALUES (1113, 'freddy', 'lucky', 'nairobi');
    INSERT INTO post_inspection (id, inspection_date, amenities_after_use_id, facilities_after_use_id, entertainment_after_use_id) VALUES (613, '2020-11-20 08:00:00',
		713, 813, 913);
    INSERT INTO login_details (id, username, pass_word, last_updated, security_questions_id) VALUES (14, 'Fred435', 'Freddyon765', '2020-11-09 20:30:15', 1113);
    INSERT INTO login (id, email, phone_number, create_date, last_login, account_status, verified_status, login_details_id) VALUES (10013, 'frankonofredo90@gmail.com',
		12563321687, '2020-11-03 08:45:23', '2020-11-20 07:23:40', 'active', 'verified', 14);
	INSERT INTO staff (id, first_name, last_name, gender, age, title, post_inspection_id) VALUES (1013, 'Claire', 'Daniella', 'Female', 38, 'Partner', 613);
    INSERT INTO dependents (id, spouse, children, infants, last_update) VALUES (23, 'yes', 0, 1, '2020-11-06 19:18:28');
    INSERT INTO address (id, house_no, street, postcode, state, last_update, country_id) VALUES (113, 32, 'Mombasa Road', 0029, 'Nairobi', '2020-11-07 20:15:44', 91);
    INSERT INTO rules (id, pets, smoking) VALUES (513, 'yes', 'yes');
    INSERT INTO reviews (id, stars, comments, recommend) VALUES (2513, 4, 'Nice', 'yes');
    INSERT INTO entertainment (id, tv, sound_system, projector, water_front, beach_front) VALUES (1713, 'yes', 'yes', 'yes', 'yes', 'yes');
    INSERT INTO facilities (id, hot_tub, ev_charger, pool, gym, free_parking, entertainment_id) VALUES (1613, 'yes', 'yes', 'yes', 'yes', 'yes', 1713);
	INSERT INTO amenities (id, kitchen, air_conditioning, heating, washer, dryer, internet, facilities_id) VALUES (1513, 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 1613);
	INSERT INTO room_owner_address (id, house_no, street, state, postcode, last_update, country_id) VALUES (2013, 53, '3rd Street', 'Oran', 42018, 
		'2020-06-04 04:16:39', 93);
    INSERT INTO room_owner (id, first_name, last_name, gender, age, room_owner_address_id) VALUES (1313, 'Merna', 'Mculloch', 'Female', 41, 2013);
    INSERT INTO room_address (id, house_no, street, postcode, state, country_id, room_owner_id, amenities_id) VALUES (413, 56, '3rd Street', 42012, 'Oran', 
		93, 1313, 1513);
    INSERT INTO room (id, home_type, total_bedrooms, total_bathrooms, published_date, room_address_id, rules_id) VALUES (163, 'Entire Place', 2, 2, '2020-04-29 15:20:24',
		413, 513);
	INSERT INTO payment (id, payment_mode, price, discount, total_price, payment_status, reviews_id) VALUES (263, 'card', 700, 10, 690, 'paid', 2513);
    INSERT INTO reservation (id, reservation_type, booking_date, start_date, end_date, last_update, room_id, payment_id) VALUES (14, 'instant book', '2020-11-09 14:18:34',
		'2020-11-12 20:00:00', '2020-11-19 19:00:00', '2020-11-10 22:23:34', 163, 263);
    
	INSERT INTO customer (id, first_name, last_name, gender, age, job_title, job_industry, dependents_id, address_id, staff_id, login_id, reservation_id)
		VALUES (14, 'Onfredo', 'Frank', 'Male', 41, 'Tax Accountant', 'Financial Services', 23, 113, 1013, 10013, 14);
COMMIT;

START TRANSACTION;
	UPDATE amenities_after_use SET post_inspection_id = 613 WHERE id = 713;
	UPDATE facilities_after_use SET post_inspection_id = 613 WHERE id = 813;
    UPDATE entertainment_after_use SET post_inspection_id = 613 WHERE id = 913;
    UPDATE security_questions SET login_details_id = 14 WHERE id = 1113;
    UPDATE post_inspection SET staff_id = 1013 WHERE id = 613;
    UPDATE login_details SET login_id = 10013 WHERE id = 14;
    UPDATE login SET customer_id = 14 WHERE id = 10013;
    UPDATE staff SET customer_id = 14 WHERE id = 1013;
    UPDATE dependents SET customer_id = 14 WHERE id = 23;
    UPDATE address SET customer_id = 14 WHERE id = 113;
    UPDATE rules SET room_id = 163 WHERE id = 513;
    UPDATE reviews SET payment_id = 263 WHERE id = 2513;
    UPDATE entertainment SET facilities_id = 1613 WHERE id = 1713;
    UPDATE facilities SET amenities_id = 1513 WHERE id = 1613;
    UPDATE amenities SET room_address_id = 413 WHERE id = 1513;
    UPDATE room_owner_address SET room_owner_id = 1313 WHERE id = 2013;
    UPDATE room_owner SET room_address_id = 413 WHERE id = 1313;
    UPDATE room_address SET room_id = 163 WHERE id = 413;
    UPDATE room SET reservation_id = 14 WHERE id = 163;
    UPDATE payment SET reservation_id = 14 WHERE id = 263;
    UPDATE reservation SET customer_id = 14 WHERE id = 14;
COMMIT;


#ROW FIFTEEN
START TRANSACTION;
	#INSERT INTO country (id, country, continent, last_updated) VALUES (83, 'Nigeria', 'Africa', '2020-08-22 19:34:35');
	INSERT INTO amenities_after_use (id, kitchen, air_conditioning, heating, washer, dryer, internet) VALUES (714, 'good', 'good', 'good', 'good', 'good', 'good');
	INSERT INTO facilities_after_use (id, hot_tub, ev_charger, pool, gym, free_parking) VALUES (814, 'good', 'good', 'good', 'good', 'good');
    INSERT INTO entertainment_after_use (id, tv, sound_system, projector, water_front, beach_front) VALUES (914, 'good', 'good', 'good', 'good', 'good');
    INSERT INTO security_questions (id, nickname, pet_name, birth_city) VALUES (1114, 'selin', 'none', 'Coast');
    INSERT INTO post_inspection (id, inspection_date, amenities_after_use_id, facilities_after_use_id, entertainment_after_use_id) VALUES (614, '2020-11-27 08:00:00',
		714, 814, 914);
    INSERT INTO login_details (id, username, pass_word, last_updated, security_questions_id) VALUES (15, 'townie34', 'Amtoerw345', '2020-11-16 21:40:45', 1114);
    INSERT INTO login (id, email, phone_number, create_date, last_login, account_status, verified_status, login_details_id) VALUES (10014, 'iamtownsend@gmail.com',
		81236743252, '2020-11-12 08:56:01', '2020-11-27 07:13:45', 'active', 'verified', 15);
	INSERT INTO staff (id, first_name, last_name, gender, age, title, post_inspection_id) VALUES (1014, 'Jessica', 'Parker', 'Female', 48, 'Supervisor', 614);
    INSERT INTO dependents (id, spouse, children, infants, last_update) VALUES (24, 'no', 0, 0, '2020-11-15 12:19:35');
    INSERT INTO address (id, house_no, street, postcode, state, last_update, country_id) VALUES (114, 235, 'Badu', 00291, 'Ivory Coast', '2020-11-16 21:15:24', 92);
    INSERT INTO rules (id, pets, smoking) VALUES (514, 'yes', 'yes');
    INSERT INTO reviews (id, stars, comments, recommend) VALUES (2514, 3, 'great', 'no');
    INSERT INTO entertainment (id, tv, sound_system, projector, water_front, beach_front) VALUES (1714, 'yes', 'yes', 'yes', 'yes', 'yes');
    INSERT INTO facilities (id, hot_tub, ev_charger, pool, gym, free_parking, entertainment_id) VALUES (1614, 'no', 'yes', 'no', 'yes', 'yes', 1714);
	INSERT INTO amenities (id, kitchen, air_conditioning, heating, washer, dryer, internet, facilities_id) VALUES (1514, 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 1614);
	INSERT INTO room_owner_address (id, house_no, street, state, postcode, last_update, country_id) VALUES (2014, 23, 'Main Street', 'Alaska', 10010, 
		'2020-06-03 09:20:12', 80);
    INSERT INTO room_owner (id, first_name, last_name, gender, age, room_owner_address_id) VALUES (1314, 'Morie', 'Flexxon', 'Female', 29, 2014);
    INSERT INTO room_address (id, house_no, street, postcode, state, country_id, room_owner_id, amenities_id) VALUES (414, 21, 'Main Street', 10012, 'Alaska', 
		80, 1314, 1514);
    INSERT INTO room (id, home_type, total_bedrooms, total_bathrooms, published_date, room_address_id, rules_id) VALUES (164, 'Entire Place', 3, 2, '2020-05-01 13:10:26',
		414, 514);
	INSERT INTO payment (id, payment_mode, price, discount, total_price, payment_status, reviews_id) VALUES (264, 'card', 620, 20, 600, 'paid', 2514);
    INSERT INTO reservation (id, reservation_type, booking_date, start_date, end_date, last_update, room_id, payment_id) VALUES (15, 'request book', '2020-11-15 12:19:20',
		'2020-11-19 19:00:00', '2020-11-26 18:00:00', '2020-11-15 20:30:14', 164, 264);
    
	INSERT INTO customer (id, first_name, last_name, gender, age, job_title, job_industry, dependents_id, address_id, staff_id, login_id, reservation_id)
		VALUES (15, 'Townsend', 'Trope', 'Male', 51, 'Professor', 'Education', 24, 114, 1014, 10014, 15);
COMMIT;

START TRANSACTION;
	UPDATE amenities_after_use SET post_inspection_id = 614 WHERE id = 714;
	UPDATE facilities_after_use SET post_inspection_id = 614 WHERE id = 814;
    UPDATE entertainment_after_use SET post_inspection_id = 614 WHERE id = 914;
    UPDATE security_questions SET login_details_id = 15 WHERE id = 1114;
    UPDATE post_inspection SET staff_id = 1014 WHERE id = 614;
    UPDATE login_details SET login_id = 10014 WHERE id = 15;
    UPDATE login SET customer_id = 15 WHERE id = 10014;
    UPDATE staff SET customer_id = 15 WHERE id = 1014;
    UPDATE dependents SET customer_id = 15 WHERE id = 24;
    UPDATE address SET customer_id = 15 WHERE id = 114;
    UPDATE rules SET room_id = 164 WHERE id = 514;
    UPDATE reviews SET payment_id = 264 WHERE id = 2514;
    UPDATE entertainment SET facilities_id = 1614 WHERE id = 1714;
    UPDATE facilities SET amenities_id = 1514 WHERE id = 1614;
    UPDATE amenities SET room_address_id = 414 WHERE id = 1514;
    UPDATE room_owner_address SET room_owner_id = 1314 WHERE id = 2014;
    UPDATE room_owner SET room_address_id = 414 WHERE id = 1314;
    UPDATE room_address SET room_id = 164 WHERE id = 414;
    UPDATE room SET reservation_id = 15 WHERE id = 164;
    UPDATE payment SET reservation_id = 15 WHERE id = 264;
    UPDATE reservation SET customer_id = 15 WHERE id = 15;
COMMIT;


#ROW SIXTEEN
START TRANSACTION;
	#INSERT INTO country (id, country, continent, last_updated) VALUES (83, 'Nigeria', 'Africa', '2020-08-22 19:34:35');
	INSERT INTO amenities_after_use (id, kitchen, air_conditioning, heating, washer, dryer, internet) VALUES (715, 'good', 'good', 'good', 'good', 'good', 'good');
	INSERT INTO facilities_after_use (id, hot_tub, ev_charger, pool, gym, free_parking) VALUES (815, 'good', 'good', 'good', 'good', 'good');
    INSERT INTO entertainment_after_use (id, tv, sound_system, projector, water_front, beach_front) VALUES (915, 'good', 'good', 'good', 'good', 'good');
    INSERT INTO security_questions (id, nickname, pet_name, birth_city) VALUES (1115, 'stefflin', 'none', 'houdegbe');
    INSERT INTO post_inspection (id, inspection_date, amenities_after_use_id, facilities_after_use_id, entertainment_after_use_id) VALUES (615, '2020-11-30 08:00:00',
		715, 815, 915);
    INSERT INTO login_details (id, username, pass_word, last_updated, security_questions_id) VALUES (16, 'Steffy675', 'steffward890', '2020-11-17 20:10:25', 1115);
    INSERT INTO login (id, email, phone_number, create_date, last_login, account_status, verified_status, login_details_id) VALUES (10015, 'steffduncan@outlook.com',
		653290765767, '2020-11-11 07:49:15', '2020-11-30 08:14:50', 'active', 'verified', 16);
	INSERT INTO staff (id, first_name, last_name, gender, age, title, post_inspection_id) VALUES (1015, 'Mercy', 'Caroline', 'Female', 36, 'Agent', 615);
    INSERT INTO dependents (id, spouse, children, infants, last_update) VALUES (25, 'yes', 0, 0, '2020-11-18 11:00:25');
    INSERT INTO address (id, house_no, street, postcode, state, last_update, country_id) VALUES (115, 100, 'Kilometer Baker', 55700, 'Lome', '2020-11-15 20:19:30', 94);
    INSERT INTO rules (id, pets, smoking) VALUES (515, 'no', 'yes');
    INSERT INTO reviews (id, stars, comments, recommend) VALUES (2515, 5, 'Exquisite place', 'yes');
    INSERT INTO entertainment (id, tv, sound_system, projector, water_front, beach_front) VALUES (1715, 'yes', 'yes', 'yes', 'yes', 'yes');
    INSERT INTO facilities (id, hot_tub, ev_charger, pool, gym, free_parking, entertainment_id) VALUES (1615, 'yes', 'yes', 'yes', 'yes', 'yes', 1715);
	INSERT INTO amenities (id, kitchen, air_conditioning, heating, washer, dryer, internet, facilities_id) VALUES (1515, 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 1615);
	INSERT INTO room_owner_address (id, house_no, street, state, postcode, last_update, country_id) VALUES (2015, 72, 'Augle', 'Gauteng', 0710, 
		'2020-06-15 09:45:20', 95);
    INSERT INTO room_owner (id, first_name, last_name, gender, age, room_owner_address_id) VALUES (1315, 'Mara', 'Blume', 'Female', 50, 2015);
    INSERT INTO room_address (id, house_no, street, postcode, state, country_id, room_owner_id, amenities_id) VALUES (415, 75, 'Augle', 0712, 'Gauteng', 
		95, 1315, 1515);
    INSERT INTO room (id, home_type, total_bedrooms, total_bathrooms, published_date, room_address_id, rules_id) VALUES (165, 'Entire Place', 1, 1, '2020-05-04 12:13:29',
		415, 515);
	INSERT INTO payment (id, payment_mode, price, discount, total_price, payment_status, reviews_id) VALUES (265, 'card', 740, 10, 730, 'paid', 2515);
    INSERT INTO reservation (id, reservation_type, booking_date, start_date, end_date, last_update, room_id, payment_id) VALUES (16, 'instantt book', '2020-11-17 13:20:40',
		'2020-11-23 21:00:00', '2020-11-29 20:00:00', '2020-11-18 23:30:45', 165, 265);
    
	INSERT INTO customer (id, first_name, last_name, gender, age, job_title, job_industry, dependents_id, address_id, staff_id, login_id, reservation_id)
		VALUES (16, 'Stefan', 'Dunnan', 'Female', 29, 'Automation Engineer', 'Manufacturing', 25, 115, 1015, 10015, 16);
COMMIT;

START TRANSACTION;
	UPDATE amenities_after_use SET post_inspection_id = 615 WHERE id = 715;
	UPDATE facilities_after_use SET post_inspection_id = 615 WHERE id = 815;
    UPDATE entertainment_after_use SET post_inspection_id = 615 WHERE id = 915;
    UPDATE security_questions SET login_details_id = 16 WHERE id = 1115;
    UPDATE post_inspection SET staff_id = 1015 WHERE id = 615;
    UPDATE login_details SET login_id = 10015 WHERE id = 16;
    UPDATE login SET customer_id = 16 WHERE id = 10015;
    UPDATE staff SET customer_id = 16 WHERE id = 1015;
    UPDATE dependents SET customer_id = 16 WHERE id = 25;
    UPDATE address SET customer_id = 16 WHERE id = 115;
    UPDATE rules SET room_id = 165 WHERE id = 515;
    UPDATE reviews SET payment_id = 265 WHERE id = 2515;
    UPDATE entertainment SET facilities_id = 1615 WHERE id = 1715;
    UPDATE facilities SET amenities_id = 1515 WHERE id = 1615;
    UPDATE amenities SET room_address_id = 415 WHERE id = 1515;
    UPDATE room_owner_address SET room_owner_id = 1315 WHERE id = 2015;
    UPDATE room_owner SET room_address_id = 415 WHERE id = 1315;
    UPDATE room_address SET room_id = 165 WHERE id = 415;
    UPDATE room SET reservation_id = 16 WHERE id = 165;
    UPDATE payment SET reservation_id = 16 WHERE id = 265;
    UPDATE reservation SET customer_id = 16 WHERE id = 16;
COMMIT;


#ROW SEVENTEEN
START TRANSACTION;
	#INSERT INTO country (id, country, continent, last_updated) VALUES (83, 'Nigeria', 'Africa', '2020-08-22 19:34:35');
	INSERT INTO amenities_after_use (id, kitchen, air_conditioning, heating, washer, dryer, internet) VALUES (716, 'good', 'good', 'good', 'good', 'good', 'good');
	INSERT INTO facilities_after_use (id, hot_tub, ev_charger, pool, gym, free_parking) VALUES (816, 'good', 'good', 'good', 'good', 'good');
    INSERT INTO entertainment_after_use (id, tv, sound_system, projector, water_front, beach_front) VALUES (916, 'good', 'good', 'good', 'good', 'good');
    INSERT INTO security_questions (id, nickname, pet_name, birth_city) VALUES (1116, 'winny', 'hank', 'tanzi');
    INSERT INTO post_inspection (id, inspection_date, amenities_after_use_id, facilities_after_use_id, entertainment_after_use_id) VALUES (616, '2020-12-11 09:00:00',
		716, 816, 916);
    INSERT INTO login_details (id, username, pass_word, last_updated, security_questions_id) VALUES (17, 'Winsor09', 'Brille8945', '2020-12-04 20:09:10', 1116);
    INSERT INTO login (id, email, phone_number, create_date, last_login, account_status, verified_status, login_details_id) VALUES (10016, 'basilewinsor@gmail.com',
		28947465241, '2020-12-01 07:50:10', '2020-12-11 08:14:53', 'active', 'verified', 17);
	INSERT INTO staff (id, first_name, last_name, gender, age, title, post_inspection_id) VALUES (1016, 'Natasha', 'Smith', 'Female', 34, 'Partner', 616);
    INSERT INTO dependents (id, spouse, children, infants, last_update) VALUES (26, 'no', 0, 0, '2020-12-02 11:00:21');
    INSERT INTO address (id, house_no, street, postcode, state, last_update, country_id) VALUES (116, 20, 'Msamvu', 23721, 'Kara', '2020-11-15 20:19:30', 96);
    INSERT INTO rules (id, pets, smoking) VALUES (516, 'yes', 'yes');
    INSERT INTO reviews (id, stars, comments, recommend) VALUES (2516, 5, 'Very Great Place', 'yes');
    INSERT INTO entertainment (id, tv, sound_system, projector, water_front, beach_front) VALUES (1716, 'yes', 'yes', 'yes', 'yes', 'yes');
    INSERT INTO facilities (id, hot_tub, ev_charger, pool, gym, free_parking, entertainment_id) VALUES (1616, 'yes', 'yes', 'yes', 'yes', 'yes', 1716);
	INSERT INTO amenities (id, kitchen, air_conditioning, heating, washer, dryer, internet, facilities_id) VALUES (1516, 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 1616);
	INSERT INTO room_owner_address (id, house_no, street, state, postcode, last_update, country_id) VALUES (2016, 160, 'Lenin', 'Altai', 634120, 
		'2020-06-23 09:20:10', 97);
    INSERT INTO room_owner (id, first_name, last_name, gender, age, room_owner_address_id) VALUES (1316, 'Weibull', 'Girvan', 'Female', 60, 2016);
    INSERT INTO room_address (id, house_no, street, postcode, state, country_id, room_owner_id, amenities_id) VALUES (416, 162, 'Lenin', 634123, 'Altai', 
		97, 1316, 1516);
    INSERT INTO room (id, home_type, total_bedrooms, total_bathrooms, published_date, room_address_id, rules_id) VALUES (166, 'Hotel Room', 1, 1, '2020-05-09 13:00:00',
		416, 516);
	INSERT INTO payment (id, payment_mode, price, discount, total_price, payment_status, reviews_id) VALUES (266, 'card', 510, 10, 500, 'paid', 2516);
    INSERT INTO reservation (id, reservation_type, booking_date, start_date, end_date, last_update, room_id, payment_id) VALUES (17, 'request book', '2020-12-01 11:00:23',
		'2020-12-03 19:00:00', '2020-12-09 18:00:00', '2020-12-03 20:11:25', 166, 266);
    
	INSERT INTO customer (id, first_name, last_name, gender, age, job_title, job_industry, dependents_id, address_id, staff_id, login_id, reservation_id)
		VALUES (17, 'Bassile', 'Winsor', 'Male', 33, 'Programmer', 'Information Technology', 26, 116, 1016, 10016, 17);
COMMIT;

START TRANSACTION;
	UPDATE amenities_after_use SET post_inspection_id = 616 WHERE id = 716;
	UPDATE facilities_after_use SET post_inspection_id = 616 WHERE id = 816;
    UPDATE entertainment_after_use SET post_inspection_id = 616 WHERE id = 916;
    UPDATE security_questions SET login_details_id = 17 WHERE id = 1116;
    UPDATE post_inspection SET staff_id = 1016 WHERE id = 616;
    UPDATE login_details SET login_id = 10016 WHERE id = 17;
    UPDATE login SET customer_id = 17 WHERE id = 10016;
    UPDATE staff SET customer_id = 17 WHERE id = 1016;
    UPDATE dependents SET customer_id = 17 WHERE id = 26;
    UPDATE address SET customer_id = 17 WHERE id = 116;
    UPDATE rules SET room_id = 166 WHERE id = 516;
    UPDATE reviews SET payment_id = 266 WHERE id = 2516;
    UPDATE entertainment SET facilities_id = 1616 WHERE id = 1716;
    UPDATE facilities SET amenities_id = 1516 WHERE id = 1616;
    UPDATE amenities SET room_address_id = 416 WHERE id = 1516;
    UPDATE room_owner_address SET room_owner_id = 1316 WHERE id = 2016;
    UPDATE room_owner SET room_address_id = 416 WHERE id = 1316;
    UPDATE room_address SET room_id = 166 WHERE id = 416;
    UPDATE room SET reservation_id = 17 WHERE id = 166;
    UPDATE payment SET reservation_id = 17 WHERE id = 266;
    UPDATE reservation SET customer_id = 17 WHERE id = 17;
COMMIT;


#ROW EIGHTEEN
START TRANSACTION;
	#INSERT INTO country (id, country, continent, last_updated) VALUES (83, 'Nigeria', 'Africa', '2020-08-22 19:34:35');
	INSERT INTO amenities_after_use (id, kitchen, air_conditioning, heating, washer, dryer, internet) VALUES (717, 'good', 'good', 'good', 'good', 'good', 'good');
	INSERT INTO facilities_after_use (id, hot_tub, ev_charger, pool, gym, free_parking) VALUES (817, 'good', 'good', 'good', 'good', 'good');
    INSERT INTO entertainment_after_use (id, tv, sound_system, projector, water_front, beach_front) VALUES (917, 'good', 'good', 'good', 'good', 'good');
    INSERT INTO security_questions (id, nickname, pet_name, birth_city) VALUES (1117, 'shanty', 'none', 'kara');
    INSERT INTO post_inspection (id, inspection_date, amenities_after_use_id, facilities_after_use_id, entertainment_after_use_id) VALUES (617, '2020-12-11 07:00:00',
		717, 817, 917);
    INSERT INTO login_details (id, username, pass_word, last_updated, security_questions_id) VALUES (18, 'shane92', 'westin457', '2020-12-08 23:09:40', 1117);
    INSERT INTO login (id, email, phone_number, create_date, last_login, account_status, verified_status, login_details_id) VALUES (10017, 'michaelshane@gmail.com',
		56747802902, '2020-12-03 07:43:30', '2020-12-11 09:54:12', 'active', 'verified', 18);
	INSERT INTO staff (id, first_name, last_name, gender, age, title, post_inspection_id) VALUES (1017, 'Zapata', 'Alice', 'Female', 38, 'Supervisor', 617);
    INSERT INTO dependents (id, spouse, children, infants, last_update) VALUES (27, 'yes', 0, 0, '2020-12-05 11:00:54');
    INSERT INTO address (id, house_no, street, postcode, state, last_update, country_id) VALUES (117, 98, 'Sokode', 55788, 'Morogoro', '2020-12-07 20:23:33', 94);
    INSERT INTO rules (id, pets, smoking) VALUES (517, 'yes', 'yes');
    INSERT INTO reviews (id, stars, comments, recommend) VALUES (2517, 4, 'Amazing Place', 'yes');
    INSERT INTO entertainment (id, tv, sound_system, projector, water_front, beach_front) VALUES (1717, 'yes', 'yes', 'yes', 'yes', 'yes');
    INSERT INTO facilities (id, hot_tub, ev_charger, pool, gym, free_parking, entertainment_id) VALUES (1617, 'yes', 'yes', 'yes', 'yes', 'yes', 1717);
	INSERT INTO amenities (id, kitchen, air_conditioning, heating, washer, dryer, internet, facilities_id) VALUES (1517, 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 1617);
	INSERT INTO room_owner_address (id, house_no, street, state, postcode, last_update, country_id) VALUES (2017, 102, 'Main', 'Virginia', 10120, 
		'2020-06-27 09:45:22', 80);
    INSERT INTO room_owner (id, first_name, last_name, gender, age, room_owner_address_id) VALUES (1317, 'Ruben', 'Handlin', 'Female', 65, 2017);
    INSERT INTO room_address (id, house_no, street, postcode, state, country_id, room_owner_id, amenities_id) VALUES (417, 100, 'Main', 10122, 'Virginia', 
		80, 1317, 1517);
    INSERT INTO room (id, home_type, total_bedrooms, total_bathrooms, published_date, room_address_id, rules_id) VALUES (167, 'Entire Place', 2, 2, '2020-05-20 19:24:45',
		417, 517);
	INSERT INTO payment (id, payment_mode, price, discount, total_price, payment_status, reviews_id) VALUES (267, 'card', 900, 80, 820, 'paid', 2517);
    INSERT INTO reservation (id, reservation_type, booking_date, start_date, end_date, last_update, room_id, payment_id) VALUES (18, 'instant book', '2020-12-04 12:30:43',
		'2020-12-07 16:00:00', '2020-12-10 15:00:00', '2020-12-08 21:15:45', 167, 267);
    
	INSERT INTO customer (id, first_name, last_name, gender, age, job_title, job_industry, dependents_id, address_id, staff_id, login_id, reservation_id)
		VALUES (18, 'Shane', 'Michael', 'Male', 38, 'Teacher', 'Education', 27, 117, 1017, 10017, 18);
COMMIT;

START TRANSACTION;
	UPDATE amenities_after_use SET post_inspection_id = 617 WHERE id = 717;
	UPDATE facilities_after_use SET post_inspection_id = 617 WHERE id = 817;
    UPDATE entertainment_after_use SET post_inspection_id = 617 WHERE id = 917;
    UPDATE security_questions SET login_details_id = 18 WHERE id = 1117;
    UPDATE post_inspection SET staff_id = 1017 WHERE id = 617;
    UPDATE login_details SET login_id = 10017 WHERE id = 18;
    UPDATE login SET customer_id = 18 WHERE id = 10017;
    UPDATE staff SET customer_id = 18 WHERE id = 1017;
    UPDATE dependents SET customer_id = 18 WHERE id = 27;
    UPDATE address SET customer_id = 18 WHERE id = 117;
    UPDATE rules SET room_id = 167 WHERE id = 517;
    UPDATE reviews SET payment_id = 267 WHERE id = 2517;
    UPDATE entertainment SET facilities_id = 1617 WHERE id = 1717;
    UPDATE facilities SET amenities_id = 1517 WHERE id = 1617;
    UPDATE amenities SET room_address_id = 417 WHERE id = 1517;
    UPDATE room_owner_address SET room_owner_id = 1317 WHERE id = 2017;
    UPDATE room_owner SET room_address_id = 417 WHERE id = 1317;
    UPDATE room_address SET room_id = 167 WHERE id = 417;
    UPDATE room SET reservation_id = 18 WHERE id = 167;
    UPDATE payment SET reservation_id = 18 WHERE id = 267;
    UPDATE reservation SET customer_id = 18 WHERE id = 18;
COMMIT;


#ROW NINETEEN
START TRANSACTION;
	#INSERT INTO country (id, country, continent, last_updated) VALUES (83, 'Nigeria', 'Africa', '2020-08-22 19:34:35');
	INSERT INTO amenities_after_use (id, kitchen, air_conditioning, heating, washer, dryer, internet) VALUES (718, 'good', 'good', 'good', 'good', 'good', 'good');
	INSERT INTO facilities_after_use (id, hot_tub, ev_charger, pool, gym, free_parking) VALUES (818, 'good', 'good', 'good', 'good', 'good');
    INSERT INTO entertainment_after_use (id, tv, sound_system, projector, water_front, beach_front) VALUES (918, 'good', 'good', 'good', 'good', 'good');
    INSERT INTO security_questions (id, nickname, pet_name, birth_city) VALUES (1118, 'Tess', 'none', 'Lagos');
    INSERT INTO post_inspection (id, inspection_date, amenities_after_use_id, facilities_after_use_id, entertainment_after_use_id) VALUES (618, '2020-12-21 09:00:00',
		718, 818, 918);
    INSERT INTO login_details (id, username, pass_word, last_updated, security_questions_id) VALUES (19, 'Tessy2', 'Terrys678', '2020-12-10 20:11:52', 1118);
    INSERT INTO login (id, email, phone_number, create_date, last_login, account_status, verified_status, login_details_id) VALUES (10018, 'leesatessy56@gmail.com',
		8045673421, '2020-12-06 09:40:41', '2020-12-21 06:00:42', 'active', 'verified', 19);
	INSERT INTO staff (id, first_name, last_name, gender, age, title, post_inspection_id) VALUES (1018, 'Iris', 'Snow', 'Female', 48, 'Supervisor', 618);
    INSERT INTO dependents (id, spouse, children, infants, last_update) VALUES (28, 'yes', 1, 0, '2020-12-10 14:11:21');
    INSERT INTO address (id, house_no, street, postcode, state, last_update, country_id) VALUES (118, 34, 'Oza', 10137, 'Benin', '2020-12-07 20:23:33', 83);
    INSERT INTO rules (id, pets, smoking) VALUES (518, 'yes', 'yes');
    INSERT INTO reviews (id, stars, comments, recommend) VALUES (2518, 5, 'Had a sweet experience', 'yes');
    INSERT INTO entertainment (id, tv, sound_system, projector, water_front, beach_front) VALUES (1718, 'yes', 'yes', 'yes', 'yes', 'yes');
    INSERT INTO facilities (id, hot_tub, ev_charger, pool, gym, free_parking, entertainment_id) VALUES (1618, 'yes', 'yes', 'yes', 'yes', 'yes', 1718);
	INSERT INTO amenities (id, kitchen, air_conditioning, heating, washer, dryer, internet, facilities_id) VALUES (1518, 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 1618);
	INSERT INTO room_owner_address (id, house_no, street, state, postcode, last_update, country_id) VALUES (2018, 1671, 'Thorncliff', 'Alberta', 91700, 
		'2020-06-29 08:40:11', 81);
    INSERT INTO room_owner (id, first_name, last_name, gender, age, room_owner_address_id) VALUES (1318, 'Isiah', 'Fardell', 'Male', 52, 2018);
    INSERT INTO room_address (id, house_no, street, postcode, state, country_id, room_owner_id, amenities_id) VALUES (418, 1674, 'Thorncliff', 91712, 'Alberta', 
		81, 1318, 1518);
    INSERT INTO room (id, home_type, total_bedrooms, total_bathrooms, published_date, room_address_id, rules_id) VALUES (168, 'Entire Place', 1, 1, '2020-05-27 17:30:14',
		418, 518);
	INSERT INTO payment (id, payment_mode, price, discount, total_price, payment_status, reviews_id) VALUES (268, 'card', 570, 70, 500, 'paid', 2518);
    INSERT INTO reservation (id, reservation_type, booking_date, start_date, end_date, last_update, room_id, payment_id) VALUES (19, 'instant book', '2020-12-09 12:50:12',
		'2020-12-13 20:00:00', '2020-12-20 19:00:00', '2020-12-10 21:23:27', 168, 268);
    
	INSERT INTO customer (id, first_name, last_name, gender, age, job_title, job_industry, dependents_id, address_id, staff_id, login_id, reservation_id)
		VALUES (19, 'Leesa', 'Tessy', 'Female', 41, 'Professor', 'Education', 28, 118, 1018, 10018, 19);
COMMIT;

START TRANSACTION;
	UPDATE amenities_after_use SET post_inspection_id = 618 WHERE id = 718;
	UPDATE facilities_after_use SET post_inspection_id = 618 WHERE id = 818;
    UPDATE entertainment_after_use SET post_inspection_id = 618 WHERE id = 918;
    UPDATE security_questions SET login_details_id = 19 WHERE id = 1118;
    UPDATE post_inspection SET staff_id = 1018 WHERE id = 618;
    UPDATE login_details SET login_id = 10018 WHERE id = 19;
    UPDATE login SET customer_id = 19 WHERE id = 10018;
    UPDATE staff SET customer_id = 19 WHERE id = 1018;
    UPDATE dependents SET customer_id = 19 WHERE id = 28;
    UPDATE address SET customer_id = 19 WHERE id = 118;
    UPDATE rules SET room_id = 168 WHERE id = 518;
    UPDATE reviews SET payment_id = 268 WHERE id = 2518;
    UPDATE entertainment SET facilities_id = 1618 WHERE id = 1718;
    UPDATE facilities SET amenities_id = 1518 WHERE id = 1618;
    UPDATE amenities SET room_address_id = 418 WHERE id = 1518;
    UPDATE room_owner_address SET room_owner_id = 1318 WHERE id = 2018;
    UPDATE room_owner SET room_address_id = 418 WHERE id = 1318;
    UPDATE room_address SET room_id = 168 WHERE id = 418;
    UPDATE room SET reservation_id = 19 WHERE id = 168;
    UPDATE payment SET reservation_id = 19 WHERE id = 268;
    UPDATE reservation SET customer_id = 19 WHERE id = 19;
COMMIT;


#ROW TWENTY
START TRANSACTION;
	#INSERT INTO country (id, country, continent, last_updated) VALUES (83, 'Nigeria', 'Africa', '2020-08-22 19:34:35');
	INSERT INTO amenities_after_use (id, kitchen, air_conditioning, heating, washer, dryer, internet) VALUES (719, 'good', 'good', 'good', 'good', 'good', 'good');
	INSERT INTO facilities_after_use (id, hot_tub, ev_charger, pool, gym, free_parking) VALUES (819, 'good', 'good', 'good', 'good', 'good');
    INSERT INTO entertainment_after_use (id, tv, sound_system, projector, water_front, beach_front) VALUES (919, 'good', 'good', 'good', 'good', 'good');
    INSERT INTO security_questions (id, nickname, pet_name, birth_city) VALUES (1119, 'Kendy', 'tom', 'frankfurt');
    INSERT INTO post_inspection (id, inspection_date, amenities_after_use_id, facilities_after_use_id, entertainment_after_use_id) VALUES (619, '2020-12-27 10:00:00',
		719, 819, 919);
    INSERT INTO login_details (id, username, pass_word, last_updated, security_questions_id) VALUES (20, 'Kendert43', 'kennydew4987', '2020-12-19 21:45:20', 1119);
    INSERT INTO login (id, email, phone_number, create_date, last_login, account_status, verified_status, login_details_id) VALUES (10019, 'kendalhummes76@gmail.com',
		90456878923, '2020-12-12 09:31:20', '2020-12-28 07:15:20', 'active', 'verified', 20);
	INSERT INTO staff (id, first_name, last_name, gender, age, title, post_inspection_id) VALUES (1019, 'Caitlin', 'West', 'Female', 40, 'Partner', 619);
    INSERT INTO dependents (id, spouse, children, infants, last_update) VALUES (29, 'yes', 0, 0, '2020-12-16 19:00:40');
    INSERT INTO address (id, house_no, street, postcode, state, last_update, country_id) VALUES (119, 47, 'Kanyenye', 23103, 'Tabora', '2020-12-07 20:23:33', 96);
    INSERT INTO rules (id, pets, smoking) VALUES (519, 'no', 'yes');
    INSERT INTO reviews (id, stars, comments, recommend) VALUES (2519, 4, 'Very good', 'yes');
    INSERT INTO entertainment (id, tv, sound_system, projector, water_front, beach_front) VALUES (1719, 'yes', 'yes', 'yes', 'yes', 'yes');
    INSERT INTO facilities (id, hot_tub, ev_charger, pool, gym, free_parking, entertainment_id) VALUES (1619, 'yes', 'yes', 'yes', 'yes', 'yes', 1719);
	INSERT INTO amenities (id, kitchen, air_conditioning, heating, washer, dryer, internet, facilities_id) VALUES (1519, 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 1619);
	INSERT INTO room_owner_address (id, house_no, street, state, postcode, last_update, country_id) VALUES (2019, 18, 'Neuen Schoenhauser', 'Berlin', 10428, 
		'2020-06-30 08:45:00', 84);
    INSERT INTO room_owner (id, first_name, last_name, gender, age, room_owner_address_id) VALUES (1319, 'Freda', 'Evelyn', 'Female', 37, 2019);
    INSERT INTO room_address (id, house_no, street, postcode, state, country_id, room_owner_id, amenities_id) VALUES (419, 16, 'Neuen Schoenhauser', 10430, 'Berlin', 
		84, 1319, 1519);
    INSERT INTO room (id, home_type, total_bedrooms, total_bathrooms, published_date, room_address_id, rules_id) VALUES (169, 'Entire Place', 3, 3, '2020-05-29 16:00:53',
		419, 519);
	INSERT INTO payment (id, payment_mode, price, discount, total_price, payment_status, reviews_id) VALUES (269, 'card', 760, 150, 610, 'paid', 2519);
    INSERT INTO reservation (id, reservation_type, booking_date, start_date, end_date, last_update, room_id, payment_id) VALUES (20, 'instant book', '2020-12-15 15:20:30',
		'2020-12-20 19:00:00', '2020-12-26 18:00:00', '2020-12-16 22:40:15', 169, 269);
    
	INSERT INTO customer (id, first_name, last_name, gender, age, job_title, job_industry, dependents_id, address_id, staff_id, login_id, reservation_id)
		VALUES (20, 'Kendall', 'Humes', 'Female', 35, 'Software Developer', 'Information Technology', 29, 119, 1019, 10019, 20);
COMMIT;

START TRANSACTION;
	UPDATE amenities_after_use SET post_inspection_id = 619 WHERE id = 719;
	UPDATE facilities_after_use SET post_inspection_id = 619 WHERE id = 819;
    UPDATE entertainment_after_use SET post_inspection_id = 619 WHERE id = 919;
    UPDATE security_questions SET login_details_id = 20 WHERE id = 1119;
    UPDATE post_inspection SET staff_id = 1019 WHERE id = 619;
    UPDATE login_details SET login_id = 10019 WHERE id = 20;
    UPDATE login SET customer_id = 20 WHERE id = 10019;
    UPDATE staff SET customer_id = 20 WHERE id = 1019;
    UPDATE dependents SET customer_id = 20 WHERE id = 29;
    UPDATE address SET customer_id = 20 WHERE id = 119;
    UPDATE rules SET room_id = 169 WHERE id = 519;
    UPDATE reviews SET payment_id = 269 WHERE id = 2519;
    UPDATE entertainment SET facilities_id = 1619 WHERE id = 1719;
    UPDATE facilities SET amenities_id = 1519 WHERE id = 1619;
    UPDATE amenities SET room_address_id = 419 WHERE id = 1519;
    UPDATE room_owner_address SET room_owner_id = 1319 WHERE id = 2019;
    UPDATE room_owner SET room_address_id = 419 WHERE id = 1319;
    UPDATE room_address SET room_id = 169 WHERE id = 419;
    UPDATE room SET reservation_id = 20 WHERE id = 169;
    UPDATE payment SET reservation_id = 20 WHERE id = 269;
    UPDATE reservation SET customer_id = 20 WHERE id = 20;
COMMIT;

