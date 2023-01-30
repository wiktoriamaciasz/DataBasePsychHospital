/* POKAZ FUNKCJI/WIDOKÓW, PROCEDUR/WYZWALACZY

!!!7.!!!
*/

--FUNKCJA WYLICZAJĄCA WIEK PACJENTA

SELECT * FROM dbo.ObliczWiek(1)

-- WIDOK PODAJĄCY INFORMACJE O DNIACH POBYTU W SZPITALU I LICZBIE HOSPITALIZACJI

SELECT * FROM Info_Pobyty

-- WIDOK INFORMUJĄCY O WYPEŁNIENIU ODDZIALÓW SZPITALNYCH PRZEZ PACJENTÓW
SELECT * FROM DostepneMiejscaNaOddzialach


-- WIDOK pokazujący lekarzy i ich wszystkich pacjentow
SELECT * FROM vw_Pacjenci_Lekarzy

-- WIDOK pokazujący lekarzy i ich obecnych pacjentow
SELECT * FROM vw_Pacjenci_Lekarzy_AKT

-- FUNKCJA pokazująca lekarza i jego obecnych pacjentów
SELECT * FROM f_Pacjenci_Lekarza('Patrycja', 'Nowakowska')

-- FUNKCJA pokazująca lekarza i jego byłych pacjentów
SELECT * FROM f_Historia_Pacjentów_Lekarza('Patrycja', 'Nowakowska')

-- FUNKCJA pokazująca pacjenta i jego obecnych lekarzy
SELECT * FROM f_Lekarze_Pacjenta('Monika', 'Sobczak')

-- FUNKCJA pokazująca pacjenta i jego byłych lekarzy
SELECT * FROM f_Historia_Lekarzy_Pacjenta('Monika', 'Sobczak')
	

--Widok zwracający częstość występowania danych jednostek chorobowych w szpitalu
SELECT * FROM CzestoscWystepowaniaJednostekChoorbowych


---------------------------------------
-------Wyzwalacze i Procedury----------
---------------------------------------

-- w tabeli pacjenci jest kolumna dataUrodzenia i Pesel na wypadek pacjentów nieposiadających numeru pesel i/lub udokumentowanej daty urodzenia

-- WYZWALACZ INSTEAD OF INSERT
-- NA TABELI PACJENCI
-- SPRAWDZAJĄCY DODAWANE DANE DO TABELI PACJENCI- POPRAWNOŚĆ/ZGODNOŚĆ PESELA I DATY

INSERT INTO Pacjenci VALUES
('Tymoteusz', 'Jasiński', 'M', '1972-05-04', '72050459950', 1, 178),
('Dominik', 'Kamiński', 'M', '1988-05-19', '88051960935', 0, 185),
('Lidia', 'Kaczmarek', 'K', '1928-05-12', '29051210920', 1, 184), -- zły pesel, dobry: 28051210920
('Norbert', 'Pawłowski', 'M', '1949-02-13', '49021367890', 1, 179), -- zły pesel, dobry: 49021367891
('Zygmunt', 'Sobczak', 'M', '2005-06-26', '05262649138', 1, 171),
('Wioletta', 'Jabłońska', 'K', '1953-11-18', NULL, 0, 187)


-- WYZWALACZ INSTEAD OF UPDATE
-- NA TABELI PACJENCI
-- SPRAWDZAJĄCY MODYFIKOWANE DANE DO TABELI PACJENCI- POPRAWNOŚĆ/ZGODNOŚĆ PESELA I DATY
UPDATE Pacjenci
SET Pesel = '58032157277'
WHERE Pesel = '58032157278' -- nie przejdzie, bo byłby błędny pesel

SELECT * FROm Pacjenci
WHERE Pesel = '58032157278'

UPDATE Pacjenci
SET DataUrodzenia = '1958-04-21'
WHERE Pesel = '58032157278' -- nie przejdzie, bo byłby błędny pesel

UPDATE Pacjenci
SET DataUrodzenia = '1958-04-21'
WHERE Pesel = '58042157278' -- przejdzie, zmiana jest spójna

UPDATE Pacjenci
SET Nazwisko = 'Nowak'
WHERE Pesel = '76121257869' -- przejdzie, zmiana jest spójna


-- WYZWALACZ INSTEAD OF INSERT
-- NA TABELI PRACOWNICY
-- SPRAWDZAJĄCY MODYFIKOWANE DANE DO TABELI PACJENCI- POPRAWNOŚĆ PESELA
INSERT INTO Pracownicy VALUES
('Wiesław', 'Laskowski', 'M', '29083059734', 'Pielęgniarz', 'Magister', 4886, 0, '1958-05-11', '+48 721675648', 'ul. Karminowa 136/29', 'Sędziszów Małopolski'),
('Tadeusz', 'Krawczyk', 'M', '44081854155', 'Lekarz', 'Doktor Habilitowany', 16752, 0, '1991-02-19', '+48 694041151', 'ul. Wrocławska 96', 'Bełżyce'), -- zły pesel, dobry 44081854150
('Milena', 'Pawlak', 'K', NULL, 'Lekarz', 'Doktor Habilitowany', 16752, 0, '2003-03-26', '+48 722240867', 'ul. Zacisze 41/39', 'Maków Podhalański')

INSERT INTO Pracownicy VALUES
('Janina', 'Maciejewska', 'K', '72052539942', 'Diagnostyk Laboratoryjny', 'Magister', 5863, 0, '2010-10-24', '+48 667925799', 'ul. Partyzantów 43/21', 'Sochaczew'),
('Janina', 'Maciejewska', 'K', '72052539942', 'Diagnostyk Laboratoryjny', 'Magister', 5863, 0, '2010-10-24', '+48 667925799', 'ul. Partyzantów 43/21', 'Sochaczew') -- nie przejdzie, ten sam PESEL

-- WYZWALACZ INSTEAD OF UPDATE
-- NA TABELI PRACOWNICY
-- SPRAWDZAJĄCY MODYFIKOWANE DANE DO TABELI PACJENCI- POPRAWNOŚĆ PESELA

UPDATE Pracownicy
SET Nazwisko = 'Nowak'
WHERE Pesel = '44081854155' -- przejdzie, zmiana jest spójna

-- WYZWALACZ INSTEAD OF DELETE
-- NA TABELI AktualneStrategie Leczenia
SELECT * FROM AktualneStrategieLeczenia

SELECT * FROM HistoriaStrategieLeczenia

DELETE FROM AktualneStrategieLeczenia
WHERE ID = 6

SELECT * FROM AktualneStrategieLeczenia

SELECT * FROM HistoriaStrategieLeczenia


/*
Procedura dodająca strategię leczenia dla danego pacjenta (imie, nazwisko, pesel) przypisując mu lekarza
*/
EXEC DodajLeczenie
	@imie_pacj = 'Mariola',
	@nazwisko_pacj = 'Krawczyk',
	@pesel_pacj = '70081814560',
	@imie_lek = 'Klaudia',
	@nazw_lek = 'Kaczmarczyk',
	@pesel_lek = '82030517264'

/*
Procedura wpisująca detale leczenia
*/
EXEC UzupelnijLeczenie
	@id_leczenia = 7,
	@choroba = 'Zaburzenie osobowości',
	@lek = 'Olzapin',
	@dawka = 10,
	@oddzial = 'Oddział Ogólnopsychiatryczny'


GO

/*
Procedura wpisująca datę końcową leczenia
*/
EXEC ZakonczLeczenie
	@id_leczenia = 4
