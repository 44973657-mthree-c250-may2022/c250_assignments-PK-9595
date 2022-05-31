use PersonalTrainer;

-- Use an aggregate to count the number of Clients.
-- 500 rows

select count(*) from client;
--------------------

-- Use an aggregate to count Client.BirthDate.
-- The number is different than total Clients. Why?
-- 463 rows

select count(client.birthdate) from client;
--------------------

-- Group Clients by City and count them.
-- Order by the number of Clients desc.
-- 20 rows

select count(FirstName),
	city
from client
group by city;

--------------------

-- Calculate a total per invoice using only the InvoiceLineItem table.
-- Group by InvoiceId.
-- You'll need an expression for the line item total: Price * Quantity.
-- Aggregate per group using SUM().
-- 1000 rows

select sum(price*quantity) as total
from invoicelineitem
group by invoiceid;

--------------------

-- Calculate a total per invoice using only the InvoiceLineItem table.
-- (See above.)
-- Only include totals greater than $500.00.
-- Order from lowest total to highest.
-- 234 rows
select invoiceid, sum(price*quantity) as total
from invoicelineitem
group by invoiceid
having sum(price*quantity)>500
order by sum(price*quantity) desc;

--------------------

-- Calculate the average line item total
-- grouped by InvoiceLineItem.Description.
-- 3 rows

select description, avg(price*quantity) as average 
from invoicelineitem
group by invoicelineitem.description;
--------------------

-- Select ClientId, FirstName, and LastName from Client
-- for clients who have *paid* over $1000 total.
-- Paid is Invoice.InvoiceStatus = 2.
-- Order by LastName, then FirstName.
-- 146 rows

select client.clientid, client.firstname, client.lastname
from client
join invoice on invoice.clientid = client.clientid
join invoicelineitem on invoice.invoiceid=invoicelineitem.invoiceid
where invoice.invoicestatus=2
group by client.clientid
having sum(invoicelineitem.price*invoicelineitem.quantity)>1000 
order by 
	client.lastname, client.firstname;

--------------------

-- Count exercises by category.
-- Group by ExerciseCategory.Name.
-- Order by exercise count descending.
-- 13 rows
select exercise.name, 
	count(exerciseid) as count
from exercise
join exercisecategory on exercise.exercisecategoryid=exercisecategory.exercisecategoryid
group by exercisecategory.name
order by count(exerciseid) desc;

--------------------

-- Select Exercise.Name along with the minimum, maximum,
-- and average ExerciseInstance.Sets.
-- Order by Exercise.Name.
-- 64 rows

select exercise.name, 
	max(exerciseinstance.sets) as maxSets,
    min(exerciseinstance.sets) as minSets,
    avg(exerciseinstance.sets) as avgSets
from exercise
join exerciseinstance on exercise.exerciseid=exerciseinstance.exerciseid
group by exercise.exerciseid, exercise.name
order by
	exercise.name;

--------------------

-- Find the minimum and maximum Client.BirthDate
-- per Workout.
-- 26 rows
-- Sample: 
-- WorkoutName, EarliestBirthDate, LatestBirthDate
-- '3, 2, 1... Yoga!', '1928-04-28', '1993-02-07'

select w.name as workoutName,
		min(c.birthdate) as earliestBirthDate,
        max(c.birthdate) as latestBirthDate
from workout as w
join clientworkout as cw on cw.workoutid=w.workoutid
join client as c on c.clientid=cw.clientid
group by w.workoutid;

--------------------

-- Count client goals.
-- Be careful not to exclude rows for clients without goals.
-- 500 rows total
-- 50 rows with no goals

select c.clientid,
		count(cg.goalid) as goals
from client as c
left join clientgoal as cg on cg.clientid=c.clientid
group by c.clientid;

--------------------

-- Select Exercise.Name, Unit.Name, 
-- and minimum and maximum ExerciseInstanceUnitValue.Value
-- for all exercises with a configured ExerciseInstanceUnitValue.
-- Order by Exercise.Name, then Unit.Name.
-- 82 rows

select e.name as exerciseName,
		u.name as unitName,
        min(eiuv.value) as minVal,
        max(eiuv.value) as maxVal
from exercise as e
join exerciseinstance as ei on ei.exerciseid=e.exerciseid
join exerciseinstanceunitvalue as eiuv on eiuv.exerciseinstanceid=ei.exerciseinstanceid
join unit as u on eiuv.unitid=u.unitid
group by e.exerciseid,e.`Name`, u.UnitId, u.`Name`
order by e.name, u.name;


--------------------

-- Modify the query above to include ExerciseCategory.Name.
-- Order by ExerciseCategory.Name, then Exercise.Name, then Unit.Name.
-- 82 rows

select e.name as exerciseName,
		u.name as unitName,
        ec.name as categoryName,
        min(eiuv.value) as minVal,
        max(eiuv.value) as maxVal
from exercise as e
join exerciseinstance as ei on ei.exerciseid=e.exerciseid
join exerciseinstanceunitvalue as eiuv on eiuv.exerciseinstanceid=ei.exerciseinstanceid
join unit as u on eiuv.unitid=u.unitid
join exercisecategory as ec on e.exercisecategoryid=ec.exercisecategoryid
group by e.exerciseid,e.`Name`, u.UnitId, u.`Name`
Order by ec.Name, e.Name, u.Name;

--------------------

-- Select the minimum and maximum age in years for
-- each Level.
-- To calculate age in years, use the MySQL function DATEDIFF.
-- 4 rows
select level.name as `level`,
		datediff(curdate(),min(client.birthdate))/365 as maxAge,
        datediff(curdate(),max(client.birthdate))/365 as minAge
from level 
join workout on level.levelid = workout.levelid
join clientworkout on clientworkout.workoutid=workout.workoutid
join `client` on `client`.clientid=clientworkout.clientid
group by level.name;
        

--------------------

-- Stretch Goal!
-- Count logins by email extension (.com, .net, .org, etc...).
-- Research SQL functions to isolate a very specific part of a string value.
-- 27 rows (27 unique email extensions)

select count(clientid),
		substring_index(emailaddress,'.',-1) as extension
from login
group by substring_index(emailaddress,'.',-1);
--------------------

-- Stretch Goal!
-- Match client goals to workout goals.
-- Select Client FirstName and LastName and Workout.Name for
-- all workouts that match at least 2 of a client's goals.
-- Order by the client's last name, then first name.
-- 139 rows

select client.firstname,
		client.lastname,
		workout.name as workoutName,
        count(goal.goalid) as sameGoals
from client
join clientgoal on clientgoal.clientid = client.clientid
join goal on goal.goalid=clientgoal.goalid
join workoutgoal on workoutgoal.goalid=goal.goalid
join workout on workout.workoutid=workoutgoal.workoutid
group by workout.workoutid, client.clientid
having count(goal.goalid)>1
order by client.lastname, client.firstname;

