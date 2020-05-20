USE epl_db;

/* 4 Matches day 1 in which home team won .
   Home team : team 1 , away team : team 2 */
SELECT Match_Num , Team_1 , Team_2 FROM matches WHERE `Full time score Team_1` > `Full time score Team_2` AND Match_Day = 1;

/* 5 Teams having more than one manager per season */
SELECT Team,COUNT(*) AS number_managers FROM managers GROUP BY Team HAVING COUNT(*) > 1;  

/* 6 Manager working for more than one team */
SELECT Manager,COUNT(*) AS number_teams FROM managers GROUP BY Manager HAVING COUNT(*) > 1;

/* 7 Managers , teams and goals scored by teams in home stadium */
SELECT Manager,Team,number_goals FROM managers INNER JOIN 
(SELECT Team_1 , SUM(`Full time score Team_1`) AS number_goals FROM matches GROUP BY Team_1 ORDER BY number_goals DESC) AS TEAM_GOALS_TBL
ON Team = Team_1 AND `Status` = 'ACTIVE' ORDER BY number_goals DESC;

/* 8 */
SELECT Manager,Team , COUNT(*) as num_matches_won FROM managers INNER JOIN matches ON 
Team = Team_1 AND `Full time score Team_1` > `Full time score Team_2`
OR Team = Team_2 AND `Full time score Team_1` < `Full time score Team_2`
AND `Status` = 'ACTIVE' GROUP BY Team ORDER BY num_matches_won DESC; 

/* 9 */
