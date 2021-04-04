CREATE PROCEDURE CountJointSessions
AS

BEGIN

SELECT CONVERT(DATE, dbo.iPhoneSessions.LoginDate) AS [Day],
       COUNT(dbo.iPhoneSessions.UserId) AS NoOfJointSessions  

FROM dbo.iPhoneSessions

INNER JOIN dbo.webSessions
      ON dbo.iPhoneSessions.UserId = dbo.webSessions.UserId
      AND dbo.iPhoneSessions.LoginDate = dbo.webSessions.LoginDate

GROUP BY dbo.iPhoneSessions.LoginDate

END