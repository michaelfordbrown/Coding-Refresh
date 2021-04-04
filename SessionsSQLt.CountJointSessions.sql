USE [InterviewQuestions]
GO
/****** Object:  StoredProcedure [SessionsSQLt].[CountJointSessions]    Script Date: 04/04/2021 20:17:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [SessionsSQLt].[CountJointSessions]
AS

BEGIN

IF OBJECT_ID(N'SessionsSQLt.NoOfSessions') IS NOT NULL
 DROP TABLE SessionsSQLt.NoOfSessions

SELECT CONVERT(DATE, dbo.iPhoneSessions.LoginDate) AS [Day],
       COUNT(dbo.iPhoneSessions.UserId) AS NoOfJointSessions  

INTO SessionsSQLt.NoOfSessions

FROM dbo.iPhoneSessions

INNER JOIN dbo.webSessions
      ON dbo.iPhoneSessions.UserId = dbo.webSessions.UserId
      AND dbo.iPhoneSessions.LoginDate = dbo.webSessions.LoginDate

GROUP BY dbo.iPhoneSessions.LoginDate

END
