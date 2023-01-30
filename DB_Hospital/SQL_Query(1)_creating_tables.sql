/* Tworzenie tabel

!!!1.!!!

TABLICE:
-- TWORZENIE PACJENTOW, KONTATKU DO PACJENTOW
-- TWORZENIE BADAÑ, WYNIKÓW, POMIARÓW PACJENTÓW
-- TWORZENIE OBJAWÓW, CHORÓB PACJENTÓW
-- TWORZENIE KATEGORII, LEKÓW, PRODUCENTÓW LEKÓW, INTERAKCJI, OBJAWÓW UBOCZNYCH
-- TWORZENIE STRUKTURY, PRACOWNIKÓW SZPITALA
-- TWORZENIE POBYTÓW PACJENTÓW W SZPITALU
-- TWORZENIE STRATEGII LECZENIA

Pacjenci [x], DaneKontaktowe [x],

BadanieMoczu [x], BadanieKrwi  [x], HistoriaWagi [x], WynikiDanychPsychologicznych [x]

Choroby [x], WszystkieChorobyPacjentow  [x],
Objawy [x], ObjawyPacjentow [x],

KategoriaLeku [x], Leki [x], ProducenciLekow [x], InterakcjeLekowe [x], ObjawyUboczneLekow [x], 

Oddzialy [x],
Pracownicy [x],
TypZatrudnienia [x]

Pobyty [x],

StrategieLeczenia [x]  (AktualneStrategieLeczenia [x], HistoriaStrategieLeczenia [x])
*/
-- TWORZENIE PACJENTOW, KONTATKU DO PACJENTOW


--DROP TABLES w dobrej kolejnosci:

/*
DROP TABLE HistoriaStrategieLeczenia 
DROP TABLE AktualneStrategieLeczenia
DROP TABLE Pobyty 
DROP TABLE Pracownicy 
DROP TABLE TypZatrudnienia 
DROP TABLE Oddzialy
DROP TABLE ObjawyUboczneLekow 
DROP TABLE InterakcjeLekowe 
DROP TABLE Leki
DROP TABLE ProducenciLekow 
DROP TABLE KategoriaLeku 
DROP TABLE ObjawyPacjentow
DROP TABLE Objawy 
DROP TABLE WszystkieChorobyPacjentow  
DROP TABLE Choroby
DROP TABLE WynikiDanychPsychologicznych
DROP TABLE HistoriaWagi 
DROP TABLE BadanieKrwi  
DROP TABLE BadanieMoczu 
DROP TABLE DaneKontaktowe 
DROP TABLE Pacjenci 
*/


CREATE TABLE Pacjenci (
 	ID INT PRIMARY KEY IDENTITY(1,1),
 	Imie VARCHAR(255),
 	Nazwisko VARCHAR(255),
 	Plec CHAR(1),
 	DataUrodzenia DATE,
 	Pesel VARCHAR(11),
 	Palenie BIT,
 	Wzrost INT,
 );
 
 CREATE TABLE DaneKontaktowe (
	ID_Osoby INT IDENTITY(1,1),
	ID_Pacjenta INT,
	NumerKontaktowy VARCHAR(255),
	EMAIL VARCHAR(255),
	Adres VARCHAR(255),
	Miasto VARCHAR(255),
	Kraj VARCHAR(255),
	PRIMARY KEY (ID_Osoby, ID_Pacjenta),
	FOREIGN KEY(ID_Pacjenta) REFERENCES Pacjenci(ID)
);
 
-- TWORZENIE BADAÑ, WYNIKÓW, POMIARÓW PACJENTÓW
CREATE TABLE BadanieMoczu (
	ID_Pacjenta INT,
	DataBadania DATE,
	Barwa VARCHAR(255),
	Klarownosc BIT,
	OdczynPh FLOAT,
	CiezarMoczu FLOAT,
	Leukocyty BIT,
	Hemoglobina BIT,
	Bilirubina BIT,
	Urobilinogen BIT,
	Bialko BIT,
	Glukoza BIT,
	Ketony BIT,
	Azotyny BIT,
	PRIMARY KEY (ID_Pacjenta, DataBadania),
	FOREIGN KEY (ID_Pacjenta) REFERENCES Pacjenci(ID)
);

CREATE TABLE BadanieKrwi (
	ID_Pacjenta INT,
	DataBadania DATETIME,
	Erytrocyty FLOAT,
	Leukocyty FLOAT,
	Hemoglobina FLOAT,
	Hematokryt FLOAT,
	PlytkiKrwi FLOAT,
	Glukoza FLOAT,
	PRIMARY KEY (ID_Pacjenta, DataBadania),
	FOREIGN KEY (ID_Pacjenta) REFERENCES Pacjenci(ID)
);

CREATE TABLE HistoriaWagi (
	ID_Pacjenta INT,
	Waga INT,
	DataPomiaru DATE,
	PRIMARY KEY (ID_Pacjenta, DataPomiaru),
	FOREIGN KEY(ID_Pacjenta) REFERENCES Pacjenci(ID)
);

CREATE TABLE WynikiDanychPsychologicznych (
	ID_Pacjenta INT,
	Data DATE,
	TestBECCA INT,
	SkalaYOUNGA INT,
	TestMMPI2 INT,
	TestDUDIT INT,
	SkalaAUDIT INT,
	SkalaPANNS INT,
	PRIMARY KEY (ID_Pacjenta, Data),
	FOREIGN KEY(ID_Pacjenta) REFERENCES Pacjenci(ID),
);

-- TWORZENIE OBJAWÓW, CHORÓB PACJENTÓW

CREATE TABLE Choroby (
 	ID INT PRIMARY KEY,
 	NazwaChoroby VARCHAR(255)
 );

CREATE TABLE WszystkieChorobyPacjentow (
 	ID_Pacjenta INT,
 	ID_Choroby INT,
 	PRIMARY KEY (ID_Pacjenta, ID_Choroby),
 	FOREIGN KEY(ID_Pacjenta) REFERENCES Pacjenci(ID),
 	FOREIGN KEY(ID_Choroby) REFERENCES Choroby(ID),
 );
 
 CREATE TABLE Objawy (
	ID INT PRIMARY KEY,
	NazwaObjawu VARCHAR(255),
);

CREATE TABLE ObjawyPacjentow (
	ID_Pacjenta INT,
	ID_Objawu INT,
	DataWystapienia DATE,
	PRIMARY KEY (ID_Pacjenta, ID_Objawu),
	FOREIGN KEY(ID_Pacjenta) REFERENCES Pacjenci(ID),
	FOREIGN KEY(ID_Objawu) REFERENCES Objawy(ID),
);

-- TWORZENIE KATEGORII, LEKÓW, PRODUCENTÓW LEKÓW, INTERAKCJI, OBJAWÓW UBOCZNYCH
CREATE TABLE KategoriaLeku(
	IdKategorii INT Primary key,
	NazwaKategorii VARCHAR(256)
);

CREATE TABLE ProducenciLekow (
	ID INT PRIMARY KEY,
	Nazwa VARCHAR(256),
	NumerKontaktowy VARCHAR(256),
	Email VARCHAR(255),
	Adres VARCHAR(255),
	Kraj VARCHAR(255),
	UE BIT,
 );

CREATE TABLE Leki (
 	ID INT PRIMARY KEY,
 	NazwaLeku VARCHAR(255),
 	Generacja INT,
 	Producent INT,
 	Kategoria INT,
 	SubstancjaCzynna VARCHAR(255),
 	IloscLekuNaStanie INT,
 	FOREIGN KEY(Kategoria) REFERENCES KategoriaLeku(IdKategorii),
	FOREIGN KEY(Producent) REFERENCES ProducenciLekow(ID),
 );

 
CREATE TABLE InterakcjeLekowe (
	ID_LEK_1 INT,
	ID_LEK_2 INT,
	TypInterakcji VARCHAR(255),
	PRIMARY KEY (ID_LEK_1, ID_LEK_2),
	FOREIGN KEY(ID_LEK_1) REFERENCES LEKI(ID),
	FOREIGN KEY(ID_LEK_2) REFERENCES LEKI(ID)
);


CREATE TABLE ObjawyUboczneLekow (
	ID_LEK INT,
	ObjawUboczny VARCHAR(255),
	PRIMARY KEY (ID_LEK, ObjawUboczny),
	FOREIGN KEY(ID_LEK) REFERENCES LEKI(ID),
);


-- TWORZENIE STRUKTURY, PRACOWNIKÓW SZPITALA

CREATE Table Oddzialy(
	IdOddzialu INT Primary key,
	NazwaOddzialy VARCHAR(256),
	Kierownik INT,
	LiczbaMiejsc INT
);

CREATE TABLE TypZatrudnienia (
	ID INT PRIMARY KEY,
	Nazwa VARCHAR(256)
);

CREATE TABLE Pracownicy (
 	ID INT PRIMARY KEY IDENTITY(1,1),
 	Imie VARCHAR(256),
 	Nazwisko VARCHAR(256),
	Plec CHAR(1),
	PESEL VARCHAR(11),
 	Stanowisko VARCHAR(256),
 	StopienNaukowy VARCHAR(256),
 	Wyplata MONEY,
 	ID_typZatrudnienia INT,
 	DataZatrudnienia DATE,
 	NrKontaktowy VARCHAR(256),
 	Adres VARCHAR(256),
 	Miasto VARCHAR(256),
	FOREIGN KEY(ID_typZatrudnienia) REFERENCES TypZatrudnienia(ID)
 );
 
-- TWORZENIE POBYTÓW PACJENTÓW W SZPITALU

CREATE TABLE Pobyty (
	ID_pacjenta INT,
	DataPrzyjecia DATE,
	DataWypisu DATE,
	PRIMARY KEY (ID_Pacjenta, DataPrzyjecia),
	FOREIGN KEY(ID_Pacjenta) REFERENCES Pacjenci(ID),
	CHECK (DataWypisu>DataPrzyjecia)
);


-- TWORZENIE STRATEGII LECZENIA

-- TWORZENIE STRATEGII LECZENIA

/*
CREATE TABLE StrategieLeczenia (
	ID INT PRIMARY KEY IDENTITY(1,1),
	ID_Pacjenta INT,
	ID_Choroby INT,
	ID_Leku INT,
	DawkaLeku VARCHAR(255),
	LekarzProwadzacy INT,
	ID_Oddzialu INT,
	DataRozpoczecia DATE,
	DataZakonczenia DATE,
	FOREIGN KEY(ID_Pacjenta) REFERENCES Pacjenci(ID),
	FOREIGN KEY(ID_Choroby) REFERENCES Choroby(ID),
	FOREIGN KEY(ID_Leku) REFERENCES Leki(ID),
	FOREIGN KEY(LekarzProwadzacy) REFERENCES Pracownicy(ID),
	FOREIGN KEY(ID_Oddzialu) REFERENCES Oddzialy(IdOddzialu),
);

*/
--DROP TABLE  AktualneStrategieLeczenia

CREATE TABLE AktualneStrategieLeczenia (
	ID INT PRIMARY KEY IDENTITY(1,1),
	ID_Pacjenta INT,
	ID_Choroby INT,
	ID_Leku INT,
	DawkaLeku VARCHAR(255),
	LekarzProwadzacy INT,
	ID_Oddzialu INT,
	DataRozpoczecia DATE,
	FOREIGN KEY(ID_Pacjenta) REFERENCES Pacjenci(ID),
	FOREIGN KEY(ID_Choroby) REFERENCES Choroby(ID),
	FOREIGN KEY(ID_Leku) REFERENCES Leki(ID),
	FOREIGN KEY(LekarzProwadzacy) REFERENCES Pracownicy(ID),
	FOREIGN KEY(ID_Oddzialu) REFERENCES Oddzialy(IdOddzialu),
);

CREATE TABLE HistoriaStrategieLeczenia (
	ID INT PRIMARY KEY,
	ID_Pacjenta INT,
	ID_Choroby INT,
	ID_Leku INT,
	DawkaLeku VARCHAR(255),
	LekarzProwadzacy INT,
	ID_Oddzialu INT,
	DataRozpoczecia DATE,
	DataZakonczenia DATE,
	FOREIGN KEY(ID_Pacjenta) REFERENCES Pacjenci(ID),
	FOREIGN KEY(ID_Choroby) REFERENCES Choroby(ID),
	FOREIGN KEY(ID_Leku) REFERENCES Leki(ID),
	FOREIGN KEY(LekarzProwadzacy) REFERENCES Pracownicy(ID),
	FOREIGN KEY(ID_Oddzialu) REFERENCES Oddzialy(IdOddzialu),
);