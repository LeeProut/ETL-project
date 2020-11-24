CREATE TABLE governor_result (
index INT PRIMARY KEY, 
state VARCHAR (255), 
county VARCHAR (255), 
candidate VARCHAR (255), 
party VARCHAR (255),
candidate_votes INT, 
won BOOL, 
percent_count INT, 
percent_votes FLOAT	
);

SELECT * FROM governor_result

CREATE TABLE governor_cn_winner (
index INT PRIMARY KEY, 
state VARCHAR (255), 
county VARCHAR (255), 
candidate VARCHAR (255), 
party VARCHAR (255),
candidate_votes INT, 
won BOOL, 	
percent_count INT, 
percent_votes FLOAT		
); 

SELECT * FROM governor_cn_winner

CREATE TABLE governor_st_winner (
index INT PRIMARY KEY, 
state VARCHAR (255), 
candidate VARCHAR (255), 
candidate_votes INT	
); 

SELECT * FROM governor_st_winner

CREATE TABLE gov_total_votes (
index INT PRIMARY KEY, 
state VARCHAR (255), 
votes INT
); 

SELECT * FROM gov_total_votes 


