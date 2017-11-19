Insert into Recommendation
Values((Select uID
			from User
			where uID = input.uID),input.name,input.stars,input.opinion) #Fill in in Java Input