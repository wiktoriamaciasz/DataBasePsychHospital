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
