--- SQL REMAINDER:

--- Create database:
CREATE DATABASE bikesearch;

--- Drop database:
DROP DATABASE bikesearch;

--- Create table:
CREATE TABLE BIKES(
    model       char(70) NOT NULL,
    trademark   char(30) NOT NULL,
    store       varchar(30) NOT NULL,
    url         varchar(200) NOT NULL,
    kind        varchar(30),
    price       real NOT NULL
);

--- Insert value in table:
INSERT INTO bikes VALUES
    ('0000-KK -0000', 'KK-TRADEMARK', 'KK-STORE', 'www.kkstore.com', 'MTB', '999.99');

--- Empty table:
TRUNCATE TABLE; 

--- Erase table:
DROP TABLE; 

--- Modify user:
ALTER USER davide WITH PASSWORD 'hu8jmn3'; # ADD PASSWORD

--- Modify table:
ALTER TABLE bikes RENAME prize TO price;

--- Modify table column type:
ALTER TABLE bikes ALTER COLUMN "model" TYPE varchar(50);

--- Delete table:
DELETE FROM bikes WHERE store ~ 'Mammoth';

--- Modify table content:
UPDATE bikes SET  url='http://www.kkstore.com' WHERE model ~ 'KK';

--- Count entries:
SELECT count(*) from bikes ;

--- Search:
---
SELECT * from bikes WHERE model ~ 'KK';
        model         |      trademark       |  store   |       url       | kind | price  
 ----------------------+----------------------+----------+-----------------+------+--------
 0000-KK -0000        | KK-TRADEMARK         | KK-STORE | www.kkstore.com | MTB  | 999.99

SELECT * from bikes WHERE model ~ '00000' OR trademark ~ 'KK';
         model         |      trademark       |  store   |       url       | kind | price  
 ----------------------+----------------------+----------+-----------------+------+--------
  0000-KK -0000        | KK-TRADEMARK         | KK-STORE | www.kkstore.com | MTB  | 999.99


--- Search, avoiding repeated values:
---
SELECT DISTINCT store FROM bikes ORDER by store;
     store      
----------------
 Bicicletas Gil
 Bicimania
 Bicimarket
 BikeStocks
 BuhoBike
 Mammoth
 Sanferbike

--- How to update "encoding" :
bikesearch=# UPDATE pg_database set encoding=8 WHERE datname='bikesearch'; 
--- Where encoding could be:
--- 0 : SQL_ASCII
--- 6 : UNICODE_UTF8
--- 8 : LATIN1 (accepts accents, ñ, etc.)
