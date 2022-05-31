-- Activity 1
SELECT * from Exercise;

-- Activity 2
SELECT * from client;

-- Activity 3
SELECT * from client where city = 'Metairie';

-- Activity 4
SELECT count(*) from client where clientid = '818u7faf-7b4b-48a2-bf12-7a26c92de20c';

-- Activity 5
SELECT count(*) from goal;

-- Activity 6
SELECT `name`, levelid from workout;

-- Activity 7
SELECT `name`, levelid, notes from workout where levelid=2;

-- Activity 8
SELECT FirstName, LastName, City from client
	Where 
		city = "Metairie"
        or city = "Kenner"
        or city = "Gretna";
SELECT count(*) from client
	Where 
		city = "Metairie"
        or city = "Kenner"
        or city = "Gretna";
        
-- Activity 9
Select firstname, lastname, birthdate from client
	where
		birthdate between "1980-01-01" and "1989-12-31";
Select count(*) from client
	where
		birthdate between "1980-01-01" and "1989-12-31";
    
-- Activity 10
Select firstname, lastname, birthdate from client 
	where 
		birthdate >= "1980-01-01" and
        birthdate <= "1989-12-31";
Select count(*) from client 
	where 
		birthdate >= "1980-01-01" and
        birthdate <= "1989-12-31";
        
-- Activity 11
Select clientid, emailaddress, passwordhash from login
	where
		emailaddress like "%.gov";
Select count(*) from login
	where
		emailaddress like "%.gov";
        
-- Activity 12
Select clientid, emailaddress, passwordhash from login
	where
		emailaddress not like "%.com";
Select count(*) from login
	where
		emailaddress not like "%.com";
        
-- Activity 13
Select firstname, lastname from client
	where birthdate is null;
Select count(*) from client
	where birthdate is null;
    
-- Activity 14
Select name from exercisecategory
	where ParentCategoryId is not null;
Select count(*) from exercisecategory
	where ParentCategoryId is not null;
    
-- Activity 15
Select name, notes from workout
	where
		LevelId = 3 and
        notes like "%you%";
Select count(*) from workout
	where
		LevelId = 3 and
        notes like "%you%";
        
-- Activity 16
Select Firstname, lastname, city from client
	Where
		city = "LaPlace" and
        (Lastname like "L%" or
        Lastname like "M%" or
        Lastname like "N%");
        
-- Activity 17
select invoiceid, description, price, quantity, price*quantity as line_item_total from invoicelineitem
	where
		price*quantity between 15 and 25;
select count(*) from invoicelineitem
	where
		price*quantity between 15 and 25;
        
-- Activity 18
select firstname, lastname from client
	where
		firstname="Estrella" and
        lastname = "Bazely";
select  login.EmailAddress from client, login
	where 
		firstname = "Estrella" and lastname = "Bazely"
        and login.clientid = client.clientid; 
        
-- Activity 19
select workoutid from workout 
	where 
		`name` = "This is Parkour";
select goalid from workoutgoal
	where workoutid = 12;
select `name` from goal
	where goalid = 3
    or goalid = 8 
    or goalid = 15;
        
