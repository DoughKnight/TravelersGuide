CREATE TABLE Country (
    name VARCHAR(40),
    background VARCHAR(4000),
    latitude INT,
    longitude INT,
    area INT,
    PRIMARY KEY(name)
);

CREATE TABLE Users(
    userID INT,
    firstname VARCHAR(20),
    lastname VARCHAR(20),
    age INT,
    email VARCHAR(30),
    language VARCHAR(20) REFERENCES Language(name),
    avatar VARCHAR(50),
    country VARCHAR(40) REFERENCES Country(name),
    PRIMARY KEY(userID)
);

INSERT INTO Users VALUES (-1, "Admin", "Istrator", -1, "admin@travelersguide.com", "English", "default.png", "United States");

CREATE TABLE Connection (
    userID1 INT REFERENCES Users(userID),
    userID2 INT REFERENCES Users(userID),
    meetDate DATE,
    PRIMARY KEY(userID1, userID2)
);

CREATE TABLE Recommendation (
    userID INT REFERENCES Users(userID),
    name VARCHAR(40) REFERENCES Country(name),
    stars INT,
    opinion VARCHAR(200),
    PRIMARY KEY(userID, name)
);

CREATE TABLE Boundaries (
    name1 VARCHAR(40) REFERENCES Country(name),
    name2 VARCHAR(40) REFERENCES Country(name),
    length INT,
    PRIMARY KEY(name1, name2)
);

CREATE TABLE Languages (
    id INT PRIMARY KEY,
    name VARCHAR(30),
    country VARCHAR(40) REFERENCES Country(name),
    percent FLOAT
);

CREATE TABLE Industries (
    id INT PRIMARY KEY,
    country VARCHAR(40) REFERENCES Country(name),
    industry VARCHAR(70),
    notes varchar(200)
);

DELIMITER //
CREATE TRIGGER firstConnection
AFTER INSERT ON Users
FOR EACH ROW
BEGIN
    INSERT INTO Connection
    VALUES (NEW.userID, -1, CURRENT_DATE);
    INSERT INTO Connection
    VALUES (-1, NEW.userID, CURRENT_DATE);
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER distinctAvatar
BEFORE UPDATE ON Users
FOR EACH ROW
BEGIN
    IF NEW.avatar IN (SELECT avatar FROM Users) THEN
        SET NEW.avatar = OLD.avatar;
    END IF;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE reflectConnection()
BEGIN
    INSERT IGNORE INTO Connection
    (SELECT c1.UID2, c2.UID1, c1.MeetDate
        FROM Connection c1, Connection c2
        WHERE c1.UID2 = c2.UID2 AND c1.UID1 = C2.UID1);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE reflectConnection()
BEGIN
    INSERT IGNORE INTO Connection
    (SELECT c1.userID2, c1.userID1, c1.meetDate
        FROM Connection c1
        WHERE NOT EXISTS
            (SELECT *
                FROM Connection AS c2
                WHERE c2.userID1 = c1.userID2 AND c2.userID2 = c1.userID1));
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE reflectBoundaries()
BEGIN
    INSERT IGNORE INTO Boundaries
    (SELECT b1.name2, b1.name1, b1.length
        FROM Boundaries b1
        WHERE NOT EXISTS
            (SELECT *
                FROM Boundaries AS b2
                WHERE b2.name1 = b1.name2 AND b2.name2 = b1.name1));
END//
DELIMITER ;
