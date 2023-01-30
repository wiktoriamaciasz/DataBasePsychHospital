/* Stworzenie STRATEGIELECZENIA

!!!3.!!!
*/

GO
CREATE VIEW StrategieLeczenia AS
SELECT *, NULL AS [DataZakonczenia] FROM AktualneStrategieLeczenia UNION
SELECT * FROM HistoriaStrategieLeczenia
GO