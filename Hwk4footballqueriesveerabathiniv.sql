USE epl_db;

/* 4 Matches day 1 in which home team won .
   Home team : team 1 , away team : team 2 */
SELECT Match_Num , Team_1 as home_team, Team_2 as away_team FROM matches WHERE `Full time score Team_1` > `Full time score Team_2` AND Match_Day = 1;

/* 5 Teams having more than one manager per season */
SELECT Team,COUNT(*) AS number_managers FROM managers GROUP BY Team HAVING COUNT(*) > 1;  

/* 6 Manager working for more than one team */
SELECT Manager,COUNT(*) AS number_teams FROM managers GROUP BY Manager HAVING COUNT(*) > 1;

/* 7 Active Managers , teams and goals scored by teams in home stadium  */
SELECT Manager,Team,number_goals FROM managers INNER JOIN 
(SELECT Team_1 , SUM(`Full time score Team_1`) AS number_goals FROM matches GROUP BY Team_1 ORDER BY number_goals DESC) AS TEAM_GOALS_TBL
ON Team = Team_1 AND `Status` = 'ACTIVE' ORDER BY number_goals DESC;

/* 8 Active manager's , number of matches won by their team */
SELECT Manager,Team , COUNT(*) as num_matches_won FROM managers INNER JOIN matches ON 
(Team = Team_1 AND `Full time score Team_1` > `Full time score Team_2`)
OR (Team = Team_2 AND `Full time score Team_1` < `Full time score Team_2`)
AND `Status` = 'ACTIVE' GROUP BY Team ORDER BY num_matches_won DESC; 

/* 9 Assuming team_1 is where the home stadium and total goals is Full time score 1 + Full time score 2 , rearranging them in 
     descending order and retriving the max value like below , to get the team_1 with max goals and thereby goals scored */
SELECT Venue from stadiums INNER JOIN
(SELECT Team , MAX(goals_scored) from stadiums INNER JOIN
(SELECT Team_1 , SUM(`Full time score Team_1` + `Full time score Team_2`) as goals_scored FROM matches GROUP BY Team_1) AS TEAM_GOALS_TBL
ON Team = Team_1) AS MAX_GOALS_TBL WHERE MAX_GOALS_TBL.Team = stadiums.Team;

/* 10 Respective teams and number of draws they participated in */
SELECT Team , COUNT(*) as num_matches_draw FROM stadiums INNER JOIN matches WHERE (Team = Team_1 OR Team = Team_2) 
AND `Full time score Team_1` = `Full time score Team_2` GROUP BY Team ORDER BY num_matches_draw DESC;

/* 11 Respective teams and number of clean sheets they got */
SELECT Team , COUNT(*) as num_clean_sheets FROM stadiums INNER JOIN matches WHERE (Team = Team_1 AND `Full time score Team_2` = 0) 
OR (Team = Team_2 AND `Full time score Team_1` = 0) GROUP BY Team ORDER BY num_clean_sheets DESC LIMIT 5;

/* 12 Matches between christmas and new year where Team_1 ( home ) scored more than 3 goals */
SELECT * FROM matches WHERE (Date BETWEEN '2017-12-25' AND '2018-1-3') AND (`Full time score Team_1` >= 3);

/* 13 Matches where team losing in first half wins at the end */
SELECT * FROM matches WHERE 
((`Half time score Team_1` > `Half time score Team_2` ) AND (`Full time score Team_1` < `Full time score Team_2`))
OR
((`Half time score Team_1` < `Half time score Team_2` ) AND (`Full time score Team_1` > `Full time score Team_2`));

/* 14 Top 5 teams as per matches won */
SELECT Team FROM stadiums INNER JOIN matches ON 
(Team = Team_1 AND `Full time score Team_1` > `Full time score Team_2`)
OR (Team = Team_2 AND `Full time score Team_1` < `Full time score Team_2`)
GROUP BY Team ORDER BY COUNT(*) DESC LIMIT 5; 

/* 15 avg goals statistics for a team in home and away environment */
SELECT Team , avg_goals_scored_home , avg_goals_conceded_home , avg_goals_scored_away , avg_goals_conceded_away FROM stadiums INNER JOIN
(SELECT Team as home_team, (SUM(`Full time score Team_1`) / COUNT(*)) as avg_goals_scored_home , (SUM(`Full time score Team_2`) / COUNT(*)) as avg_goals_conceded_home
FROM stadiums INNER JOIN matches ON Team = Team_1 GROUP BY home_team) AS HOME_STATS_TBL INNER JOIN
(SELECT Team as away_team, (SUM(`Full time score Team_2`) / COUNT(*)) as avg_goals_scored_away , (SUM(`Full time score Team_1`) / COUNT(*)) as avg_goals_conceded_away
FROM stadiums INNER JOIN matches ON Team = Team_2 GROUP BY away_team) AS AWAY_STATS_TBL ON (Team = home_team AND Team = away_team) GROUP BY Team;


