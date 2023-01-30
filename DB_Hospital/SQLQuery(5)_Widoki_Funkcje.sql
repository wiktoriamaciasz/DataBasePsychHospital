/* Dodawanie FUNKCJI/WIDOKÓW

!!!5.!!!
*/

-- WIDOK PRACOWNIKÓW KTÓRZY S¥ MEDYCZNI
GO
CREATE VIEW vw_Pracownicy_Medyczni AS
SELECT * FROM Pracownicy
WHERE Stanowisko IN ('Lekarz', 'Pielêgniarz', 'Diagnostyk Laboratoryjny', 'Asystent Medyczny')
GO

-- WIDOK PRACOWNIKÓW KTÓRZY S¥ BIUROWI

Go
CREATE VIEW vw_Pracownicy_Biurowi AS
SELECT * FROM Pracownicy
WHERE Stanowisko IN ('Sekretarz', 'Dyrektor')
GO

-- WIDOK PRACOWNIKÓW KTÓRZY S¥ DIETETYKAMI
Go
CREATE VIEW vw_Dietetycy AS
SELECT * FROM Pracownicy
WHERE Stanowisko IN ('Dietetyk')
GO

/* FUNKCJA WYLICZAJ¥CA WIEK PACJENTA
*/

IF OBJECT_ID('ObliczWiek','FN') IS NOT NULL
    DROP FUNCTION ObliczWiek
GO
Create function ObliczWiek(@idpacjenta INT) 
returns int 
as 
Begin 
    DECLARE @DataUro DATE
    SET @DataUro = (SELECT DataUrodzenia FROM Pacjenci WHERE ID =  @idpacjenta)
	IF MONTH(@DataUro) = MONTH(getdate()) and day(@DataUro)>day(getdate()) 
		return datediff(MONTH,@DataUro, getdate())/12 - 1
	return datediff(MONTH,@DataUro, getdate())/12
End
GO

/*
WIDOK PODAJ¥CY INFORMACJE O DNIACH POBYTU W SZPITALU I LICZBIE HOSPITALIZACJI
*/
GO
CREATE VIEW Info_Pobyty AS
SELECT *,
	datediff(dd,DataPrzyjecia,DataWypisu) AS Dni,
    COUNT(*) OVER (PARTITION BY ID_pacjenta
		order by DataPrzyjecia
        RANGE BETWEEN unbounded preceding AND unbounded following) [Liczba pobytów ogó³em] 
FROM Pobyty
GO



/*
WIDOK INFORMUJ¥CY O WYPE£NIENIU ODDZIALÓW SZPITALNYCH PRZEZ PACJENTÓW
*/
GO
CREATE VIEW DostepneMiejscaNaOddzialach AS
select count(*) as LiczbaOsobNaOddziale , t1.LiczbaWszystkichMiejsc, (t1.LiczbaWszystkichMiejsc-count(*)) AS PozostaleMiejsca ,t1.NazwaOddzialu from
(select ID_Pacjenta, o.IdOddzialu as ID_Oddzialu, MIN(o.NazwaOddzialy) AS NazwaOddzialu, MIN(o.LiczbaMiejsc) AS LiczbaWszystkichMiejsc
from StrategieLeczenia sl inner join oddzialy o
on o.IdOddzialu = sl.Id_Oddzialu
where DataZakonczenia is null
group by id_pacjenta, o.IdOddzialu) as t1
group by t1.ID_Oddzialu, t1.NazwaOddzialu, t1.LiczbaWszystkichMiejsc
GO


/*
WIDOK pokazuj¹cy lekarzy i ich wszystkich pacjentow
*/
GO
CREATE VIEW vw_Pacjenci_Lekarzy AS
SELECT Pracownicy.Imie AS [Imie Lekarza], Pracownicy.Nazwisko [Nazwisko Lekarza], Pracownicy.Stanowisko, Pracownicy.StopienNaukowy, '=>' AS Leczy, Pacjenci.Imie [Imie Pacjenta], Pacjenci.Nazwisko [Nazwisko Pacjenta], Pacjenci.Pesel [PESEL Pacjenta], StrategieLeczenia.DataRozpoczecia, StrategieLeczenia.DataZakonczenia
FROM Pracownicy RIGHT JOIN StrategieLeczenia ON Pracownicy.ID = StrategieLeczenia.LekarzProwadzacy INNER JOIN Pacjenci ON StrategieLeczenia.ID_Pacjenta = Pacjenci.ID
GO

/*
WIDOK pokazuj¹cy lekarzy i ich obecnych pacjentow
*/
GO
CREATE VIEW vw_Pacjenci_Lekarzy_AKT AS
SELECT Pracownicy.Imie AS [Imie Lekarza], Pracownicy.Nazwisko [Nazwisko Lekarza], Pracownicy.Stanowisko, Pracownicy.StopienNaukowy, '=>' AS Leczy, Pacjenci.Imie [Imie Pacjenta], Pacjenci.Nazwisko [Nazwisko Pacjenta], Pacjenci.Pesel [PESEL Pacjenta], AktualneStrategieLeczenia.DataRozpoczecia
FROM Pracownicy RIGHT JOIN AktualneStrategieLeczenia ON Pracownicy.ID = AktualneStrategieLeczenia.LekarzProwadzacy INNER JOIN Pacjenci ON AktualneStrategieLeczenia.ID_Pacjenta = Pacjenci.ID
GO

/*
FUNKCJA pokazuj¹ca lekarza i jego obecnych pacjentów
*/
IF OBJECT_ID('f_Pacjenci_Lekarza','IF') IS NOT NULL
    DROP FUNCTION f_Pacjenci_Lekarza

GO
CREATE FUNCTION f_Pacjenci_Lekarza ( @imie VARCHAR(256), @nazwisko VARCHAR(256) )
RETURNS table
AS
RETURN
(
SELECT Pracownicy.Imie AS [Imie Lekarza], Pracownicy.Nazwisko [Nazwisko Lekarza], Pracownicy.Stanowisko, Pracownicy.StopienNaukowy, '=>' AS Leczy, Pacjenci.Imie [Imie Pacjenta], Pacjenci.Nazwisko [Nazwisko Pacjenta], Pacjenci.Pesel [PESEL Pacjenta], AktualneStrategieLeczenia.DataRozpoczecia
FROM Pracownicy RIGHT JOIN AktualneStrategieLeczenia ON Pracownicy.ID = AktualneStrategieLeczenia.LekarzProwadzacy INNER JOIN Pacjenci ON AktualneStrategieLeczenia.ID_Pacjenta = Pacjenci.ID
WHERE Pracownicy.ID IN (

SELECT Pracownicy.ID FROM Pracownicy
WHERE Pracownicy.Imie = @imie AND Pracownicy.Nazwisko = @nazwisko

)

)
GO

/*
FUNKCJA pokazuj¹ca lekarza i historiê jego pacjentów
*/
IF OBJECT_ID('f_Historia_Pacjentów_Lekarza','IF') IS NOT NULL
    DROP FUNCTION f_Historia_Pacjentów_Lekarza

GO
CREATE FUNCTION f_Historia_Pacjentów_Lekarza ( @imie VARCHAR(256), @nazwisko VARCHAR(256) )
RETURNS table
AS
RETURN
(
SELECT Pracownicy.Imie AS [Imie Lekarza], Pracownicy.Nazwisko [Nazwisko Lekarza], Pracownicy.Stanowisko, Pracownicy.StopienNaukowy, '=>' AS Leczy, Pacjenci.Imie [Imie Pacjenta], Pacjenci.Nazwisko [Nazwisko Pacjenta], Pacjenci.Pesel [PESEL Pacjenta], HistoriaStrategieLeczenia.DataRozpoczecia, HistoriaStrategieLeczenia.DataZakonczenia
FROM Pracownicy RIGHT JOIN HistoriaStrategieLeczenia ON Pracownicy.ID = HistoriaStrategieLeczenia.LekarzProwadzacy INNER JOIN Pacjenci ON HistoriaStrategieLeczenia.ID_Pacjenta = Pacjenci.ID
WHERE Pracownicy.ID IN (

SELECT Pracownicy.ID FROM Pracownicy
WHERE Pracownicy.Imie = @imie AND Pracownicy.Nazwisko = @nazwisko

)

)
GO


/*
Widok zwracaj¹cy czêstoœæ wystêpowania danych jednostek chorobowych w szpitalu
*/
GO
CREATE VIEW CzestoscWystepowaniaJednostekChoorbowych AS
SELECT COUNT(*) AS [Liczba Pacjentów], NazwaChoroby [Nazwa Choroby] FROM Pacjenci P
INNER JOIN 
WszystkieChorobyPacjentow WCP ON P.ID = WCP.ID_Pacjenta
INNER JOIN
Choroby C ON WCP.ID_Choroby=C.ID
GROUP BY NazwaChoroby
GO

/*
Widok ilustruj¹cy najpopularniejsze leki u¿ywane przez lekarzy w terapii pacjentów w danym szpitalu
*/
GO
CREATE VIEW UzycieLekow AS
SELECT P.ID, P.Imie, P.Nazwisko, L.NazwaLeku, COUNT(NazwaLeku) Iloœæ FROM Pracownicy P
INNER JOIN StrategieLeczenia SL
ON P.ID=SL.LekarzProwadzacy
INNER JOIN Leki L ON L.ID= SL.ID_LEKU 
WHERE P.Stanowisko = 'Lekarz'
GROUP BY P.Nazwisko, L.NazwaLeku, P.ID, P.Imie
GO


/*
FUNKCJA pokazuj¹ca pacjenta i jego obecnych lekarzy
*/
IF OBJECT_ID('f_Lekarze_Pacjenta','IF') IS NOT NULL
    DROP FUNCTION f_Lekarze_Pacjenta

GO
CREATE FUNCTION f_Lekarze_Pacjenta ( @imie VARCHAR(256), @nazwisko VARCHAR(256) )
RETURNS table
AS
RETURN
(
SELECT Pracownicy.Imie AS [Imie Lekarza], Pracownicy.Nazwisko [Nazwisko Lekarza], Pracownicy.Stanowisko, Pracownicy.StopienNaukowy, '=>' AS Leczy, Pacjenci.Imie [Imie Pacjenta], Pacjenci.Nazwisko [Nazwisko Pacjenta], Pacjenci.Pesel [PESEL Pacjenta], AktualneStrategieLeczenia.DataRozpoczecia
FROM Pracownicy RIGHT JOIN AktualneStrategieLeczenia ON Pracownicy.ID = AktualneStrategieLeczenia.LekarzProwadzacy INNER JOIN Pacjenci ON AktualneStrategieLeczenia.ID_Pacjenta = Pacjenci.ID
WHERE Pacjenci.ID IN (

SELECT Pacjenci.ID FROM Pacjenci
WHERE Pacjenci.Imie = @imie AND Pacjenci.Nazwisko = @nazwisko

)

)
GO

/*
FUNKCJA pokazuj¹ca pacjenta i jego historie lekarzy
*/
IF OBJECT_ID('f_Historia_Lekarzy_Pacjenta','IF') IS NOT NULL
    DROP FUNCTION f_Historia_Lekarzy_Pacjenta
GO
CREATE FUNCTION f_Historia_Lekarzy_Pacjenta ( @imie VARCHAR(256), @nazwisko VARCHAR(256) )
RETURNS table
AS
RETURN
(
SELECT Pracownicy.Imie AS [Imie Lekarza], Pracownicy.Nazwisko [Nazwisko Lekarza], Pracownicy.Stanowisko, Pracownicy.StopienNaukowy, '=>' AS Leczy, Pacjenci.Imie [Imie Pacjenta], Pacjenci.Nazwisko [Nazwisko Pacjenta], Pacjenci.Pesel [PESEL Pacjenta], HistoriaStrategieLeczenia.DataRozpoczecia, HistoriaStrategieLeczenia.DataZakonczenia
FROM Pracownicy RIGHT JOIN HistoriaStrategieLeczenia ON Pracownicy.ID = HistoriaStrategieLeczenia.LekarzProwadzacy INNER JOIN Pacjenci ON HistoriaStrategieLeczenia.ID_Pacjenta = Pacjenci.ID
WHERE Pacjenci.ID IN (

SELECT Pacjenci.ID FROM Pacjenci
WHERE Pacjenci.Imie = @imie AND Pacjenci.Nazwisko = @nazwisko

)

)
GO
