/*
Ebenezer K.M Amoah
15862023
Final Individual Assignment

*/

create database digistic_pharma_15862023;
use digistic_pharma_15862023;

CREATE TABLE person (
    Personid INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY ,
    Fname VARCHAR(40) NOT NULL,
    Lname VARCHAR(40) NOT NULL,
    Gender ENUM('M', 'F') NOT NULL,
    Telephone VARCHAR(15) NOT NULL,
    Email VARCHAR(30),
    Address VARCHAR(30) NOT NULL,
    DOB DATE NOT NULL,
    #This index was created to facilitate a query where results are sorted by Gender
    INDEX (Gender)
);
 
CREATE TABLE customer (
    Customerid INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Occupation VARCHAR(20) ,
    Personid INT UNSIGNED UNIQUE NOT NULL ,
    FOREIGN KEY (Personid)
        REFERENCES person (Personid) on update restrict on delete restrict
);
 
 
CREATE TABLE pharmacy_clerk (
    PharmacyClerkid INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Shift TIME NOT NULL,
    Experience INT NOT NULL,
    Personid INT UNSIGNED UNIQUE NOT NULL,
    FOREIGN KEY (Personid)
        REFERENCES person (Personid) on update restrict on delete restrict
);
 
CREATE TABLE pharmacy_dispenser (
    PharmacyDispenserid INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Shift TIME NOT NULL,
    Experience INT NOT NULL,
    Personid INT UNSIGNED UNIQUE NOT NULL,
    FOREIGN KEY (Personid)
        REFERENCES person (Personid),
    PharmacyClerkid INT UNSIGNED UNIQUE NOT NULL,
    FOREIGN KEY (PharmacyClerkid)
        REFERENCES pharmacy_clerk (PharmacyClerkid) on update restrict on delete restrict
);

CREATE TABLE supplier (
    Supplierid INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Telephone VARCHAR(15) NOT NULL,
    Email VARCHAR(30) NOT NULL,
    Address VARCHAR(30) NOT NULL,
    Location VARCHAR(30) NOT NULL
);
 
CREATE TABLE inventory (
    Inventoryid INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    NumberofDrugsAvailable INT NOT NULL,
    NumberofDrugsReceived INT NOT NULL,
    NumberofExpiredDrugs INT NOT NULL,
    NumberOfDrugsSold  INT GENERATED ALWAYS AS ((NumberofDrugsReceived+NumberofExpiredDrugs)- NumberofDrugsAvailable) NOT NULL,
    Supplierid INT UNSIGNED UNIQUE NOT NULL ,
    FOREIGN KEY (Supplierid)
        REFERENCES supplier (Supplierid) on update restrict on delete restrict
);
 
CREATE TABLE drug (
    Drugid INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    DrugName varchar(30) NOT NULL,
    ManufactureDate DATE NOT NULL,
    ExpiryDate DATE NOT NULL,
    Inventoryid INT UNSIGNED NOT NULL,
    FOREIGN KEY (Inventoryid)
        REFERENCES inventory (Inventoryid) on update restrict on delete restrict, 
	#This index was created to facilitate the query used to display expired drugs
    INDEX (ExpiryDate)
);
 
CREATE TABLE custorder (
    Orderid INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    OrderDetails VARCHAR(30) NOT NULL,
    Customerid INT UNSIGNED NOT NULL UNIQUE,
    PharmacyClerkid INT UNSIGNED NOT NULL UNIQUE,
    FOREIGN KEY (PharmacyClerkid)
        REFERENCES pharmacy_clerk (PharmacyClerkid) on update restrict on delete restrict,
    FOREIGN KEY (Customerid)
        REFERENCES customer (Customerid) on update restrict on delete restrict
);

CREATE TABLE sales_invoice (
    SalesInvoiceID INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Sale_Date DATE NOT NULL,
    Sale_Time TIME NOT NULL,
    Total_Amount DECIMAL(20 , 2 ) NOT NULL,
    Payment_Type VARCHAR(30) NOT NULL,
    Discount DECIMAL(3 , 1 ) NOT NULL,
    Amount_Paid decimal(20,2) NOT NULL,
    Amount_Remaining decimal(20,2) generated always as ((Amount_Paid+Discount)-Total_Amount) NOT NULL,
    Customerid INT UNSIGNED NOT NULL UNIQUE,
    PharmacyClerkid INT UNSIGNED NOT NULL UNIQUE,
    DrugQuantity INT NOT NULL,
    Drugid INT UNSIGNED NOT NULL UNIQUE,
    FOREIGN KEY (Drugid)
        REFERENCES drug (Drugid) on update restrict on delete restrict,
    FOREIGN KEY (Customerid)
        REFERENCES customer (Customerid) on update restrict on delete restrict,
    FOREIGN KEY (PharmacyClerkid)
        REFERENCES pharmacy_clerk (PharmacyClerkid) on update restrict on delete restrict,
        #This index was created to facilitate the query used to display total nmber of drugs sold.
    INDEX (DrugQuantity)
);
 
create table purchase_invoice(
 Purchaseinvoiceid int  unsigned not null auto_increment primary key,
 Purchase_Date date NOT NULL,
 Purchase_Time time NOT NULL,
 Total_Amount decimal(20,2) NOT NULL,
 Payment_Type varchar(30) NOT NULL,
Amount_Paid decimal(20,2) NOT NULL,
 Amount_Remaining decimal(20,2) generated always as (Amount_Paid-Total_Amount) NOT NULL,
 PharmacyDispenserid INT  UNSIGNED NOT NULL UNIQUE,
    FOREIGN KEY (PharmacyDispenserid)
        REFERENCES pharmacy_dispenser (PharmacyDispenserid) on update restrict on delete restrict,
 Supplierid INT UNSIGNED NOT NULL,
    FOREIGN KEY (Supplierid)
        REFERENCES supplier (Supplierid) on update restrict on delete restrict,
 Drugid INT UNSIGNED NOT NULL UNIQUE,
    FOREIGN KEY (Drugid)
        REFERENCES drug (Drugid) on update restrict on delete restrict,
 DrugQuantity int NOT NULL,
 ##This index was created to help facilitate the query used to return payments made to the supplier ordered by time paid.
    INDEX (Purchase_Time)
 
 
 );
 

  
  
  

insert into person (Fname,Lname,Gender,Telephone,Email,Address,DOB) values ("James","Mount","M","+233578606273","rnewman@icloud.com","243 Forest Hills Drive","1998-03-12");
insert into person (Fname,Lname,Gender,Telephone,Email,Address,DOB) values ("Eddy","Wells","M","+233967604473","eddy.w@icloud.com","258  Hall Place","2000-08-15");
insert into person (Fname,Lname,Gender,Telephone,Email,Address,DOB) values ("Lenny","Adams","M","+233556658873","rnlennyadams@icloud.com","28 Park Circle Painesville","2009-09-17");
insert into person (Fname,Lname,Gender,Telephone,Email,Address,DOB) values ("Tara","Bennett","F","+238559606873","reebennettman@icloud.com","7948 Hilldale Lane Ypsilanti","2010-04-16");
insert into person (Fname,Lname,Gender,Telephone,Email,Address,DOB) values ("Kelvin","Barett","M","+233557607686","k.barrett@randatmail.com","13 Division Ave. Alabaster","2015-09-19");
insert into person (Fname,Lname,Gender,Telephone,Email,Address,DOB) values ("Samantha","Mason","F","+233567806173","s.mason@randatmail.com","203 NE. Jackson Rd","1997-02-12");
insert into person (Fname,Lname,Gender,Telephone,Email,Address,DOB) values ("Alberta","Carroll","F","+233515508893","a.carroll@aomail.com","7717 Winding Way Dr","1996-09-18");
insert into person (Fname,Lname,Gender,Telephone,Email,Address,DOB) values ("Tommy","Mount","M","+233757806823","tmount@icloud.com","9555 Market Street","1999-02-12");
insert into person (Fname,Lname,Gender,Telephone,Email,Address,DOB) values ("Alan","Murphy","F","+233852606273","ralannur@icloud.com","243 Vicinity Drive","1999-11-12");
insert into person (Fname,Lname,Gender,Telephone,Email,Address,DOB) values ("Roddy","Waveth","M","+233979644473","rod.wave@icloud.com","258  Cuban Links","2001-08-15");
insert into person (Fname,Lname,Gender,Telephone,Email,Address,DOB) values ("Adwoa","Adams","M","+233556658873","radwoaadams@icloud.com","288 Cirte Painez","2007-09-17");
insert into person (Fname,Lname,Gender,Telephone,Email,Address,DOB) values ("Ciara","Cole","F","+238825706873","rciara.ole@ipillow.com","79998 Country Lane Ypsilanti","2007-04-16");
insert into person (Fname,Lname,Gender,Telephone,Email,Address,DOB) values ("Kelvin","Patel","M","+233745986686","kpatel@randatmail.com","13 Broke Lane","2001-10-12");
insert into person (Fname,Lname,Gender,Telephone,Email,Address,DOB) values ("Nicole","Merell","F","+233567809856","nicki.merell@randatmail.com","22 Glock Lane","1999-11-30");
insert into person (Fname,Lname,Gender,Telephone,Email,Address,DOB) values ("Trent","Verhern","M","+233968742393","tver@aomail.com","7717 Dollar Way","2003-10-17");
insert into person (Fname,Lname,Gender,Telephone,Email,Address,DOB) values ("Theresa","James","F","+236587426823","theresa@icloud.com","854 Alansa Road","2005-01-19");
insert into person (Fname,Lname,Gender,Telephone,Email,Address,DOB) values ("Tanya","Pells","F","+233852606273","tpells@icloud.com","274 Petalls Drive","1998-05-12");
insert into person (Fname,Lname,Gender,Telephone,Email,Address,DOB) values ("Elsie","Webble","F","+233967696573","elswe@icloud.com","212 Somerset","2009-09-14");
insert into person (Fname,Lname,Gender,Telephone,Email,Address,DOB) values ("Kirwin","Tristcht","M","+233556675473","kirtr@icloud.com","200 Dreamsville","2005-05-13");
insert into person (Fname,Lname,Gender,Telephone,Email,Address,DOB) values ("Odum","Teber","M","+238559606956","reeodutman@icloud.com","988 Twindale Lane ","2004-10-26");
insert into person (Fname,Lname,Gender,Telephone,Email,Address,DOB) values ("Sandra","Buit","F","+233557602136","ksewett@randatmail.com","243 Rexford Alabaster","2004-11-28");
insert into person (Fname,Lname,Gender,Telephone,Email,Address,DOB) values ("Ernest","Molert","M","+233567745173","sdsseon@randatmail.com","209  Samson Rd","2000-12-31");
insert into person (Fname,Lname,Gender,Telephone,Email,Address,DOB) values ("Calihendra","Momonia","F","+233585208893","iejrdoll@aomail.com","771 Hate Way Dr","2006-06-15");
insert into person (Fname,Lname,Gender,Telephone,Email,Address,DOB) values ("Santi","Motan","M","+233757807453","satnunt@icloud.com","9558 Baskeet","2005-05-19");
insert into person (Fname,Lname,Gender,Telephone,Email,Address,DOB) values ("Abubakr","Linester","M","+233965606273","rabukakdur@icloud.com","248 Pickty Drive","2008-09-13");


insert into customer(Occupation,Personid) values ("Farmer",1);
insert into customer(Occupation,Personid) values ("Doctor",2);
insert into customer(Occupation,Personid) values ("Businessman",3);
insert into customer(Occupation,Personid) values ("Rapper",4);
insert into customer(Occupation,Personid) values ("Actor",5);
insert into customer(Occupation,Personid) values ("House-Maid",6);



insert into pharmacy_clerk(Shift,Experience,Personid) values ( "19:00:00" , 12 , 13);
insert into pharmacy_clerk(Shift,Experience,Personid) values ( "12:00:00" , 12 , 14);
insert into pharmacy_clerk(Shift,Experience,Personid) values ( "06:00:00" , 12 , 15);
insert into pharmacy_clerk(Shift,Experience,Personid) values ( "08:00:00" , 12 , 16);
insert into pharmacy_clerk(Shift,Experience,Personid) values ( "17:30:00" , 12 , 17);
insert into pharmacy_clerk(Shift,Experience,Personid) values ( "21:00:00" , 12 , 18);


insert into pharmacy_dispenser(Shift,Experience,Personid,PharmacyClerkid) values ( "19:00:00" , 12 , 7 , 1);
insert into pharmacy_dispenser(Shift,Experience,Personid,PharmacyClerkid) values ( "12:00:00" , 12 , 8 , 2);
insert into pharmacy_dispenser(Shift,Experience,Personid,PharmacyClerkid) values ( "06:00:00" , 12 , 9 , 3);
insert into pharmacy_dispenser(Shift,Experience,Personid,PharmacyClerkid) values ( "08:00:00" , 12 , 10 , 4);
insert into pharmacy_dispenser(Shift,Experience,Personid,PharmacyClerkid) values ( "17:00:00" , 12 , 11, 5);
insert into pharmacy_dispenser(Shift,Experience,Personid,PharmacyClerkid) values ( "21:00:00" , 12 , 12, 6);



insert into supplier(Telephone,Email,Address,Location) values ("233453879678","gambo.supplies@gmail.com","243 Kisseiman Drive","Kisseiman");


insert into inventory(NumberofDrugsAvailable,NumberofDrugsReceived,NumberofExpiredDrugs,Supplierid) values (8546,9856,85,1);


insert into drug(DrugName,ManufactureDate,ExpiryDate,Inventoryid) values ("Paracetamol","2019-04-12","2020-04-12",1);
insert into drug(DrugName,ManufactureDate,ExpiryDate,Inventoryid) values ("Cough Syrup","2019-04-12","2023-04-12",1);
insert into drug(DrugName,ManufactureDate,ExpiryDate,Inventoryid) values ("Malar X","2020-04-12","2022-04-12",1);
insert into drug(DrugName,ManufactureDate,ExpiryDate,Inventoryid) values ("Timu Kutin Syrup","2008-04-12","2024-04-12",1);
insert into drug(DrugName,ManufactureDate,ExpiryDate,Inventoryid) values ("Trexorla","2010-04-12","2030-04-12",1);
insert into drug(DrugName,ManufactureDate,ExpiryDate,Inventoryid) values ("Rubbing Alcohol","2019-06-12","2040-04-12",1);
insert into drug(DrugName,ManufactureDate,ExpiryDate,Inventoryid) values ("COVACCINE","2020-04-12","2021-04-13",1);
insert into drug(DrugName,ManufactureDate,ExpiryDate,Inventoryid) values ("Pot 2","2019-04-12","2025-04-12",1);
insert into drug(DrugName,ManufactureDate,ExpiryDate,Inventoryid) values ("Phenolatin","2019-04-12","2020-04-12",1);
insert into drug(DrugName,ManufactureDate,ExpiryDate,Inventoryid) values ("Parelato","2019-04-12","2020-06-12",1);
insert into drug(DrugName,ManufactureDate,ExpiryDate,Inventoryid) values ("Molterinuima","2019-04-12","2023-04-12",1);




insert into custorder(OrderDetails,Customerid,PharmacyClerkid) values ("Paracetamol",1,1);
insert into custorder(OrderDetails,Customerid,PharmacyClerkid) values ("Tipa Hunu",2,3);
insert into custorder(OrderDetails,Customerid,PharmacyClerkid) values ("Timu Kutin Syrup",4,5);
insert into custorder(OrderDetails,Customerid,PharmacyClerkid) values ("Rubbing Alcohol",6,4);
insert into custorder(OrderDetails,Customerid,PharmacyClerkid) values ("Trexorla",5,6);
insert into custorder(OrderDetails,Customerid,PharmacyClerkid) values ("Paracetamol",3,2);


insert into sales_invoice(Sale_Date,Sale_Time,Total_Amount,Payment_Type,Discount,Amount_Paid,Customerid,PharmacyClerkid,DrugQuantity,Drugid) values("2021-12-12","17:30:00",100.00,"MobileMoney",10,50.00,5,2,2,3);
insert into sales_invoice(Sale_Date,Sale_Time,Total_Amount,Payment_Type,Discount,Amount_Paid,Customerid,PharmacyClerkid,DrugQuantity,Drugid) values("2021-12-12","19:30:00",150.00,"MobileMoney",10,140.00,4,1,5,4);
insert into sales_invoice(Sale_Date,Sale_Time,Total_Amount,Payment_Type,Discount,Amount_Paid,Customerid,PharmacyClerkid,DrugQuantity,Drugid) values("2021-12-12","21:30:00",150.00,"Cash",10,140.00,1,6,2,2);
insert into sales_invoice(Sale_Date,Sale_Time,Total_Amount,Payment_Type,Discount,Amount_Paid,Customerid,PharmacyClerkid,DrugQuantity,Drugid) values("2021-12-14","17:30:00",100.00,"MobileMoney",10,50.00,2,3,2,1);
insert into sales_invoice(Sale_Date,Sale_Time,Total_Amount,Payment_Type,Discount,Amount_Paid,Customerid,PharmacyClerkid,DrugQuantity,Drugid) values("2021-11-12","19:30:00",150.00,"MobileMoney",10,140.00,3,4,5,11);
insert into sales_invoice(Sale_Date,Sale_Time,Total_Amount,Payment_Type,Discount,Amount_Paid,Customerid,PharmacyClerkid,DrugQuantity,Drugid) values("2021-10-12","21:30:00",150.00,"Cash",10,140.00,6,5,2,10);

 

insert into purchase_invoice(Purchase_Date,Purchase_Time,Total_Amount,Payment_Type,Amount_Paid,PharmacyDispenserid,Supplierid,Drugid,DrugQuantity) values("2021-12-12","17:30:00",1000.00,"Cash",1000.00,2,1,3,50);
insert into purchase_invoice(Purchase_Date,Purchase_Time,Total_Amount,Payment_Type,Amount_Paid,PharmacyDispenserid,Supplierid,Drugid,DrugQuantity) values("2021-12-12","19:30:00",2000.00,"Cash",1500.00,1,1,4,50);
insert into purchase_invoice(Purchase_Date,Purchase_Time,Total_Amount,Payment_Type,Amount_Paid,PharmacyDispenserid,Supplierid,Drugid,DrugQuantity) values("2021-12-12","19:30:00",1000.00,"Cash",1000.00,4,1,6,50);
insert into purchase_invoice(Purchase_Date,Purchase_Time,Total_Amount,Payment_Type,Amount_Paid,PharmacyDispenserid,Supplierid,Drugid,DrugQuantity) values("2021-12-12","19:30:00",1000.00,"Cash",1000.00,6,1,5,500);
insert into purchase_invoice(Purchase_Date,Purchase_Time,Total_Amount,Payment_Type,Amount_Paid,PharmacyDispenserid,Supplierid,Drugid,DrugQuantity) values("2021-12-12","19:30:00",1000.00,"Cash",400.00,5,1,7,50);




#Query to display details of pharmacy dispensers and pharmacy clerks by order of Gender.
SELECT 
    *
FROM
    pharmacy_dispenser
        INNER JOIN
    person ON pharmacy_dispenser.Personid = person.Personid
    ORDER BY
    person.Gender;

SELECT 
    *
FROM
    pharmacy_clerk
        INNER JOIN
    person ON pharmacy_clerk.Personid = person.Personid
    ORDER BY
    person.Gender;


#Query to fnid total number of drugs sold
SELECT 
    SUM(DrugsQuantity) AS total
FROM
    (SELECT 
        sales_invoice.DrugQuantity AS DrugsQuantity
    FROM
        sales_invoice UNION ALL SELECT 
        inventory.NumberOfDrugsSold  AS DrugsQuantity
    FROM
        inventory) AS nestedQuery
;

#Query to find expired drugs
SELECT * FROM Drug where Drug.ExpiryDate > CURRENT_DATE;

#Query to find details of customers and their sales invoices.
SELECT 
    *
FROM
    customer
        LEFT OUTER JOIN
    sales_invoice ON customer.Customerid = sales_invoice.Customerid
        INNER JOIN
    person ON customer.Personid = person.Personid
WHERE
    sales_invoice.Sale_Date IS NOT NULL;

#Query to display all purchase invoices issued by the pharmacy dispenser ordered by time.
SELECT 
    *
FROM
    purchase_invoice
ORDER BY Purchase_Time DESC;




 





