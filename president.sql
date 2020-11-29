CREATE TABLE president_result (
	index INT PRIMARY KEY,
	state VARCHAR(255),
	county VARCHAR(255),
	candidate VARCHAR(255),
	party VARCHAR(255),
	candidate_votes INT,
	won BOOL, 
	percent_count INT,	
	percent_votes FLOAT
);

SELECT * FROM president_result;

CREATE TABLE president_cn_winner (
	index INT PRIMARY KEY,
	state VARCHAR(255),
	county VARCHAR(255),
	candidate VARCHAR(255),
	party VARCHAR(255),
	candidate_votes INT,
	won BOOL, 
	percent_count INT,	
	percent_votes FLOAT
);

SELECT * FROM president_cn_winner;

CREATE TABLE president_st_winner (
	index INT PRIMARY KEY,
	state VARCHAR(255),
	candidate VARCHAR(255),
	candidate_votes INT
);

SELECT * FROM president_st_winner;

CREATE TABLE presedent_total_votes (
	state VARCHAR(255),
	votes INT
);

SELECT pcw.state, pcw.county, pcw.candidate, 
		pcw.candidate_votes, pr.percent_votes
FROM president_cn_winner as pcw
INNER JOIN president_result as pr
ON pcw.index = pr.index;




