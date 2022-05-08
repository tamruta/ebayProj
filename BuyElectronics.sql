DROP DATABASE IF EXISTS BuyElectronics;
CREATE DATABASE  IF NOT EXISTS `BuyElectronics` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `BuyElectronics`;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=1 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP TABLE IF EXISTS `users`;
CREATE TABLE users( 
account_id int,
username varchar(30),
user_password varchar(30),
isAdmin bool default false,
isCusRes bool default false,
PRIMARY KEY (account_id));

-- data dump
INSERT INTO users VALUES 
(1, 'admin', 'admin', true, false), 
(2, 'cusrep', 'cusrep', false, true), 
(3, 'user', 'passie', false, false), 
(4, 'corn', 'muffin', false, false),
(5, 'john','hehe', false, false),
(6, 'maddy', 'hoho', false, false);


CREATE TABLE IF NOT EXISTS electronic_item(
item_id int PRIMARY KEY, 
model_Number varchar(20), 
item_type varchar(30), 
item_year char(4), 
dimensions varchar(6), 
item_memory varchar(5), 
specifications varchar(20));

INSERT INTO electronic_item VALUES
(1, '205VA', 'monitor', '2020', '20', '128', 'something'),
(2, '554A', 'monitor', '2018', '16', '128', 'specs'),
(3, '205VA', 'monitor', '2020', '20', '128', 'something'),
(4, '205VA', 'monitor', '2020', '20', '128', 'something'),
(5, '554A', 'monitor', '2018', '16', '128', 'specs'),
(6, 'macbook1', 'laptop', '2016', '13', '128', 'something'),
(7, 'macbook2', 'laptop', '2018', '15', '256', 'specs'),
(8, 'dell1', 'laptop', '2019', '15', '256', 'something'),
(9, 'macbook2', 'laptop', '2019', '16', '256', 'something'),
(10, 'dt1', 'desktop', '2018', '16', '128', 'specs');

-- shows active auctions; have to calculate current price
CREATE TABLE IF NOT EXISTS auction(
auction_id int UNIQUE, 
buyer_id int,
seller_id int,
item_id int,
closing_date varchar(20), 
starting_price float,
min_price float, 
increment float, 
bid_limit float, 
current_price float,
auction_active bool,
sold_to_id int,
PRIMARY KEY (auction_id, seller_id),
FOREIGN KEY (seller_id) references users(account_id) on delete cascade on update cascade,
FOREIGN KEY (item_id) references electronic_item(item_id) on delete cascade on update cascade);

INSERT INTO auction VALUES 
(1, 5, 6, 1, '2022-05-05', 100.0, 150.0, 10.0, 200.0, 200.0, false, 5),
(2, 4, 6, 2, '2022-05-05', 100.0, 150.0, 10.0, 200.0, 175.0, false, 4),
(3, 4, 5, 3, '2022-05-05', 100.0, 150.0, 10.0, 200.0, 10000, true, NULL),
(4, 5, 6, 4, '2022-05-05', 100.0, 150.0, 10.0, 200.0, 400.0, false, 5),
(5, 3, 4, 5, '2022-05-05', 100.0, 150.0, 10.0, 200.0, 155.0, false, 3),
(6, 6, 3, 6, '2022-05-05', 100.0, 150.0, 10.0, 200.0, 600.0, false, 6),
(7, 6, 4, 7, '2022-05-05', 100.0, 150.0, 10.0, 200.0, 1000.0, false, 6),
(8, 5, 3, 8, '2022-05-05', 100.0, 150.0, 10.0, 200.0, 550.0, false, 5),
(9, 3, 6, 9, '2022-05-05', 100.0, 150.0, 10.0, 200.0, 750.0, false, 3),
(10, 4, 6, 10, '2022-05-05', 100.0, 150.0, 10.0, 200.0, 600.0, false, 4);

-- has a history of which auctions ended when and who it was sold to and the price it was sold at
-- have to calculate auction_active
-- if active, refer to the auction page, if inactive then current price is the last price so needs no reference
CREATE TABLE IF NOT EXISTS viewHistory(
history_id int UNIQUE,
seller_id int, 
user_account_id int, 
auction_id int, 
item_id int, 
end_date date,
price float,
auction_active bool,
PRIMARY KEY(history_id, user_account_id, seller_id, auction_id, item_id), 
FOREIGN KEY(auction_id) references auction(auction_id) on delete cascade on update restrict,
FOREIGN KEY(seller_id) references auction(seller_id) on delete cascade on update restrict,
FOREIGN KEY(user_account_id) references users(account_id) on delete cascade on update restrict,
FOREIGN KEY(item_id) references electronic_item(item_id) on delete cascade on update restrict);

INSERT INTO viewHistory VALUES 
(12, 4, 5, 2, 1, '2022-05-05', 10000, true),
(10, 4, 5, 2, 1, '2022-05-05', 5000, true),
(11, 4, 5, 2, 1, '2022-05-05', 7500, true),
(9, 4, 5, 2, 1, '2022-05-05', 1000, true);


-- alert gets active for a certain account_id to be alerted about item_id if alert_active is true
CREATE TABLE IF NOT EXISTS alert(
alert_id int,
account_id int, 
item_id int, 
alert_active bool default false,
alert_type varchar(100),
PRIMARY KEY(alert_id),
FOREIGN KEY(account_id) references users(account_id) on delete cascade on update cascade,
FOREIGN KEY(item_id) references electronic_item(item_id)on delete cascade on update cascade);

-- have not added to this, don't know what this would be used for
CREATE TABLE IF NOT EXISTS search(
account_id int, 
item_id int, 
PRIMARY KEY(account_id),
FOREIGN KEY(account_id) references users(account_id),
FOREIGN KEY (item_id) references electronic_item(item_id));

-- a table to store questions and answers
CREATE TABLE IF NOT EXISTS qna(
q_id int PRIMARY KEY,
question varchar(100),
answer varchar(200),
user_id int,
cusrep_id int,
FOREIGN KEY(user_id) references users(account_id) on delete cascade on update cascade,
FOREIGN KEY(cusrep_id) references users(account_id) on delete cascade on update cascade);

INSERT INTO qna VALUES 
(1, "My bid got deleted?", "You were being an asshole.", 4, 2), 
(2, "How do I delete my item?", "I have deleted the auction and bids for you.", 5, 2);

ALTER USER 'root'@'localhost' IDENTIFIED BY 'Rootuser!1';

CREATE TABLE IF NOT EXISTS automatic_bid(
auction_id int, 
buyer_id int,
seller_id int,
item_id int,
current_price float,
increment float,
PRIMARY KEY (auction_id, buyer_id, seller_id),
FOREIGN KEY (buyer_id) references users(account_id) on delete cascade on update cascade,
FOREIGN KEY (seller_id) references users(account_id) on delete cascade on update cascade,
FOREIGN KEY (item_id) references electronic_item(item_id) on delete restrict on update restrict);


select * from qna where question like '%bid%' or answer like '%bid%';
