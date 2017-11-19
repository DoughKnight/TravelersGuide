Select u1.uid,u1.firstname, u1.lastname, u2.uid,u2.firstname, u2.lastname, meetDate
from User u1, User u2, Connection
where u2.uID = Connection.uID2
and u1.uID = Connection.uID1
Order by meetDate DESC #Sort by whatever