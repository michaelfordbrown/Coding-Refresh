USE [InterviewQuestions]
GO
/****** Object:  StoredProcedure [SessionsSQLt].[Test to check routine outputs correct data in table given normal input>]    Script Date: 04/04/2021 19:46:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [SessionsSQLt].[Test to check routine outputs correct data in table given normal input>] 
AS
BEGIN
  --Assemble

IF OBJECT_ID(N'SessionsSQLt.Users') IS NOT NULL
  DROP TABLE SessionsSQLt.Users

  CREATE TABLE SessionsSQLt.Users (
    UserId INT,
    UserName VARCHAR(50)
);

INSERT INTO SessionsSQLt.Users
 VALUES (1, 'Sun')
 , (2, 'Butterfly')
 , (3, 'Max')
 , (4, 'Alex');

IF OBJECT_ID(N'SessionsSQLt.iPhoneSessions') IS NOT NULL
  DROP TABLE SessionsSQLt.iPhoneSessions

CREATE TABLE SessionsSQLt.iPhoneSessions (
    SessionId INT,
    UserId INT,
    LoginDate DATETIME,
);
 
INSERT INTO SessionsSQLt.iPhoneSessions VALUES 
  (1, 1, CONVERT(DATETIME, '2021-04-02'))
 ,(2, 3, CONVERT(DATETIME, '2021-04-02'))
 ,(3, 1, CONVERT(DATETIME, '2021-04-04'))
 ,(4, 2, CONVERT(DATETIME, '2021-04-04'));

IF OBJECT_ID(N'SessionsSQLt.webSessions') IS NOT NULL
  DROP TABLE SessionsSQLt.webSessions

CREATE TABLE SessionsSQLt.webSessions (
    SessionId INT,
    UserId INT,
    LoginDate DATETIME,
);

INSERT INTO SessionsSQLt.webSessions VALUES 
  (1, 1, CONVERT(DATETIME, '2021-04-02'))
 ,(2, 2, CONVERT(DATETIME, '2021-04-03'))
 ,(3, 2, CONVERT(DATETIME, '2021-04-03'))
 ,(4, 2, CONVERT(DATETIME, '2021-04-04'))
 ,(5, 1, CONVERT(DATETIME, '2021-04-04'));

IF OBJECT_ID(N'SessionsSQLt.Expected') IS NOT NULL
  DROP TABLE SessionsSQLt.Expected

CREATE TABLE SessionsSQLt.Expected (
    [Day] DATE, 
	NoOfJointSessions  INT
);

INSERT INTO SessionsSQLt.Expected VALUES
   (CONVERT(DATE,'2021-04-02'), 1)
  ,(CONVERT(DATE,'2021-04-04'), 2);

  --Act

EXEC  SessionsSQLt.CountJointSessions

SELECT * INTO SessionsSQLt.Actual FROM SessionsSQLt.NoOfSessions

  --Assert

EXEC tSQLt.AssertEqualsTable 
@Expected = N'SessionsSQLt.Expected'
, @Actual = N'SessionsSQLt.Actual'
, @FailMsg = N'The expected data was not returned.'

END;

