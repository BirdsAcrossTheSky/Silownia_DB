/*
Created: 05.12.2022
Modified: 08.12.2022
Project: Silownia
Model: Silownia
Company: Politechnika Warszawska
Author: Piotr Biernat
Version: 1.2.1
Database: Oracle 19c
*/


-- Create tables section -------------------------------------------------

-- Table Silownie

CREATE TABLE Silownie(
  Nr_silowni Integer NOT NULL,
  Nazwa Varchar2(20 ) NOT NULL,
  Data_zalozenia Date NOT NULL,
  Godzina_otwarcia Date NOT NULL,
  Godzina_zamkniecia Date NOT NULL,
  Nr_adresu Integer NOT NULL
)
/

-- Create indexes for table Silownie

CREATE INDEX IX_Relationship5 ON Silownie (Nr_adresu)
/

-- Add keys for table Silownie

ALTER TABLE Silownie ADD CONSTRAINT SilowniaPK PRIMARY KEY (Nr_silowni)
/

-- Table Klienci

CREATE TABLE Klienci(
  Nr_klienta Integer NOT NULL,
  Imie Varchar2(20 ) NOT NULL,
  Nazwisko Varchar2(30 ) NOT NULL,
  Data_urodzenia Date NOT NULL,
  PESEL Char(11 ),
  Plec Char(1 )
        CHECK (Plec IN ('K', 'M')),
  Email Varchar2(30 ),
  Nr_telefonu Varchar2(12 ),
  Cena_karnetu Number(10,2) NOT NULL,
  Czy_ulga Char(1 ) NOT NULL,
  Nr_silowni Integer NOT NULL,
  Nr_adresu Integer NOT NULL
)
/

-- Create indexes for table Klienci

CREATE INDEX IX_Posiada_klienta ON Klienci (Nr_silowni)
/

CREATE INDEX IX_Relationship12 ON Klienci (Nr_adresu)
/

-- Add keys for table Klienci

ALTER TABLE Klienci ADD CONSTRAINT KlientPK PRIMARY KEY (Nr_klienta)
/

-- Table Pracownicy

CREATE TABLE Pracownicy(
  Nr_pracownika Integer NOT NULL,
  Imie Varchar2(20 ) NOT NULL,
  Nazwisko Varchar2(30 ) NOT NULL,
  Data_urodzenia Date NOT NULL,
  PESEL Char(11 ),
  Plec Char(1 )
        CHECK (Plec IN ('K', 'M')),
  Stanowisko Varchar2(30 ) NOT NULL,
  Nr_konta Char(26 ),
  Pensja Number(10,2) NOT NULL,
  Etat Float(2) NOT NULL,
  Email Varchar2(30 ),
  Nr_telefonu Varchar2(12 ),
  Nr_silowni Integer NOT NULL,
  Nr_adresu Integer NOT NULL
)
/

-- Create indexes for table Pracownicy

CREATE INDEX IX_Zatrudnia_pracownika ON Pracownicy (Nr_silowni)
/

CREATE INDEX IX_Relationship7 ON Pracownicy (Nr_adresu)
/

-- Add keys for table Pracownicy

ALTER TABLE Pracownicy ADD CONSTRAINT PracownikPK PRIMARY KEY (Nr_pracownika)
/

-- Table Wyposazenia

CREATE TABLE Wyposazenia(
  Nr_wyposazenia Integer NOT NULL,
  Nazwa_wyposazenia Varchar2(30 ) NOT NULL,
  Nr_silowni Integer NOT NULL,
  Nr_stanowiska Integer NOT NULL
)
/

-- Create indexes for table Wyposazenia

CREATE INDEX IX_Posiada_wyposazenie ON Wyposazenia (Nr_silowni)
/

CREATE INDEX IX_Ma_przypisane_wyposazenie ON Wyposazenia (Nr_stanowiska)
/

-- Add keys for table Wyposazenia

ALTER TABLE Wyposazenia ADD CONSTRAINT WyposazeniePK PRIMARY KEY (Nr_wyposazenia)
/

-- Table Akcesoria

CREATE TABLE Akcesoria(
  Rodzaj_akcesorium Varchar2(20 ) NOT NULL,
  Czy_do_maszyny Char(1 ) NOT NULL,
  Nr_wyposazenia Integer NOT NULL
)
/

-- Add keys for table Akcesoria

ALTER TABLE Akcesoria ADD CONSTRAINT Unique_Identifier6 PRIMARY KEY (Nr_wyposazenia)
/

-- Table Ciezary

CREATE TABLE Ciezary(
  Rodzaj_ciezaru Varchar2(7 ) NOT NULL
        CHECK (Ciezar IN ('Talerz', 'Sztanga', 'Hantel')),
  Waga Integer NOT NULL,
  Nr_wyposazenia Integer NOT NULL
)
/

-- Add keys for table Ciezary

ALTER TABLE Ciezary ADD CONSTRAINT Unique_Identifier7 PRIMARY KEY (Nr_wyposazenia)
/

-- Table Zajecia

CREATE TABLE Zajecia(
  Nr_zajec Integer NOT NULL,
  Nazwa Varchar2(30 ) NOT NULL,
  Godzina_rozpoczecia Date NOT NULL,
  Godzina_zakonczenia Date NOT NULL,
  Dzien_tygodnia Varchar2(12 ) NOT NULL
        CHECK (DniTyg IN ('Poniedzialek', 'Wtorek', 'Sroda', 'Czwartek', 'Piatek', 'Sobota', 'Niedziela')),
  Limit_uczestnikow Integer NOT NULL,
  Nr_silowni Integer NOT NULL,
  Nr_pracownika Integer NOT NULL,
  Nr_strefy Integer NOT NULL
)
/

-- Create indexes for table Zajecia

CREATE INDEX IX_Oferuje_zajecia ON Zajecia (Nr_silowni)
/

CREATE INDEX IX_Prowadzi_zajecia ON Zajecia (Nr_pracownika)
/

CREATE INDEX IX_Relationship14 ON Zajecia (Nr_strefy)
/

-- Add keys for table Zajecia

ALTER TABLE Zajecia ADD CONSTRAINT ZajeciaPK PRIMARY KEY (Nr_zajec)
/

-- Table Stanowiska_cw

CREATE TABLE Stanowiska_cw(
  Nr_stanowiska Integer NOT NULL,
  Czy_czynne Char(1 ) NOT NULL,
  Rodzaj_stanowiska Varchar2(30 ) NOT NULL,
  Czy_na_prad Char(1 ) NOT NULL,
  Nr_silowni Integer NOT NULL,
  Nr_strefy Integer NOT NULL
)
/

-- Create indexes for table Stanowiska_cw

CREATE INDEX IX_Posiada_stanowisko ON Stanowiska_cw (Nr_silowni)
/

CREATE INDEX IX_Relationship13 ON Stanowiska_cw (Nr_strefy)
/

-- Add keys for table Stanowiska_cw

ALTER TABLE Stanowiska_cw ADD CONSTRAINT StanowiskoPK PRIMARY KEY (Nr_stanowiska)
/

-- Table Rodzaje_karnetu_Zajecia

CREATE TABLE Rodzaje_karnetu_Zajecia(
  Nr_zajec Integer NOT NULL,
  Nr_rodzaju_karnetu Integer NOT NULL
)
/

-- Table Wlasciciele

CREATE TABLE Wlasciciele(
  Nr_wlasciciela Integer NOT NULL,
  Imie Varchar2(20 ) NOT NULL,
  Nazwisko Varchar2(30 ) NOT NULL,
  Nr_silowni Integer NOT NULL,
  Nr_adresu Integer NOT NULL
)
/

-- Create indexes for table Wlasciciele

CREATE INDEX IX_Relationship1 ON Wlasciciele (Nr_silowni)
/

CREATE INDEX IX_Relationship17 ON Wlasciciele (Nr_adresu)
/

-- Add keys for table Wlasciciele

ALTER TABLE Wlasciciele ADD CONSTRAINT PK_Wlasciciele PRIMARY KEY (Nr_wlasciciela)
/

-- Table and Columns comments section


-- Table Adresy

CREATE TABLE Adresy(
  Nr_adresu Integer NOT NULL,
  Ulica Varchar2(30 ) NOT NULL,
  Nr_budynku Varchar2(10 ) NOT NULL,
  Nr_lokalu Varchar2(4 ),
  Miasto Varchar2(30 ) NOT NULL,
  Kod_pocztowy Char(6 ) NOT NULL
)
/

-- Add keys for table Adresy

ALTER TABLE Adresy ADD CONSTRAINT PK_Adresy PRIMARY KEY (Nr_adresu)
/

-- Table Strefy

CREATE TABLE Strefy(
  Nr_strefy Integer NOT NULL,
  Nazwa_strefy Varchar2(30 ) NOT NULL,
  Metraz Integer NOT NULL,
  Czy_dla_klientow Char(1 ) NOT NULL
)
/

-- Add keys for table Strefy

ALTER TABLE Strefy ADD CONSTRAINT PK_Strefy PRIMARY KEY (Nr_strefy)
/

-- Table Karnety

CREATE TABLE Karnety(
  Nr_karnetu Integer NOT NULL,
  Data_rozpoczecia_karnetu Date NOT NULL,
  Data_zakonczenia_karnetu Date NOT NULL,
  Czy_ulgowy Char(1 ) NOT NULL,
  Attribute1 Integer,
  Nr_klienta Integer NOT NULL
)
/

-- Create indexes for table Karnety

CREATE INDEX IX_Relationship9 ON Karnety (Attribute1)
/

CREATE INDEX IX_Relationship10 ON Karnety (Nr_klienta)
/

-- Add keys for table Karnety

ALTER TABLE Karnety ADD CONSTRAINT PK_Karnety PRIMARY KEY (Nr_karnetu)
/

-- Table Rodzaje_karnetu

CREATE TABLE Rodzaje_karnetu(
  Nr_rodzaju_karnetu Integer NOT NULL,
  Nazwa_karnetu Varchar2(20 ) NOT NULL,
  Czas_trwania Timestamp(3) NOT NULL,
  Godzina_start Date NOT NULL,
  Godzina_koniec Date NOT NULL,
  Cena Number(10,2) NOT NULL,
  Cena_ulgowa Number(10,2) NOT NULL
)
/

-- Add keys for table Rodzaje_karnetu

ALTER TABLE Rodzaje_karnetu ADD CONSTRAINT PK_Rodzaje_karnetu PRIMARY KEY (Nr_rodzaju_karnetu)
/

-- Table Dane_zakupu

CREATE TABLE Dane_zakupu(
  Nr_zakupu Integer NOT NULL,
  Data_zakupu Date NOT NULL,
  Data_gwarancji Date,
  Nr_stanowiska Integer NOT NULL,
  Nr_wyposazenia Integer NOT NULL
)
/

-- Create indexes for table Dane_zakupu

CREATE INDEX IX_Relationship15 ON Dane_zakupu (Nr_stanowiska)
/

CREATE INDEX IX_Relationship16 ON Dane_zakupu (Nr_wyposazenia)
/

-- Add keys for table Dane_zakupu

ALTER TABLE Dane_zakupu ADD CONSTRAINT PK_Dane_zakupu PRIMARY KEY (Nr_zakupu)
/


-- Create foreign keys (relationships) section ------------------------------------------------- 

ALTER TABLE Pracownicy ADD CONSTRAINT Zatrudnia_pracownika FOREIGN KEY (Nr_silowni) REFERENCES Silownie (Nr_silowni)
/



ALTER TABLE Klienci ADD CONSTRAINT Posiada_klienta FOREIGN KEY (Nr_silowni) REFERENCES Silownie (Nr_silowni)
/



ALTER TABLE Zajecia ADD CONSTRAINT Oferuje_zajecia FOREIGN KEY (Nr_silowni) REFERENCES Silownie (Nr_silowni)
/



ALTER TABLE Stanowiska_cw ADD CONSTRAINT Posiada_stanowisko FOREIGN KEY (Nr_silowni) REFERENCES Silownie (Nr_silowni)
/



ALTER TABLE Wyposazenia ADD CONSTRAINT Posiada_wyposazenie FOREIGN KEY (Nr_silowni) REFERENCES Silownie (Nr_silowni)
/



ALTER TABLE Zajecia ADD CONSTRAINT Prowadzi_zajecia FOREIGN KEY (Nr_pracownika) REFERENCES Pracownicy (Nr_pracownika)
/



ALTER TABLE Wyposazenia ADD CONSTRAINT Ma_przypisane_wyposazenie FOREIGN KEY (Nr_stanowiska) REFERENCES Stanowiska_cw (Nr_stanowiska)
/



ALTER TABLE Wlasciciele ADD CONSTRAINT Silownia_ma_wlasciciela FOREIGN KEY (Nr_silowni) REFERENCES Silownie (Nr_silowni)
/



ALTER TABLE Silownie ADD CONSTRAINT Silownia_znajduje_sie_pod_adresem FOREIGN KEY (Nr_adresu) REFERENCES Adresy (Nr_adresu)
/



ALTER TABLE Pracownicy ADD CONSTRAINT Pracownik_mieszka_pod_adresem FOREIGN KEY (Nr_adresu) REFERENCES Adresy (Nr_adresu)
/



ALTER TABLE Karnety ADD CONSTRAINT Rodzaj_karnetu_okresla_karnet FOREIGN KEY (Attribute1) REFERENCES Rodzaje_karnetu (Nr_rodzaju_karnetu)
/



ALTER TABLE Karnety ADD CONSTRAINT Klient_posiada_karnet FOREIGN KEY (Nr_klienta) REFERENCES Klienci (Nr_klienta)
/



ALTER TABLE Klienci ADD CONSTRAINT Klient_mieszka_pod_adresem FOREIGN KEY (Nr_adresu) REFERENCES Adresy (Nr_adresu)
/



ALTER TABLE Stanowiska_cw ADD CONSTRAINT Strefa_ma_stanowisko FOREIGN KEY (Nr_strefy) REFERENCES Strefy (Nr_strefy)
/



ALTER TABLE Zajecia ADD CONSTRAINT Zajecia_odbywaja_sie_w_strefie FOREIGN KEY (Nr_strefy) REFERENCES Strefy (Nr_strefy)
/



ALTER TABLE Dane_zakupu ADD CONSTRAINT Stanowisko_ma_dane_zakupu FOREIGN KEY (Nr_stanowiska) REFERENCES Stanowiska_cw (Nr_stanowiska)
/



ALTER TABLE Dane_zakupu ADD CONSTRAINT Wyposazenie_ma_dane_zakupu FOREIGN KEY (Nr_wyposazenia) REFERENCES Wyposazenia (Nr_wyposazenia)
/



ALTER TABLE Wlasciciele ADD CONSTRAINT Wlasciciel_mieszka_pod_adresem FOREIGN KEY (Nr_adresu) REFERENCES Adresy (Nr_adresu)
/



ALTER TABLE Rodzaje_karnetu_Zajecia ADD CONSTRAINT Uprawnia_do_zajec_Rodzaj_karnetu FOREIGN KEY (Nr_rodzaju_karnetu) REFERENCES Rodzaje_karnetu (Nr_rodzaju_karnetu)
/





