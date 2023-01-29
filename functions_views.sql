/* FUNKCJA WYLICZAJĄCA WIEK PACJENTA
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


/*
WIDOK PODAJĄCY INFORMACJE O DNIACH POBYTU W SZPITALU I LICZBIE HOSPITALIZACJI
*/
CREATE VIEW Info_Pobyty AS
SELECT *,
	datediff(dd,DataPrzyjecia,DataWypisu) AS Dni,
    COUNT(*) OVER (PARTITION BY ID_pacjenta
		order by DataPrzyjecia
        RANGE BETWEEN unbounded preceding AND unbounded following) [Liczba pobytów ogółem] 
FROM Pobyty




/*
WIDOK INFORMUJĄCY O WYPEŁNIENIU ODDZIALÓW SZPITALNYCH PRZEZ PACJENTÓW
*/
CREATE VIEW DostepneMiejscaNaOddzialach AS
select count(*) as LiczbaOsobNaOddziale , t1.LiczbaWszystkichMiejsc, (t1.LiczbaWszystkichMiejsc-count(*)) AS PozostaleMiejsca ,t1.NazwaOddzialu from
(select ID_Pacjenta, o.IdOddzialu as ID_Oddzialu, MIN(o.NazwaOddzialy) AS NazwaOddzialu, MIN(o.LiczbaMiejsc) AS LiczbaWszystkichMiejsc
from StrategieLeczenia sl inner join oddzialy o
on o.IdOddzialu = sl.Id_Oddzialu
where DataZakonczenia is null
group by id_pacjenta, o.IdOddzialu) as t1
group by t1.ID_Oddzialu, t1.NazwaOddzialu, t1.LiczbaWszystkichMiejsc

/*
WIDOK pokazujący lekarzy i ich obecnych pacjentow
*/
GO
CREATE VIEW vw_Pacjenci_Lekarzy AS
SELECT Pracownicy.Imie AS [Imie Lekarza], Pracownicy.Nazwisko [Nazwisko Lekarza], Pracownicy.Stanowisko, Pracownicy.StopienNaukowy, '=>' AS Leczy, Pacjenci.Imie [Imie Pacjenta], Pacjenci.Nazwisko [Nazwisko Pacjenta], Pacjenci.Pesel [PESEL Pacjenta]
FROM Pracownicy RIGHT JOIN StrategieLeczenia ON Pracownicy.ID = StrategieLeczenia.LekarzProwadzacy INNER JOIN Pacjenci ON StrategieLeczenia.ID_Pacjenta = Pacjenci.ID
GO


/*
FUNKCJA pokazująca lekarza i jego obecnych pacjentów
*/
GO
CREATE FUNCTION f_Pacjenci_Lekarza ( @imie VARCHAR(256), @nazwisko VARCHAR(256) )
RETURNS table
AS
RETURN
(
SELECT Pracownicy.Imie AS [Imie Lekarza], Pracownicy.Nazwisko [Nazwisko Lekarza], Pracownicy.Stanowisko, Pracownicy.StopienNaukowy, '=>' AS Leczy, Pacjenci.Imie [Imie Pacjenta], Pacjenci.Nazwisko [Nazwisko Pacjenta], Pacjenci.Pesel [PESEL Pacjenta]
FROM Pracownicy RIGHT JOIN StrategieLeczenia ON Pracownicy.ID = StrategieLeczenia.LekarzProwadzacy INNER JOIN Pacjenci ON StrategieLeczenia.ID_Pacjenta = Pacjenci.ID
WHERE Pracownicy.ID IN (

SELECT Pracownicy.ID FROM Pracownicy
WHERE Pracownicy.Imie = @imie AND Pracownicy.Nazwisko = @nazwisko

)

)
GO



/*
Widok zwracający częstość występowania danych jednostek chorobowych w szpitalu
*/

CREATE VIEW CzestoscWystepowaniaJednostekChoorbowych AS
SELECT COUNT(*) AS [Liczba Pacjentów], NazwaChoroby [Nazwa Choroby] FROM Pacjenci P
INNER JOIN 
WszystkieChorobyPacjentow WCP ON P.ID = WCP.ID_Pacjenta
INNER JOIN
Choroby C ON WCP.ID_Choroby=C.IDChoroby
GROUP BY NazwaChoroby

