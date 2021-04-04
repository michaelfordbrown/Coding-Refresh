USE [InterviewQuestions]
GO
/****** Object:  StoredProcedure [SessionsSQLt].[TestToCheckSessionsExists]    Script Date: 04/04/2021 20:25:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [SessionsSQLt].[TestToCheckSessionsExists] 
AS
BEGIN
  --Assemble


  --Act

  --Assert
  EXEC tSQLt.AssertObjectExists @ObjectName = N'iPhoneSessions',
       @Message = N'iPhonesSessions does NOT exist'

  EXEC tSQLt.AssertObjectExists @ObjectName = N'webSessions',
       @Message = N'webSessions does NOT exist'

--  EXEC tSQLt.Fail 'This test is not yet written!'

END;