-- WYZWALACZ INSTEAD OF DELETE
-- NA TABELI AktualneStrategie Leczenia
DROP TRIGGER TR_DELETE_AktualneStrategieLeczenia
GO
CREATE TRIGGER TR_DELETE_AktualneStrategieLeczenia ON AktualneStrategieLeczenia
INSTEAD OF DELETE
AS
	DECLARE @TEXT NVARCHAR(256)
	INSERT INTO HistoriaStrategieLeczenia (ID, ID_Pacjenta, ID_Choroby, ID_Leku, DawkaLeku, LekarzProwadzacy, ID_Oddzialu, DataRozpoczecia, DataZakonczenia)
	SELECT deleted.ID, deleted.ID_Pacjenta, deleted.ID_Choroby, deleted.ID_Leku, deleted.DawkaLeku, deleted.LekarzProwadzacy, deleted.ID_Oddzialu, deleted.DataRozpoczecia,  GETDATE() AS [DataZakonczenia]
	FROM deleted
	SET @TEXT = 'Dodano dzisiejszą datę zakończenia leczenia'
	PRINT(@TEXT)

	DELETE FROM AktualneStrategieLeczenia
	WHERE AktualneStrategieLeczenia.ID IN (SELECT deleted.ID FROM deleted)
GO
