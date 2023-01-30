/* Dodawanie wstêpnych wartoœci

!!!2.!!!

do bazy danych szpitala
*/
/*
TABLICE:
-- WPROWADZENIE DANYCH PRZYK£ADOWYCH DO PACJENTOW, KONTATKU DO PACJENTOW
-- WPROWADZENIE DANYCH PRZYK£ADOWYCH DO BADAÑ, WYNIKÓW, POMIARÓW PACJENTÓW
-- WPROWADZENIE DANYCH PRZYK£ADOWYCH DO OBJAWÓW, CHORÓB PACJENTÓW
-- WPROWADZENIE DANYCH PRZYK£ADOWYCH DO KATEGORII, LEKÓW, PRODUCENTÓW LEKÓW, INTERAKCJI, OBJAWÓW UBOCZNYCH
-- WPROWADZENIE DANYCH PRZYK£ADOWYCH DO STRUKTURY, PRACOWNIKÓW SZPITALA
-- WPROWADZENIE DANYCH PRZYK£ADOWYCH DO POBYTÓW PACJENTÓW W SZPITALU
-- WPROWADZENIE DANYCH PRZYK£ADOWYCH DO STRATEGII LECZENIA

Pacjenci [x], DaneKontaktowe [x],

BadanieMoczu [], BadanieKrwi  [], HistoriaWagi [], WynikiDanychPsychologicznych []

Choroby [x], WszystkieChorobyPacjentow  [x],
Objawy [], ObjawyPacjentow [],

KategoriaLeku [x], Leki [x], ProducenciLekow [], InterakcjeLekowe [], ObjawyUboczneLekow [], 

Oddzialy [x],
Pracownicy [x],

Pobyty [],

StrategieLeczenia []
*/

-- WPROWADZENIE DANYCH PRZYK£ADOWYCH DO PACJENTOW, KONTATKU DO PACJENTOW

INSERT INTO Pacjenci VALUES
	('Ewelina', 'Przybylska', 'K', '1932-04-01', '32040176108', 1, 167),
	('Zdzis³aw', 'Szulc', 'M', NULL, '52060291939', 0, 173),
	('Zofia', 'Janik', 'K', '1950-09-19', '50091930982', 1, 169),
	('El¿bieta', 'Nowak', 'K', '2000-12-25', '00322531707', 1, 180),
	('Volodymyr', 'Laskowski', 'M', '1969-04-13', '69041384832', 1, 178),
	('Maksymilian', 'Sobczak', 'M', '1982-04-11', '82041136995', 0, 162),
	('Kamil', 'Chmielewski', 'M', '1954-01-12', '54011260197', 1, 178),
	('Alan', 'Wieczorek', 'M', '1944-03-31', '44033187156', 0, 190),
	('Witold', 'Kaczmarczyk', 'M', '2007-07-24', '07272485434', 0, 174),
	('Irena', 'Gajewska', 'K', '1936-04-29', NULL, 1, 185),
	('Olga', 'Kaczmarek', 'K', '1977-06-07', '77060741307', 1, 185),
	('Sylwester', 'Kwiatkowski', 'M', '1997-05-17', '97051730934', 1, 179),
	('Norbert', 'Zieliñski', 'M', '1958-03-21', '58032157278', 0, 169),
	('Stanis³awa', 'Górecka', 'K', '1976-12-12', '76121257869', 0, 187),
	('Ewa', 'Szczepañska', 'K', '1969-11-14', '69111413448', 0, 185),
	('Wiktor', 'Szulc', 'M', '1937-01-03', '37010382417', 0, 164),
	('Danuta', 'Pawlak', 'K', '1921-11-15', '21111547347', 1, 174),
	('Tomasz', 'Marciniak', 'M', '1956-03-18', '56031873337', 0, 167),
	('Ireneusz', 'Nowakowski', 'M', '1932-02-12', '32021224013', 0, 184),
	('Halina', 'Grabowska', 'K', '1966-05-08', '66050833368', 0, 176),
	('Henryk', 'Janik', 'M', '1952-11-11', '52111172514', 1, 178),
  ('Ireneusz', 'D¹browski', 'M', '1923-12-20', '23122023810', 1, 164),
  ('Gabriel', 'Nowicki', 'M', '1966-07-16', '66071633471', 1, 178),
  ('Jaros³aw', 'Nowak', 'M', '1999-01-27', '99012716933', 0, 188),
  ('Dawid', 'Michalak', 'M', '1992-01-30', NULL, 0, 168),
  ('Izabela', 'Maciejewska', 'K', '1937-12-26', '37122624926', 0, 162),
  ('Marlena', 'Nowak', 'K', '2009-03-24', '09232415648', 1, 175),
  ('Józef', 'Adamczyk', 'M', NULL, NULL, 0, 172),
  ('Amelia', 'Mazur', 'K', '1939-09-12', '39091293668', 1, 189),
  ('Aniela', 'Wójcik', 'K', '1995-03-31', '95033192507', 1, 163),
  ('Halina', 'Sikorska', 'K', '1964-09-24', '64092426801', 0, 170),
 ('Andrzej', 'Borowski', 'M', '2010-04-27', '10242788770', 1, 163),
('Rados³aw', 'Walczak', 'M', '1948-12-27', '48122783377', 1, 165),
('Oliwia', 'Zió³kowska', 'K', '1964-04-18', '64041839269', 1, 171),
('W³odzimierz', 'Zawadzki', 'M', '1927-03-03', '27030377818', 1, 183),
('Kamila', 'D¹browska', 'K', '1985-10-05', '85100565084', 0, 177),
('Miros³aw', 'Jasiñski', 'M', '1952-07-05', '52070530857', 0, 182),
('Wiktor', 'Zakrzewski', 'M', '1980-05-30', '80053093233', 1, 176),
('Dawid', 'Wróbel', 'M', '1928-06-21', '28062166818', 0, 183),
('Nadia', 'Tomaszewska', 'K', '1979-07-11', '79071111324', 1, 164),
('Mariola', 'Krawczyk', 'K', '1970-08-18', '70081814560', 0, 164),
('Eugeniusz', 'B¹k', 'M', '1937-05-04', '37050426919', 1, 160),
('Bartosz', 'B³aszczyk', 'M', '1932-02-18', '32021887030', 1, 177),
('£ucja', 'Sawicka', 'K', '2005-06-09', '05260951365', 1, 176),
('Nadia', 'Makowska', 'K', '1944-04-15', '44041513947', 0, 187),
('Wanda', 'Maciejewska', 'K', '2008-01-11', '08211158224', 1, 169),
('Emilia', 'Sadowska', 'K', '1920-05-05', '20050514685', 0, 181),
('Andrzej', 'Zieliñski', 'M', '2007-12-06', '07320652719', 0, 181),
('Kazimiera', 'Borowska', 'K', '1988-04-22', '88042251307', 1, 178),
('Marta', 'Wojciechowska', 'K', '2005-11-24', '05312423727', 0, 160),
('Justyna', 'Zalewska', 'K', '1994-03-31', '94033119268', 1, 170),
('Stanis³awa', 'Sobczak', 'K', '1920-08-14', '20081463820', 1, 165),
('Amelia', 'Sawicka', 'K', '2010-08-24', '10282484045', 0, 167),
('Arkadiusz', 'Wiœniewski', 'M', '1940-07-27', '40072739275', 0, 184),
('Oliwier', 'Ko³odziej', 'M', '1954-12-27', '54122786678', 1, 169),
('Zygmunt', 'Malinowski', 'M', '1979-10-03', '79100334157', 0, 186),
('Wiktor', 'Grabowski', 'M', '1945-07-02', '45070263379', 1, 177),
('Volodymyr', 'Mazur', 'M', '1927-07-07', '27070770592', 0, 169),
('Zdzis³aw', 'B³aszczyk', 'M', '1920-07-03', '20070396177', 0, 176),
('Kornelia', 'Zawadzka', 'K', '1936-10-20', '36102071927', 0, 188),
('Ireneusz', 'Pietrzak', 'M', '1978-04-12', '78041222233', 0, 160),
('Edward', 'Zió³kowski', 'M', '1960-10-25', '60102588514', 0, 163),
('Alina', 'Król', 'K', '1963-04-19', '63041966227', 1, 162),
('Joanna', 'Sobczak', 'K', '1927-01-21', '27012143541', 0, 168),
('Paulina', 'Zawadzka', 'K', '1937-08-11', '37081140705', 0, 171),
('Mariusz', 'Mazurek', 'M', '1969-12-26', '69122672838', 1, 169),
('Marcin', 'Kucharski', 'M', '2005-01-21', '05212150552', 0, 190),
('Józef', 'Borkowski', 'M', '1945-01-08', '45010825436', 1, 183),
('Monika', 'Sobczak', 'K', '1977-04-25', '77042598486', 0, 183),
('Aleksandra', 'Kania', 'K', '1978-01-18', '78011899407', 1, 175),
('Julia', 'Gajewska', 'K', '1923-09-27', '23092772268', 1, 178),
('Katarzyna', 'Borowska', 'K', '1922-08-27', '22082764986', 0, 164),
('Jolanta', 'Chmielewska', 'K', '1963-09-16', '63091693906', 1, 165),
('£ucja', 'Jab³oñska', 'K', '1957-01-23', '57012373466', 1, 163);

INSERT INTO DaneKontaktowe VALUES
  (1, '+48 507836657', 'email1@domena1.com', 'ul. Saturna 2/43', 'I³owa', 'Polska'),
  (1, '+48 510621350', 'email2@domena1.com', 'ul. Sportowa 5', 'Bia³a Rawska', 'Polska'),
  (2, '+48 509393005', 'email3@domena1.com', 'ul. Gospodarcza 41/63', 'Milicz', 'Polska'),
  (3, '+48 880677938', 'email4@domena1.com', 'ul. Grunwaldzka 44', 'Œcinawa', 'Polska'),
  (4, '+48 537299150', 'email5@domena1.com', 'ul. Têczowa 2/68', 'Lewin Brzeski', 'Polska'),
  (6, '+48 515319351', 'email1@domena2.com', 'ul. Wioœlarska 40', 'Mszczonów', 'Polska'),
  (5, '+48 735118959', 'email2@domena2.com', 'ul. Widokowa 54/26', 'Lipsko', 'Polska'),
  (11, '+48 575269049', 'email3@domena2.com', 'ul. Dunikowskiego 2/14', 'Chodecz', 'Polska'),
  (11, '+48 663553284', 'email4@domena2.com', 'ul. Spó³dzielcza 154/17', 'Pakoœæ', 'Polska'),
  (7, '+48 720583722', 'email1@domena3.com', 'ul. Wroc³awska 78/46', '£êknica', 'Polska')

-- WPROWADZENIE DANYCH PRZYK£ADOWYCH DO BADAÑ, WYNIKÓW, POMIARÓW PACJENTÓW

INSERT INTO BadanieMoczu Values
  (2, '2021-10-09', 's³omkowy', 1, 6, 1.03, 0, 0, 0, 0, 0, 0, 0, 0),
  (3, '2021-12-19','s³omkowy', 1, 7, 1.02, 0, 0, 0, 0, 0, 0, 0, 0);

INSERT INTO HistoriaWagi VALUES
	(4, 51, '2019-03-14'),
	(4, 56, '2020-11-21'),
	(4, 53, '2021-12-02');
  

-- WPROWADZENIE DANYCH PRZYK£ADOWYCH DO OBJAWÓW, CHORÓB PACJENTÓW

INSERT INTO Objawy VALUES
	(1,'obni¿enie nastroju'),
	(2,'problemy ze snem'),
	(3,'apatia'),
	(4,'myœli samobójcze'),
	(5,'halucynacje'),
	(6,'urojenia'),
	(7,'dr¿enie cia³a'),
	(8,'niepokój'),
	(9,'natrêtne myœli'),
	(10,'pobudzenie psychoruchowe'),
	(11,'agresja'),
	(12,'dezorganizacja myœlenia')
	;

INSERT INTO ObjawyPacjentow VALUES
(6, 8, '2020-10-12'),
(6, 10, '2020-10-14'),
(6, 11, '2020-10-14'),
(4, 9, '2020-11-21');

INSERT INTO Choroby VALUES 
	(1, 'Schizofrenia'),
	(2, 'Zaburzenia ze spektrum autyzmu'),
	(3, 'Depresja'),
	(4, 'Zaburzenie lêkowe'),
	(5, 'Choroba afektywna dwubiegunowa'),
	(6, 'PTSD'),
	(7, 'Zaburzenie osobowoœci'),
	(8, 'Otêpienie'),
	(9, 'Nadciœnienie'),
	(10, 'Cukrzyca'),
	(11, 'Miazdzyca'),
	(12, 'Oty³oœæ'),
	(13, 'Choroba Hashimoto'),
	(14, 'Bulimia');
  
INSERT INTO WszystkieChorobyPacjentow VALUES
  (1, 1),
  (1, 3),
  (2, 2),
  (4,14),
  (4, 7),
  (6, 12),
  (6, 11),
  (6, 10),
  (6, 6)

-- WPROWADZENIE DANYCH PRZYK£ADOWYCH DO KATEGORII, LEKÓW, PRODUCENTÓW LEKÓW, INTERAKCJI, OBJAWÓW UBOCZNYCH
INSERT INTO KategoriaLeku VALUES
	(1, 'SSRI-Antydepresanty'),
	(2, 'SNRI-Antydepresanty'),
	(3, 'Neuroleptyki'),
	(4, 'Stabilizator nastroju'),
	(5, 'Benzodiazepiny'),
	(6,'Agonista GABA'),
	(7,'Antagonista NMDA'),
	(8,'Antagonista receptora opioidowego');

INSERT INTO ProducenciLekow VALUES
  (1, 'Mylan', '225466400', 'reception@mylan.com', 'Canonsburg 15317 Pennsylvania', 'USA',0),
  (2, 'Sanofi Aventis', '330153774000', 'sanofiaventis@sanofi.com', '46 avenue de la Grande Armee 75017 Paris', 'France', 1),
  (3, 'Egis', '701238226399', 'egispharmaceuticals@egis.com', 'Kereszturi 1475 Budapest 10', 'Hungary', 1),
  (4, 'Lekam', '226358041','biuro@lekam.com', 'Jana Pawla II 80 Warszawa', 'Poland', 1),
  (5, 'Adamed', '422250556','recepcja@adamed.com', 'ul. Szkolna 33 Warszawa', 'Poland', 1),
  (6, 'Unia', '228501186','unia@uniapharm.com', 'ul. Chlodna 56 Warszawa', 'Poland', 1),
  (7, 'GSK', '35462910182', 'gskservices@gsk.com', 'Brentford 980', 'United Kingdom', 0),
  (8, 'Pfizer', '2127332323', 'pfizer@pfizer.com', '235 East 42nd Street NY', 'USA', 0),
  (9, 'Polfa Warszawa S.A.' ,'226913900','polfawarszawainfo@polfa.com', 'Karolkowa 22 Warszawa', 'Poland', 1),
  (10, 'Biofarm', '616651500', 'biofarm@biofarm.com', 'ul. Walbrzyska Poznan','Poland',1),
  (11, 'Accord','5852687605','info@accord.com', 'St, Paul 55108', 'USA', 0)
  
 INSERT INTO Leki VALUES
	(1,'Sertagen',NULL,1,1,'Sertralina',207),
	(2,'Bioxetin',NULL,2,1,'Fluoksytyna',378),
	(3,'Parogen',NULL,1,1,'Paroksytyna',154),
	(4, 'Velaxin',NULL,3,2,'Wenlafaksyna',79),
	(5, 'Olzapin', 2,4,3,'Olanzapina',601),
	(6,'Kwetaplex',2,5,3,'Kwetiapina',108),
	(7,'Solian',2,2,3,'Amisulpiryd',123),
	(8,'Haloperidol',1,6,3,'Haloperidol',396),
	(9,'Lithium Carbonicum',NULL,7,4,'Lit',221),
	(10,'Depakine Chrono',NULL,2,4,'Kwas Walproinowy',253),
	(11,'Xanax',NULL,8,5,'Alprazolam',99),
	(12,'Relanium',NULL,9,5,'Diazepam',138),
	(13,'Pregabalin',NULL,1,6,'Pregabalina',258),
	(14,'Biomentin',NULL,10,7,'Memantyna',43),
	(15,'Naltex',NULL,11,8,'Naltrexone',71);
  

-- WPROWADZENIE DANYCH PRZYK£ADOWYCH DO STRUKTURY, PRACOWNIKÓW SZPITALA

INSERT INTO Oddzialy VALUES 
  (1, 'Oddzia³ Ogólnopsychiatryczny', 1, 40),
  (2, 'Odzia³ Leczenia Alkoholowych Zespo³ów Abstynencyjnych', 2, 25),
  (3, 'Oddzia³ Rehabilitacyjny', 3, 50),
  (4, 'Oddzia³ Psychogeriatryczny', 4, 40),
  (5, 'Oddzia³ Psychiatryczny Dzieci i M³odzie¿y', 5, 40)
  
INSERT INTO TypZatrudnienia VALUES
	(0, 'umowa o pracê'),
	(1, 'umowa zlecenie')


INSERT INTO Pracownicy VALUES
('Artur', 'Adamski', 'M', '21122532233', 'Sekretarz', 'Licencjat', 4188, 1, '1971-06-24', '+48 534877196', 'ul. Rumiankowa 63/97', 'Chocianów'),
('Ignacy', 'Wasilewski', 'M', '57083193075', 'Sekretarz', 'NULL', 3490, 0, '1999-12-21', '+48 797751711', 'ul. Ogrodowa 48/84', 'Lubsko'),
('Zuzanna', 'Sikorska', 'K', '53060191083', 'Sekretarz', 'Licencjat', 4188, 0, '1988-08-12', '+48 885688847', 'ul. Na³kowskiej 71/79', 'Z¹bkowice Œl¹skie'),
('Edyta', 'Pawlak', 'K', '78032755689', 'Asystent Medyczny', 'Magister', 4886, 1, '2005-01-11', '+48 793318325', 'ul. Kasprowicza 4', 'G³ogów'),
('Ignacy', 'Wiœniewski', 'M', '33121072395', 'Diagnostyk Laboratoryjny', 'Magister', 5863, 0, '1992-05-12', '+48 695998770', 'ul. Krótka 42/19', 'Lubaczów'),
('Irena', 'Urbañska', 'K', '61051787302', 'Sekretarz', 'Licencjat', 4188, 0, '1989-09-02', '+48 696590301', 'ul. Modrzewiowa 122', 'Lewin Brzeski'),
('Arkadiusz', 'Wróbel', 'M', '59103180719', 'Sekretarz', 'NULL', 3490, 0, '1987-12-14', '+48 604344947', 'ul. Norwida 139/32', 'Kraków'),
('Daria', 'Pietrzak', 'K', '28102470363', 'Pielêgniarz', 'Doktor', 6282, 0, '1956-12-14', '+48 662895426', 'ul. Ko³³¹taja 146', 'Skwierzyna'),
('Jagoda', 'Janik', 'K', '49042850866', 'Sekretarz', 'Magister', 4886, 0, '1999-01-28', '+48 728795431', 'ul. Listopada 11', 'Pu³awy'),
('Patrycja', 'Nowakowska', 'K', '22071966401', 'Lekarz', 'Doktor Habilitowany', 16752, 0, '1983-04-09', '+48 513715220', 'ul. S³oneczna 60/64', 'Wa³brzych'),
('Wies³aw', 'Jab³oñski', 'M', '43100271952', 'Pielêgniarz', 'Doktor', 6282, 0, '2009-03-08', '+48 726928445', 'ul. Sportowa 90/105', 'Kowary'),
('Wies³aw', 'Lewandowski', 'M', '85062699597', 'Dyrektor', 'Doktor Habilitowany', 16752, 0, '2010-02-03', '+48 730613252', 'ul. Koœciuszki 37', 'Krasnystaw'),
('Rafa³', 'B³aszczyk', 'M', '55030567751', 'Lekarz', 'Doktor Habilitowany', 16752, 0, '1997-12-30', '+48 578861443', 'ul. Dolna 49', 'Nowogrodziec'),
('Renata', 'Kaczmarek', 'K', '39111193420', 'Dyrektor', 'Doktor Habilitowany', 16752, 0, '1978-10-18', '+48 509438098', 'ul. Cukrownicza 62/57', 'Tyczyn'),
('Weronika', 'KaŸmierczak', 'K', '37011533423', 'Diagnostyk Laboratoryjny', 'Magister', 5863, 0, '1971-11-22', '+48 603932642', 'ul. S³owackiego 29/92', 'Gryfów Œl¹ski'),
('S³awomir', 'Chmielewski', 'M', '54011148819', 'Pielêgniarz', 'Licencjat', 4188, 0, '1989-01-26', '+48 604124647', 'ul. Œwiêtos³awy 94', 'Nowy Targ'),
('Tomasz', 'Zalewski', 'M', '34061173414', 'Diagnostyk Laboratoryjny', 'Magister', 5863, 0, '1963-06-15', '+48 533604955', 'ul. Jesionowa 4/13', 'Kozienice'),
('Zofia', 'Jankowska', 'K', '44082491228', 'Pielêgniarz', 'Licencjat', 4188, 0, '2008-12-10', '+48 604027782', 'ul. Olimpijska 161/5', 'Ryglice'),
('Ewelina', 'Olszewska', 'K', '44080979722', 'Pielêgniarz', 'Licencjat', 4188, 0, '2004-12-26', '+48 789887524', 'ul. Turkusowa 30', 'Lubañ'),
('Bart³omiej', 'Zieliñski', 'M', '49091921052', 'Diagnostyk Laboratoryjny', 'Magister', 5863, 0, '1979-11-05', '+48 696468060', 'ul. Klonowa 13', 'Kudowa-Zdrój'),
('Wanda', 'Nowakowska', 'K', '25112574845', 'Pielêgniarz', 'Licencjat', 4188, 0, '1975-10-27', '+48 603085922', 'ul. Morcinka 98/52', 'Kroœniewice'),
('Andrzej', 'Zieliñski', 'M', '58071338777', 'Pielêgniarz', 'NULL', 3490, 0, '1983-07-31', '+48 729075387', 'ul. Hawrysza 14', 'Solec Kujawski'),
('Jolanta', 'Soko³owska', 'K', '65122828989', 'Sekretarz', 'NULL', 3490, 0, '2005-02-26', '+48 534266245', 'ul. Zamkowa 38', '£êczyca'),
('Oliwier', 'KaŸmierczak', 'M', '29082391297', 'Pielêgniarz', 'Magister', 4886, 0, '2003-03-24', '+48 508451847', 'ul. Barbary 82/41', 'Lubniewice'),
('Mieczys³aw', 'Kucharski', 'M', '21112237335', 'Dietetyk', 'Doktor', 7538, 0, '1966-01-09', '+48 788505853', 'ul. Kasprowicza 90/28', 'Be³¿yce'),
('Henryk', 'Dudek', 'M', '27011622670', 'Diagnostyk Laboratoryjny', 'Licencjat', 5025, 0, '1966-10-05', '+48 601967384', 'ul. Mietkowska 1/83', '¯ary'),
('Justyna', 'Baran', 'K', '78110922042', 'Dyrektor', 'Doktor Habilitowany', 16752, 0, '2008-11-30', '+48 534137881', 'ul. Hirszfelda 46/117', 'Oborniki Œl¹skie'),
('Wiktoria', 'Szymañska', 'K', '75092177901', 'Diagnostyk Laboratoryjny', 'Magister', 5863, 0, '2007-09-14', '+48 789770745', 'ul. G³ogowska 15/119', 'Krapkowice'),
('Sabina', 'Borowska', 'K', '63080725560', 'Sekretarz', 'Licencjat', 4188, 1, '1996-05-04', '+48 503113236', 'ul. Kwiatowa 172/63', 'M³awa'),
('Karolina', 'Kubiak', 'K', '35121249643', 'Asystent Medyczny', 'Doktor', 6282, 1, '1987-12-09', '+48 791303142', 'ul. Morcinka 54', 'Radomsko'),
('Karol', 'Adamczyk', 'M', '72042852415', 'Pielêgniarz', 'Licencjat', 4188, 0, '2008-03-10', '+48 795213063', 'ul. Partyzantów 93/21', 'Dêbica'),
('Angelika', 'Kucharska', 'K', '77112539120', 'Pielêgniarz', 'Licencjat', 4188, 0, '2005-10-02', '+48 507836622', 'ul. Wêglowa 86/7', 'Kowalewo Pomorskie'),
('Agata', 'Olszewska', 'K', '82112817769', 'Pielêgniarz', 'NULL', 3490, 0, '2009-09-21', '+48 605192273', 'ul. Morelowa 173/12', 'O¿arów Mazowiecki'),
('Cezary', 'Jakubowski', 'M', '61020878411', 'Pielêgniarz', 'NULL', 3490, 0, '2009-03-07', '+48 576233049', 'ul. Staromiejska 40/103', 'Chodecz'),
('S³awomir', 'Lewandowski', 'M', '76031064511', 'Sekretarz', 'Licencjat', 4188, 0, '2010-07-14', '+48 511440841', 'ul. Piwna 63/5', 'W³oc³awek'),
('Wojciech', 'Michalak', 'M', '58120243937', 'Dietetyk', 'Doktor', 7538, 0, '1991-02-20', '+48 505417795', 'ul. Wodna 172', 'Janowiec Wielkopolski'),
('Franciszek', 'Kubiak', 'M', '62041464636', 'Diagnostyk Laboratoryjny', 'Licencjat', 5025, 0, '1993-11-02', '+48 734063672', 'ul. G³ogowska 41/60', 'Rabka-Zdrój'),
('Klaudia', 'Kaczmarczyk', 'K', '82030517264', 'Lekarz', 'Doktor', 12564, 0, '2007-02-08', '+48 722424740', 'ul. Polna 47/94', 'Œwiebodzin'),
('Laura', 'Janik', 'K', '30061596345', 'Pielêgniarz', 'Doktor', 6282, 0, '1963-02-05', '+48 570635904', 'ul. Osiedle 23/11', 'Bobowa'),
('Hubert', 'Kaczmarek', 'M', '83120578156', 'Lekarz', 'Doktor Habilitowany', 16752, 0, '2009-04-28', '+48 729679285', 'ul. Lipowa 31/74', 'Bochnia'),
('Dominik', 'Brzeziñski', 'M', '66013053835', 'Pielêgniarz', 'Licencjat', 4188, 0, '1995-01-14', '+48 694352768', 'ul. Sybiraków 55', 'Koronowo'),
('Marcelina', 'Sikora', 'K', '52061963602', 'Sekretarz', 'NULL', 3490, 0, '1989-12-06', '+48 513949105', 'ul. Szpitalna 100/54', 'Gostynin'),
('Antoni', 'Sadowski', 'M', '72072177878', 'Dietetyk', 'Doktor', 7538, 0, '2003-01-31', '+48 724093224', 'ul. Widokowa 163/88', 'Toruñ'),
('Aleksandra', 'Adamska', 'K', '31070160501', 'Asystent Medyczny', 'Licencjat', 4188, 1, '1998-10-07', '+48 881531167', 'ul. Poprzeczna 21', 'Tyczyn'),
('Katarzyna', 'Brzeziñska', 'K', '27103170920', 'Sekretarz', 'Magister', 4886, 0, '1983-11-17', '+48 736104841', 'ul. Samborska 147/52', 'Milanówek'),
('Wojciech', 'Adamczyk', 'M', '66092885510', 'Dyrektor', 'Doktor', 12564, 0, '2002-07-27', '+48 532438866', 'ul. Skalna 15/25', 'Piotrków Kujawski'),
('Beata', 'Dudek', 'K', '61112722888', 'Dietetyk', 'Doktor', 7538, 0, '1987-11-24', '+48 885593450', 'ul. Saneczkowa 80/32', 'Lubieñ Kujawski'),
('Dominik', 'Dudek', 'M', '42071432838', 'Lekarz', 'Doktor', 12564, 0, '1972-06-08', '+48 887706574', 'ul. Stroma 88/4', 'Wolbrom');

-- WPROWADZENIE DANYCH PRZYK£ADOWYCH DO POBYTÓW PACJENTÓW W SZPITALU

-- WPROWADZENIE DANYCH PRZYK£ADOWYCH DO STRATEGII LECZENIA
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- WYKONAÆ PRZED DODANIEM TRIGGERÓW!!!!!!!!!!!!!!!!!!!!
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
INSERT INTO AktualneStrategieLeczenia VALUES
(62, 11, 1, '70', 26, 1, '2012-12-19'),
(38, 12, 4, '88', 28, 1, '2010-04-27'),
(15, 13, 7, '108', 30, 2, '2020-11-23'),
(66, 14, 10, '130', 32, 4, '2022-09-02'),
(42, 1, 13, '154', 34, 2, '2021-12-17'),
(18, 2, 1, '180', 36, 1, '2012-08-15'),
(69, 3, 4, '208', 38, 1, '2009-04-10'),
(69, 3, 4, '208', 38, 1, '2009-04-10'),
(46, 4, 7, '238', 40, 2, '2018-03-04'),
(22, 5, 10, '270', 42, 4, '2014-02-07'),
(72, 6, 13, '304', 34, 2, '2012-10-09'),
(49, 7, 1, '340', 36, 1, '2021-02-23'),
(26, 8, 4, '378', 30, 1, '2017-12-26'),
(62, 11, 1, '70', 26, 1, '2015-04-26'),
(38, 12, 4, '88', 28, 1, '2022-09-09'),
(15, 13, 7, '108', 30, 2, '2016-05-28'),
(66, 14, 10, '130', 32, 4, '2020-10-31'),
(42, 1, 13, '154', 34, 2, '2021-05-14'),
(18, 2, 1, '180', 36, 1, '2020-03-30'),
(69, 3, 4, '208', 38, 1, '2020-11-18'),
(46, 4, 7, '238', 40, 2, '2015-10-20'),
(22, 5, 10, '270', 2, 4, '2021-02-10'),
(72, 6, 13, '304', 4, 2, '2019-10-29'),
(49, 7, 1, '340', 6, 1, '2015-03-04'),
(26, 8, 4, '378', 8, 1, '2022-04-18'),
(2, 9, 7, '418', 10, 2, '2017-09-27'),
(52, 10, 10, '460', 12, 4, '2016-08-21'),
(29, 11, 13, '4', 14, 2, '2017-06-10'),
(6, 12, 1, '50', 16, 1, '2019-01-24'),
(56, 13, 4, '98', 18, 1, '2019-06-26'),
(32, 14, 7, '148', 20, 2, '2017-08-17'),
(9, 1, 10, '200', 22, 4, '2020-10-28'),
(60, 2, 13, '254', 24, 2, '2019-07-31'),
(36, 3, 1, '310', 26, 1, '2017-01-29'),
(12, 4, 4, '368', 28, 1, '2018-02-04'),
(63, 5, 7, '428', 30, 2, '2019-01-23'),
(40, 6, 10, '490', 32, 4, '2015-06-23'),
(16, 7, 13, '54', 34, 2, '2020-11-12'),
(66, 8, 1, '120', 36, 1, '2021-06-03'),
(43, 9, 4, '188', 38, 1, '2020-11-25'),
(20, 10, 7, '258', 40, 2, '2021-06-30'),
(70, 11, 10, '330', 2, 4, '2015-07-24'),
(46, 12, 13, '404', 4, 2, '2018-05-08'),
(23, 13, 1, '480', 6, 1, '2015-11-10'),
(74, 14, 4, '58', 8, 1, '2022-03-02'),
(50, 1, 7, '138', 10, 2, '2018-01-07'),
(26, 2, 10, '220', 12, 4, '2019-11-28'),
(3, 3, 13, '304', 14, 2, '2022-04-27'),
(54, 4, 1, '390', 16, 1, '2017-05-15'),
(30, 5, 4, '478', 18, 1, '2015-08-30'),
(6, 6, 7, '68', 20, 2, '2018-07-17'),
(57, 7, 10, '160', 22, 4, '2015-07-04'),
(34, 8, 13, '254', 24, 2, '2021-05-18'),
(10, 9, 1, '350', 26, 1, '2018-06-07'),
(60, 10, 4, '448', 28, 1, '2017-07-12'),
(37, 11, 7, '48', 30, 2, '2018-01-22'),
(14, 12, 10, '150', 32, 4, '2017-01-30'),
(64, 13, 13, '254', 34, 2, '2019-05-05'),
(40, 14, 1, '360', 36, 1, '2017-07-01'),
(17, 1, 4, '468', 38, 1, '2021-03-01'),
(68, 2, 7, '78', 40, 2, '2022-03-28'),
(44, 3, 10, '190', 2, 4, '2019-07-13'),
(20, 4, 13, '304', 4, 2, '2021-03-17')



INSERT INTO HistoriaStrategieLeczenia (ID, ID_Pacjenta, ID_Choroby, ID_Leku, DawkaLeku, LekarzProwadzacy, ID_Oddzialu, DataRozpoczecia, DataZakonczenia)
SELECT AktualneStrategieLeczenia.ID, AktualneStrategieLeczenia.ID_Pacjenta, AktualneStrategieLeczenia.ID_Choroby, AktualneStrategieLeczenia.ID_Leku, AktualneStrategieLeczenia.DawkaLeku, AktualneStrategieLeczenia.LekarzProwadzacy, AktualneStrategieLeczenia.ID_Oddzialu, AktualneStrategieLeczenia.DataRozpoczecia, NULL AS [DataZakonczenia]
FROM AktualneStrategieLeczenia
WHERE AktualneStrategieLeczenia.ID IN (1, 2, 3, 4, 5, 7, 8, 9, 12, 13 )

DELETE FROM AktualneStrategieLeczenia
WHERE ID IN (1, 2, 3, 4, 5, 7, 8, 9, 12, 13 )

UPDATE HistoriaStrategieLeczenia
SET DataZakonczenia = '2020-12-01'
WHERE ID = 1

UPDATE HistoriaStrategieLeczenia
SET DataZakonczenia = '2022-10-30'
WHERE ID = 2

UPDATE HistoriaStrategieLeczenia
SET DataZakonczenia = '2022-06-13'
WHERE ID = 3

UPDATE HistoriaStrategieLeczenia
SET DataZakonczenia = '2022-12-18'
WHERE ID = 4

UPDATE HistoriaStrategieLeczenia
SET DataZakonczenia = '2022-12-23'
WHERE ID = 5

UPDATE HistoriaStrategieLeczenia
SET DataZakonczenia = '2016-03-19'
WHERE ID = 7

UPDATE HistoriaStrategieLeczenia
SET DataZakonczenia = '2015-12-12'
WHERE ID = 8

UPDATE HistoriaStrategieLeczenia
SET DataZakonczenia = '2022-06-11'
WHERE ID = 9

UPDATE HistoriaStrategieLeczenia
SET DataZakonczenia = '2022-05-16'
WHERE ID = 12

UPDATE HistoriaStrategieLeczenia
SET DataZakonczenia = '2020-06-23'
WHERE ID = 13