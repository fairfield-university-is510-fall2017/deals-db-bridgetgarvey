USE DEALS;
ALTER TABLE DealTypes  
  ADD FOREIGN KEY (Typecode)
    REFERENCES TypeCodes (TypeCode);

USE DEALS;
ALTER TABLE DealTypes
	ADD FOREIGN KEY (DealID)
		REFERENCES Deals (DealID);
        
USE DEALS;
ALTER TABLE DealParts
	ADD FOREIGN KEY (DealID)
		REFERENCES Deals (DealID);
        
USE DEALS;
ALTER TABLE Players
	ADD FOREIGN KEY (DealID)
		REFERENCES Deals (DealID);
        
USE DEALS;
ALTER TABLE PlayerSupports
	ADD FOREIGN KEY (PlayerID)
		REFERENCES Players (PlayerID);

USE DEALS;
ALTER TABLE PlayerSupports
	ADD FOREIGN KEY (SupportCodeID)
		REFERENCES SupportCodes (SupportCodeID);
        
USE DEALS;
ALTER TABLE PlayerSupports
	ADD FOREIGN KEY (FirmID)
		REFERENCES Firms (FirmID);
        
USE DEALS;
ALTER TABLE Players
	ADD FOREIGN KEY (RoleCode)
		REFERENCES RoleCodes (RoleCode);
        
USE DEALS;
ALTER TABLE Players
	ADD FOREIGN KEY (DealID)
		REFERENCES Deals(DealID)
