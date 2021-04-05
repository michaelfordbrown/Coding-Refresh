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
-- SQL DEVELOPMENT PROCESS
--
--     1. Look at the question and confirm what is needed
--
--        Find friend acceptance rate = 
--
--            receiver accepted messages / total messages for reciever * 100
--
--     1.1. What tables are needed
--
--          Friend Request table that records:
--
--              - message orginator
--              - message receiptent 
--              - date
--              - action (freiend request, request accepted, request not accepted)
--
--     1.2. Is GROUP BY needed?
-- 
--          Needed to collect information by date
--
--     1.3. Is a subquery needed?
--
--          Get the sent details (recipients and date):
--
--              SELECT user_id_sender, user_id_receiver, [date]  
--              FROM fb_friends_requests
--              WHERE [action] = 'sent'
--
--          Get the accepted detais (recipients and date)
--
--              SELECT user_id_sender, user_id_receiver, [date]  
--              FROM fb_friends_requests
--              WHERE [action] = 'accepted'
--
--     1.4. Joins needed?
--
--          Yes.
--          It would not be one-to-one but more sent than accepted messages
--
--          sent messages LEFT JOIN accepted messages
--          Joined to match the accepted message for sender message 
--          (by user id's)
--
--     1.5. Big expressions?
--     
--          Calculate the Acceptance Rate by date:
--
--          COUNT(number of accepted messages) /
--          COUNT(number of sent messages) * 100
--
--     2. Get some working code
--
--     2.1 Create tables with test data
--
--      CREATE TABLE  fb_friends_requests (
--                    sender VARCHAR(50),
--                    receiver VARCHAR(50),
--                    ds DATETIME,
--                    action varchar(50)
--      );
--
--      INSERT INTO fb_friends_requests VALUES 
--          ('ad4943sdz', '948ksx123d', CONVERT(DATETIME, '2020-01-04'), 'sent')
 --        ,('fg503kdsdd', 'ofp049dkd', CONVERT(DATETIME, '2020-01-04'), 'sent')
 --        ,('dfdfxf9483', '9djjjd9283', CONVERT(DATETIME, '2020-01-04'), 'sent')
 --        ,('hh643dfert', '847jfkf203', CONVERT(DATETIME, '2020-01-04'), 'sent')
 --        ,('ad4943sdz', '948ksx123d', CONVERT(DATETIME, '2020-01-06'), 'accepted')
 --        ,('fffkfld9499', '993lsldidif', CONVERT(DATETIME, '2020-01-06'), 'sent')
 --        ,('fg503kdsdd', 'ofp049dkd', CONVERT(DATETIME, '2020-01-10'), 'accepted')
 --        ,('fffkfld9499', '993lsldidif', CONVERT(DATETIME, '2020-01-10'), 'accepted')
 --        ,('r4gfgf2344', '234ddr4545', CONVERT(DATETIME, '2020-01-06'), 'sent')
 --        ,('ffdfff4234234', 'lpjzjdi4949', CONVERT(DATETIME, '2020-01-06'), 'sent')
 --        ,('r4gfgf2344', '234ddr4545', CONVERT(DATETIME, '2020-01-11'), 'accepted')
 --        ,('dfdfxf9483', '9djjjd9283', CONVERT(DATETIME, '2020-01-15'), 'accepted');
--
--     2.2 Get the basics working to check test data correct etc.
--
--      SELECT user_id_sender, user_id_receiver, [date] FROM fb_friends_requests
--
--      
--
--     3. Get the joins right (One join at a time)
--
--          Sent messages LEFT JOIN accpted messgaes 
--          by users
--
--           SELECT *
--           FROM  
--              (SELECT user_id_sender, user_id_receiver, [date]  
--          	 FROM fb_friends_requests
--          	 WHERE [action] = 'sent') AS sent
--
--            LEFT JOIN
--          	(SELECT user_id_sender, user_id_receiver, [date]  
--            FROM fb_friends_requests
--            WHERE [action] = 'accepted') AS accpeted
--
--            ON accpeted.user_id_sender = sent.user_id_sender
--            AND accpeted.user_id_receiver = sent.user_id_receiver
--
--     4. Write any expressions and verify them (starting in the SELECT clause > WHERE clause)
--
--        COUNT(accpeted fb_friends_requests.user_id_sender) * 1.0 / 
--        COUNT(sent fb_friends_requests.user_id_sender) * 100
--
--     5. Write any where clause expressions and verify them
--
--     
--     6. Arrange the columns and rows in preparation for grouping
--
--        
--
--     7. Add the grouping, visually verfiy
--
--        GROUP BY sent fb_friends_requests.[date]
--
--     8. Add the having
--
--     9. Add the order by
--
--         ORDER BY friend_requests.sender, friend_requests.ds 
--
--    10. Tidy up the code
--
--        Apply CONVERT (DECIMAL) function to reduce the number of digits
--        afte the rate calctions
--
--        CONVERT(DECIMAL(6,2), COUNT(accepted.user_id_sender) * 1.0 / 
--        COUNT([sent].user_id_sender))

IF OBJECT_ID(N'fb_friends_requests') IS NOT NULL
	DROP TABLE fb_friends_requests;

CREATE TABLE fb_friends_requests
(
   user_id_sender VARCHAR(50)
 , user_id_receiver VARCHAR(50)
 , [date] DATETIME
 , [action] VARCHAR(15)
);

INSERT INTO fb_friends_requests VALUES
  ('ad4943sdz', '948ksx123d', CONVERT(DATETIME, '2020-01-04'), 'sent')
 ,('fg503kdsdd', 'ofp049dkd', CONVERT(DATETIME, '2020-01-04'), 'sent')
 ,('dfdfxf9483', '9djjjd9283', CONVERT(DATETIME, '2020-01-04'), 'sent')
 ,('hh643dfert', '847jfkf203', CONVERT(DATETIME, '2020-01-04'), 'sent')
 ,('ad4943sdz', '948ksx123d', CONVERT(DATETIME, '2020-01-06'), 'accepted')
 ,('fffkfld9499', '993lsldidif', CONVERT(DATETIME, '2020-01-06'), 'sent')
 ,('fg503kdsdd', 'ofp049dkd', CONVERT(DATETIME, '2020-01-10'), 'accepted')
 ,('fffkfld9499', '993lsldidif', CONVERT(DATETIME, '2020-01-10'), 'accepted')
 ,('r4gfgf2344', '234ddr4545', CONVERT(DATETIME, '2020-01-06'), 'sent')
 ,('ffdfff4234234', 'lpjzjdi4949', CONVERT(DATETIME, '2020-01-06'), 'sent')
 ,('r4gfgf2344', '234ddr4545', CONVERT(DATETIME, '2020-01-11'), 'accepted')
 ,('dfdfxf9483', '9djjjd9283', CONVERT(DATETIME, '2020-01-15'), 'accepted');

 SELECT CONVERT(DECIMAL(6,2), COUNT(accepted.user_id_sender) * 1.0 / COUNT([sent].user_id_sender) * 100)
 , [sent].[date] 
  
 FROM  
     (SELECT user_id_sender, user_id_receiver, [date]  
	 FROM fb_friends_requests
	 WHERE [action] = 'sent') AS [sent]

LEFT JOIN
	(SELECT user_id_sender, user_id_receiver, [date]  
	 FROM fb_friends_requests
	 WHERE [action] = 'accepted') AS accepted

	 ON accepted.user_id_sender = [sent].user_id_sender
	 AND accepted.user_id_receiver = [sent].user_id_receiver

GROUP BY [sent].[date]
