Select firstname, lastname, meetDate
from User, Connection
where User.uID = Connection.uID2
and Connection.uID1 = 1 #Fill in 