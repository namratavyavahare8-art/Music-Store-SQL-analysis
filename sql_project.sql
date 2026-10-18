-- CREATING THE DATABASE

create database sql_project;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DATABASE IN USE

use sql_project;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CREATING TABLES AND LOADING DATA 

create table track(track_id int,name varchar(200),album_id int,media_type_id int,genere_id int,composer varchar(200),milliseconds int,bytes int,unit_price float);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/track.csv"
INTO TABLE track
FIELDS TERMINATED BY ","
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

create table album(album_id int,title varchar(100), artist_id int);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/album.csv"
INTO TABLE album
FIELDS TERMINATED BY ","
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

create table artist(artist_id int,name varchar(100));

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/artist.csv"
INTO TABLE artist
FIELDS TERMINATED BY ","
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

create table customer(customer_id int,first_name varchar(20),last_name varchar(20),company varchar(50),
address varchar(50),city varchar(20),state varchar(10),country varchar(20),
postal_code varchar(20),phone varchar(20),fax varchar(20),email varchar(50),support_rep_id int);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customer.csv"
INTO TABLE customer
FIELDS TERMINATED BY ","
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

create table employee(employee_id int,last_name varchar(20),first_name varchar(20),title varchar(40),
reports_to varchar(20),levels varchar(5),birthdate date,hire_date date,address varchar(50),city varchar(20),
state varchar(20),country varchar(20),postal_code varchar(20),phone varchar(20),fax varchar(20),email varchar(40));

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/employee.csv"
INTO TABLE employee
FIELDS TERMINATED BY ","
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

create table genre(genre_id int,name varchar(20));

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/genre.csv"
INTO TABLE genre
FIELDS TERMINATED BY ","
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

create table invoice(invoice_id int ,customer_id int,invoice_date date,billing_address varchar(100),
billing_city varchar(30),billing_state varchar(20),billing_country varchar (20),billing_postal_code varchar(20),total float);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/invoice.csv"
INTO TABLE invoice
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

DELETE FROM invoice
WHERE invoice_id = 0;

create table invoice_line(invoice_line_id int,invoice_id int,track_id int,unit_price float,quantity int);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/invoice_line.csv"
INTO TABLE invoice_line
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

create table media_type(media_type_id int,name varchar(40));

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/media_type.csv"
INTO TABLE media_type
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

create table playlist(playlist_id int,name varchar(40));

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/playlist.csv"
INTO TABLE playlist
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

create table playlist_track(playlist_id int,track_id int);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/playlist_track.csv"
INTO TABLE playlist_track
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 1.Who is the senior most employee based on job title?
select * from employee;
select first_name,last_name,title,max(levels) as senior_most_emp
from employee
group by first_name,last_name,title;

-- 2.Which countries have the most invoices?
select billing_country,count(invoice_id) as total_invoices
from invoice 
group by billing_country
order by total_invoices desc 
limit 1;

-- 3.Who is the best customer? The customer who has spent the most money will be declared the best customer.
select * from customer;
select * from invoice;
select c.first_name,c.last_name,sum(i.total) as cx_max_spent
from customer c
join invoice i on c.customer_id=i.customer_id
group by c.first_name,c.last_name
order by cx_max_spent desc
limit 1;
 
-- 4.Write query to return the email, first name and last name of all Rock Music listeners. 
-- Return your list ordered alphabetically by email starting with A
select distinct c.first_name,c.last_name,c.email
from customer c
join invoice i on c.customer_id=invoice_id
join invoice_line il on i.invoice_id=il.invoice_id
join track t on t.track_id=il.track_id
join genre g on g.genre_id=t.genre_id
where g.name="rock"
order by c.email;

-- 5. Display the track name, album title, and artist name for every track.
select t.name,a.title,ar.name
from track t
left join album a on t.album_id=a.album_id
left join artist ar on ar.artist_id=a.artist_id;

-- 6. Find the number of tracks in each album. Display album title and track count.
select a.title,count(t.track_id) as no_of_tracks
from album a
left join track t on t.album_id=a.album_id
group by a.title;

-- 7. Find the tracks whose price is greater than the average track price.
select name,unit_price
from track
where unit_price>(select avg(unit_price) from track);

-- 8.Display each artist along with:
- Artist name
- Number of albums
- Number of tracks
- Total sales revenue
select ar.artist_id,ar.name as artist_name,count(DISTINCT al.album_id) as number_of_albums,
count(DISTINCT t.track_id) as number_of_tracks,coalesce(sum(il.unit_price * il.quantity), 0) as total_sales_revenue
from artist ar
left join album al on al.artist_id= ar.artist_id
left join track t on t.album_id= al.album_id
left join invoice_line il on il.track_id= t.track_id
group by ar.artist_id, ar.name
order by total_sales_revenue desc;







