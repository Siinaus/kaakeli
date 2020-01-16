 /*Ylläpitolauseet*/ 


/*päivitetään numeron +358412633058 omistajan tietoihin uusi vaihdettu numero +358407589252 */ 
UPDATE Puhelin SET puhelinnumero='+358407589252'WHERE puhelinnumero ='+358412633058'; 
 

/*päivitetään katuosoite asiakkaalle Kukkakauppa Tammenterho*/ 
UPDATE Asiakas  
SET katuosoite='Teollisuuskatu 5', postinumero=40901, postitoimipaikka='Laukaa'  
WHERE nimi= 'Kukkakauppa Tammenterho'; 
 

/*poistetaan tilaus jossa tilauspäivämäärä on vanhempi kuin 1.2.2018*/ 
DELETE FROM Tilaus  
WHERE tilauspvm < '2000-02-01'; 
 

/*päivitetään kasvualueen alue, jossa on Aavikko, Erämaaksi*/ 
UPDATE Kasvualue SET alue = 'Erämaa' WHERE alue='Aavikko' AND kasvualue=1;  
 

/*muutetaan sähköpostisoite yritykselle, jonka y-tunnus 2061174-9 ja sähköpostiosoite on info@partaharjunpuutarha.fi.*/  
UPDATE Viljelija SET sahkoposti= 'viljelija@partaharjunpuutarha.fi'  
WHERE sahkoposti='info@partaharjunpuutarha.fi' AND ytunnus= '2061174-9';  

 
/*päivitetään tilausta, muokataan 1-tilaukseen määräksi 10. */ 
UPDATE KasvilajiTilaus SET maara=10  
WHERE tilaus=1;  
 

/*poistetaan tilaus jossa tilauspäivämäärä on vanhempi kuin 1.1.2000*/ 
DELETE FROM Tilaus   
WHERE YEAR(tilauspvm) < 2000; 
 

/*Kyselyt*/ 
 

/*Yksinkertainen SELECT-lause. Näytä kaikki kasvit hintoineen, jotka maksavat 5e tai enemmän.*/ 
SELECT nimi,hinta FROM Kasvilaji  
WHERE hinta >=5.00; 


/*Näytä viljelijät kasveineen niin, että kasvilajit ovat aakkosjärjestyksessä*/ 
SELECT k.nimi AS kasvilaji, v.nimi AS viljelija FROM Viljelija v 
INNER JOIN ViljelijaKasvilaji vk ON v.viljelija=vk.viljelija 
INNER JOIN Kasvilaji k ON k.kasvilaji=vk.kasvilaji 
ORDER BY kasvilaji; 
 

/*Näytä viljelijöiden kukkivien kasvien tieteellinen nimi ja lajike*/ 
SELECT v.nimi AS Viljelija, kl.tieteellinen As Nimi, kl.lajike AS Lajike  
FROM Kasvilaji kl 
LEFT OUTER JOIN ViljelijaKasvilaji vk ON kl.kasvilaji=vk.kasvilaji 
LEFT OUTER JOIN Viljelija v ON vk.viljelija=v.viljelija 
WHERE  kl.kukinta=1; 
 

/*Näytä kaikki puuvartiset kasvit*/ 
SELECT kl.nimi AS Nimi FROM Kasvilaji kl 
INNER JOIN Kasvityyppi kt ON kl.kasvityyppi=kt.kasvityyppi 
WHERE kt.kasvityyppi= 
(SELECT kasvityyppi FROM Kasvityyppi kt2 WHERE tyyppi='Puuvartinen'); 
 

/*Montako kasvia sisälsi Erika Palmun 3.1.1999 tilaus?*/ 
SELECT SUM(maara) AS lkm FROM Asiakas a 
INNER JOIN Tilaus t ON a.asiakas=t.asiakas 
INNER JOIN KasvilajiTilaus kt ON kt.tilaus=t.tilaus 
INNER JOIN Kasvilaji kl ON kl.kasvilaji=kt.kasvilaji 
WHERE a.asiakas=1 AND t.tilaus=4; 
 

/* Näytä asiakkaat, jotka eivät ole tilanneet mitään.*/ 
SELECT nimi FROM Asiakas a 
WHERE a.asiakas NOT IN  
(SELECT t.asiakas FROM Tilaus t); 
 

/* Mitä kasveja on saatavilla koossa S?*/ 
SELECT kl.nimi FROM Kasvilaji kl 
INNER JOIN Koko k ON kl.koko=k.koko 
WHERE k.kokoluokka='S'; 