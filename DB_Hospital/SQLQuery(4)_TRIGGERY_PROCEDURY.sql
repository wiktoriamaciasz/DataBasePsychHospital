/* Dodawanie TRIGGERÓW/PROCEDUR

!!!4.!!!
*/

-- FUNKCJA SPRAWDZAJĄCA POPRAWNOŚĆ NUMERU PESEL (SUMA KONTROLNA)
GO
CREATE FUNCTION CheckPESEL ( @PESEL VARCHAR(256) )
RETURNS BIT
AS
	BEGIN
	DECLARE @sum INT
	DECLARE @controlSum INT
	DECLARE @result BIT

	SET @controlSum = CAST( SUBSTRING(@PESEL, 11, 1) AS INT)

	SET @sum = CAST( SUBSTRING(@PESEL, 1, 1) AS INT) -- 1
	SET @sum = ( @sum + CAST( SUBSTRING(@PESEL, 2, 1) AS INT) * 3 ) % 10 -- 3
	SET @sum = ( @sum + CAST( SUBSTRING(@PESEL, 3, 1) AS INT) * 7 ) % 10 -- 7
	SET @sum = ( @sum + CAST( SUBSTRING(@PESEL, 4, 1) AS INT) * 9 ) % 10 -- 9
	SET @sum = ( @sum + CAST( SUBSTRING(@PESEL, 5, 1) AS INT) * 1 ) % 10 -- 1
	SET @sum = ( @sum + CAST( SUBSTRING(@PESEL, 6, 1) AS INT) * 3 ) % 10 -- 3
	SET @sum = ( @sum + CAST( SUBSTRING(@PESEL, 7, 1) AS INT) * 7 ) % 10 -- 7
	SET @sum = ( @sum + CAST( SUBSTRING(@PESEL, 8, 1) AS INT) * 9 ) % 10 -- 9
	SET @sum = ( @sum + CAST( SUBSTRING(@PESEL, 9, 1) AS INT) * 1 ) % 10 -- 1
	SET @sum = ( @sum + CAST( SUBSTRING(@PESEL, 10, 1) AS INT) * 3 ) % 10 -- 3


	SET @sum = ( 10 - (@sum % 10) ) % 10

	IF @sum = @controlSum
		SET @result=1
	ELSE
		SET @result=0

	RETURN @result
	END
GO


-- WYZWALACZ INSTEAD OF INSERT
-- NA TABELI PACJENCI
-- SPRAWDZAJĄCY DODAWANE DANE DO TABELI PACJENCI- POPRAWNOŚĆ/ZGODNOŚĆ PESELA I DATY

GO
CREATE TRIGGER TR_INSERT_Pacjenci ON Pacjenci
INSTEAD OF INSERT
AS
	DECLARE @TEXT NVARCHAR(256)
	DECLARE @unique BIT
	DECLARE @pesel VARCHAR(256)
	SET @unique = 1

	DECLARE ITERATOR CURSOR FOR
	SELECT Imie, Nazwisko, Plec, DataUrodzenia, Pesel, Palenie, Wzrost FROM inserted
	OPEN Iterator
	DECLARE @imie VARCHAR(256)
	DECLARE @nazwisko VARCHAR(256)
	DECLARE @plec VARCHAR(256)
	DECLARE @dataurodzenia DATE
	DECLARE @palenie BIT
	DECLARE @wzrost INT

	DECLARE @peselDateGood BIT
	DECLARE @peselGood BIT

	

	FETCH Iterator INTO @imie, @nazwisko, @plec, @dataurodzenia, @pesel, @palenie, @wzrost
	WHILE (@@FETCH_STATUS = 0 ) BEGIN

		SET @peselDateGood = 1
		SET @peselGood = 1
		SET @unique = 1

		-- sprawdzenie czy pesel jest unique
		IF @pesel IN ( SELECT Pesel FROM Pacjenci ) BEGIN
			SET @TEXT = FORMATMESSAGE ('Nie dodano pacjenta Pesel: %s. Pesel jest już w bazie danych',@pesel)
			SET @unique = 0
		END
		
		-- sprawdzenie daty i daty w peselu
		IF ( @pesel IS NOT NULL ) AND ( @dataurodzenia IS NOT NULL ) BEGIN
			DECLARE @peselday VARCHAR(2)
			DECLARE @peselmonth VARCHAR(2)
			DECLARE @peselyear VARCHAR(256)
			DECLARE @peselmonthright CHAR(1)
			DECLARE @peselmonthleft CHAR(1)
			DECLARE @peselcentury CHAR(2)

			SET @peselday = SUBSTRING(@pesel, 5, 2)

			SET @peselmonthleft = SUBSTRING(@pesel, 3, 1)

			IF @peselmonthleft IN (0, 1)
				SET @peselcentury = '19'
			IF @peselmonthleft IN (2, 3)
				SET @peselcentury = '20'
			IF @peselmonthleft IN (4, 5)
				SET @peselcentury = '21'

			IF @peselmonthleft = 2
				SET @peselmonthleft = '0'
			IF @peselmonthleft = 3
				SET @peselmonthleft = '1'
			IF @peselmonthleft = 4
				SET @peselmonthleft = '0'
			IF @peselmonthleft = 5
				SET @peselmonthleft = '1'

			SET @peselmonthright = SUBSTRING(@pesel, 4, 1)


			SET @peselmonth = @peselmonthleft + @peselmonthright

			SET @peselyear = SUBSTRING(@pesel, 1, 2)

			DECLARE @peseldate VARCHAR(256)
			SET @peseldate = @peselcentury + @peselyear + '-' + @peselmonth + '-' + @peselday

			DECLARE @datedate VARCHAR(256)
			SET @datedate = SUBSTRING( CAST(@dataurodzenia as char), 1, 11)

			--PRINT @datedate
			--PRINT @peseldate
			IF @datedate = @peseldate
				SET @peselDateGood = 1
			ELSE
				SET @peselDateGood = 0
		END

		IF (@pesel IS NOT NULL ) BEGIN
			-- sprawwdzenie pesela
			--PRINT dbo.CheckPesel(@pesel)
			IF dbo.CheckPesel(@pesel) = 0
				SET @peselGood = 0
		END

		IF (@peselDateGood = 1 AND @peselGood = 1 AND @unique = 1) BEGIN
		INSERT INTO Pacjenci VALUES (@imie, @nazwisko, @plec, @dataurodzenia, @pesel, @palenie, @wzrost)

		SET @TEXT = FORMATMESSAGE (
		'Dodano pacjenta %s %s Pesel: %s Data Urodzenia: %s',
		@imie, @nazwisko, @pesel, SUBSTRING(CAST(@dataurodzenia as char), 1, 10)
		)
		END
		IF (@peselGood = 0) BEGIN
		SET @TEXT = FORMATMESSAGE (
		'Nie dodano pacjenta %s %s. Błędny Pesel: %s',
		@imie, @nazwisko, @pesel)
		END
		IF (@peselDateGood = 0) BEGIN
		SET @TEXT = FORMATMESSAGE (
		'Nie dodano pacjenta %s %s Pesel: %s Data Urodzenia: %s, błędny PESEL lub data urodzenia',
		@imie, @nazwisko, @pesel, SUBSTRING(CAST(@dataurodzenia as char), 1, 10)
		)
		END
		
	PRINT @TEXT
	FETCH Iterator INTO @imie, @nazwisko, @plec, @dataurodzenia, @pesel, @palenie, @wzrost
END
CLOSE Iterator
DEALLOCATE Iterator
GO

-- WYZWALACZ INSTEAD OF UPDATE
-- NA TABELI PACJENCI
-- SPRAWDZAJĄCY MODYFIKOWANE DANE DO TABELI PACJENCI- POPRAWNOŚĆ/ZGODNOŚĆ PESELA I DATY

GO
CREATE TRIGGER TR_UPDATE_Pacjenci ON Pacjenci
INSTEAD OF UPDATE
AS
	DECLARE ITERATOR CURSOR FOR
	SELECT ID, Imie, Nazwisko, Plec, DataUrodzenia, Pesel, Palenie, Wzrost FROM inserted
	OPEN Iterator
	DECLARE @id INT
	DECLARE @imie VARCHAR(256)
	DECLARE @nazwisko VARCHAR(256)
	DECLARE @plec VARCHAR(256)
	DECLARE @dataurodzenia DATE
	DECLARE @pesel VARCHAR(256)
	DECLARE @palenie BIT
	DECLARE @wzrost INT

	DECLARE @peselDateGood BIT

	DECLARE @TEXT NVARCHAR(256)

	--SET IDENTITY_INSERT Pacjenci ON

	FETCH Iterator INTO @id, @imie, @nazwisko, @plec, @dataurodzenia, @pesel, @palenie, @wzrost
	WHILE (@@FETCH_STATUS = 0 ) BEGIN
		
		-- sprawdzenie daty i daty w peselu
		DECLARE @peselday VARCHAR(2)
		DECLARE @peselmonth VARCHAR(2)
		DECLARE @peselyear VARCHAR(256)
		DECLARE @peselmonthright CHAR(1)
		DECLARE @peselmonthleft CHAR(1)
		DECLARE @peselcentury CHAR(2)

		SET @peselday = SUBSTRING(@pesel, 5, 2)

		SET @peselmonthleft = SUBSTRING(@pesel, 3, 1)

		IF @peselmonthleft IN (0, 1)
			SET @peselcentury = '19'
		IF @peselmonthleft IN (2, 3)
			SET @peselcentury = '20'
		IF @peselmonthleft IN (4, 5)
			SET @peselcentury = '21'

		IF @peselmonthleft = 2
			SET @peselmonthleft = '0'
		IF @peselmonthleft = 3
			SET @peselmonthleft = '1'
		IF @peselmonthleft = 4
			SET @peselmonthleft = '0'
		IF @peselmonthleft = 5
			SET @peselmonthleft = '1'

		SET @peselmonthright = SUBSTRING(@pesel, 4, 1)


		SET @peselmonth = @peselmonthleft + @peselmonthright

		SET @peselyear = SUBSTRING(@pesel, 1, 2)

		DECLARE @peseldate VARCHAR(256)
		SET @peseldate = @peselcentury + @peselyear + '-' + @peselmonth + '-' + @peselday

		DECLARE @datedate VARCHAR(256)
		SET @datedate = SUBSTRING( CAST(@dataurodzenia as char), 1, 11)

		--PRINT @datedate
		--PRINT @peseldate
		IF @datedate = @peseldate
			SET @peselDateGood = 1
		ELSE
			SET @peselDateGood = 0

		-- sprawwdzenie pesela
		--PRINT dbo.CheckPesel(@pesel)
		DECLARE @peselGood BIT
		IF dbo.CheckPesel(@pesel) = 1
			SET @peselGood = 1
		ELSE
			SET @peselGood = 0

		IF (@peselDateGood = 1 AND @peselGood = 1) BEGIN

		UPDATE Pacjenci
		SET Imie = @imie, Nazwisko = @nazwisko, Plec = @plec, DataUrodzenia = @dataurodzenia, Pesel = @pesel, Palenie = @palenie, Wzrost = @wzrost
		WHERE Pacjenci.ID = @id

		SET @TEXT = FORMATMESSAGE (
		'Zmodyfikowano pacjenta %s %s Pesel: %s Data Urodzenia: %s',
		@imie, @nazwisko, @pesel, SUBSTRING(CAST(@dataurodzenia as char), 1, 10)
		)
		END
		IF (@peselGood = 0) BEGIN
		SET @TEXT = FORMATMESSAGE (
		'Nie zmodyfikowano pacjenta %s %s. Błędny Pesel: %s',
		@imie, @nazwisko, @pesel)

		END
		IF (@peselDateGood = 0) BEGIN
		SET @TEXT = FORMATMESSAGE (
		'Nie zmodyfikowano pacjenta %s %s Pesel: %s Data Urodzenia: %s, błędny PESEL lub data urodzenia',
		@imie, @nazwisko, @pesel, SUBSTRING(CAST(@dataurodzenia as char), 1, 10)
		)
		END
		
	PRINT @TEXT
	FETCH Iterator INTO @id, @imie, @nazwisko, @plec, @dataurodzenia, @pesel, @palenie, @wzrost
END
CLOSE Iterator
DEALLOCATE Iterator
GO


-- WYZWALACZ INSTEAD OF INSERT
-- NA TABELI PRACOWNICY
-- SPRAWDZAJĄCY MODYFIKOWANE DANE DO TABELI PACJENCI- POPRAWNOŚĆ PESELA


GO
CREATE TRIGGER TR_INSERT_Pracownicy ON Pracownicy
INSTEAD OF INSERT
AS
	DECLARE @TEXT NVARCHAR(256)
	

	DECLARE ITERATOR CURSOR FOR
	SELECT Imie, Nazwisko, Plec, Pesel, Stanowisko, StopienNaukowy, Wyplata, ID_typZatrudnienia, DataZatrudnienia, NrKontaktowy, Adres, Miasto FROM inserted
	OPEN Iterator
	DECLARE @imie VARCHAR(256)
	DECLARE @nazwisko VARCHAR(256)
	DECLARE @plec VARCHAR(256)
	DECLARE @stanowisko VARCHAR(256)
	DECLARE @pesel VARCHAR(256)
	DECLARE @dataurodzenia DATE
	DECLARE @stopienNaukowy VARCHAR(256)
	DECLARE @wyplata MONEY
	DECLARE @typZatrudnienia INT
	DECLARE @dataZatrudnienia DATE
	DECLARE @nrKontaktowy VARCHAR(256)
	DECLARE @adres VARCHAR(256)
	DECLARE @miasto VARCHAR(256)

	DECLARE @unique BIT
	DECLARE @peselGood BIT
	

	FETCH Iterator INTO @imie, @nazwisko, @plec, @pesel, @stanowisko, @stopienNaukowy, @wyplata, @typZatrudnienia, @dataZatrudnienia, @nrKontaktowy, @adres, @miasto
	WHILE (@@FETCH_STATUS = 0 ) BEGIN

		SET @peselGood = 1
		SET @unique = 1

		-- sprawdzenie czy pesel jest unique
		IF @pesel IN ( SELECT Pesel FROM Pracownicy ) BEGIN
			SET @TEXT = FORMATMESSAGE ('Nie dodano pracownika Pesel: %s. Pesel jest już w bazie danych',@pesel)
			SET @unique = 0
		END

		IF (@pesel IS NOT NULL ) BEGIN
			IF dbo.CheckPesel(@pesel) = 0
				SET @peselGood = 0
		END

		IF ( @peselGood = 1 AND @unique = 1) BEGIN
		INSERT INTO Pracownicy VALUES (@imie, @nazwisko, @plec, @pesel, @stanowisko, @stopienNaukowy, @wyplata, @typZatrudnienia, @dataZatrudnienia, @nrKontaktowy, @adres, @miasto)

		SET @TEXT = FORMATMESSAGE (
		'Dodano pracownika %s %s Pesel: %s',
		@imie, @nazwisko, @pesel
		)
		END
		IF (@peselGood = 0) BEGIN
		SET @TEXT = FORMATMESSAGE (
		'Nie dodano pracownika %s %s. Błędny Pesel: %s',
		@imie, @nazwisko, @pesel)
		END
		
	PRINT @TEXT
	FETCH Iterator INTO @imie, @nazwisko, @plec, @pesel, @stanowisko, @stopienNaukowy, @wyplata, @typZatrudnienia, @dataZatrudnienia, @nrKontaktowy, @adres, @miasto
END
CLOSE Iterator
DEALLOCATE Iterator
GO



-- WYZWALACZ INSTEAD OF UPDATE
-- NA TABELI PRACOWNICY
-- SPRAWDZAJĄCY MODYFIKOWANE DANE DO TABELI PACJENCI- POPRAWNOŚĆ PESELA
GO
CREATE TRIGGER TR_UPDATE_Pracownicy ON Pracownicy
INSTEAD OF UPDATE
AS
	DECLARE @TEXT VARCHAR(256)
	DECLARE ITERATOR CURSOR FOR
	SELECT ID, Imie, Nazwisko, Plec, Pesel, Stanowisko, StopienNaukowy, Wyplata, ID_typZatrudnienia, DataZatrudnienia, NrKontaktowy, Adres, Miasto FROM inserted
	OPEN Iterator
	DECLARE @id INT
	DECLARE @imie VARCHAR(256)
	DECLARE @nazwisko VARCHAR(256)
	DECLARE @plec VARCHAR(256)
	DECLARE @stanowisko VARCHAR(256)
	DECLARE @pesel VARCHAR(256)
	DECLARE @dataurodzenia DATE
	DECLARE @stopienNaukowy VARCHAR(256)
	DECLARE @wyplata MONEY
	DECLARE @typZatrudnienia INT
	DECLARE @dataZatrudnienia DATE
	DECLARE @nrKontaktowy VARCHAR(256)
	DECLARE @adres VARCHAR(256)
	DECLARE @miasto VARCHAR(256)

	DECLARE @peselGood BIT

	FETCH Iterator INTO @id, @imie, @nazwisko, @plec, @pesel, @stanowisko, @stopienNaukowy, @wyplata, @typZatrudnienia, @dataZatrudnienia, @nrKontaktowy, @adres, @miasto
	WHILE (@@FETCH_STATUS = 0 ) BEGIN

		-- sprawwdzenie pesela
		IF dbo.CheckPesel(@pesel) = 1
			SET @peselGood = 1
		ELSE
			SET @peselGood = 0

		PRINT (@peselGood)

		IF @peselGood = 1 BEGIN
			UPDATE Pracownicy
			SET Imie = @imie, Nazwisko = @nazwisko, Plec = @plec, Pesel = @pesel, Stanowisko = @stanowisko, StopienNaukowy = @stopienNaukowy, Wyplata = @wyplata,
			ID_typZatrudnienia = @typZatrudnienia, DataZatrudnienia = @dataZatrudnienia, NrKontaktowy = @nrKontaktowy, Adres = @adres, Miasto = @miasto
			WHERE Pracownicy.ID = @id

			SET @TEXT = FORMATMESSAGE (
			'Zmodyfikowano pracownika %s %s Pesel: %s',
			@imie, @nazwisko, @pesel
			)
		END
		IF @peselGood = 0 BEGIN
			SET @TEXT = FORMATMESSAGE (
			'Nie zmodyfikowano pracownika %s %s. Błędny Pesel: %s',
			@imie, @nazwisko, @pesel)
		END
		
	PRINT @TEXT
	FETCH Iterator INTO @id, @imie, @nazwisko, @plec, @pesel, @stanowisko, @stopienNaukowy, @wyplata, @typZatrudnienia, @dataZatrudnienia, @nrKontaktowy, @adres, @miasto
END
CLOSE Iterator
DEALLOCATE Iterator
GO

-- WYZWALACZ INSTEAD OF DELETE
-- NA TABELI AktualneStrategie Leczenia
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
/*
GO
CREATE TRIGGER TR_INSERT_StrategieLeczenia ON StrategieLeczenia
AFTER INSERT
AS
PRINT 'Dodano nową strategię leczenia pacjenta.'
SELECT * FROM inserted
GO
*/


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
