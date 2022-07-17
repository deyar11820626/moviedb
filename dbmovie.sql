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
    REFERENCES reviewer(id) on delete set null,
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
            
      INSERT INTO movie_reviewer
      VALUES ('4','6','5');
	 INSERT INTO trailer (movie_id,link)
     VALUES ('2','https://www.youtube.com/watch?v=T4BzzHYQUNg'),
            ('2','https://www.youtube.com/watch?v=bRz2hY6ykGE'),
            ('1','https://www.youtube.com/watch?v=aWzlQ2N6qqg'),
            ('3','https://www.youtube.com/watch?v=gHNOXDiD9Vk'),
            ('3','https://www.youtube.com/watch?v=sWfgTiJ3sCs');
            select * from movie_actor;
	INSERT INTO reviewer (id)
	  VALUES ('6');
      INSERT INTO movie_reviewer
	  VALUES ('1','6','2');
	#1
	SELECT id,
           first_name, 
           last_name, 
           gender
    FROM actor 
    WHERE actor.id 
    IN (
                      SELECT actor_id
                      FROM movie_actor
                      WHERE movie_id = 
                      (
                        SELECT id
                        FROM movie
                        WHERE movie.title = 'Supernova'
                      ));
       #2               
    SELECT first_name, 
           last_name
    FROM director 
    WHERE director.id 
    IN (
                      SELECT director_id
                      FROM movie_director
                      WHERE movie_id = 
                      (
                        SELECT id
                        FROM movie
                        WHERE movie.title = 'Supernova'
                      ));
        #3
        SELECT title as 'Movie title',
               _year as 'Movie year',
               duration as 'Movie time',
               release_date as 'Date of release',
               country as 'Movie country'
		FROM movie 
        WHERE country != 'USA';               
       #4 find those movies where reviewer is unknown.
       #Return movie title, year, release date, director first name, last name, actor first name, last name  
SELECT movie.title, 
       movie._year as 'Movie year',
       movie.release_date as 'Release date',
       actor.first_name,
       actor.last_name,
       director.first_name,
       director.last_name
FROM movie
INNER JOIN movie_actor ON movie.id = movie_actor.movie_id
INNER JOIN actor ON movie_actor.actor_id = actor.id
INNER JOIN movie_director ON movie.id = movie_director.movie_id
INNER JOIN director ON movie_director.director_id = director.id
WHERE movie.id IN (
	               SELECT movie_reviewer.movie_id
                   FROM movie_reviewer 
                   INNER JOIN reviewer ON movie_reviewer.reviewer_id = reviewer.id
				   WHERE reviewer._name IS NULL
		  ) ;
	   #5
 SELECT movie.title 
 FROM movie
 INNER JOIN movie_director ON movie.id = movie_director.movie_id
 INNER JOIN director ON movie_director.director_id = director.id
 WHERE first_name = 'Stanley' AND last_name = 'Kubrick';
						
         #6
        SELECT DISTINCT _year
        FROM movie
        INNER JOIN movie_reviewer ON movie.id = movie_reviewer.movie_id
        WHERE rating > 3
        ORDER BY _year;  
       #7
       SELECT title
	   FROM movie
	   WHERE movie.id NOT IN (
                               SELECT movie_id 
                               FROM movie_reviewer
							  );
        
        #8
        SELECT _name
        FROM reviewer 
	    WHERE id NOT IN (
                          SELECT reviewer_id
                          FROM movie_reviewer
                        );
		
       #9
SELECT reviewer._name,
       movie.title,
       movie_reviewer.rating as 'Review stars'
FROM movie
INNER JOIN movie_reviewer ON movie.id = movie_reviewer.movie_id
INNER JOIN reviewer ON movie_reviewer.reviewer_id = reviewer.id
WHERE movie_reviewer.rating IS NOT NULL
ORDER BY reviewer._name , movie.title, movie_reviewer.rating;
        
        #10
        SELECT reviewer._name as 'Reviewer`s name',
              movie.title as 'Movie title'
        FROM reviewer
        INNER JOIN movie_reviewer ON reviewer.id = movie_reviewer.reviewer_id
        INNER JOIN movie ON movie_reviewer.movie_id = movie.id
        WHERE reviewer.id IN(
        SELECT reviewer_id
        FROM movie_reviewer 
        GROUP BY reviewer_id
        HAVING count(movie_id)>1)
        GROUP BY reviewer._name, movie.title;
        #11
        SELECT movie.title,
              MAX( movie_reviewer.rating)
        FROM movie 
        INNER JOIN movie_reviewer ON movie_reviewer.movie_id=movie.id
        WHERE movie.id IN(
        SELECT movie_id
        FROM movie_reviewer
        GROUP BY movie_id
        HAVING AVG(rating) IN(
        SELECT MAX( average.num)
        FROM (SELECT AVG(rating) as num FROM movie_reviewer GROUP BY movie_id) AS average))
        GROUP BY movie.title
        ORDER BY movie.title; 
     
      #12
  SELECT _name 
  FROM reviewer 
  WHERE id IN (
               SELECT reviewer_id 
               FROM movie_reviewer
               WHERE movie_id IN (
                                  SELECT id 
                                  FROM movie 
                                  WHERE title = 'Supernova'
                                  )
              );   

      #13
	  insert into reviewer (_name)
      values ('Deyar44');
      insert into movie_reviewer
      VALUES ('2','4','1');
      
      SELECT DISTINCT title
      FROM movie 
      WHERE id IN(
      SELECT movie_id
      FROM movie_reviewer 
      WHERE reviewer_id NOT IN (
                                    SELECT id 
                                    FROM reviewer
									WHERE _name = 'Deyar44'
                                    )
                                    );
                                    select * from movie_reviewer;
      
 
 #14
 SELECT reviewer._name,
        movie.title,
        movie_reviewer. rating
 FROM reviewer
 INNER JOIN movie_reviewer ON movie_reviewer.reviewer_id = reviewer.id
 INNER JOIN movie ON movie.id = movie_reviewer.movie_id
 WHERE movie.id IN(
 SELECT movie_id
 FROM movie_reviewer
 WHERE rating IN (SELECT MIN(rating)
 FROM movie_reviewer)) AND reviewer.id 	IN (SELECT reviewer_id
 FROM movie_reviewer
 WHERE rating IN (SELECT MIN(rating)
 FROM movie_reviewer));
        
SELECT reviewer._name,
        movie.title,
        movie_reviewer. rating
 FROM reviewer
 INNER JOIN movie_reviewer ON movie_reviewer.reviewer_id = reviewer.id
 INNER JOIN movie ON movie.id = movie_reviewer.movie_id
 WHERE movie.id IN(
        SELECT movie_id
        FROM movie_reviewer
        GROUP BY movie_id
        HAVING AVG(rating) IN(
        SELECT MIN( average.num)
        FROM (SELECT AVG(rating) as num FROM movie_reviewer GROUP BY movie_id) AS average));
        #15
SELECT title
FROM movie
WHERE id IN (
			 SELECT movie_id
			 FROM movie_director
			 WHERE director_id IN (
								   SELECT id 
                                   FROM director 
								   WHERE first_name = 'Martin'
                                   )
			);

  #16
       SELECT title
       FROM movie
       WHERE id IN(
       SELECT movie_id
       FROM movie_actor
       WHERE actor_id IN(
       SELECT actor_id
       FROM movie_actor 
       GROUP BY actor_id
       HAVING count(movie_id) >=2));
insert into movie_reviewer values ('4','2','1');
 select * from movie_reviewer;
 select * from movie;
 select * from reviewer;
 INSERT INTO movie_reviewer
 Values ('1','4','9');
 INSERT INTO movie_reviewer
 Values ('2','5','9');
        SELECT _year, 
               count(id) as 'count' 
        FROM movie
        group by _year
	    ORDER BY _year;
       
 #from the lowest to highest
 SELECT movie.title,
        AVG(movie_reviewer.rating)
 FROM movie
 INNER JOIN movie_reviewer ON movie.id = movie_reviewer.movie_id
 GROUP BY movie_reviewer.movie_id
 ORDER BY  AVG(movie_reviewer.rating),movie.title;

       