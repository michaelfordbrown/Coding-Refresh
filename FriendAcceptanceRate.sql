--
-- INTERVIEW QUESTION
--     Friend Acceptance Rate
--
-- AUTHOR
--     Mike Brown (mike.brown20160630@gmail.com)
--
-- DESCRIPTION
-- Write a SQL query to find out the overall friend acceptance rate for each day.
-- friend_requests: ds | sender | receiver | action (Sent, accepted, rejected etc).
-- DAY(ds) | friend_acceptance_rate(receiver) = accepted(receiver)/total(receiver)
-- for each receiver count distent accepter 
--
-- DATA
--     friend_requests: friend_requests_id, ds, sender, receiver, action
--
-- OUTPUT
--     User, Day, FriendRate
--
--     General approach to writing SQL
--
--     
--     2. Get some working code
--
--     2.1 Create tables with test data

--      CREATE TABLE  friend_requests (
--          friend_requests_id INT ,
--          ds DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
--          sender INT,
--          receiver INT,
--          action varchar(50),
--      );

INSERT INTO friend_requests
VALUES (1, DATEADD(DAY, 1, CURRENT_TIMESTAMP), 2, 1, 'accepted')
, (2, DATEADD(DAY, 1, CURRENT_TIMESTAMP), 2, 1, 'accepted')
, (4, DATEADD(DAY, 1, CURRENT_TIMESTAMP), 2, 1, 'no')
, (3, DATEADD(DAY, 1, CURRENT_TIMESTAMP), 2, 2, 'accepted')

--
--     2.2 Get the basics working to check test data correct etc.
--
--     3. Get the joins right (One join at a time)
--
--     4. Write any expressions and verify them (starting in the SELECT clause > WHERE clause)
--
--     5. Write any where clause expressions and verify them
--
--     
--     6. Arrange the columns and rows in preparation for grouping

--
--     7. Add the grouping, visually verfiy
--
--
--     8. Add the having
--
--     9. Add the order by
--
--    10. Tidy up the code
--


BEGIN TRAN

CREATE TABLE  friend_requests (

friend_requests_id int ,
ds DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
sender int,
receiver int,
action varchar(50),
PRIMARY KEY (friend_requests_id)

);

INSERT INTO friend_requests
VALUES (1, DATEADD(DAY, 1, CURRENT_TIMESTAMP), 2, 1, 'accepted')
, (2, DATEADD(DAY, 1, CURRENT_TIMESTAMP), 2, 1, 'accepted')
, (4, DATEADD(DAY, 1, CURRENT_TIMESTAMP), 2, 1, 'no')
, (3, DATEADD(DAY, 1, CURRENT_TIMESTAMP), 2, 2, 'accepted')

SELECT fr.receiver, DAY(fr.ds) AS Day, 
(
  CAST(
  
        COUNT(
	     CASE WHEN fr.action = 'accepted' THEN 1 ELSE NULL END
		 ) * 1.00 
		 
		 /COUNT(*) * 100 

		 AS DECIMAL (5,2))
     )
  
  AS FriendRate


FROM friend_requests AS fr

GROUP BY DAY(fr.ds), fr.receiver

ORDER BY fr.receiver, DAY(fr.ds) 

ROLLBACK TRAN