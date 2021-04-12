--
-- INTERVIEW QUESTION
--     Highest Energy Consumption
--
-- AUTHOR
--     Mike Brown (mike.brown20160630@gmail.com)
--
-- DATA
--
--
-- OUTPUT
--
-- PROGRAMMING NOTES
--
--      1. Confirm Requirements
--
--          Find the date with the highest total energy consumption from 
--          the Facebook data centers. 
--          Output the date along with the total energy consumption across 
--          all data centers.
--
--          Output
--
--              date	    total_energy
--              2020-01-06	1250
--              2020-01-07	1250
--
--      2. Determine Tables Needed
--
--       fb_eu_energy:
--          date	        consumption
--           2020-01-01	    400
--           2020-01-02	    350
--           2020-01-03	    500
--           2020-01-04	    500
--           2020-01-07	    600
--
--       fb_asia_energy:
--          date	        consumption
--          2020-01-01	400
--          2020-01-02	400
--          2020-01-04	675
--          2020-01-05	1200
--          2020-01-06	750
--          2020-01-07	400
--
--       fb_na_energy
--          date	        consumption
--          2020-01-01	250
--          2020-01-02	375
--          2020-01-03	600
--          2020-01-06	500
--          2020-01-07	250
--
--      3. Get some working code
--
--      3.1 Create tables with test data
--
            IF OBJECT_ID('fb_eu_energy') IS NOT NULL
                DROP TABLE fb_eu_energy

            CREATE TABLE fb_eu_energy(
            [date] DATETIME
            , consumption INT
            );

            IF OBJECT_ID('fb_asia_energy') IS NOT NULL
                DROP TABLE fb_asia_energy

            CREATE TABLE fb_asia_energy(
            [date] DATETIME
            , consumption INT
            );

            IF OBJECT_ID('fb_na_energy') IS NOT NULL
                DROP TABLE fb_na_energy

            CREATE TABLE fb_na_energy(
            [date] DATETIME
            , consumption INT
            )
--
            INSERT INTO fb_eu_energy VALUES
            (CONVERT(DATETIME, '2020-01-01'), 400)
            , (CONVERT(DATETIME, '2020-01-02'), 350)
            , (CONVERT(DATETIME, '2020-01-03'), 500)
            , (CONVERT(DATETIME, '2020-01-04'), 500)
            , (CONVERT(DATETIME, '2020-01-07'), 600)

            INSERT INTO fb_asia_energy VALUES
            (CONVERT(DATETIME, '2020-01-01'), 400)
            , (CONVERT(DATETIME, '2020-01-02'), 400)
            , (CONVERT(DATETIME, '2020-01-04'), 675)
            , (CONVERT(DATETIME, '2020-01-05'),1200)
            , (CONVERT(DATETIME, '2020-01-06'), 750)
            , (CONVERT(DATETIME, '2020-01-07'), 400)

            INSERT INTO fb_na_energy VALUES
            (CONVERT(DATETIME, '2020-01-01'), 250)
            , (CONVERT(DATETIME, '2020-01-02'), 375)
            , (CONVERT(DATETIME, '2020-01-03'), 600)
            , (CONVERT(DATETIME, '2020-01-06'), 500)
            , (CONVERT(DATETIME, '2020-01-07'), 250)
--
--      3.2 Get the basics working to check test data correct etc.
--
            SELECT [date], consumption FROM fb_eu_energy
            SELECT [date], consumption FROM fb_asia_energy
            SELECT [date], consumption FROM fb_na_energy
--
--      3.3 Determine which data sets are necessary
--
--          Put all of the tables together inorder to sort to find the 
--          maximum energy consumption.
--
			SELECT *
			FROM fb_eu_energy

			UNION ALL

			SELECT * 
			FROM fb_asia_energy

			UNION ALL

			SELECT * 
			FROM fb_na_energy
--
--     3. Get the joins right (One join at a time)
--
--          No joins necessary
--
--     4. Write any expressions and verify them (starting in the SELECT clause > WHERE clause)
--
--          Get the sum total energy consumption (by date) from all tables
--
            SELECT temp_max.date, SUM(temp_max)
            FROM
                (
--                  all site consumption tables
                ) AS temp_max
--
--
--     5. Write any where clause expressions and verify them
--     
--     6. Arrange the columns and rows in preparation for grouping
--
--
--     7. Add the grouping, visually verfiy
--
--        Grouping by date needed to determine sum of energy by date.
--
          GROUP BY temp_max.[date]
--
--        Grouping by the highest energy by date

          GROUP BY {determined max energy},{date of each max energy}           
--
--     8. Add the having
--
--     9. Add the order by
--
--    10. Tidy up the code
--
--        Use a Common Table Expression (CTE) to creatye a temporary result
--        to find the maximum energy value for each date
--
           WITH FindMaxEnergy_CTE([date], MaxEnergy)
           AS
           (
            SELECT temp_max.[date], SUM(temp_max.consumption)
            FROM
                (
                    SELECT *
                    FROM fb_eu_energy

                    UNION ALL

                    SELECT * 
                    FROM fb_asia_energy

                    UNION ALL

                    SELECT * 
                    FROM fb_na_energy
                ) AS temp_max 
            GROUP BY temp_max.[date]                             
           )

            SELECT findmaxenergy.[date], findmaxenergy.MaxEnergy
            AS total_energy_consumption

            FROM FindMaxEnergy_CTE AS findmaxenergy

            GROUP BY findmaxenergy.MaxEnergy, findmaxenergy.[date]

            HAVING findmaxenergy.MaxEnergy =
            (
                SELECT TOP 1 MaxEnergy
                FROM FindMaxEnergy_CTE
                ORDER BY MaxEnergy DESC
            )

-- CHANGE HISTORY
--   
