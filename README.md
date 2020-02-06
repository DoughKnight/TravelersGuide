This project makes use of world country information from the CIA World Factbook. This was developed for our CS157a Databases class. Extensive parsing in Python was used to obtain the data initially, then SQL was used thereafter.

Team Min(Sleep) - _By D. H., I. Y., and M. B._

Fields
------

* 2003 (not included) GDP Growth Rate
* 2004 (not included) GDP Per Capita
* 2011 Geographic Coordinates
* 2012 (not included) GDP Composition (sectors)
* 2020 (not included) Elevation
* 2021 (not included) Natural Hazards
* 2028 Background
* 2046 (not included) Poverty Line (% below)
* 2048 (not included) Labor Force Composition
* 2075 (not included) Ethnic Groups
* 2076 (not included) Exchange Rates
* 2090 industries
* 2096 Land Boundaries (borders)
* 2098 Languages
* 2119 (not included) Population
* 2137 (not included) Employment Rate
* 2147 Area
* 2153 (not included) Internet Users

Unused Tables
-------------

{%highlight SQL%}
CREATE TABLE Economy (country VARCHAR(40)
REFERENCES Country(name), growthRate FLOAT,
perCapita INT, agricultural FLOAT,
industry FLOAT, services FLOAT,
povertyLine FLOAT, PRIMARY KEY(country));
{%endhighlight%}

Report
------

### Database Schema

{% highlight SQL %}
CREATE TABLE Country (name VARCHAR(40),background VARCHAR(4000),latitude INT,longitude INT,area INT,PRIMARY KEY(name))

;CREATE TABLE Users (userID INT,firstname VARCHAR(20),lastname VARCHAR(20),psw VARCHAR(20),age INT,email VARCHAR(30),language VARCHAR(20) REFERENCES Languages(name),avatar VARCHAR(50),country VARCHAR(40) REFERENCES Country(name),PRIMARY KEY(userID));

CREATE TABLE Connection (userID1 INT REFERENCES Users(userID),userID2 INT REFERENCES Users(userID),meetDate DATE,PRIMARY KEY(userID1, userID2));

CREATE TABLE Recommendation (userID INT REFERENCES Users(userID),name VARCHAR(40) REFERENCES Country(name),stars INT,
opinion VARCHAR(200),updatedAt DATE,PRIMARY KEY(userID, name));

CREATE TABLE Boundaries (name1 VARCHAR(40) REFERENCES Country(name),name2 VARCHAR(40) REFERENCES Country(name),length INT,PRIMARY KEY(name1, name2));

CREATE TABLE Languages (id INT PRIMARY KEY,name VARCHAR(30),country VARCHAR(40) REFERENCES Country(name),percent FLOAT);

CREATE TABLE Industries (id INT PRIMARY KEY,country VARCHAR(40) REFERENCES Country(name),industry VARCHAR(70),notes VARCHAR(200));
{% endhighlight %}

### Screenshots of Relations

![Countries](/assets/Travelers_Guide/1.jpg)

_Countries (too many rows to show all, the background field is omitted because this makes the table too unwieldy to show)_

![Users](/assets/Travelers_Guide/2.jpg)

_Users (too many rows to show all)_

![Connection](/assets/Travelers_Guide/3.jpg)

_Connection (all users have connection with admin, -1. Too many to show all)_

![Recommendation](/assets/Travelers_Guide/4,jpg)

_Recommendation_

![Boundaries](/assets/Travelers_Guide/5.jpg)

_Boundaries (too many to show all)_

![Languages](/assets/Travelers_Guide/6.jpg)

_Languages (too many to show all)_

![Industries](/assets/Travelers_Guide/7.jpg)

_Industries (too many to show all)_

Fifteen Distinct Functions
--------------------------
1.View all users
2.View users in [a given] country
3.View users of the same language
4.Adding a connection
5.Deleting a connection
6.View own connections
7.Adding a recommendation
8.View all recommendations
9.Reset password
10.View all countries
11.Search for Country(s)
12.List world’s most and least spread languages
13.View bordering countries
14.View close countries
15.View distance from country to self
16.View distance from country to country
17.View distance from user to self

### SQL Select Statements

{% highlight SQL %}
SELECT firstname, lastname FROM Users Order by firstname ASC;

SELECT firstname,lastname from Users where country = ?;

SELECT firstname,lastname from Users as subUsers WHERE EXISTS (SELECT firstname,lastname from Users where subUsers.language = ?) order by firstname";

SELECT firstname,lastname,meetDate from Connection,Users WHERE ? = userID1 andUsers.userID = userID2 order by meetDate DESC;

SELECT user.firstname, user.lastname, con.meetDate from Connection as con, Users as userWhere con.userID1 = ? and con.userID2 = user.userID;

SELECT firstname,lastname,name,stars,opinion FROM Recommendation, Users whereRecommendation.userID = Users.userID;

SELECT name from Country;

SELECT * FROM Country WHERE Country.name = ?;

SELECT Dest.name, TRUNCATE((SQRT(POWER((Dest.longitude - userCountry.longitude), 2)+ POWER((Dest.latitude - userCountry.latitude), 2))),4) as dist FROM Country as Dest(SELECT longitude, latitude, name FROM Country where ?' = Country.name) as userCountryWhere userCountry.name <> Dest.name having dist < 10 order by dist;
SELECT name2 FROM Boundaries WHERE Boundaries.name1 = ?;

SELECT TRUNCATE((SQRT(POWER((dest.longitude - origin.longitude), 2) +POWER((dest.latitude - origin.latitude), 2))),4) as dist FROM Country as origin, Country as destWHERE origin.name <> dest.name AND origin.name = ? AND dest.name = ? SELECT TRUNCATE((SQRT(POWER((dest.longitude - origin.longitude), 2) +POWER((dest.latitude - origin.latitude), 2))),4) as dist FROM Country as origin, Country as destWHERE origin.name <> dest.name AND origin.name = ? AND dest.name = ?

SELECT destUserCountry.name, TRUNCATE((SQRT(POWER((destUserCountry.longitude -userCountry.longitude), 2) + POWER((destUserCountry.latitude - userCountry.latitude), 2))),4)as dist FROM (SELECT longitude, latitude,name FROM Country, Users WHEREUsers.firstname = ? AND Users.lastname = ? AND Users.country = Country.name) asdestUserCountry, (SELECT longitude, latitude FROM Country WHERE ? = Country.name) as userCountry;

SELECT userID, firstname, lastname, age,language,country, email, psw from Users Order byuserID ASC;

SELECT firstname, lastname, meetDate from Connection left join TravelersGuide.Users onUsers.userID = userID1 or Users.userID = userID2 order by meetDate DESC;

SELECT * from Recommendation;

_(The following SQL select statement finds some of the languages used in the greatest and leastsquare kilometers on Earth. This put our database to the test)._

SELECT DISTINCT j1.lname as mname, j1.carea AS marea
FROM
(SELECT l.name AS lname, sum(c.area) AS carea
FROM Languages AS l, Country AS c
WHERE l.country = c.name
GROUP BY l.name) AS j1
JOIN
(SELECT l.name AS lname, sum(c.area) AS carea
FROM Languages AS l, Country AS c
WHERE l.country = c.name
GROUP BY l.name) AS j2 WHERE j1.lname < j2.lname
AND j1.lname NOT IN (SELECT DISTINCT j3.lname
FROM
(SELECT l.name AS lname, sum(c.area) AS carea
FROM Languages AS l, Country AS c
WHERE l.country = c.name
GROUP BY l.name) AS j3
JOIN
(SELECT l.name AS lname, sum(c.area) AS carea
FROM Languages AS l, Country AS c
WHERE l.country = c.name
GROUP BY l.name) AS j4
WHERE j3.lname < j4.lname and j3.carea < j4.carea)
UNION
SELECT DISTINCT j1.lname as mname, j1.carea AS marea
FROM
(SELECT l.name AS lname, sum(c.area) AS carea
FROM Languages AS l, Country AS c
WHERE l.country = c.name
GROUP BY l.name) AS j1
JOIN
(SELECT l.name AS lname, sum(c.area) AS carea
FROM Languages AS l, Country AS c
WHERE l.country = c.name
GROUP BY l.name) AS j2
WHERE j1.lname < j2.lname
AND j1.lname NOT IN (SELECT DISTINCT j3.lname
FROM
(SELECT l.name AS lname, sum(c.area) AS carea
FROM Languages AS l, Country AS c
WHERE l.country = c.name
GROUP BY l.name) AS j3
JOIN
(SELECT l.name AS lname, sum(c.area) AS carea
FROM Languages AS l, Country AS c
WHERE l.country = c.name
GROUP BY l.name) AS j4
WHERE j3.lname < j4.lname and j3.carea > j4.carea);
{% endhighlight %}
