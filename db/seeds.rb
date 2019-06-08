# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# user table and seed data

# CREATE TABLE users (user_id SERIAL PRIMARY KEY, username VARCHAR);

# INSERT INTO users (username) VALUES ('Sara');
# INSERT INTO users (username) VALUES ('CJ');
# INSERT INTO users (username) VALUES ('Test');

# user_country table and seed data
# CREATE TABLE user_country (
# 	trip_id SERIAL PRIMARY KEY,
# 	user_id INT REFERENCES users (user_id) ON UPDATE CASCADE ON DELETE CASCADE,
# 	country_code VARCHAR,
# 	type VARCHAR,
# trip_date DATE);

# INSERT INTO user_country (user_id, country_code, type, trip_date)
#     VALUES (1, 'AD', 'wish', '2019-12-20' );
# INSERT INTO user_country (user_id, country_code, type, trip_date)
#     VALUES (1, 'CF', 'trip', '2018-10-10' );
# INSERT INTO user_country (user_id, country_code, type, trip_date)
#     VALUES (1, 'BW', 'trip', '2017-06-12' );
# INSERT INTO user_country (user_id, country_code, type, trip_date)
#     VALUES (2, 'BE', 'wish', '2019-12-20' );
# INSERT INTO user_country (user_id, country_code, type, trip_date)
#     VALUES (2, 'AF', 'wish', '2020-12-20' );
# INSERT INTO user_country (user_id, country_code, type, trip_date)
#     VALUES (2, 'CA', 'wish', '2029-12-20' );
# INSERT INTO user_country (user_id, country_code, type, trip_date)
#     VALUES (3, 'EE', 'trip', '2019-12-20' );
# INSERT INTO user_country (user_id, country_code, type, trip_date)
#     VALUES (3, 'ER', 'trip', '2001-08-23' );
# INSERT INTO user_country (user_id, country_code, type, trip_date)
#     VALUES (3, 'ET', 'trip', '2009-01-10' );