SELECT dest.name, TRUNCATE((SQRT(POWER((Dest.longitude - Origin.longitude), 2) + POWER((Dest.latitude - Origin.latitude), 2))),4) as dist 
from Country as Origin, Country as Dest
 where Origin.name <> Dest.name
 and Origin.name = "Greece"
ORDER BY dist ASC;
