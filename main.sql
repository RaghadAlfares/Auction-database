--Group 4: raghad alfares/shatha alsuwaid/norah almarul... section:371. 

CREATE SCHEMA OnlineAuctionStore AUTHORIZATION nano;

CREATE TABLE client(
Client_ID	INTEGER		NOT NULL,
Email	VARCHAR(50)     NOT NULL,
F_name	VARCHAR(15)		NOT NULL,
L_name	VARCHAR(15)		NOT NULL,
Password	CHAR(8)		NOT NULL,
Address		VARCHAR(30)	NOT NULL,
PRIMARY KEY (Client_ID));

CREATE table client_phone(
Client_ID	INTEGER		NOT NULL ,
Phone_number	INTEGER		NOT NULL,
UNIQUE(Phone_number),
FOREIGN KEY (Client_ID) REFERENCES client(Client_ID));

CREATE TABLE purchaser(
P_ID	INTEGER		NOT NULL ,
Billing_address		VARCHAR(30)	NOT NULL,
FOREIGN KEY (P_ID) REFERENCES client(Client_ID));

CREATE table supplier(
S_ID	INTEGER		NOT NULL ,
Bank_account_number		VARCHAR(10)		NOT NULL check(LENGTH(Bank_account_number) = 10),
UNIQUE(Bank_account_number),
FOREIGN KEY (S_ID) REFERENCES client(Client_ID));

CREATE table item(
Item_ID		INTEGER		NOT NULL ,
Product_name	VARCHAR(50)		NOT NULL,
Item_manufacture	VARCHAR(15)		NOT NULL,
Used_months		INTEGER     	NOT NULL,
Description		VARCHAR(100)	NOT NULL,
Auction_start_date		date	NOT NULL,
Auction_end_date		date	NOT NULL check(DATE(Auction_end_date)>=DATE(Auction_end_date)),
Start_bid_price   DECIMAL(4,2) NOT NULL,
Supplier_ID		INTEGER		NOT NULL,
PRIMARY KEY (Item_ID),
FOREIGN KEY (Supplier_ID) REFERENCES supplier(S_ID));

CREATE table item_language(
Item_ID		INTEGER		NOT NULL,
Item_language	VARCHAR(30),
Supp_ID            INTEGER		NOT NULL,
FOREIGN KEY (Item_ID) REFERENCES item(Item_ID),
FOREIGN KEY (Supp_ID) REFERENCES Supplier(S_ID));

CREATE table computer(
Computer_ID	INTEGER		NOT NULL,
Sup_ID	INTEGER		NOT NULL,
Memory		VARCHAR(10) NOT NULL,
Storage		VARCHAR(10) NOT NULL,
Speed		VARCHAR(10) NOT NULL,
FOREIGN KEY (Computer_ID) REFERENCES item(Item_ID),
FOREIGN KEY (Sup_ID) REFERENCES supplier(S_ID));

CREATE table printer(
Printer_ID	INTEGER		NOT NULL,
Sup_ID	INTEGER		NOT NULL,
Is_wireless	BOOLEAN NOT NULL,
Inkjet	VARCHAR(15) NOT NULL,
Is_contains_scanner	BOOLEAN NOT NULL,
FOREIGN KEY (Printer_ID) REFERENCES item(Item_ID),
FOREIGN KEY (Sup_ID) REFERENCES supplier(S_ID));

CREATE table manager(
Manager_ID	INTEGER		NOT NULL,
F_name	VARCHAR(15)		NOT NULL,
L_name	VARCHAR(15)		NOT NULL,
PRIMARY KEY (Manager_ID));

CREATE table auction(
Auction_ID	INTEGER		NOT NULL,
M_ID	INTEGER		NOT NULL,
Increment   DECIMAL(4,2),
PRIMARY KEY (Auction_ID),
FOREIGN KEY (M_ID) REFERENCES manager(Manager_ID));

CREATE table winner_bill (
Bill_ID	INTEGER		NOT NULL ,
Bill_date	date NOT NULL,
Highest_bid_price   DECIMAL(4,2),
PRIMARY KEY (Bill_ID));

CREATE table bid(
Bid_ID	INTEGER		NOT NULL,
Bid_date	date NOT NULL,
Proposed_price	 DECIMAL(4,2) NOT NULL,
Purchaser_id	INTEGER		NOT NULL,
Sup_id	INTEGER		NOT NULL,
Auction_id	INTEGER		NOT NULL,
Bill_id	 INTEGER ,
I_id	INTEGER		NOT NULL ,
PRIMARY KEY (Bid_ID),
FOREIGN KEY (Sup_id) REFERENCES supplier(S_ID),
FOREIGN KEY (Auction_id) REFERENCES auction(Auction_ID),
FOREIGN KEY (Purchaser_id) REFERENCES purchaser(P_ID),
FOREIGN KEY (Bill_id) REFERENCES winner_bill(Bill_ID),
FOREIGN KEY (I_id) REFERENCES item(Item_ID));

CREATE table feedback(
C_ID	INTEGER		NOT NULL,
Description		VARCHAR(100),
Rating	INT		check(Rating>=1 AND Rating<=5),
Billing_ID	INTEGER		NOT NULL,
FOREIGN KEY (C_ID) REFERENCES client(Client_ID),
FOREIGN KEY (Billing_ID) REFERENCES winner_bill(Bill_ID));

CREATE table shipping_company(
Tracking_ID VARCHAR(15) NOT NULL,
Name VARCHAR(15) NOT NULL,
Deliver_date date NOT NULL,
PRIMARY KEY (Tracking_ID));


CREATE table deliver_by(
Client_number INTEGER NOT NULL,
Tracking_number VARCHAR(15) NOT NULL,
FOREIGN KEY (Client_number) REFERENCES client(Client_ID),
FOREIGN KEY (Tracking_number) REFERENCES shipping_company(Tracking_ID));


INSERT INTO client (Client_ID,Email,F_name,L_name,Password,address)VALUES
(012116,'ahmad@gmail.com','ahmad','alateq','11223344','Riyadh, Olaya'),
(012117,'sara@gmail.com','sara','alshammri','12345678','Riyadh, Irqa'),
(012118,'khalid12@gmail.com','khalid','aldail','99955331','Riyadh, Irqa'),
(012119,'reem_almutairi@gmail.com','reem','almutairi','777#$776','Dammam, AlFursan'),
(012120,'reema.almohsen@gmail.com','reema','almohsen','99887766','Jeddah, Aziziyah'),
(012121,'saeed.alqahtani@gmail.com','saeed','alqahtani','11223344','Riyadh, Dhahrat Laban'),
(012122,'amal@gmail.com','amal','alrajhi','12345678','Dammam, Taiba'),
(012123,'lama@gmail.com','lama','almutairi','12335678','Jeddah, Aziziyah'),
(012124,'khalid34567@gmail.com','khalid','alqahtani','46768987','Riyadh, Irqa'),
(012125,'sara_alshammri@gmail.com','sara','alshammri','77436776','Dammam, AlFursan'),
(012126,'shatha.almohsen@gmail.com','shatha','almohsen','sh887766','Jeddah, Aziziyah'),
(012127,'raghad.alqahtani@gmail.com','raghad','alqahtani','Ra23344$','Riyadh, Dhahrat Laban');

INSERT INTO client_phone(Client_ID,Phone_number)VALUES
(012116,0553984773),
(012117,0599935683),
(012118,050324119),
(012119,0507463643),
(012120,0554361390),
(012121,0594744460),
(012122,0577300543),
(012123,0564864337),
(012124,0554291390),
(012125,0507467743),
(012126,0564892337),
(012127,050324299);

INSERT INTO purchaser (P_ID,Billing_address)VALUES
(012116,'Riyadh, Olaya'),
(012117,'Riyadh, Irqa'),
(012118,'Riyadh, Irqa'),
(012119,'Dammam, AlFursan'),
(012120,'Jeddah, Aziziyah'),
(012121,'Riyadh, Dhahrat Laban');


INSERT INTO supplier (S_ID,Bank_account_number)VALUES
(012122,'SA57946809'),
(012123,'SA10724795'),
(012124,'SA45695677'),
(012125,'SA31866807'),
(012126,'SA21323325'),
(012127,'SA77658755');

INSERT INTO Item (Item_ID,Product_name,Item_manufacture,Used_months,Description,Auction_start_date,Auction_end_date,Start_bid_price,Supplier_ID)VALUES
(452116,'HP Sprocket Select instant photo printer','HP',1,'This in-demand instant photo printer from HP is seriously cheap right now.',2021-05-11,2021-05-20,0400.00,012122),
(452117,'Canon IVY mini photo printer','Canon',0,'This mini photo printer from Canon is also available at a juicy discount.',2021-03-26,2021-04-02,0600.00,012123),
(452118,'Epson Expression Home XP-5100 color all-in-one printer','Epson',2,' This little photo-centric inkjet printer from Epson is excellent value.',2021-09-03,2021-10-20,0550.00,012124),
(452119,'Epson EcoTank ET-2800 all-in-one color pritner','Epson',1,'This Epson printer might be a little slow (10ppm in mono), but it certainly prints gorgeous high-resolution images. ',2021-12-11,2022-04-23,0550.50,012125),
(452120,'Epson Expression Photo XP-8600 wireless all-in-one printer','Epson',6,'If you want to print really high-quality photos from home, the XP-8600 could be an excellent buy. ',2021-01-01,2021-05-20,1100.00,012126),
(452121,'Canon imageCLASS MF445dw wireless laser printer','Canon',3,'Designed for small-medium businesses, this black and white laser printer (with scanner) from Canon',2021-10-22,2021-12-22,1500.00,012127),

(452122,'Dell XPS 13 (9310)','Dell',4,'A trim-to-the-max chassis, a beautiful screen, and a cutting-edge Intel (Tiger Lake).',2021-07-05,2021-09-28,4000.00,012122),
(452123,'MSI Modern 14','MSI',2,'MSIs under-$500 Modern 14 is a compelling budget laptop for day-to-day tasks,',2021-10-19,2021-11-25,2500.50,012123),
(452124,'Acer Chromebook Spin 713','Acer',1,'A touch screen with a squarish 3:2 aspect ratio.',2021-05-10,2021-05-26,3000.00,012124),
(452125,'Dell Inspiron 16 Plus (7610)','Dell',2,'The Inspiron 16 Plus (7610) is a top-notch value in a burgeoning category of laptops.',2021-06-15,2021-08-02,2500.00,012125),
(452126,'Apple iMac 27-inch (2020)','Apple',0,'Type: All-in-One CPU: 10th-gen Intel Core i5 ',2021-09-14,2021-09-23,5250.00,012126),
(452127,'Apple iMac 24-inch (2021)','Apple',1,'Display: 24-inch, 4480 x 2520 display Special Features: 1080p webcam, great speakers',2021-10-10,2021-11-10,6799.99,012127);

INSERT INTO item_language(Item_ID,Item_language,Supp_ID)VALUES
(452116,'english,chinese',012122),
(452117,'english,japanese',012123),
(452118,'english',012124),
(452119,'english',012125),
(452120,'english',012126),
(452121,'english,japanese',012127),

(452122,'english,arabic',012122),
(452123,'english',012123),
(452124,'english',012124),
(452125,'english',012125),
(452126,'english,arabic',012126),
(452127,'english',012127);

INSERT INTO computer (Sup_ID,Computer_ID,Memory,Storage,Speed)VALUES
(012122,452122,'RAM16GB','512GB','2.3GHz'),
(012123,452123,'RAM8GB','128GB','2.1GHz'),
(012124,452124,'RAM8GB','128GB','1.6GHz'),
(012125,452125,'RAM16GB','512GB','2.3GHz'),
(012126,452126,'RAM128GB','4TB','2.3GHz'),
(012127,452127,'RAM8GB','256GB','2.3GHz');

INSERT INTO printer (Sup_ID,Printer_ID,Is_wireless,Inkjet,Is_contains_scanner)VALUES
(012122,452116,1,'toner',0),
(012123,452117,1,'toner',0),
(012124,452118,0,'ink',1),
(012125,452119,0,'ink',1),
(012126,452120,1,'toner',1),
(012127,452121,1,'toner',1);

INSERT INTO manager(Manager_ID,F_name,L_name)VALUES
(580000,'norah','almarul'),
(580001,'raghad','alfares'),
(580002,'shatha','alsuwaid');

INSERT INTO auction(Auction_ID,M_ID,Increment)VALUES
(680000,580000,0050.00),
(680001,580000,0100.50),
(680002,580001,0040.00),
(680003,580001,0150.50),
(680004,580002,0300.00),
(680005,580002,0400.50);

INSERT INTO winner_bill(Bill_ID,Bill_date,Highest_bid_price)VALUES
(214143,2021-05-19,0450.00),
(214144,2021-10-15,0650.50),
(214145,2021-03-03,1140.00),
(214146,2021-05-18,4150.50),
(214147,2021-09-14,3150.50),
(214148,2021-08-07,4550.50);


INSERT INTO bid (Bid_ID,Bid_date,Proposed_price,Bill_id,Auction_id,Purchaser_id,Sup_id,I_id)VALUES
(362102,2021-05-19,0450.00,214143,680000,012116,012122,452116),
(362103,2021-10-15,0650.50,214144,680001,012117,012124,452118),
(362104,2021-03-03,1140.00,214145,680002,012118,012126,452120),
(362105,2021-08-05,4550.50,214146,680003,012119,012122,452122),
(362106,2021-05-18,3150.50,214147,680004,012120,012124,452124),
(362107,2021-09-14,5300.00,214148,680005,012121,012126,452126),
(362108,2021-08-07,4150.00,NULL,680003,012118,012122,452122);

INSERT INTO feedback (C_ID,Description,Rating,Billing_ID)VALUES
(012122,'nice person',4,214143),
(012116,'fast delivery',5,214143),
(012124,'good person but bad delivery',2,214144),
(012121,'bad quality',1,214144),
(012126,'perfect deal',5,214145),
(012118,'nice price',4,214145);

INSERT INTO shipping_company (Tracking_ID,Name,Deliver_date)VALUES
('OSADC00024204','FedEx','2021-12-23'),
('OSADC06704254','Smsa','2021-12-30'),
('OSADC67004352','Zajil','2021-12-20'),
('OSADC00784353','FedEx','2022-01-01'),
('OSADC06904385','Smsa','2021-12-19'),
('OSADC23009357','Zajil','2021-12-15');

INSERT INTO deliver_by (Client_number,Tracking_number)VALUES
(012116,'OSADC00004352'),
(012117,'OSADC00004353'),
(012118,'OSADC00004254'),
(012125,'OSADC00009357'),
(012126,'OSADC00004385'),
(012127,'OSADC00004204');

--Viewes:

--1- Supplier_items: this view shows the names of supplier, and the number of items they have placed:
CREATE VIEW Supplier_items AS
SELECT F_name , L_name, COUNT(product_name)
FROM supplier AS s, item AS i , client AS c
WHERE c.Client_ID = s.S_ID AND i.Supplier_ID = s.S_ID
GROUP BY s.S_ID;


--2- Winner_Detailes: This view returns all of the winners information as well as the item they won:
CREATE VIEW Winner_Detailes AS
SELECT F_name, L_name,email,address ,product_name
FROM supplier AS s, item AS i , client AS c
WHERE c.Client_ID = s.S_ID AND i.Supplier_ID = s.S_ID
GROUP BY c.Client_ID;

--Queries:

--1.Retrieve the number of bids and the highest bid made for every item:
SELECT   COUNT(Bid_ID),Highest_bid_price
FROM    item AS i,bid AS b,winner_bill AS w
WHERE  i.Item_ID=b.I_id AND b.Bill_ID=w.Bill_ID;

SELECT '' AS 'New Line';

--2.Retrieve the name of every supplier, and the number of items placed by him/her:
SELECT * FROM Supplier_items;

SELECT '' AS 'New Line';

--3.List all printers name and ID that have scanners and still in auction:
SELECT    Product_name, Printer_ID
FROM     item AS i,printer AS p
WHERE i.Item_ID=p.Printer_ID AND p.Is_contains_scanner=1 AND i.Auction_end_date>=2021-12-13;-- use the date of the current day. 

SELECT '' AS 'New Line';

--4.For each item with more than two bids, retrieve the item description, auction 
--expiration, and the number of bids for that item.
SELECT    Description,Auction_end_date,COUNT(Bid_ID)
FROM     item AS i, bid AS b
WHERE   i.Item_ID=b.I_id 
GROUP BY  Product_name
HAVING      COUNT(Bid_ID)>=2;

SELECT '' AS 'New Line';

--5.For each item, retrieve the number of bids, and the average price:
SELECT    COUNT(Bid_ID),AVG(Start_bid_price)
FROM     item AS i, bid AS b
WHERE   i.Item_ID=b.I_id 
GROUP BY  Product_name;

SELECT '' AS 'New Line';

--6.Find all items name and ID that has no bids yet:
SELECT   Item_ID,Product_name
FROM    item AS i
WHERE  NOT EXISTS (SELECT Bid_ID
				 FROM bid AS b
                 WHERE i.Item_ID=b.I_id);

SELECT '' AS 'New Line';

--7.List all purchasers or suppliers names who recorded a comment with 3 and
--above as transaction rating:
SELECT    F_name,L_name
FROM     feedback ,client
WHERE   C_ID=Client_ID AND Rating>=3;

SELECT '' AS 'New Line';

--8.List all suppliers name and ID who are from Riyadh that have more than two  
--placed items:
SELECT    DISTINCT Client_ID,F_name,L_name
FROM      client,item
WHERE    Client_ID=Supplier_ID AND Address LIKE '%Riyadh%';
