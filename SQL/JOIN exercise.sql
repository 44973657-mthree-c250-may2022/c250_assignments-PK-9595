-- Join exercise

USE PersonalTrainer;

-- Select all columns from ExerciseCategory and Exercise.
-- The tables should be joined on ExerciseCategoryId.
-- This query returns all Exercises and their associated ExerciseCategory.
-- 64 rows
Select *
from exercisecategory as ec
join exercise as e
	on ec.exercisecategoryid = e.exercisecategoryid;

-- ------------------
    
-- Select ExerciseCategory.Name and Exercise.Name
-- where the ExerciseCategory does not have a ParentCategoryId (it is null).
-- Again, join the tables on their shared key (ExerciseCategoryId).
-- 9 rows

Select ExerciseCategory.Name, Exercise.Name
from exercisecategory
join exercise
	on exercisecategory.exercisecategoryid = exercise.exercisecategoryid
where
	exercisecategory.parentcategoryid is null;
    
-- ------------------

-- The query above is a little confusing. At first glance, it's hard to tell
-- which Name belongs to ExerciseCategory and which belongs to Exercise.
-- Rewrite the query using an aliases. 
-- Alias ExerciseCategory.Name as 'CategoryName'.
-- Alias Exercise.Name as 'ExerciseName'.
-- 9 rows

Select 	ExerciseCategory.Name as CategoryName, 
		Exercise.Name as ExerciseName
from exercisecategory
join exercise
	on exercisecategory.exercisecategoryid = exercise.exercisecategoryid
where
	exercisecategory.parentcategoryid is null;

-- ------------------

-- Select FirstName, LastName, and BirthDate from Client
-- and EmailAddress from Login 
-- where Client.BirthDate is in the 1990s.
-- Join the tables by their key relationship. 
-- What is the primary-foreign key relationship?
-- 35 rows

Select  c.FirstName,
		c.LastName,
		c.Birthdate,
        L.EmailAddress
from client as c
join Login as L 
	on L.ClientID = c.ClientID
where
	c.birthdate between "1990-01-01" and "1999-12-31";

--------------------

-- Select Workout.Name, Client.FirstName, and Client.LastName
-- for Clients with LastNames starting with 'C'?
-- How are Clients and Workouts related?
-- 25 rows

select	Workout.Name,
		Client.Firstname,
		Client.LastName
from client
join clientworkout on client.clientid = clientworkout.clientid
join workout on clientworkout.workoutid = workout.workoutid
where
	client.lastname like "C%";

--------------------

-- Select Names from Workouts and their Goals.
-- This is a many-to-many relationship with a bridge table.
-- Use aliases appropriately to avoid ambiguous columns in the result.

select w.name as workout,
	g.name as goals
from workout as w
join workoutgoal as wg on w.workoutid=wg.workoutid
join goal as g on wg.goalid=g.goalid;

--------------------

-- Select FirstName and LastName from Client.
-- Select ClientId and EmailAddress from Login.
-- Join the tables, but make Login optional.
-- 500 rows

select c.firstname,
	c.lastname,
    L.clientid,
    L.emailaddress
from client as c
left join login as L on c.clientid=L.clientid;

--------------------

-- Using the query above as a foundation, select Clients
-- who do _not_ have a Login.
-- 200 rows

select c.firstname,
	c.lastname,
    L.clientid,
    L.emailaddress
from client as c
left join login as L on c.clientid=L.clientid
where L.clientid is null;
--------------------

-- Does the Client, Romeo Seaward, have a Login?
-- Decide using a single query.
-- nope :(

select login.clientid as "Login client ID",
	client.firstname,
    client.lastname
from login
right join client on client.clientid=login.clientid
where 
	client.firstname='Romeo'
    and client.lastname='Seaward';
    
--------------------

-- Select ExerciseCategory.Name and its parent ExerciseCategory's Name.
-- This requires a self-join.
-- 12 rows

select ec1.name,
	ec2.name as "Parent category"
from exercisecategory as ec1
join exercisecategory as ec2 on ec1.parentcategoryid=ec2.exercisecategoryid;


--------------------
    
-- Rewrite the query above so that every ExerciseCategory.Name is
-- included, even if it doesn't have a parent.
-- 16 rows

select ec1.name,
	ec2.name as "Parent category"
from exercisecategory as ec1
left join exercisecategory as ec2 on ec1.parentcategoryid=ec2.exercisecategoryid;

--------------------
    
-- Are there Clients who are not signed up for a Workout?
-- 50 rows

select client.firstname,
	client.lastname,
    cw.workoutid
from client
left join clientworkout as cw on cw.clientid=client.clientid
where
	cw.workoutid is null;


--------------------

-- Which Beginner-Level Workouts satisfy at least one of Shell Creane's Goals?
-- Goals are associated to Clients through ClientGoal.
-- Goals are associated to Workouts through WorkoutGoal.
-- 6 rows, 4 unique rows

select DISTINCT workout.workoutid,
	level.name
from client
join clientgoal on client.clientid=clientgoal.clientid
join goal on goal.goalid=clientgoal.goalid
join workoutgoal on workoutgoal.goalid=goal.goalid
join workout on workout.workoutid = workoutgoal.workoutid
join `level` on workout.levelid=`level`.levelid
where
	client.firstname = "Shell"
    and client.lastname="Creane"
    and level.name="Beginner";

--------------------

-- Select all Workouts. 
-- Join to the Goal, 'Core Strength', but make it optional.
-- You may have to look up the GoalId before writing the main query.
-- If you filter on Goal.Name in a WHERE clause, Workouts will be excluded.
-- Why?
-- 26 Workouts, 3 Goals

select workout.name as workout,
	goal.name
from workout
left join workoutgoal on workout.workoutid = workoutgoal.workoutid
	and workoutgoal.goalid=(select goalid from goal where name ="Core Strength")
left join goal on workoutgoal.goalid = goal.goalid
	 and goal.goalid=(select goalid from goal where name ="Core Strength");

--------------------

-- The relationship between Workouts and Exercises is... complicated.
-- Workout links to WorkoutDay (one day in a Workout routine)
-- which links to WorkoutDayExerciseInstance 
-- (Exercises can be repeated in a day so a bridge table is required) 
-- which links to ExerciseInstance 
-- (Exercises can be done with different weights, repetions,
-- laps, etc...) 
-- which finally links to Exercise.
-- Select Workout.Name and Exercise.Name for related Workouts and Exercises.

select workout.name as workout,
	exercise.name as exercise
from workout
join workoutday on workout.workoutid=workoutday.workoutid
join workoutdayexerciseinstance as wdei on workoutday.workoutdayid=wdei.workoutdayid
join exerciseinstance on exerciseinstance.exerciseinstanceid = wdei.exerciseinstanceid
join exercise on exercise.exerciseid=exerciseinstance.exerciseid;
--------------------
   
-- An ExerciseInstance is configured with ExerciseInstanceUnitValue.
-- It contains a Value and UnitId that links to Unit.
-- Example Unit/Value combos include 10 laps, 15 minutes, 200 pounds.
-- Select Exercise.Name, ExerciseInstanceUnitValue.Value, and Unit.Name
-- for the 'Plank' exercise. 
-- How many Planks are configured, which Units apply, and what 
-- are the configured Values?
-- 4 rows, 1 Unit, and 4 distinct Values

select exercise.name,
	exerciseinstanceunitvalue.value,
    unit.name
from exercise
join exerciseinstance on exercise.exerciseid = exerciseinstance.exerciseid
join exerciseinstanceunitvalue on exerciseinstanceunitvalue.exerciseinstanceid=exerciseinstance.exerciseinstanceid
join unit on unit.unitid = exerciseinstanceunitvalue.unitid
	where exercise.name = "Plank";
