-- TWORZENIE WYZWALACZY (5)

--#1
-- info o update'owaniu pobytów w szpitalu 

CREATE TRIGGER TR_UPDATE_Pobyty ON Pobyty
AFTER UPDATE
AS
PRINT 'Zmodyfikowanio zawartość danych na temat pobytów pacjentów w szpitalu.'
SELECT * FROM deleted
SELECT * FROM inserted
GO


--#2
-- info o dodaniu nowych pracowników szpitala

GO
CREATE TRIGGER TR_INSERT_Pracownicy ON Pracownicy
AFTER INSERT
AS
PRINT 'Dodano nowego pracownika szpitala.'
SELECT * FROM inserted
GO


--#3
-- info o dodaniu nowych diagnoz dla pacjentów

GO
CREATE TRIGGER TR_INSERT_WszystkieChorobyPacjentow ON WszystkieChorobyPacjentow
AFTER INSERT
AS
PRINT 'Dodano nową diagnozę.'
SELECT * FROM inserted
GO


--#4
-- info o dodaniu strategii leczenia

GO
CREATE TRIGGER TR_INSERT_StrategieLeczenia ON StrategieLeczenia
AFTER INSERT
AS
PRINT 'Dodano nową strategię leczenia pacjenta.'
SELECT * FROM inserted
GO
