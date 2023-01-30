
-- WIDOK PRACOWNIKÓW KTÓRZY S¥ MEDYCZNI
GO
CREATE VIEW vw_Pracownicy_Medyczni AS
SELECT * FROM Pracownicy
WHERE Stanowisko IN ('Lekarz', 'Pielêgniarz', 'Diagnostyk Laboratoryjny', 'Asystent Medyczny')
GO

-- WIDOK PRACOWNIKÓW KTÓRZY S¥ BIUROWI

Go
CREATE VIEW vw_Pracownicy_Biurowi AS
SELECT * FROM Pracownicy
WHERE Stanowisko IN ('Sekretarz', 'Dyrektor')
GO

-- WIDOK PRACOWNIKÓW KTÓRZY S¥ DIETETYKAMI
Go
CREATE VIEW vw_Dietetycy AS
SELECT * FROM Pracownicy
WHERE Stanowisko IN ('Dietetyk')
GO
