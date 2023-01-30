/* POKAZ FUNKCJI/WIDOK�W, PROCEDUR/WYZWALACZY

!!!7.!!!
*/

--FUNKCJA WYLICZAJ�CA WIEK PACJENTA

SELECT * FROM ObliczWiek(2)

-- WIDOK PODAJ�CY INFORMACJE O DNIACH POBYTU W SZPITALU I LICZBIE HOSPITALIZACJI

SELECT * FROM Info_Pobyty

-- WIDOK INFORMUJ�CY O WYPE�NIENIU ODDZIAL�W SZPITALNYCH PRZEZ PACJENT�W
SELECT * FROM DostepneMiejscaNaOddzialach


-- WIDOK pokazuj�cy lekarzy i ich wszystkich pacjentow
SELECT * FROM vw_Pacjenci_Lekarzy

-- WIDOK pokazuj�cy lekarzy i ich obecnych pacjentow
SELECT * FROM vw_Pacjenci_Lekarzy_AKT

-- FUNKCJA pokazuj�ca lekarza i jego obecnych pacjent�w
SELECT * FROM f_Pacjenci_Lekarza('Patrycja', 'Nowakowska')

-- FUNKCJA pokazuj�ca lekarza i jego by�ych pacjent�w
SELECT * FROM f_Historia_Pacjent�w_Lekarza('Patrycja', 'Nowakowska')

-- FUNKCJA pokazuj�ca pacjenta i jego obecnych lekarzy
SELECT * FROM f_Lekarze_Pacjenta('Monika', 'Sobczak')

-- FUNKCJA pokazuj�ca pacjenta i jego by�ych lekarzy
SELECT * FROM f_Historia_Lekarzy_Pacjenta('Monika', 'Sobczak')
	

--Widok zwracaj�cy cz�sto�� wyst�powania danych jednostek chorobowych w szpitalu
SELECT * FROM CzestoscWystepowaniaJednostekChoorbowych


---------------------------------------
-------Wyzwalacze i Procedury----------
---------------------------------------

-- w tabeli pacjenci jest kolumna dataUrodzenia i Pesel na wypadek pacjent�w nieposiadaj�cych numeru pesel i/lub udokumentowanej daty urodzenia

-- WYZWALACZ INSTEAD OF INSERT
-- NA TABELI PACJENCI
-- SPRAWDZAJ�CY DODAWANE DANE DO TABELI PACJENCI- POPRAWNO��/ZGODNO�� PESELA I DATY

INSERT INTO Pacjenci VALUES
('Tymoteusz', 'Jasi�ski', 'M', '1972-05-04', '72050459950', 1, 178),
('Dominik', 'Kami�ski', 'M', '1988-05-19', '88051960935', 0, 185),
('Lidia', 'Kaczmarek', 'K', '1928-05-12', '29051210920', 1, 184), -- z�y pesel, dobry: 28051210920
('Norbert', 'Paw�owski', 'M', '1949-02-13', '49021367890', 1, 179), -- z�y pesel, dobry: 49021367891
('Zygmunt', 'Sobczak', 'M', '2005-06-26', '05262649138', 1, 171),
('Wioletta', 'Jab�o�ska', 'K', '1953-11-18', NULL, 0, 187)


-- WYZWALACZ INSTEAD OF UPDATE
-- NA TABELI PACJENCI
-- SPRAWDZAJ�CY MODYFIKOWANE DANE DO TABELI PACJENCI- POPRAWNO��/ZGODNO�� PESELA I DATY
UPDATE Pacjenci
SET Pesel = '58032157277'
WHERE Pesel = '58032157278' -- nie przejdzie, bo by�by b��dny pesel

SELECT * FROm Pacjenci
WHERE Pesel = '58032157278'

UPDATE Pacjenci
SET DataUrodzenia = '1958-04-21'
WHERE Pesel = '58032157278' -- nie przejdzie, bo by�by b��dny pesel

UPDATE Pacjenci
SET DataUrodzenia = '1958-04-21'
WHERE Pesel = '58042157278' -- przejdzie, zmiana jest sp�jna

UPDATE Pacjenci
SET Nazwisko = 'Nowak'
WHERE Pesel = '76121257869' -- przejdzie, zmiana jest sp�jna


-- WYZWALACZ INSTEAD OF INSERT
-- NA TABELI PRACOWNICY
-- SPRAWDZAJ�CY MODYFIKOWANE DANE DO TABELI PACJENCI- POPRAWNO�� PESELA
INSERT INTO Pracownicy VALUES
('Wies�aw', 'Laskowski', 'M', '29083059734', 'Piel�gniarz', 'Magister', 4886, 0, '1958-05-11', '+48 721675648', 'ul. Karminowa 136/29', 'S�dzisz�w Ma�opolski'),
('Tadeusz', 'Krawczyk', 'M', '44081854155', 'Lekarz', 'Doktor Habilitowany', 16752, 0, '1991-02-19', '+48 694041151', 'ul. Wroc�awska 96', 'Be��yce'), -- z�y pesel, dobry 44081854150
('Milena', 'Pawlak', 'K', NULL, 'Lekarz', 'Doktor Habilitowany', 16752, 0, '2003-03-26', '+48 722240867', 'ul. Zacisze 41/39', 'Mak�w Podhala�ski')

INSERT INTO Pracownicy VALUES
('Janina', 'Maciejewska', 'K', '72052539942', 'Diagnostyk Laboratoryjny', 'Magister', 5863, 0, '2010-10-24', '+48 667925799', 'ul. Partyzant�w 43/21', 'Sochaczew'),
('Janina', 'Maciejewska', 'K', '72052539942', 'Diagnostyk Laboratoryjny', 'Magister', 5863, 0, '2010-10-24', '+48 667925799', 'ul. Partyzant�w 43/21', 'Sochaczew') -- nie przejdzie, ten sam PESEL

-- WYZWALACZ INSTEAD OF UPDATE
-- NA TABELI PRACOWNICY
-- SPRAWDZAJ�CY MODYFIKOWANE DANE DO TABELI PACJENCI- POPRAWNO�� PESELA

UPDATE Pracownicy
SET Nazwisko = 'Nowak'
WHERE Pesel = '44081854155' -- przejdzie, zmiana jest sp�jna

-- WYZWALACZ INSTEAD OF DELETE
-- NA TABELI AktualneStrategie Leczenia
SELECT * FROM AktualneStrategieLeczenia

SELECT * FROM HistoriaStrategieLeczenia

DELETE FROM AktualneStrategieLeczenia
WHERE ID = 6

SELECT * FROM AktualneStrategieLeczenia

SELECT * FROM HistoriaStrategieLeczenia


/*
Procedura dodaj�ca strategi� leczenia dla danego pacjenta (imie, nazwisko, pesel) przypisuj�c mu lekarza
*/
EXEC DodajLeczenie
	@imie_pacj = 'Mariola',
	@nazwisko_pacj = 'Krawczyk',
	@pesel_pacj = '70081814560',
	@imie_lek = 'Klaudia',
	@nazw_lek = 'Kaczmarczyk',
	@pesel_lek = '82030517264'

/*
Procedura wpisuj�ca detale leczenia
*/
EXEC UzupelnijLeczenie
	@id_leczenia = 7,
	@choroba = 'Zaburzenie osobowo�ci',
	@lek = 'Olzapin',
	@dawka = 10,
	@oddzial = 'Oddzia� Og�lnopsychiatryczny'


GO

/*
Procedura wpisuj�ca dat� ko�cow� leczenia
*/
EXEC ZakonczLeczenie
	@id_leczenia = 4