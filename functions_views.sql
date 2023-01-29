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