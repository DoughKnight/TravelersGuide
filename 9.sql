Select * #Fill this with whatever variables
from (Select * 
from Country
right join Industries
on Country.name = Industries.country) as CountryIndustry 
where CountryIndustry.name = "Spain"
#on CountryIndustry.name = "Spain"
#left join Economy
#on CountryIndustry.name = Economy.country #Fill when economy is filled
