-- TWORZENIE WYZWALACZY (5)

--#1
-- info o update'owaniu pobytów w szpitalu 
GO
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
CREATE TRIGGER TR_AFTER_INSERT_Pracownicy ON Pracownicy
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



/* Procedura zwracająca prawidłowość wyników krwi pacjentów - procedura bierze poprawkę na wyznaczone normy osobno dla mężczyzn i kobiet*/
GO
CREATE PROC WynikiKrwi (@id_pacjenta INT, @dataczas DATETIME) AS
	DECLARE @Erytrocyty FLOAT
	DECLARE @plec VARCHAR(256)
	SET @Erytrocyty = (SELECT Erytrocyty FROM BadanieKrwi WHERE ID_Pacjenta = @id_pacjenta AND DataBadania = @dataczas)
	SET @plec = (SELECT plec FROM Pacjenci WHERE ID = @id_pacjenta)
	IF (@Erytrocyty BETWEEN 3.5 AND 5.2 AND @plec='K') OR (@Erytrocyty BETWEEN 4.5 AND 5.4 AND @plec='M')
	PRINT('Liczba erytrocytów liczona w mln/mm3 - prawidłowa')
	ELSE
	PRINT('Liczba erytrocytów liczona w mln/mm3 - nieprawidłowa')	
	DECLARE @Leukocyty FLOAT
	SET @Leukocyty = (SELECT Leukocyty FROM BadanieKrwi WHERE ID_Pacjenta = @id_pacjenta AND DataBadania = @dataczas)
	IF @Leukocyty BETWEEN 4 AND 10
	PRINT('Liczba leukocytów liczona w tys./μl - prawidłowa')
	ELSE
	PRINT('Liczba leukocytów liczona w tys./μl - nieprawidłowa')
	DECLARE @Hemoglobina FLOAT
	SET @Hemoglobina = (SELECT Hemoglobina FROM BadanieKrwi WHERE ID_Pacjenta = @id_pacjenta AND DataBadania = @dataczas)
	IF (@Hemoglobina BETWEEN 12 AND 16 AND @plec='K') OR (@Hemoglobina BETWEEN 13 AND 18 AND @plec='M')
	PRINT('Ilość hemoglobiny liczona w g/dl - prawidłowa')
	ELSE
	PRINT('Ilość hemoglobiny liczona w g/dl - nieprawidłowa')	
	DECLARE @Hematokryt FLOAT
	SET @Hematokryt = (SELECT Hematokryt FROM BadanieKrwi WHERE ID_Pacjenta = @id_pacjenta AND DataBadania = @dataczas)
	IF (@Hematokryt BETWEEN 37 AND 47 AND @plec='K') OR (@Hematokryt BETWEEN 40 AND 50 AND @plec='M')
	PRINT('Hematokryt (%) prawidłowy')
	ELSE
	PRINT('Hematokryt (%) nieprawidłowy')	
	DECLARE @PlytkiKrwi FLOAT
	SET @PlytkiKrwi = (SELECT PlytkiKrwi FROM BadanieKrwi WHERE ID_Pacjenta = @id_pacjenta AND DataBadania = @dataczas)
	IF @PlytkiKrwi BETWEEN 150 AND 400
	PRINT('Liczba płytek krwi liczona w tys./μl - prawidłowa')
	ELSE
	PRINT('Liczba płytek krwi liczona w tys./μl - nieprawidłowa')
	DECLARE @Glukoza FLOAT
	SET @Glukoza = (SELECT Glukoza FROM BadanieKrwi WHERE ID_Pacjenta = @id_pacjenta AND DataBadania = @dataczas)
	IF @Glukoza BETWEEN 80 AND 140
	PRINT('Poziom glukozy (mg/dl) - prawidłowy')
	ELSE
	PRINT('Poziom glukozy (mg/dl) - nieprawidłowy')
GO


/*
Procedura oceniająca wyniki pacjenta w skali depresji Becca 
*/

GO
CREATE PROC TestBecca(@id_pacjenta INT, @data DATE) AS
    DECLARE @wynik INT
    SET @wynik = (SELECT TestBECCA FROM WynikiDanychPsychologicznych WHERE ID_Pacjenta = @id_pacjenta AND Data = @data)
    IF @wynik BETWEEN 0 AND 11
    PRINT 'brak depresji' 
    ELSE 
        IF @wynik BETWEEN 12 AND 19
        PRINT 'lekka depresja' 
        ELSE
            IF @wynik BETWEEN 20 AND 25
            PRINT 'umiarkowana depresja' 
            ELSE
                IF @wynik > 26 
                PRINT 'ciężka depresja' 
GO


/*
Procedura oceniająca epizod maniakalny w chorobie afektywnej dwubiegunowej za pomocą skali Younga
*/
GO
CREATE PROC SkalaYOUNGA(@id_pacjenta INT, @data DATE) AS
    DECLARE @wynik INT
    SET @wynik = (SELECT SkalaYounga FROM WynikiDanychPsychologicznych WHERE ID_Pacjenta = @id_pacjenta AND Data = @data)
    IF @wynik BETWEEN 0 AND 12
    PRINT 'remisja manii' 
    ELSE 
        IF @wynik BETWEEN 13 AND 19
        PRINT 'minimalne symptomy manii' 
        ELSE
            IF @wynik BETWEEN 20 AND 25
            PRINT 'hipomania' 
            ELSE
                IF @wynik BETWEEN 26 AND 37
                PRINT 'umiarkowana mania'
                ELSE
                    IF @wynik>37
                    PRINT 'ciężka mania'
GO


/*
Procedura oceniająca uzależnienie pacjenta od alkoholu z wykorzystaniem skali AUDIT
*/
GO
CREATE PROC SkalaAudit (@id_pacjenta INT, @data DATE) AS
    DECLARE @wynik INT
    SET @wynik = (SELECT SkalaAUDIT FROM WynikiDanychPsychologicznych WHERE ID_Pacjenta = @id_pacjenta AND Data = @data)
    IF @wynik >=8
    PRINT 'wskazane pogłębione badanie diagnostyczne u terapeuty uzależnień' 
    ELSE 
    PRINT 'wynik w normie' 
    RETURN @wynik
GO

/*
Procedura dodająca strategię leczenia dla danego pacjenta (imie, nazwisko, pesel) przypisując mu lekarza
*/
GO
CREATE PROC DodajLeczenie(@imie_pacj VARCHAR(256), @nazwisko_pacj VARCHAR(256), @pesel_pacj VARCHAR(11), @imie_lek VARCHAR(256), @nazw_lek VARCHAR(256), @pesel_lek VARCHAR(11))
AS
	BEGIN
		
		DECLARE @id_pacj INT
		SELECT @id_pacj = Pacjenci.ID FROM Pacjenci WHERE Pacjenci.PESEL = @pesel_pacj

		DECLARE @id_lek INT
		SELECT @id_lek = Pracownicy.ID FROM Pracownicy WHERE Pracownicy.PESEL = @pesel_lek

		INSERT INTO StrategieLeczenia VALUES
		( @id_pacj, NULL, NULL, NULL, @id_lek, NULL, GETDATE(), NULL )

		SELECT * FROM StrategieLeczenia
	END
GO

/*
Procedura wpisująca detale leczenia
*/
GO
CREATE PROC UzupelnijLeczenie ( @id_leczenia INT, @choroba VARCHAR(256), @lek VARCHAR(256), @dawka VARCHAR(256), @oddzial VARCHAR(256) )
AS
	BEGIN
		DECLARE @id_choroby INT
		SELECT @id_choroby = Choroby.ID FROM Choroby WHERE Choroby.NazwaChoroby = @choroba
		
		DECLARE @id_leku INT
		SELECT @id_leku = Leki.ID FROm Leki WHERE Leki.NazwaLeku = @lek

		DECLARE @id_oddzialu INT
		SELECT @id_oddzialu = Oddzialy.IdOddzialu FROm Oddzialy WHERE Oddzialy.NazwaOddzialy = @oddzial

		UPDATE StrategieLeczenia
		SET ID_Choroby = @id_choroby, ID_Leku = @id_leku, DawkaLeku = @dawka, ID_Oddzialu = @id_oddzialu
		WHERE ID = @id_leczenia

		SELECT * FROM StrategieLeczenia
	END
GO

/*
Procedura wpisująca datę końcową leczenia
*/
GO
CREATE PROC ZakonczLeczenie (@id_leczenia INT)
AS
	BEGIN
	DECLARE @TEXT VARCHAR(256)
	IF (SELECT DataZakonczenia FROM StrategieLeczenia WHERE StrategieLeczenia.ID = @id_leczenia) IS NULL BEGIN
		UPDATE StrategieLeczenia
		SET DataZakonczenia = GETDATE()
		WHERE ID = @id_leczenia
		SET @TEXT = 'Leczenie zakonczone'
		END
	ELSE
		SET @TEXT = 'Leczenie już było zakonczone'

	PRINT ( @TEXT )
	SELECT * FROM StrategieLeczenia
	END
GO

