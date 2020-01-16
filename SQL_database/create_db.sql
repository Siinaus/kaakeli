CREATE DATABASE IF NOT EXISTS vehka;  
USE vehka;  

DROP TABLE IF EXISTS ViljelijaKasvilaji; 
DROP TABLE IF EXISTS KasvilajiTilaus; 
DROP TABLE IF EXISTS Tilaus; 
DROP TABLE IF EXISTS Kasvilaji; 
DROP TABLE IF EXISTS Kasvityyppi;  
DROP TABLE IF EXISTS Kasvualue;  
DROP TABLE IF EXISTS Kastelutarve; 
DROP TABLE IF EXISTS Koko; 
DROP TABLE IF EXISTS Vari; 
DROP TABLE IF EXISTS ViljelijaPuhelin; 
DROP TABLE IF EXISTS Viljelija; 
DROP TABLE IF EXISTS Puhelin; 
DROP TABLE IF EXISTS AsiakasYhteyshenkilo; 
DROP TABLE IF EXISTS Asiakas; 
DROP TABLE IF EXISTS Yhteyshenkilo; 
 
CREATE TABLE Yhteyshenkilo( 
yhteyshenkilo INT AUTO_INCREMENT, 
etunimi VARCHAR(20) NOT NULL, 
sukunimi VARCHAR(40) NOT NULL, 
CONSTRAINT pk_yhteyshenkilo PRIMARY KEY (yhteyshenkilo) 
)ENGINE=INNODB; 

CREATE TABLE Asiakas ( 
asiakas INT AUTO_INCREMENT, 
ytunnus CHAR(10) NOT NULL, 
nimi VARCHAR(50) NOT NULL, 
katuosoite VARCHAR(50), 
postinumero CHAR(5), 
postitoimipaikka VARCHAR(20), 
sahkoposti VARCHAR(50), 
puhelin VARCHAR(50), 
yhteyshenkilo INT, 
CONSTRAINT pk_asiakas PRIMARY KEY(asiakas), 
CONSTRAINT fk_yhteyshenkilo FOREIGN KEY (yhteyshenkilo) REFERENCES Yhteyshenkilo(yhteyshenkilo) 
    ON UPDATE CASCADE
    ON DELETE CASCADE 
) ENGINE=INNODB; 

CREATE TABLE AsiakasYhteyshenkilo( 
asiakas INT NOT NULL, 
yhteyshenkilo INT AUTO_INCREMENT NOT NULL, 
PRIMARY KEY (asiakas,yhteyshenkilo), 
FOREIGN KEY (asiakas) REFERENCES Asiakas(asiakas), 
FOREIGN KEY (yhteyshenkilo) REFERENCES Yhteyshenkilo(yhteyshenkilo) 
    ON UPDATE CASCADE 
    ON DELETE CASCADE 
) ENGINE=INNODB; 

CREATE TABLE Puhelin( 
puhelin INT AUTO_INCREMENT, 
puhelinnumero VARCHAR(20) NOT NULL, 
PRIMARY KEY(puhelin) 
) ENGINE=INNODB; 

CREATE TABLE Viljelija( 
viljelija INT AUTO_INCREMENT, 
ytunnus CHAR(10), 
nimi VARCHAR(50), 
katuosoite VARCHAR(50), 
postinumero CHAR(10), 
postitoimipaikka VARCHAR(30), 
maa VARCHAR(30), 
sahkoposti VARCHAR(50), 
yhteyshenkilo VARCHAR(40), 
puhelin INT, 
PRIMARY KEY (viljelija), 
CONSTRAINT fk_puhelin FOREIGN KEY (puhelin) REFERENCES Puhelin(puhelin) 
    ON UPDATE CASCADE 
    ON DELETE CASCADE 
) ENGINE=INNODB; 

CREATE TABLE ViljelijaPuhelin( 
puhelin INT, 
viljelija INT, 
PRIMARY KEY (viljelija, puhelin), 
FOREIGN KEY (viljelija) REFERENCES Viljelija(viljelija), 
FOREIGN KEY (puhelin) REFERENCES Puhelin(puhelin) 
    ON UPDATE CASCADE 
    ON DELETE CASCADE 
) ENGINE=INNODB; 
 
CREATE TABLE Vari( 
vari INT AUTO_INCREMENT, 
savy VARCHAR(40) NOT NULL, 
PRIMARY KEY (vari)  
)ENGINE INNODB; 

CREATE TABLE Koko( 
koko INT AUTO_INCREMENT, 
kokoluokka CHAR(3) NOT NULL, 
PRIMARY KEY (koko) 
)ENGINE INNODB; 


CREATE TABLE Kastelutarve( 
kastelutarve INT AUTO_INCREMENT NOT NULL, 
kuvaus VARCHAR(20), 
PRIMARY KEY (kastelutarve) 
)ENGINE INNODB; 

CREATE TABLE Kasvualue( 
kasvualue INT AUTO_INCREMENT PRIMARY KEY, 
alue VARCHAR(30) 
)ENGINE INNODB; 

CREATE TABLE Kasvityyppi( 
kasvityyppi INT AUTO_INCREMENT PRIMARY KEY, 
tyyppi VARCHAR(20) NOT NULL, 
kastelutarve INT NOT NULL, 
kasvualue INT NOT NULL, 
CONSTRAINT fk_kastelutarve FOREIGN KEY (kastelutarve) REFERENCES Kastelutarve(kastelutarve), 
CONSTRAINT fk_kasvualue FOREIGN KEY (kasvualue) REFERENCES Kasvualue(kasvualue) 
    ON UPDATE CASCADE 
    ON DELETE CASCADE 
)ENGINE INNODB; 

CREATE TABLE Kasvilaji( 
kasvilaji INT AUTO_INCREMENT PRIMARY KEY, 
tieteellinen VARCHAR(50) NOT NULL, 
lajike VARCHAR(20), 
nimi VARCHAR(30), 
kukinta BOOLEAN NOT NULL, 
hinta DECIMAL(10,2), 
vari INT NOT NULL, 
koko INT NOT NULL, 
kasvityyppi INT NOT NULL, 
CONSTRAINT fk_vari FOREIGN KEY (vari) REFERENCES Vari(vari), 
CONSTRAINT fk_koko FOREIGN KEY (koko) REFERENCES Koko(koko), 
CONSTRAINT fk_kasvityyppi FOREIGN KEY (kasvityyppi) REFERENCES Kasvityyppi(kasvityyppi) 
    ON UPDATE CASCADE 
    ON DELETE CASCADE 
)ENGINE INNODB; 
 
CREATE TABLE Tilaus( 
tilaus INT AUTO_INCREMENT PRIMARY KEY, 
asiakas INT, 
tilauspvm DATE NOT NULL, 
toimituspvm DATE, 
FOREIGN KEY (asiakas) REFERENCES Asiakas(asiakas) 
)ENGINE INNODB; 

CREATE TABLE KasvilajiTilaus( 
kasvilaji INT NOT NULL, 
tilaus INT NOT NULL, 
maara INT NOT NULL, 
CONSTRAINT fk_kasvilaji FOREIGN KEY (kasvilaji) REFERENCES Kasvilaji(kasvilaji), 
CONSTRAINT fk_tilaus FOREIGN KEY (tilaus) REFERENCES Tilaus(tilaus) 
    ON UPDATE CASCADE 
    ON DELETE CASCADE 
)ENGINE INNODB; 

CREATE TABLE ViljelijaKasvilaji( 
kasvilaji INT NOT NULL, 
viljelija INT NOT NULL, 
CONSTRAINT fk_vkasvilaji FOREIGN KEY (kasvilaji) REFERENCES Kasvilaji(kasvilaji), 
CONSTRAINT fk_viljelija FOREIGN KEY (viljelija) REFERENCES Viljelija(viljelija) 
    ON UPDATE CASCADE 
    ON DELETE CASCADE 
)ENGINE INNODB; 

--Tiedon lisääminen 

INSERT INTO Yhteyshenkilo(etunimi, sukunimi) VALUES 
('Erika', 'Palmu'), ('Meri', 'Saastamoinen'), ('Ruusu', 'Kujala'), ('Martti', 'Ekholm'), 
('Karlo', 'Metsälä'), ('Ulla', 'Teräväinen'), ('Ukko', 'Salo'), ('Mauri', 'Mäkinen'), ('Kukka', 'Ketonen'); 

INSERT INTO Asiakas(ytunnus, nimi, katuosoite, postinumero, postitoimipaikka, sahkoposti, puhelin, yhteyshenkilo) VALUES 
('1334567-9', 'Vihersisustus Erika Palmu', 'Kirkkotie 34', '40430', 'Jyväskylä', 'erika.palmu@vihersisus.fi', '0405622845', 1), 
('2234537-8', 'Kukkakauppa Tammenterho', 'Puistokatu 56', '40900', 'Laukaa', 'info@tammenterho.fi', '0506722346', 3), 
('1237737-6', 'Missio Viherrys', 'Lampitie 2', '40420', 'Jyskä', 'palvelut@missioviherrys.fi', '0146633845', 4), 
('1234337-3', 'Viherpalvelu TietoTaito', 'Vapaudenkatu 7', '40134', 'Puuppola', 'tietotaito@viherpalvelu.fi', '0509903462', 7),
('1569874-1', 'Terapiakukka Outinen', 'Perätie 4', '40270', 'Palokka', 'kukka@terapiaan.fi', '020400500', 2), 
('9876543-3', 'Kukkia ja Sidontaa', 'Puistikko 54', '44510', 'Äänekoski', 'domino@kukkakimppu.fi', '0507453159', 6); 

INSERT INTO AsiakasYhteyshenkilo VALUES (1, 1), (1, 2), (2, 3), (3, 4), (3, 5), (3, 6), (4, 7); 

INSERT INTO Puhelin(puhelinnumero) VALUES ('+358412633058'), ('+358438811038'), ('+35835884991'), ('+35887384963'), ('+4658945597'), ('+0387384963'); 

INSERT INTO Viljelija(ytunnus, nimi, katuosoite, postinumero, postitoimipaikka, maa, sahkoposti, yhteyshenkilo, puhelin) VALUES  
('4592245-9', 'Tainan Taimet', 'Loivantie 3', '86180', 'Pellikkaperä', 'Suomi', 'info@taimet.fi', 'Taina Kekkonen', 1), 
('1105868-7', 'Keijon Puutarha', 'Kukkamäki 57', '44500', 'Viitasaari', 'Suomi', 'keijo@puutarhuri.fi', 'Keijo Hiltunen', 2), 
('120182-5', 'Primavera Leppanen', 'Hietikko 45', '86600', 'Haapavesi', 'Suomi', 'kevat@leppanen.fi', 'Lucille Leppänen', 3), 
('2061174-9', 'Partaharjun Puutarha', 'Partaharjuntie 431', '76280', 'Partaharju','Suomi', 'info@partaharjunpuutarha.fi', 'Erkki Savolainen', 4), 
('1594568-6', 'Görans Blommor', 'Nordengaten 5', '41131', 'Göteborg', 'Sverige', 'göran@blommor.se', 'Görans Strömdahl',5), 
('9203852-4', 'EverBloom', 'Floraveg 5', '59602', 'Aalsmeer', 'Holland', 'order@everbloom.nl', 'Jan-Peter Tikken', 6); 

INSERT INTO ViljelijaPuhelin VALUES (1, 1), (2, 2), (3, 3), (4, 4), (5,5), (6,6); 

INSERT INTO Vari(savy) VALUES ('Syvä vihreä'), ('Vaalean vihreä'), ('Keltavihreä'), ('Valkovihreä'), ('Valkoinen'), ('Punasävyinen'), ('Monivärinen'); 

INSERT INTO Koko(kokoluokka) VALUES ('XS'), ('S'), ('M'), ('L'), ('XL'); 

INSERT INTO Kastelutarve(kuvaus) VALUES ('Niukka'), ('Kohtalainen'), ('Runsas'); 

INSERT INTO Kasvualue(alue) VALUES ('Aavikko'), ('Välimeri'), ('Substrooppinen'), ('Tropiikki'); 

INSERT INTO Kasvityyppi(tyyppi, kastelutarve, kasvualue) VALUES ('Kaktus', 1, 1), ('Mehikasvi', 1, 2), ('Köynnöspuu', 2, 2), ('Köynnös', 2, 4),  
('Vehkakasvit', 2, 4), ('Saniainen', 3, 4), ('Puuvartinen', 2, 3), ('Bonsai', 2, 3); 

INSERT INTO Kasvilaji(tieteellinen, lajike, nimi, kukinta, hinta, vari, koko, kasvityyppi) VALUES  
('Philodendron scandens', 'Brazil', 'Herttaköynnösvehka', 0, 3.50, 3, 2, 4), 
('Dracaena deremensis', 'Dorado', 'Traakkipuu', 0, 2.80, 3, 3, 7), ('Hoya bella', 'Choco', 'Posliinikukka', 1, 3.33, 1, 3, 3), 
('Anthurium', 'Vanilla', 'Flamingonkukka', 1, 5.00, 1, 2, 5), ('Pinus sylvestris', NULL, 'Bonsaimänty', 0, 12.00, 1, 4, 8), 
('Davallia', NULL, 'Käpäläsaniainen', 0, 5.60, 1, 2, 6), 
('Ariocarpus', NULL, 'Kivikaktus', 1, 7.30, 4, 1, 1), 
('Aloë vera', NULL, 'Lääkealoe', 0, 14.90, 1, 4, 2), 
('Hibiscus rosa-sinensis', NULL, 'Kiinanruusu', 1, 30.50, 1, 5, 7); 


INSERT INTO ViljelijaKasvilaji VALUES (1, 2), (2, 2), (3, 2), (4, 2), (9, 2), (5, 1), (8, 1), (3, 4), (4, 4), (7, 4), (9, 4), 
(1, 3), (2, 3), (3, 3), (4, 3), (6, 3), (4,5), (7,5), (9,5), (1,6), (2,6), (6,6), (9,6); 

INSERT INTO Tilaus(asiakas, tilauspvm) VALUES (1, '2018-01-31'), 
(2, '2018-02-02'), (3, '2018-03-05'), (1,'1999-01-03'), (5,'2018-05-03'), (2,'2018-12-01'), (4,'2018-06-01'), (3,'1998-03-03'); 

INSERT INTO KasvilajiTilaus VALUES (1,1,5), (2,2,8), (3,3,5), (4,4,8), (5,4,3), (9,5,1), (7,6,6), (3,6,6), (1,7,1), (5,8,9);