CREATE DATABASE IF NOT EXISTS MovieCatalogue;


USE MovieCatalogue;


CREATE TABLE IF NOT EXISTS `Genre` (
	`GenreID` int not null auto_increment,
	`GenreName` varchar(30) not null,
    PRIMARY KEY (`GenreID`)
);

CREATE TABLE IF NOT EXISTS `Rating` (
	`RatingID` int not null auto_increment,
	`RatingName` varchar(5) not null,
    PRIMARY KEY (`RatingID`)
);

CREATE TABLE IF NOT EXISTS `Director` (
	`DirectorID` int not null auto_increment,
	`FirstName` varchar(30) not null,
	`LastName` varchar(30) not null,
	`BirthDate` date null,
    PRIMARY KEY (`DirectorID`)
);

CREATE TABLE IF NOT EXISTS `Actor` (
	`ActorID`  int not null auto_increment,
	`FirstName` varchar(30) not null,
	`LastName` varchar(30) not null,
	`BirthDate` date null,
    PRIMARY KEY (`ActorID`)
);

CREATE TABLE IF NOT EXISTS `Movie` (
	`MovieID` int not null auto_increment,
	`GenreID` int not null,
	`DirectorID` int null,
	`RatingID` int null,
	`Title` varchar(128) not null,
	`ReleaseDate` date null,
    PRIMARY KEY (`MovieID`)
);


ALTER TABLE `Movie`
 ADD CONSTRAINT `fk_MovieGenre` FOREIGN KEY (`GenreID`) REFERENCES `Genre`
(`GenreID`) ON DELETE NO ACTION;
ALTER TABLE `Movie`
 ADD CONSTRAINT `fk_MovieDirector` FOREIGN KEY (`DirectorID`) REFERENCES `Director`
(`DirectorID`) ON DELETE NO ACTION;
ALTER TABLE `Movie`
 ADD CONSTRAINT `fk_MovieRating` FOREIGN KEY (`RatingID`) REFERENCES `Rating`
(`RatingID`) ON DELETE NO ACTION;

CREATE TABLE IF NOT EXISTS `CastMember` (
	`CastMemberID` int not null auto_increment,
	`ActorID` int not null,
	`MovieID` int not null,
	`Role` varchar(50) not null,
    PRIMARY KEY (`CastMemberID`)
);

ALTER TABLE `CastMember`
 ADD CONSTRAINT `fkCastMemberActor` FOREIGN KEY (`ActorID`) REFERENCES `Actor`
(`ActorID`) ON DELETE NO ACTION;


ALTER TABLE `CastMember`
 ADD CONSTRAINT `fkCastMemberMovie` FOREIGN KEY (`MovieID`) REFERENCES `Movie`
(`MovieID`) ON DELETE NO ACTION;


-- DML EXERCISE -----------------------------------------------------

insert into actor (FirstName, LastName, BirthDate) VALUES
	("Bill", "Murray", "1950/9/21"),
	("Dan", "Aykroyd", "1952/1/7"),
    ("John", "Candy", "1950/10/31"),
    ("Steve", "Martin", NULL),
    ("Sylvester", "Stallone", NULL);
    
insert into director (FirstName, LastName, Birthdate) Values
	("Ivan", "Reitman", "1946-10-27"),
    ("Ted", "Kotcheff", NULL);
    
insert into rating (RatingName) Values
	("G"),
    ("PG"),
    ("PG-13"),
    ("R");
    
insert into Genre (GenreName) Values
	("Action"),
    ("Comedy"),
    ("Drama"),
    ("Horror");
    
insert into movie (GenreID, DirectorID, RatingID, Title, ReleaseDate) values
	(1,2,4,"Rambo: First Blood", "1982/10/22"),
    (2,NULL,4,"Planes, Trains & Automobiles", "1987-11-25"),
    (2,1,2,"Ghostbusters", NULL),
    (2,NULL,2,"The Great Outdoors", "1988-6-17");
    
insert into castmember (actorid, movieid, role) values
	(5,1, "John Rambo"),
    (4,2, "Neil Page"),
    (3,2, "Del Griffith"),
    (1,3, "Dr. Peter Venkman"),
    (2,3, "Dr. Raymond Stanz"),
    (2,4, "Roman Craig"),
    (3,4, "Chet Ripley");
    
update movie set
	Title = "Ghostbusters (1984)",
    ReleaseDate = "1984-6-8"
		where title = "Ghostbusters";
        
update genre set
	GenreName = "Action/Adventure"
		where GenreName = "Action";

delete from castmember
	where movieid=1;

SET SQL_SAFE_UPDATES=0;

delete from movie
	where Title = "Rambo: First Blood";

SET SQL_SAFE_UPDATES=1;

Alter table actor
	add column
		DateOfDeath date;
        
SET SQL_SAFE_UPDATES=0;
    
UPDATE actor set
	DateOfDeath=("1994-3-4") 
		WHERE
			FirstName="John" and
            LastName="Candy";
            
SET SQL_SAFE_UPDATES=1;
        
select * from actor;