Select * #Fill this with whatever variables
from (Select * 
from Country
right join Industries
on Country.name = Industries.country) as CountryIndustry 
left join Economy
on CountryIndustry.name = Economy.country
