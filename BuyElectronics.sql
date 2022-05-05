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
INSERT INTO users VALUES (1, 'admin', 'admin', true, false), (2, 'cusrep', 'cusrep', false, true), (3, 'user', 'passie', false, false);


CREATE TABLE IF NOT EXISTS electronic_item(
item_id int PRIMARY KEY, 
model_Number varchar(20), 
item_type varchar(30), 
item_year char(4), 
dimensions varchar(6), 
item_memory varchar(5), 
specifications varchar(20));

-- shows active auctions; have to calculate current price
CREATE TABLE IF NOT EXISTS auction(
auction_id int, 
buyer_id int,
seller_id int,
item_id int,
closing_date date, 
starting_price float,
min_price float, 
increment float, 
bid_limit float, 
current_price float,
auction_active bool,
sold_to_id int,
PRIMARY KEY (auction_id, buyer_id, seller_id),
FOREIGN KEY (buyer_id) references users(account_id) on delete restrict on update restrict,
FOREIGN KEY (seller_id) references users(account_id) on delete restrict on update restrict,
FOREIGN KEY (item_id) references electronic_item(item_id) on delete restrict on update restrict);

-- has a history of which auctions ended when and who it was sold to and the price it was sold at
-- have to calculate auction_active
-- if active, refer to the auction page, if inactive then current price is the last price so needs no reference
CREATE TABLE IF NOT EXISTS viewHistory(
buyer_id int, 
seller_id int, 
user_account_id int, 
auction_id int, 
item_id int, 
end_date date,
price float,
auction_active bool,
PRIMARY KEY(user_account_id, buyer_id, seller_id, auction_id, item_id), 
FOREIGN KEY(auction_id) references auction(auction_id) on delete restrict on update restrict,
FOREIGN KEY(buyer_id) references auction(buyer_id) on delete restrict on update restrict,
FOREIGN KEY(seller_id) references auction(seller_id) on delete restrict on update restrict,
FOREIGN KEY(user_account_id) references users(account_id) on delete restrict on update restrict,
FOREIGN KEY(item_id) references electronic_item(item_id) on delete restrict on update restrict);

-- alert gets active for a certain account_id to be alerted about item_id if alert_active is true
CREATE TABLE IF NOT EXISTS alert(
account_id int, 
item_id int, 
alert_active bool default false,
PRIMARY KEY(account_id, item_id),
FOREIGN KEY(account_id) references users(account_id) on delete restrict on update restrict,
FOREIGN KEY(item_id) references electronic_item(item_id) on delete cascade on update cascade);

-- have not added to this, don't know what this would be used for
CREATE TABLE IF NOT EXISTS search(
account_id int, 
item_id int, 
PRIMARY KEY(account_id),
FOREIGN KEY(account_id) references users(account_id) on delete restrict on update restrict,
FOREIGN KEY (item_id) references electronic_item(item_id) on delete cascade on update cascade);

ALTER USER 'root'@'localhost' IDENTIFIED BY 'Rootuser!1';

