SELECT dest.name, TRUNCATE((SQRT(POWER((Dest.longitude - userCountry.longitude), 2) + POWER((Dest.latitude - userCountry.latitude), 2))),4) as dist 
from  Country as Dest, (Select longitude, latitude
									 from Country, User
									 where User.uID = 0 
									 and User.country = Country.name) as userCountry
 
where  Dest.name = "Sweden"
