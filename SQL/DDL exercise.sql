drop database if exists moviecatalogue;
create database moviecatalogue;
use moviecatalogue;

create table Genre
	(GenreID int not null auto_increment primary key,
    GenreName varchar(30) not null);
    
create table actor
	(ActorID int not null primary key auto_increment,
    FirstName varchar(30) not null,
    LastName varchar(30) not null,
    Birthdate date);
    
create table rating
	(RatingID int primary key not null auto_increment,
    RatingName char(5) not null);
    
create table director
	(DirectorID int primary	key not null auto_increment,
    FirstName varchar(30) not null,
    LastName varchar(30) not null,
    Birthdate date);

create table movie
	(MovieID int not null primary key auto_increment,
    GenreID int not null,
    DirectorID int,
    RatingID int,
    Title varchar(128) not null,
    ReleaseDate date,
    foreign key (genreID) references genre(genreID),
    foreign key (directorID) references director(directorID),
    foreign key (ratingID) references rating(ratingID));
    
create table castmembers
	(CastMemberID int primary key not null auto_increment,
    ActorID int not null,
    MovieID int not null,
    `Role` varchar(50) not null,
    foreign key (ActorID) references actor(actorid),
    foreign key (MovieID) references movie(movieid));