/* Indeksy

!!!6.!!!
*/

CREATE INDEX IX_Pacjenci_Nazwisko
ON Pacjenci (Nazwisko); 


CREATE INDEX IX_Pacjenci_Nazwisko2
ON Pacjenci (Nazwisko)
INCLUDE (Imie)
WHERE Palenie=1
