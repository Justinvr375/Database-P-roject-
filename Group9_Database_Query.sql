CREATE DATABASE DBD2781Project_Group9  ----------Creating database 
ON PRIMARY(
NAME = 'DBD2781ProjectData1',
FILENAME = 'D:\DBD2781ProjectDatabase\DBD2781ProjectData1.mdf',
SIZE = 50mb,
MAXSIZE = 25GB,
FILEGROWTH = 10mb
),
FILEGROUP SECONDARY(
NAME = 'DBD2781ProjectData2',
FILENAME = 'D:\DBD2781ProjectDatabase\DBD2781ProjectData2.ndf',
SIZE = 50mb,
MAXSIZE = 25GB,
FILEGROWTH = 10mb
)
LOG ON(
NAME = 'DBD2781ProjectLog1',
FILENAME = 'D:\DBD2781ProjectDatabase\DBD2781ProjectLog1.ldf',
SIZE = 50mb,
MAXSIZE = 25GB,
FILEGROWTH = 10mb
)
GO ----------------Batch seperator for Database Creation
--------Creating tables within database 
USE DBD2781Project_Group9
CREATE TABLE Country(
CountryID INT IDENTITY(1,1) PRIMARY KEY, ---Primary key
CountryName VARCHAR(35) NOT NULL UNIQUE,
)

CREATE TABLE City(
CityID INT IDENTITY(1,1) PRIMARY KEY, ---Primary key
CityName VARCHAR(25) NOT NULL,
CountryID INT,
CONSTRAINT FK_Country FOREIGN KEY (CountryID) REFERENCES Country(CountryID), ---Foreign Key
)

CREATE TABLE Stadium(
StadiumID INT IDENTITY(1,1) PRIMARY KEY, ---Primary key
StadiumName VARCHAR(20) NOT NULL,
Capacity INT NOT NULL,
CityID INT,
CONSTRAINT FK_City FOREIGN KEY (CityID) REFERENCES City(CityID)  ---Foreign Key
)

CREATE TABLE Team(
TeamID INT IDENTITY(1,1) PRIMARY KEY, ---Primary key
TeamName VARCHAR(30) NOT NULL UNIQUE,
CountryID INT,
CONSTRAINT FK_TeamCountry FOREIGN KEY (CountryID) REFERENCES Country(CountryID) ---Foreign Key
)

CREATE TABLE [Match] (
MatchID INT IDENTITY(1,1) PRIMARY KEY, ---Primary key
MatchDate DATE NOT NULL,
MatchTime TIME NOT NULL,
MatchStage VARCHAR(50) NOT NULL,
StadiumID INT NOT NULL,
CONSTRAINT FK_Stadium FOREIGN KEY (StadiumID) REFERENCES Stadium(StadiumID), ---Foreign Key
HomeTeamID INT NOT NULL,
CONSTRAINT FK_HomeTeam FOREIGN KEY (HomeTeamID) REFERENCES Team(TeamID), ---Foreign Key
AwayTeamID INT NOT NULL,
CONSTRAINT FK_AwayTeam FOREIGN KEY (AwayTeamID) REFERENCES Team(TeamID), --Unique constraint 
HomeScore INT DEFAULT 0,
AwayScore INT DEFAULT 0,
Attendance INT DEFAULT 0
)

CREATE TABLE CoachingStaff(
CoachID INT IDENTITY(1,1) PRIMARY KEY, ---Primary key
FirstName VARCHAR(20) NOT NULL,
LastName VARCHAR(20) NOT NULL,
CoachRole VARCHAR(20) NOT NULL,
TeamID INT,
CONSTRAINT FK_CoachTeam FOREIGN KEY (TeamID) REFERENCES Team(TeamID) ---Foreign Key
)

CREATE TABLE Player (
PlayerID INT IDENTITY(1,1) PRIMARY KEY, ---Primary key
FirstName VARCHAR(20) NOT NULL,
LastName VARCHAR(20) NOT NULL,
DateOfBirth DATE NOT NULL,
Postion VARCHAR(20) NOT NULL,
JerseyNumber INT NOT NULL,
TeamID INT,
CONSTRAINT FK_PlayerTeam FOREIGN KEY (TeamID) REFERENCES Team(TeamID), ---Foreign Key
CONSTRAINT U_TeamJersey UNIQUE (TeamID, JerseyNumber)   --Unique constraint 


)

CREATE TABLE Fan(
FanID INT IDENTITY(1,1) PRIMARY KEY, ---Primary key
FirstName VARCHAR(20) NOT NULL,
LastName VARCHAR(20) NOT NULL,
Email VARCHAR(100) NOT NULL UNIQUE,
Phone VARCHAR(20) UNIQUE, 
CountryID INT NOT NULL,
CONSTRAINT FK_FanCountry FOREIGN KEY (CountryID) REFERENCES Country(CountryID)
)

CREATE TABLE Ticket(
TicketID INT IDENTITY(1,1) PRIMARY KEY, ---Primary key
MatchID INT NOT NULL,
FanID INT NOT NULL,
SeatNumber VARCHAR(10) NOT NULL,
Section VARCHAR(30),
Price DECIMAL(10,2) NOT NULL,
PurchaseDate DATETIME NOT NULL,
CONSTRAINT FK_TicketMatch FOREIGN KEY (MatchID) REFERENCES [Match](MatchID),
CONSTRAINT FK_FanTicket FOREIGN KEY (FanID) REFERENCES Fan(FanID),
CONSTRAINT U_MatchSeatNumber UNIQUE (MatchID, SeatNumber)
)


GO ------------Batch seperator for table creation

---------Inserting values into all tables 
INSERT INTO Country (CountryName) -----Inserting data into country table 
VALUES 
('Brazil'),
('Australia'),
('Canada'),
('USA'),
('Japan'),
('Argentina'),
('South Africa'),
('Mexico'),
('New Zealand'),
('Eswatini')

INSERT INTO City (CityName, CountryID)  ----Inserting data into city table 
VALUES 
('Atlanta',4 ),
('Boston',4 ),
('Toronto',3 ),
('Vancouver',3 )


INSERT INTO Stadium (StadiumName, Capacity, CityID) ---Inserting data into Stadium table 
VALUES
('Toronto Stadium', 45000, 3),
('BC Place Vancouver', 54000, 4),
('Atlanta Stadium', 75000, 1),
('Boston Stadium', 63000, 2)


INSERT INTO Team (TeamName, CountryID) -----Inserting data into team table 
VALUES 
('Toronto FC', 3),
('Team Australia Mens', 2),
('Samurai Blue', 5),
('Brazil National football team' ,1),
('Argentina national team', 6),
('SA Soccer National Team',7),
('Mexico National Team',8),
('New Zealand Mens National Team',9),
('Eswatini Football Team',10)

INSERT INTO [Match] (MatchDate, MatchTime, MatchStage, StadiumID, HomeTeamID, AwayTeamID, HomeScore, AwayScore) ---Inserting data into Matches table 
VALUES
('2026-05-10', '12:30:00', 'Final', 1, 6,7,2,0),
('2026-05-12', '15:30:00', 'Final', 1, 8,1,3,1),
('2026-05-14', '12:30:00', 'Final', 4, 7,9,0,3),
('2026-05-16', '10:30:00', 'Final', 3, 9,8,2,0),
('2026-05-18', '12:30:00', 'Final', 2, 9,6,3,3)


INSERT INTO CoachingStaff (FirstName, LastName, CoachRole, TeamID) --Data into Coaching Staff
VALUES
('Leon', 'Kennedy', 'Head Coach', 6),
('Mike', 'Jefferson', 'Assistant Coach', 6),
('Yuta', 'Kawasaki', 'Assistant Coach', 8),
('Sean', 'Delongman', 'Head Coach', 8),
('Hanno', 'Lankenstein', 'Head Coach', 9),
('Chad', 'Hendriks', 'Assistant Coach', 9),
('Aiden', 'Frankinson', 'Head Coach', 7),
('Daniel', 'Le Chip', 'Assisnant Coach', 7)


INSERT INTO Player (FirstName, LastName, DateOfBirth, Postion, JerseyNumber, TeamID) --Data into Player table
VALUES 
('Liam','Nkosi', '1998-04-12', 'Forward', 9, 6), 
('Ethan','Turner', '1995-08-14', 'Midfielder', 8, 6), 
('Michael','Carter', '1998-11-22', 'Defender', 5, 6), 
('Khyle','Mitchell', '2000-01-02', 'Goalkeeper', 1, 6), 
('Ethan','Walker', '1994-03-20', 'Forward', 11, 7), 
('Jacob','Harris', '2001-11-12', 'Midfielder', 10, 7), 
('Alexander','Jacobs', '2002-01-15', 'Defender', 4, 7)


INSERT INTO Fan(FirstName, LastName, Email, Phone, CountryID) ---Inserting data into Fan table 
VALUES 
('Chandre', 'Walker', 'cw@gmail.com', '067 987 6798', 1),
('Charne', 'Holmes', 'ch@gmail.com', '045 777 1344', 3),
('Daniel', 'Goggins', 'dg@gmail.com', '090 832 1113', 1),
('Geralt', 'Rivia', 'GoR@gmail.com', '055 6776 2424', 6),
('Richard', 'Richar', 'RichR@gmail.com', '049 923 7754', 4),
('Anika', 'Risso', 'AR@gmail.com', '041 111 5656', 5)

SELECT * FROM Ticket
SELECT * FROM [Match]
SELECT * FROM Fan
INSERT INTO Ticket (MatchID, FanID, SeatNumber, Section, Price, PurchaseDate) --- Inserting Data into Ticket table
VALUES
(3, 6, 'A12', 'Upper', 540.00, '2026-03-12'),
(4, 1, 'B41', 'Lower', 901.00, '2026-02-10'),
(2, 2, 'D450', 'Upper', 970.00, '2026-04-22'),
(1, 5, 'GH560', 'Middel', 830.50, '2025-12-26'),
(5,4, 'J56', 'Upper', 450.50, '2026-01-21')

UPDATE [Match]
SET Attendance = 
(
	SELECT COUNT(*)
	FROM Ticket
	WHERE [Match].MatchID = Ticket.MatchID
);

GO ----Batch seperator --END of Table data insertion

--Join Showing players with their teams and countries 
SELECT (p.FirstName + ' ' + p.LastName) AS PlayerName,p.JerseyNumber, t.TeamName, c.CountryName
FROM Player p 
INNER JOIN Team t 
ON p.TeamID=t.TeamID
INNER JOIN Country c 
ON t.CountryID = c.CountryID
ORDER BY PlayerName

---Join showing fans and the matches they watched
SELECT (f.FirstName + ' ' + f.LastName) AS FanName, m.MatchID, m.MatchTime, m.MatchStage, m.StadiumID, m.HomeTeamID, m.AwayTeamID, t.SeatNumber, t.Section
FROM Fan f
JOIN Ticket t 
ON f.FanID=t.FanID
JOIN [dbo].[Match] m 
ON t.MatchID=m.MatchID

---Teams that were away teams in certain matches 
SELECT t.TeamName, m.MatchID, m.MatchTime, m.MatchStage, m.StadiumID, m.AwayTeamID
FROM Team t 
Right JOIN [dbo].[Match] m 
ON t.TeamID= m.AwayTeamID

--Teams that were home teams in certain matches 
SELECT t.TeamName, m.MatchID, m.MatchTime, m.MatchStage, m.StadiumID, m.AwayTeamID
FROM Team t 
Right JOIN [dbo].[Match] m 
ON t.TeamID= m.HomeTeamID

---Sub-Query --Finds players above age of 21
SELECT (p.FirstName + ' ' + p.LastName) AS PlayersAbove21, p.JerseyNumber, p.DateOfBirth
FROM Player p
WHERE PlayerID IN (SELECT PlayerID
					FROM Player
					WHERE DATEDIFF(Year,DateOfBirth, GETDATE()) > 21)

---Sub-Query that checks which teams have won as Away team
SELECT TeamName
FROM Team
WHERE TeamName IN	(SELECT  t.TeamName
					FROM Team t
					INNER JOIN [dbo].[Match] m 
					ON t.TeamID=m.AwayTeamID
					WHERE m.HomeScore < m.AwayScore
					GROUP BY t.TeamName)

---Sub-Query that checks which teams have won as Home team
SELECT TeamName
FROM Team
WHERE TeamName IN	(SELECT  t.TeamName
					FROM Team t
					INNER JOIN [dbo].[Match] m 
					ON t.TeamID=m.HomeTeamID
					WHERE m.HomeScore > m.AwayScore
					GROUP BY t.TeamName)

--Sub-Query-- Finds the city and country (Canada in this case) of a stadium and displays 

SELECT s.StadiumID, s.StadiumName, c.cityName, co.CountryName
FROM Stadium s INNER JOIN City c 
ON s.CityID=c.CityID INNER JOIN Country co
ON co.CountryID = c.CountryID
WHERE StadiumID IN (SELECT StadiumID
					FROM Stadium
					WHERE CityID IN (SELECT CityID
										FROM City
										WHERE CountryID = 3))

GO -- Batch seperator for CTE
--CTE with Case counting the total amount of matches a team has played 
WITH TotalMatches AS(
SELECT t.TeamName, COUNT(CASE WHEN t.TeamID=m.AwayTeamID OR t.TeamID= m.HomeTeamID THEN 1 END) AS AmountOfMatches 
FROM Team t 
INNER JOIN [dbo].[Match] m 
ON t.TeamID=m.AwayTeamID OR t.TeamID=m.HomeTeamID
GROUP BY t.TeamName)

SELECT * 
FROM TotalMatches
ORDER BY AmountOfMatches DESC;

---CTE --Finding total matches that a stadium has hosted and displaying the stadium details 

With TotalMatchesHosted AS (
SELECT s.StadiumName, s.StadiumID, COUNT(m.StadiumID) AS AmountOfMathcesHosted
FROM Stadium s LEFT JOIN [Match] m ON s.StadiumID=m.StadiumID
GROUP BY s.StadiumName, s.StadiumId)

SELECT s.StadiumID, s.StadiumName, s.Capacity, t.AmountOfMathcesHosted
FROM Stadium s INNER JOIN TotalMatchesHosted t ON s.StadiumID= t.StadiumID

GO -- Bath seperator for 1ste Case
-- CASES ---
-- Case that will show the level of tier of each ticket based on its price --
USE [DBD2781Project_Group9]
SELECT t.TicketID, s.StadiumName, th.TeamName AS HomeTeamName , ta.TeamName AS AwayTeamName ,
t.SeatNumber, t.Section, t.Price, -- The columns taken from their respective tables
	CASE 
		WHEN t.Price <= 600 THEN 'Lower' -- If the price of the ticket is lower then 600 it is lower tier
		WHEN t.Price BETWEEN 600 AND 850 THEN 'Middel' -- If the price of the ticket between 600 and 850 its higher tier
		WHEN t.Price >= 850 THEN 'Higher' -- If it is above 850 its higher tier
	END AS TicketTier
FROM [Ticket] t 
INNER JOIN [Match] m ON t.MatchID = m.MatchID -- The inner Join the ticket table with the match table using the matchID 
--Using the Match table we then join it with stadium in order to find stadium name
INNER JOIN [Stadium] s ON m.StadiumID = s.StadiumID
-- In order to find home team name we take the home team id and compare it with the team id form the teams table
INNER JOIN [Team] th ON m.HomeTeamID = th.TeamID 
-- We do the same with the away team where we take their id and compare it with the team id from the teams table
INNER JOIN [Team] ta ON m.AwayTeamID = ta.TeamID;

GO --batch seperator for 2nd Case
-- Case to determine fans interset based on the capacity of the stadium --
SELECT StadiumID, StadiumName, Capacity, 
	CASE 
		WHEN Capacity <= 50000 THEN 'Low' -- lower the 50'000 then they have low interest 
		WHEN Capacity BETWEEN 50000 AND 60000 THEN 'Medium' -- Between 50'000 and 60'000 they have medium interest
		WHEN Capacity >= 60000 THEN 'High' -- And if higher the 60000 they have high interest
	END AS FansInterest
FROM Stadium

GO -- Batch seperator 3rd Case
-- Determines which nation is a host nation or away nation
SELECT c.CountryID, c.CountryName,ct.CityName, s.StadiumName,
	CASE 
		WHEN c.CountryID = 4 OR c.CountryID = 3 Then 'Host Nation' -- USA and Canada are host nations
		ELSE 'Away Nation'
	END AS HostNationOrAwayNation
	FROM Country c LEFT JOIN City ct ON c.CountryID = ct.CountryID -- Outer join in order to find the cityID and city name
	LEFT JOIN Stadium s ON ct.CityID = s.CityID --By using the cityID we find the stadium name

GO -- Batch seperator for procedures 
-- Store procedure where the total amount of capacity for a country gets caculated using
-- the country ID(The sum of all the capacity) and also determines the capacity status
CREATE PROCEDURE sp_TotalCapacityForCountry
	@CountryID INT
AS
	BEGIN
		SELECT ct.CountryName , SUM(s.Capacity) AS TotalCapacity, 
		CASE 
			WHEN SUM(s.Capacity) < 40000 Then 'LowCapcity'
			WHEN SUM(s.Capacity) BETWEEN 40000 AND 70000 THEN 'Medium Capacity'
			WHEN SUM(s.Capacity) > 70000 THEN 'High Capacity'
		END AS CapacityStatus
		FROM Stadium s LEFT JOIN City c -- Stadium City key in order to find the country ID
		ON s.CityID = c.CityID
		LEFT JOIN Country ct
		ON c.CountryID = ct.CountryID -- From the City table we use the country ID to find its name
		WHERE c.CountryID = @CountryID
		GROUP BY ct.CountryName
	END

GO -- Batch Seperator for 2nd Store procedure  
-- store procedure to find the total amount of players for teams
CREATE PROCEDURE sp_TotalAmountOfPlayers
@TeamID INT
AS 
	BEGIN
		SELECT t.TeamName, Count(p.PlayerID) AS AmountOfPlayers
		FROM Team t INNER JOIN Player p
		ON t.TeamID = p.TeamID
		WHERE t.TeamID = @TeamID
		GROUP BY t.TeamName
	END 

GO -- Batch Seperator for the final store preocedure
-- Store procedure that caculates the amount of ticket for that country 
CREATE PROCEDURE sp_TotalAmountOfTickets 
@Country INT
AS 
	BEGIN
		SELECT c.CountryName, COUNT(t.TicketID) AS TotalAmountOfTickets
		FROM Country c 
		INNER JOIN City ct -- Inner join in order to find the CityID
		ON c.CountryID = ct.CountryID
		INNER JOIN Stadium s -- Inner Join in order to find the StadiumID 
		ON ct.CityID = s.CityID
		INNER JOIN [Match] m -- Inner Join in order to find the mathID
		ON s.StadiumID = m.StadiumID
		INNER JOIN Ticket t 
		ON m.MatchID = t.MatchID -- Using all the joins we can find the ticket orgin of country
		WHERE c.CountryID = @Country
		GROUP BY c.CountryName
	END

GO -- Batch seperator for the 1st function
-- Some Fans were given this function determines the new price for that fan

CREATE FUNCTION fn_TicketDisscount (@DisscountAmount INT,@FanID INT)
RETURNS MONEY 
	AS
		BEGIN 
			DECLARE @Disscount DECIMAL;
			SELECT @Disscount = 100 - @DisscountAmount
			DECLARE @NewPrice DECIMAL;
			SELECT @NewPrice = t.Price * @Disscount/100 
			FROM Ticket t
			WHERE t.FanID = @FanID
			GROUP BY t.Price
			RETURN @NewPrice
		END

GO -- Batch Seperator for the 2nd function
-- gets the sum of the ticket for the country
CREATE FUNCTION fn_NewTicketPrice(@CountryName NCHAR(20))
RETURNS TABLE
	RETURN
		(
			SELECT c.CountryName,SUM(t.Price) AS TotalPrice FROM Country c 
			INNER JOIN City ct -- Inner join in order to find the CityID
			ON c.CountryID = ct.CountryID
			INNER JOIN Stadium s -- Inner Join in order to find the StadiumID 
			ON ct.CityID = s.CityID
			INNER JOIN [Match] m -- Inner Join in order to find the mathID
			ON s.StadiumID = m.StadiumID
			INNER JOIN Ticket t 
			ON m.MatchID = t.MatchID -- Using all the joins we can find the ticket orgin of country
			WHERE c.CountryName = @CountryName
			GROUP BY c.CountryName
		)
GO -- Batch Seperator for the 3rd and final function
-- Function that determines which team wins for that match

CREATE FUNCTION fn_WinningTeam (@MatchID INT)
RETURNS @rowtable TABLE (MID INT, HometeamName CHAR(20), AwayteamName CHAR(20), WinningTeam CHAR(20))
AS
	BEGIN
		INSERT INTO @rowtable
		SELECT m.MatchID, th.TeamName, ta.TeamName,
			CASE
				WHEN HomeScore > AwayScore THEN 'Home Team Wins'
				WHEN AwayScore > HomeScore THEN 'Away Team Wins'
				WHEN HomeScore = AwayScore THEN 'Both Teams Draw'
			END AS WinningTeam
		FROM [Match] m
		LEFT JOIN Team th 
		ON m.HomeTeamID = th.TeamID
		LEFT JOIN Team ta
		ON m.AwayTeamID = ta.TeamID
		WHERE m.MatchID = @MatchID
		GROUP BY m.MatchID,th.TeamName,ta.TeamName,m.HomeScore,m.AwayScore
		RETURN
	END

GO -- Batch Seperator for 1ste View
--This View allows the organization to see the stadium ID, Name the country Name and the City its being hosted

CREATE VIEW vw_HostingInformation AS
SELECT s.StadiumID,s.StadiumName,ct.CityName,c.CountryName
FROM Stadium s
INNER JOIN City ct
ON s.CityID = ct.CityID
INNER JOIN Country c
ON ct.CountryID = c.CountryID

GO -- Batch Seperator for 2nd view
-- This view shows The Team Coaches,CoachID the team Name and the team 
CREATE VIEW vw_TeamsAndCoaches AS
SELECT 
c.CoachID, c.FirstName + ' ' + c.LastName AS FullName, c.CoachRole,t.TeamID,t.TeamName
FROM CoachingStaff c
LEFT JOIN Team t
ON c.TeamID = t.TeamID
GROUP BY c.CoachID,c.FirstName,c.LastName,c.CoachRole,t.TeamID,t.TeamName

GO -- Batch Seperator for the 3rd and Final View
-- A view that show player and their team
CREATE VIEW vw_PlayersAndTeams AS
SELECT p.PlayerID, p.FirstName + ' ' + p.LastName AS FullName,p.Postion,t.TeamID,t.TeamName
FROM Player p 
INNER JOIN Team t 
ON p.TeamID = t.TeamID

GO

-- security (loging + permissions)
-- create login

Create LOGIN fifaAdmin WITH PASSWORD = 'R0n0ld0th3go@t7';
GO

--user linked login
Create USER fifaAdmin FOR LOGIN fifaAdmin;
GO

-- permissions
GRANT SELECT, INSERT, UPDATE ON Ticket TO fifaAdmin;

-- no deletion of matches
DENY DELETE ON Match TO fifaAdmin;
GO

-- ENCRYPTION

-- Master Key
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'R0n0ld0th3go@t7';
GO

-- certificate
CREATE CERTIFICATE TicketCert
WITH SUBJECT = 'Protect fan info';
GO

-- symmetric key
CREATE SYMMETRIC KEY TicketKey
WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE TicketCert;
GO

-- encrypt on email column
OPEN SYMMETRIC KEY TicketKey
DECRYPTION BY CERTIFICATE TicketCert;

UPDATE Fan
SET Email = 
ENCRYPTBYKEY(KEY_GUID('TicketKey'),Email);

CLOSE SYMMETRIC KEY TicketKey;
GO

-- Triggers
-- stop tickets if there is no seats left
CREATE TRIGGER trg_NoOverbooking
on TICKET
INSTEAD OF INSERT
AS BEGIN

	DECLARE @match INT;
	DECLARE @capacity INT;
	DECLARE @ticketsSold INT;

	SELECT @match = MatchID FROM inserted;

	SELECT @capacity = s.Capacity
	FROM Match m
	JOIN Stadium s ON m.StadiumID = s.StadiumID
	WHERE m.MatchID = @match;
	
	SELECT @ticketsSold = COUNT(*)
	FROM Ticket

	IF @ticketsSold < @capacity
	BEGIN
		SET IDENTITY_INSERT Ticket ON;	
		INSERT INTO Ticket (TicketID,MatchID,FanID,SeatNumber,Section,Price)
		SELECT TicketID,MatchID,FanID,SeatNumber,Section,Price FROM inserted;
	END
	ELSE
	BEGIN
		PRINT 'No more tickets available';
	END

END;
GO

CREATE TRIGGER trg_Attendance
ON Ticket
AFTER INSERT
AS
BEGIN

	UPDATE Match
	SET Attendance = Attendance + 1
	WHERE MatchID IN (SELECT MatchID FROM inserted);

END;
GO

-- Transaction

BEGIN TRY

	BEGIN TRANSACTION;

	INSERT INTO Ticket (MatchID, FanID, SeatNumber, Section, Price, PurchaseDate)
		Values (1, 1, 'A12', 'North', 500, GETDATE());
	COMMIT;

END TRY
BEGIN CATCH

	ROLLBACK;
	PRINT 'booking failed';
END CATCH;
GO

-- Cursor

DECLARE @matchID INT;
DECLARE @ticketCount INT;

DECLARE match_cursor CURSOR FOR
(SELECT MatchID From [Match]);

OPEN match_cursor;

FETCH NEXT FROM match_cursor INTO @matchID;

WHILE @@FETCH_STATUS = 0
BEGIN
	SELECT @ticketCount = COUNT(*)
	FROM Ticket
	WHERE MatchID = @matchID;

	PRINT 'Match ID: ' + CAST(@matchID AS VARCHAR) +
	' | Tickets Sold: ' + CAST(@ticketCount AS VARCHAR);

	FETCH NEXT FROM match_cursor INTO @matchID;

	END;

	CLOSE match_cursor;
	DEALLOCATE match_cursor;

	