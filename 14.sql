Select sameLang.firstname, sameLang.lastname, sameLang.language
from (Select language, uID
		from User
        where uID = 0) as input, User as sameLang
where input.language = sameLang.language 
and input.uID <> sameLang.uiD