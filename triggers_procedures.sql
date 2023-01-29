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



-- TWORZENIE PROCEDUR (5)
/* #1 Procedura wylicza BMI Pacjeta
*/
GO
create proc bmi (@idpacjenta int, @data date) as 
    declare @waga FLOAT
    set @waga = (select waga from HistoriaWagi where id_pacjenta = @idpacjenta and datapomiaru = @data)
    declare @wzrost FLOAT 
    set @wzrost = (select wzrost from Pacjenci where id = @idpacjenta)
    declare @bmi FLOAT
    set @bmi= (@waga)/POWER((@wzrost/100),2)
    return @bmi 
GO


/*
Procedura sprawdzająca prawidłowość wyniku z badania moczu pacjenta
*/

GO
CREATE PROC WynikiMoczu (@id_pacjenta INT, @data DATE) AS
	DECLARE @Barwa VARCHAR(256) 
	SET @Barwa = (SELECT Barwa FROM BadanieMoczu WHERE ID_Pacjenta = @id_pacjenta AND DataBadania = @data)
	IF @Barwa = 'słomkowy'
		PRINT 'Barwa moczu: Prawidłowa'
	ELSE
		PRINT 'Barwa moczu: Nieprawidłowa '
	DECLARE @Klarownosc BIT
	SET @Klarownosc = (SELECT Klarownosc FROM BadanieMoczu WHERE ID_Pacjenta = @id_pacjenta AND DataBadania = @data)
	IF @Klarownosc = 1
		PRINT 'Klarowność moczu: Mocz klarowny'
	ELSE
		PRINT 'Klarowność moczu: Mocz nieklarowny'
	DECLARE @OdczynPh FLOAT
	SET @OdczynPh = (SELECT OdczynPh FROM BadanieMoczu WHERE ID_Pacjenta = @id_pacjenta AND DataBadania = @data)
	IF @OdczynPh >4.5 AND @OdczynPh <8 
		PRINT 'Odczyn pH moczu: Prawidłowy'
	ELSE
		PRINT 'Odczyn pH moczu: Nierawidłowy'
	DECLARE @CiezarMoczu FLOAT
	SET @CiezarMoczu = (SELECT CiezarMoczu FROM BadanieMoczu WHERE ID_Pacjenta = @id_pacjenta AND DataBadania = @data)
	IF @CiezarMoczu >1.005 AND @CiezarMoczu <1.035
		PRINT 'Ciężar moczu: Prawidłowy'
	ELSE
		PRINT 'Ciężar moczu: Nierawidłowy'	
	DECLARE @Leukocyty BIT
	SET @Leukocyty = (SELECT Leukocyty FROM BadanieMoczu WHERE ID_Pacjenta = @id_pacjenta AND DataBadania = @data)
	IF @Leukocyty = 0
		PRINT 'Brak obecności leukocytów w moczu - wynik prawidłowy'
	ELSE
		PRINT 'Obecność leukocytów w moczu - wynik nieprawidłowy'
	DECLARE @Hemoglobina BIT
	SET @Hemoglobina = (SELECT Hemoglobina FROM BadanieMoczu WHERE ID_Pacjenta = @id_pacjenta AND DataBadania = @data)
	IF @Hemoglobina = 0
		PRINT 'Brak obecności hemoglobiny w moczu - wynik prawidłowy'
	ELSE
		PRINT 'Obecność hemoglobiny w moczu - wynik nieprawidłowy'
	DECLARE @Bilirubina BIT
	SET @Bilirubina = (SELECT Bilirubina FROM BadanieMoczu WHERE ID_Pacjenta = @id_pacjenta AND DataBadania = @data)
	IF @Bilirubina = 0
		PRINT 'Brak obecności bilirubiny w moczu - wynik prawidłowy'
	ELSE
		PRINT 'Obecność bilirubiny w moczu - wynik nieprawidłowy'
	DECLARE @Urobilinogen BIT
	SET @Urobilinogen = (SELECT Urobilinogen FROM BadanieMoczu WHERE ID_Pacjenta = @id_pacjenta AND DataBadania = @data)
	IF @Urobilinogen = 0
		PRINT 'Brak obecności urobilinogenu w moczu - wynik prawidłowy'
	ELSE
		PRINT 'Obecność urobilinogenu w moczu - wynik nieprawidłowy'
	DECLARE @Bialko BIT
	SET @Bialko = (SELECT Bialko FROM BadanieMoczu WHERE ID_Pacjenta = @id_pacjenta AND DataBadania = @data)
	IF @Bialko = 0
		PRINT 'Brak obecności białka w moczu - wynik prawidłowy'
	ELSE
		PRINT 'Obecność białka w moczu - wynik nieprawidłowy'
	DECLARE @Glukoza BIT
	SET @Glukoza = (SELECT Glukoza FROM BadanieMoczu WHERE ID_Pacjenta = @id_pacjenta AND DataBadania = @data)
	IF @Glukoza = 0
		PRINT 'Brak obecności glukozy w moczu - wynik prawidłowy'
	ELSE
		PRINT 'Obecność glukozy w moczu - wynik nieprawidłowy'
	DECLARE @Ketony BIT
	SET @Ketony = (SELECT Ketony FROM BadanieMoczu WHERE ID_Pacjenta = @id_pacjenta AND DataBadania = @data)
	IF @Ketony = 0
		PRINT 'Brak obecności ketonów w moczu - wynik prawidłowy'
	ELSE
		PRINT 'Obecność ketonów w moczu - wynik nieprawidłowy'
	DECLARE @Azotyny BIT
	SET @Azotyny = (SELECT Azotyny FROM BadanieMoczu WHERE ID_Pacjenta = @id_pacjenta AND DataBadania = @data)
	IF @Azotyny = 0
		PRINT 'Brak obecności azotynów w moczu - wynik prawidłowy'
	ELSE
		PRINT 'Obecność azotynów w moczu - wynik nieprawidłowy' 
GO


