Select * 
From Recommendation
Group by uID  #Search by uID

#or

Select *
From Recommendation
Group by name #Search by country

Select * 
From Recommendation
Group by stars #Search by rating

#
DELETE from Recommendation
Where uID = input.uID and name = input.name #Delete User recommendation about Country