--
-- INTERVIEW QUESTION
--     Name of test.
--
-- AUTHOR
--     Mike Brown (mike.brown20160630@gmail.com)
--
-- DESCRIPTION
--     Write a SQL query to count the number of unique users 
--     per day who logged in from both iPhone AND Web (for that day),
--     Where iPhone logs and Web logs are in distinct relations
--
-- DATA
--     Users: UserId, UserName
--     iPhoneSessions: SessionsId, UserId, LoginDate, LogoutDate
--     WebSessions: SessionsId, UserId, LoginDate, LogoutD
--
-- OUTPUT
--     Day, NumberOfUsers
--
-- PROGRAMMING NOTES
--     General approach to writing SQL
--
--     1. Look at the question and confirm what is needed
--     1.1. What tables are needed
--     1.2.Is GROUP BY needed?
--     1.3. Is a subquery needed?
--     1.4. Joins needed?
--     1.5. Big expressions?
--     
--     2. Get some working code
--
--     2.1 Create tables with test data
--
--          CREATE TABLE Users (
--             UserId INT,
--             UserName VARCHAR(50)
--          );
--
--          CREATE TABLE iPhoneSessions (
--             SessionId INT,
--             UserId INT,
--             LoginDate DATETIME,
--          );
--
--          CREATE TABLE webSessions (
--             SessionId INT,
--             UserId INT,
--             LoginDate DATETIME,
--          );
--
--           INSERT INTO Users
--           VALUES 
--             (1, 'Sun')
--           , (2, 'Butterfly')
--           , (3, 'Max')
--           , (4, 'Alex');
--
--          INSERT INTO iPhoneSessions VALUES 
--             (1, 1, CONVERT(DATETIME, '2021-04-02'))
--            ,(2, 3, CONVERT(DATETIME, '2021-04-02'))
--            ,(3, 1, CONVERT(DATETIME, '2021-04-04'))
--            ,(4, 2, CONVERT(DATETIME, '2021-04-04'));
--
--          INSERT INTO webSessions VALUES 
--             (1, 1, CONVERT(DATETIME, '2021-04-02'))
--            ,(2, 2, CONVERT(DATETIME, '2021-04-03'))
--            ,(3, 2, CONVERT(DATETIME, '2021-04-03'))
--            ,(4, 2, CONVERT(DATETIME, '2021-04-04'))
--            ,(5, 1, CONVERT(DATETIME, '2021-04-04'));
--
--     2.2 Get the basics working to check test data correct etc.
--
--         SELECT UserName
--         FROM Users
--
--         SELECT UserId,LoginDate
--         FROM iPhoneSessions
--
--         SELECT UserId, LoginDate
--         FROM webSessions
--
--     3. Get the joins right (One join at a time)
--
--        SELECT *
--		  FROM iPhoneSessions
--
--		  INNER JOIN webSessions
--		  ON iPhoneSessions.UserId = webSessions.UserId
--
--		  INNER JOIN webSessions
--		  ON iPhoneSessions.LoginDate = webSessions.LoginDate
--
--
--		  INNER JOIN webSessions
--		  ON iPhoneSessions.UserId = webSessions.UserId
--		  AND iPhoneSessions.LoginDate = webSessions.LoginDate
--
--     4. Write any expressions and verify them (starting in the SELECT clause > WHERE clause)
--       
--          CONVERT(DATE, iPhoneSessions.LoginDate) AS [Day],
--          COUNT(iPhoneSessions.UserId) AS NoOfJointSessions 
--
--     5. Write any where clause expressions and verify them
--
--		  COUNT(iPhoneSessions.UserId) AS NoOfJointSessions  
--     
--     6. Arrange the columns and rows in preparation for grouping
--
--        SELECT iPhoneSessions.LoginDate, 
--               COUNT(iPhoneSessions.UserId) AS NoOfJointSessions     
--
--     7. Add the grouping, visually verfiy
--
--        GROUP BY iPhoneSessions.LoginDate
--
--     8. Add the having
--
--     9. Add the order by
--
--    10. Tidy up the code
--
-- CHANGE HISTORY
--   


CREATE TABLE Users (
    UserId INT,
    UserName VARCHAR(50)
);

CREATE TABLE iPhoneSessions (
    SessionId INT,
    UserId INT,
    LoginDate DATETIME,
);

CREATE TABLE webSessions (
    SessionId INT,
    UserId INT,
    LoginDate DATETIME,
);

INSERT INTO Users
 VALUES (1, 'Sun')
 , (2, 'Butterfly')
 , (3, 'Max')
 , (4, 'Alex');
 
INSERT INTO iPhoneSessions VALUES 
  (1, 1, CONVERT(DATETIME, '2021-04-02'))
 ,(2, 3, CONVERT(DATETIME, '2021-04-02'))
 ,(3, 1, CONVERT(DATETIME, '2021-04-04'))
 ,(4, 2, CONVERT(DATETIME, '2021-04-04'));

INSERT INTO webSessions VALUES 
  (1, 1, CONVERT(DATETIME, '2021-04-02'))
 ,(2, 2, CONVERT(DATETIME, '2021-04-03'))
 ,(3, 2, CONVERT(DATETIME, '2021-04-03'))
 ,(4, 2, CONVERT(DATETIME, '2021-04-04'))
 ,(5, 1, CONVERT(DATETIME, '2021-04-04'));


SELECT CONVERT(DATE, dbo.iPhoneSessions.LoginDate) AS [Day],
       COUNT(dbo.iPhoneSessions.UserId) AS NoOfJointSessions  

FROM dbo.iPhoneSessions

INNER JOIN dbo.webSessions
      ON dbo.iPhoneSessions.UserId = dbo.webSessions.UserId
      AND dbo.iPhoneSessions.LoginDate = dbo.webSessions.LoginDate

GROUP BY dbo.iPhoneSessions.LoginDate




