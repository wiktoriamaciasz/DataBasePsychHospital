-- DROP EVERYTHING


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


DROP VIEW StrategieLeczenia
DROP VIEW Info_Pobyty
DROP VIEW DostepneMiejscaNaOddzialach
DROP FUNCTION ObliczWiek
DROP FUNCTION CheckPESEL
DROP VIEW vw_Pacjenci_Lekarzy
DROP FUNCTION f_Pacjenci_Lekarza
DROP VIEW UzycieLekow
DROP VIEW CzestoscWystepowaniaJednostekChoorbowych
DROP FUNCTION f_Lekarze_Pacjenta
/*
DROP TRIGGER TR_UPDATE_Pobyty
DROP TRIGGER TR_INSERT_Pracownicy
DROP TRIGGER TR_INSERT_WszystkieChorobyPacjentow
DROP TRIGGER TR_INSERT_StrategieLeczenia
DROP TRIGGER TR_UPDATE_DowstawcyLekow
DROP TRIGGER TR_INSERT_Pacjenci
DROP TRIGGER TR_UPDATE_Pacjenci
DROP TRIGGER TR_INSERT_Pracownicy
DROP TRIGGER TR_UPDATE_Pracownicy
*/
DROP PROC WynikiMoczu
DROP PROC WynikiKrwi
DROP PROC BMI
DROP PROC TestBecca
DROP PROC SkalaYOUNGA
DROP PROC SkalaAudit
DROP PROC DodajLeczenie
DROP PROC UzupelnijLeczenie
DROP PROC ZakonczLeczenie