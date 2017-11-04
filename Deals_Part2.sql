#Bridget Garvey; 11/04/2017
#Purpose: Get comfortable with creating views and joining tables to manipulate the data

# 2. Indicate that we are using the deals database
USE deals;  
# 2, cont. Execute a test query  
SELECT *
FROM Companies
WHERE CompanyName like "%Inc.";

# 3 and 4. Select companies sorted by CompanyName
SELECT *
FROM Companies
ORDER BY CompanyID;

#5. Select Deal Parts with dollar values
SELECT DealName, PartNumber, DollarValue
FROM Deals,DealParts
WHERE Deals.DealID = DealParts.DealID;

#6. Select Deal Parts with dollar values using a join
SELECT DealName, PartNumber, DollarValue
FROM Deals join DealParts on (Deals.DealID = DealParts.DealID);

#Show each company involved in each deal
SELECT DealName,RoleCode,CompanyName
FROM Companies
	JOIN Players ON (Companies.CompanyID = Players.CompanyID)
    JOIN Deals ON (Players.DealID = Deals.DealID)
ORDER BY DealName;
    
#Create a view named DealValues that lists the DealID, total dollar value and number of parts for each deal.
SELECT Deals.DealID, DollarValue, PartNumber
FROM Deals JOIN DealParts ON (Deals.DealID = DealParts.DealID);

#Order Deals, SUM of DollarValue, and COUNT of PartNumber by DealID
SELECT Deals.DealID, SUM(DollarValue), COUNT(PartNumber)
FROM Deals JOIN DealParts ON (Deals.DealID = DealParts.DealID)
GROUP BY Deals.DealID
ORDER BY Deals.DealID;

#8. Create a reusable view based on the previous select query; Create a view that matches company to deal
DROP VIEW IF EXISTS CompanyDeals;
CREATE VIEW CompanyDeals AS
SELECT DealName,RoleCode,CompanyName
FROM Companies
	JOIN Players ON (Companies.CompanyID = Players.CompanyID)
	JOIN Deals ON (Players.DealID = Deals.DealID)
ORDER BY DealName;

#9. Create a view named DealValues that lists the DealID, total dollar value and number of parts for each deal
DROP VIEW IF EXISTS DealValues;
CREATE VIEW DealValues AS
SELECT Deals.DealID, SUM(DollarValue) AS TotDollarValue, COUNT(PartNumber) AS NumParts
FROM Deals JOIN DealParts ON (Deals.DealID = DealParts.DealID)
GROUP BY Deals.DealID
ORDER BY Deals.DealID;

SELECT * from DealValues;

# 10. Create a view named DealSummary that lists the DealID, DealName, number of players, total dollar value, and number of parts for each deal.
DROP VIEW IF EXISTS DealSummary;
CREATE VIEW DealSummary AS
SELECT Deals.DealID, DealName, COUNT(PlayerID) AS NumPlayers,  TotDollarValue, NumParts
FROM DEALS JOIN DealValues ON (DEALS.DealID = DealValues.DealID)
			JOIN Players ON (DEALS.DealID = Players.DealID)
GROUP BY Deals.DealID;
            
# 11. Create a view called DealsByType that lists TypeCode, number of deals, and total value of deals for each deal type
DROP VIEW IF EXISTS DealsByType;
CREATE VIEW DealsByType AS
SELECT DISTINCT DealTypes.TypeCode, COUNT(Deals.DealID) AS NumDeals, SUM(DealParts.DollarValue) AS TotDollarValue
FROM DealTypes 
	JOIN Deals ON (DealTypes.DealID = Deals.DealID) 
	JOIN DealParts ON (DealParts.DealID = Deals.DealID)
GROUP BY DealTypes.TypeCode; 

# 12. Create a view called DealPlayers that lists the CompanyID, Name, and Role Code for each deal. Sort the players by the RoleSortOrder.
DROP VIEW IF EXISTS DealPlayers;
CREATE VIEW DealPlayers AS
SELECT DealID, CompanyID, CompanyName, RoleCode
FROM Players 
	JOIN Deals USING (DealID)
	JOIN Companies USING (CompanyID)
	JOIN RoleCodes USING (RoleCode)
ORDER BY RoleSortOrder;

# 13. Create a view called DealsByFirm that lists the FirmID, Name, number of deals, and total value of deals for each firm
SELECT FirmID, Firms.Name, COUNT(PLAYERS.DealID) AS NumPlayers, SUM(TotDollarValue) AS TotValue
FROM Firms
	LEFT JOIN PlayerSupports USING (FirmID)
    LEFT JOIN Players USING (PlayerID)
    JOIN DealValues USING (DealID)
GROUP BY FirmID, 'Name';