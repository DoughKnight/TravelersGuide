Select User.name, Recommendation.name, Recommendation.stars, Recommendation.opinion
from Recommendation
Inner Join User
Order by Recommendation.name #Order by country first, or stars whatever works

Select name,avg(stars) as average
from Recommendation
Order by average DESC #Search for countries with highest ratings