CREATE TABLE Country (
    name VARCHAR(40),
    background VARCHAR(4000),
    latitude INT,
    longitude INT,
    area INT,
    PRIMARY KEY(name)
);

CREATE TABLE User (
    uID INT,
    name VARCHAR(20),
    age INT,
    email VARCHAR(30),
    language VARCHAR(20) REFERENCES Language(name),
    avatar VARCHAR(50),
    country VARCHAR(20) REFERENCES Country(name),
    PRIMARY KEY(uID)
);

CREATE TABLE Connection (
    uID1 INT REFERENCES User(uID),
    uID2 INT REFERENCES User(uID),
    meetDate DATE,
    PRIMARY KEY(uID1, uID2)
);

CREATE TABLE Recommendation (
    uID INT REFERENCES User(uID),
    name VARCHAR(20) REFERENCES Country(name),
    stars INT,
    opinion VARCHAR(200),
    PRIMARY KEY(uID, name)
);

CREATE TABLE Boundaries (
    name1 VARCHAR(20) REFERENCES Country(name),
    name2 VARCHAR(20) REFERENCES Country(name),
    length INT,
    PRIMARY KEY(name1, name2)
);

CREATE TABLE Languages (
    id INT PRIMARY KEY,
    name VARCHAR(20),
    country VARCHAR(20) REFERENCES Country(name),
    percent FLOAT
);

CREATE TABLE Industries (
    id INT PRIMARY KEY,
    country VARCHAR(20) REFERENCES Country(name),
    industry VARCHAR(20)
);

CREATE TABLE Economy (
    country VARCHAR(20) REFERENCES Country(name),
    growthRate FLOAT,
    perCapita INT,
    agricultural FLOAT,
    industry FLOAT,
    services FLOAT,
    povertyLine FLOAT,
    PRIMARY KEY(country)
);

DELIMITER //
CREATE TRIGGER SumLanguage
AFTER UPDATE ON Languages
FOR EACH ROW
BEGIN
    UPDATE Languages
    SET percent = 0
    WHERE country = NEW.country
    AND (0 IN (SELECT percent FROM Languages AS l WHERE l.country = NEW.country)
    OR 100 <> (SELECT SUM(percent) FROM Languages AS l2 WHERE l2.country = NEW.country));
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER SumEcon
AFTER UPDATE ON Economy
FOR EACH ROW
BEGIN
    UPDATE Economy
    SET agriculture = 0
    WHERE country = NEW.country
    AND (0 IN (SELECT agriculture FROM Economy as c WHERE c.country = NEW.country)
        OR 0 IN (SELECT industry FROM Economy as c2  WHERE c2.country = NEW.country)
        OR 0 IN (SELECT services FROM Economy as c3 WHERE c3.country = NEW.country)
        OR 100 <> (SELECT (c4.agriculture + c4.industry + c4.services) as total FROM Economy as c4 WHERE c4.country = NEW.country));
    UPDATE Economy
    SET industry = 0
    WHERE country = NEW.country
    AND (0 IN (SELECT agriculture FROM Economy as c WHERE c.country = NEW.country)
        OR 0 IN (SELECT industry FROM Economy as c2  WHERE c2.country = NEW.country)
        OR 0 IN (SELECT services FROM Economy as c3 WHERE c3.country = NEW.country)
        OR 100 <> (SELECT (c4.agriculture + c4.industry + c4.services) as total FROM Economy as c4 WHERE c4.country = NEW.country));
    UPDATE Economy
    SET services = 0
    WHERE country = NEW.country
    AND (0 IN (SELECT agriculture FROM Economy as c WHERE c.country = NEW.country)
        OR 0 IN (SELECT industry FROM Economy as c2  WHERE c2.country = NEW.country)
        OR 0 IN (SELECT services FROM Economy as c3 WHERE c3.country = NEW.country)
        OR 100 <> (SELECT (c4.agriculture + c4.industry + c4.services) as total FROM Economy as c4 WHERE c4.country = NEW.country));
END//
DELIMITER ;
