show databases;
create database dbmovie;
use dbmovie;
create table movie
(
id int(16) unsigned not null auto_increment,
title varchar(50),
_year year,
duration int(4) unsigned,
country varchar(50),
_language varchar(50),
release_date date,
CONSTRAINT pk_movie PRIMARY KEY (id)
);
drop table movie;
create table actor
 (id int(16) unsigned not null auto_increment,
  first_name varchar(50),
  last_name varchar(50),
  gender enum('female','male','other'),
   CONSTRAINT pk_actor PRIMARY KEY (id)
 );
 create table director(
 id int(16) unsigned not null auto_increment,
 first_name varchar(50),
 last_name varchar(50),
 CONSTRAINT pk_director PRIMARY KEY (id)
 );
 create table reviewer(
 id int(16) unsigned not null auto_increment,
 _name varchar(50),
  CONSTRAINT pk_reviewer PRIMARY KEY (id)
 );
 create table trailer (
  id int(16) unsigned not null auto_increment,
  link varchar(100),
  CONSTRAINT pk_trailer PRIMARY KEY (id)
  );
  create table movie_actor(
  movie_id int(16) unsigned,
  actor_id int(16) unsigned,
  role enum('Background',' Recurring character','Side character','Series regular'),
   CONSTRAINT fk_movie_actor_movie_id_id FOREIGN KEY (movie_id)
    REFERENCES movie(id),
     CONSTRAINT fk_movie_actor_actor_id_id FOREIGN KEY ( actor_id)
    REFERENCES actor(id)
  );

  create table movie_director(
  director_id int(16) unsigned ,
  movie_id int(16) unsigned,
  CONSTRAINT fk_movie_director_director FOREIGN KEY (director_id)
    REFERENCES director(id),
  CONSTRAINT fk_movie_director_movie FOREIGN KEY (movie_id)
    REFERENCES movie( id)
     
  );
  create table movie_reviewer(
  movie_id int(16) unsigned ,
  reviewer_id int(16) unsigned,
  rating int(4) unsigned,
    CONSTRAINT fk_movie_reviewer_movie FOREIGN KEY (movie_id)
    REFERENCES movie(id),
    CONSTRAINT fk_movie_reviewer_reviewer FOREIGN KEY (reviewer_id)
    REFERENCES reviewer(id),
     CONSTRAINT chk_rating check (rating >0 and rating <=10)
  );
  ALTER table trailer
ADD movie_id int(16) unsigned;
describe trailer;

ALTER TABLE trailer
ADD CONSTRAINT fk_trailer_movie
FOREIGN KEY (movie_id) REFERENCES movie(id) on delete cascade;

drop table act;
drop table direct;
drop table review;

drop table actor;
drop table movie;
drop table director;
drop table reviewer ;
drop table trailer;
drop table movie_actor;
drop table movie_director;
drop table movie_reviewer;
INSERT INTO movie(title,_year,duration,country,_language,release_date)
VALUES('Doctor Strange in the Multiverse of Madness','2022','126','USA','English','2022-5-6'); 
INSERT INTO movie(title,_year,duration,country,_language,release_date)
VALUES('Supernova','2020','93','UK','English','2020-9-22'),
      ('The Secret Garden','2020','100','France','English','2020-4-15'),
	  ('Paddington','2014','95','UK','English','2014-11-23'),
      ('Nanny McPhee','2005','97','UK','English','2005-10-21'); 
INSERT INTO actor(first_name,last_name,gender)
VALUES ('Emma','Thompson','female'),
       ('Thomas','Brodie-Sangster','male'),
       ('Ben','Whishaw','male'),
       ('Mark','Wahlberg','male'),
       ('Dixie','Egerickx','female'),
       ('Will','Poulter','male'),
       ('Charlotte','Rampling','female');
       describe movie;
       select* from movie join actor;
       INSERT INTO movie_actor(movie_id,actor_id,role)
	   VALUES ('1','1',' Recurring character'),
			  ('2','1',' Recurring character'),
              ('3','2','Background'),
			  ('4','3','Side character'),
              ('1','4','Side character'),
              ('2','3','Series regular');
       INSERT INTO director(first_name,last_name)
	   VALUES ('Steven','Spielberg'),
			  ('Martin','Scorsese'),
              ('Stanley','Kubrick'),
              ('Quentin','Tarantino'),
              ('Christopher','Nolan');
              
	  INSERT INTO movie_director
      VALUES('1','2'),
            ('2','1'),
			('3','1'),
			('3','4'),
			('4','5');
	 INSERT INTO reviewer(_name)
     VALUES ('Deyar44'),
            ('D11111'),
            ('s123456'),
            ('gam543'),
            ('hi12344');
	 INSERT INTO movie_reviewer
     VALUES ('1','2','9'),
            ('1','3','7'),
            ('2','1','5'),
            ('3','1','5'),
            ('4','5','5');
	 INSERT INTO trailer (movie_id,link)
     VALUES ('2','https://www.youtube.com/watch?v=T4BzzHYQUNg'),
            ('2','https://www.youtube.com/watch?v=bRz2hY6ykGE'),
            ('1','https://www.youtube.com/watch?v=aWzlQ2N6qqg'),
            ('3','https://www.youtube.com/watch?v=gHNOXDiD9Vk'),
            ('3','https://www.youtube.com/watch?v=sWfgTiJ3sCs');
            