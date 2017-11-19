SELECT destUserCountry.uname, TRUNCATE((SQRT(POWER((destUserCountry.longitude - userCountry.longitude), 2) + POWER((destUserCountry.latitude - userCountry.latitude), 2))),4) as dist
from  (Select longitude, latitude, User.name as uname
		 from Country, User
		where User.uID = 0 
		and User.country = Country.name) as destUserCountry , (Select longitude, latitude
																	                               from Country, User
																								  where User.uID = 1
															 	                                   and User.country = Country.name) as userCountry
 
