show databases;
create database dbmovie;
use dbmovie;
create table movie
(
id int not null auto_increment,
title tinytext,
year year,
duration int,
country tinytext,
language tinytext,
release_date date,
CONSTRAINT pk_movie PRIMARY KEY (id)
);

create table actor
 (id int not null auto_increment,
  first_name tinytext,
  last_name tinytext,
  gender enum('female','male','other'),
   CONSTRAINT pk_actor PRIMARY KEY (id)
 );
 create table director(
 id int not null auto_increment,
 first_name tinytext,
 last_name tinytext,
 CONSTRAINT pk_director PRIMARY KEY (id)
 );
 create table reviewer(
 id int not null auto_increment,
 name tinytext,
  CONSTRAINT pk_reviewer PRIMARY KEY (id)
 );
 create table trailer (
  id int not null auto_increment,
  link text,
  CONSTRAINT pk_trailer PRIMARY KEY (id)
  );
  create table act(
  movie_id int,
  actor_id int,
  role enum('Background',' Recurring character','Side character','Series regular'),
   CONSTRAINT fk_act_movie FOREIGN KEY (movie_id)
    REFERENCES movie(id),
     CONSTRAINT fk_act_actor FOREIGN KEY ( actor_id)
    REFERENCES actor(id)
  );

  create table direct(
  director_id int,
  movie_id int,
  CONSTRAINT fk_direct_director FOREIGN KEY (director_id)
    REFERENCES director(id),
  CONSTRAINT fk_direct_movie FOREIGN KEY (movie_id)
    REFERENCES movie( id)
     
  );
  create table review(
  movie_id int ,
  reviewer_id int,
  rating int,
    CONSTRAINT fk_review_movie FOREIGN KEY (movie_id)
    REFERENCES movie(id),
    CONSTRAINT fk_review_reviewer FOREIGN KEY (reviewer_id)
    REFERENCES reviewer(id),
     CONSTRAINT chk_rating check (rating >0 and rating <=10)
  );
  ALTER table trailer
ADD movie_id int;
describe trailer;

ALTER TABLE trailer
ADD CONSTRAINT fk_trailer_movie
FOREIGN KEY (movie_id) REFERENCES movie(id) on delete cascade;

