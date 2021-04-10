--
-- INTERVIEW QUESTION
--     Salaries Differences
--
-- AUTHOR
--     Mike Brown (mike.brown20160630@gmail.com)
--
-- DESCRIPTION
--
--      Write a query that calculates the difference between the highest salaries found 
--      in the marketing and engineering departments. 
--
--      Output just the difference in salaries.
--
-- DATA
--
--      Tables: db_employee, db_dept
--
--      db_employee                         db_dept                             
--          id              int                 id              int
--          first_name      varchar             department      varchar
--          last_name       varchar
--          salary          int
--          department_id   int
--
--  db_employee
--
/*
        id	first_name	last_name	salary	department_id
        10301	Keith	Morgan	27056	2
        10302	Tyler	Booth	32199	3
        10303	Clifford	Nguyen	32165	2
        10304	Mary	Jones	49488	3
        10305	Melissa	Lucero	27024	3
        10306	Ashley	Li	28516	4
        10307	Joseph	Solomon	19945	1
        10308	Anthony	Sanchez	43801	3
        10309	Katherine	Huffman	12984	4
        10310	Dawn	Foley	28902	2
        10311	Melissa	Holmes	33575	1
        10312	Kathleen	Davis	44579	2
        10313	Adam	Simmons	15442	6
        10314	Desiree	Brewer	37494	6
        10315	Sierra	Anderson	20592	6
        10316	Beth	Torres	34902	1
        10317	Pamela	Rodriguez	48187	4
        10318	Jessica	Austin	43154	2
        10319	Stephanie	Gamble	31160	2
        10320	Gregory	Cook	22681	4
        10321	Debra	Knapp	17844	5
        10322	Paul	Horton	37431	3
        10323	Henry	Solis	45269	4
        10324	William	Brewer	15947	1
        10325	Brian	Nelson	27006	1
        10326	Randall	Kramer	20695	2
        10327	Mary	Baker	46654	5
        10328	Gene	Shepard	10143	3
        10329	Christopher	Ramos	37710	4
        10330	Robin	Horne	34679	3
        10331	Alan	Wilson	43730	5
        10332	Jessica	Mccall	40882	5
        10333	Jennifer	Blankenship	13433	4
        10334	Michael	Mitchell	19044	2
        10335	Johnny	Fritz	40638	6
        10336	Gloria	Krause	21670	3
        10337	Jonathan	Holt	30267	2
        10338	Anthony	Bullock	39362	6
        10339	Robert	Mills	13188	1
        10340	Joshua	Stephens	29339	3
        10341	Alison	Hernandez	45144	3
        10342	Derek	Morgan	11286	2
        10343	Anthony	Morgan	15145	5
        10344	Jenny	Owens	40606	4
        10345	Elizabeth	Raymond	33050	5
        10346	Philip	Jones	46356	2
        10347	Seth	Gross	25681	5
        10348	Edwin	Johnson	35144	5
        10349	Ryan	Barnes	25085	1
        10350	Patrick	Booth	39940	1
        10351	Andrew	Lopez	18997	3
        10352	Sarah	Mcknight	31082	5
        10353	Patricia	Lawson	15808	1
        10354	Taylor	Tucker	20225	3
        10355	Aaron	Fischer	45787	1
        10356	Wendy	Brown	30432	4
        10357	Michael	Robertson	47657	5
        10358	Edward	Wolf	45649	1
        10359	Jacob	Brown	28782	6
        10360	Randy	Lee	45121	4
        10361	Xavier	Pace	18842	3
        10362	Anita	Chen	19669	6
        10363	David	Chapman	15426	4
        10364	Elijah	Potter	44472	2
        10365	Craig	West	37278	1
        10366	Heather	Schroeder	40546	3
        10367	Jeremy	Phillips	36605	4
        10368	William	Hall	20534	4
        10369	Kimberly	White	31456	3
        10370	Susan	Fisher	32308	1
        10371	Deborah	Duncan	18517	6
        10372	Lawrence	Smith	11636	3
        10373	Meghan	Martinez	12993	2
        10374	Paige	Mills	19448	6
        10375	Michael	Johnson	34888	6
        10376	Lori	Burns	14603	3
        10377	Stephanie	Chavez	30196	4
        10378	Luis	Sheppard	23532	6
        10379	Rebecca	Turner	28312	2
        10380	Justin	Jones	31170	6
        10381	Stephanie	Mejia	11913	3
        10382	Sharon	Liu	34620	5
        10383	Jonathan	Lester	30517	2
        10384	Olivia	Hoffman	44696	3
        10385	Michelle	Miller	36911	2
        10386	Jacob	Carr	20676	2
        10387	Ashley	Todd	49926	6
        10388	Michael	Harvey	18280	3
        10389	Anthony	Molina	26304	3
        10390	Maria	Warren	20599	5
        10391	Kenneth	Smith	28762	6
        10392	Melissa	Nichols	35266	4
        10393	Lori	Page	24569	3
        10394	Jacqueline	Stewart	41454	4
        10395	Victor	Robinson	28034	6
        10396	Meghan	Henderson	28733	2
        10397	Heather	Kelly	42487	6
        10398	Alexander	Abbott	15334	2
        10399	Christopher	Ryan	33224	3
        10400	Chelsea	Gonzalez	20785	1
*/
--  db_dept
--
/*
        id	department
        1	engineering
        2	human resource
        3	operation
        4	marketing
        5	sales
        6	customer care
*/
--
-- OUTPUT
--
--      salary_difference
--      2400
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
--
        CREATE TABLE db_employee(
              id              int                 
            , first_name      varchar(50)             
            , last_name       varchar(50)
            , salary          int
            , department_id   int
        )

        INSERT INTO db_employee VALUES        
             (10301,'Keith','Morgan',27056,2)
            ,(10302,'Tyler','Booth',32199,3)
            ,(10303,'Clifford','Nguyen',32165,2)
            ,(10304,'Mary','Jones',49488,3)
            ,(10305,'Melissa','Lucero',27024,3)
            ,(10306,'Ashley','Li',28516,4)
            ,(10307,'Joseph','Solomon',19945,1)
            ,(10308,'Anthony','Sanchez',43801,3)
            ,(10309,'Katherine','Huffman',12984,4)
            ,(10310,'Dawn','Foley',28902,2)
            ,(10311,'Melissa','Holmes',33575,1)
            ,(10312,'Kathleen','Davis',44579,2)
            ,(10313,'Adam','Simmons',15442,6)
            ,(10314,'Desiree','Brewer',37494,6)
            ,(10315,'Sierra','Anderson',20592,6)
            ,(10316,'Beth','Torres',34902,1)
            ,(10317,'Pamela','Rodriguez',48187,4)
            ,(10318,'Jessica','Austin',43154,2)
            ,(10319,'Stephanie','Gamble',31160,2)
            ,(10320,'Gregory','Cook',22681,4)
            ,(10321,'Debra','Knapp',17844,5)
            ,(10322,'Paul','Horton',37431,3)
            ,(10323,'Henry','Solis',45269,4)
            ,(10324,'William','Brewer',15947,1)
            ,(10325,'Brian','Nelson',27006,1)
            ,(10326,'Randall','Kramer',20695,2)
            ,(10327,'Mary','Baker',46654,5)
            ,(10328,'Gene','Shepard',10143,3)
            ,(10329,'Christopher','Ramos',37710,4)
            ,(10330,'Robin','Horne',34679,3)
            ,(10331,'Alan','Wilson',43730,5)
            ,(10332,'Jessica','Mccall',40882,5)
            ,(10333,'Jennifer','Blankenship',13433,4)
            ,(10334,'Michael','Mitchell',19044,2)
            ,(10335,'Johnny','Fritz',40638,6)
            ,(10336,'Gloria','Krause',21670,3)
            ,(10337,'Jonathan','Holt',30267,2)
            ,(10338,'Anthony','Bullock',39362,6)
            ,(10339,'Robert','Mills',13188,1)
            ,(10340,'Joshua','Stephens',29339,3)
            ,(10341,'Alison','Hernandez',45144,3)
            ,(10342,'Derek','Morgan',11286,2)
            ,(10343,'Anthony','Morgan',15145,5)
            ,(10344,'Jenny','Owens',40606,4)
            ,(10345,'Elizabeth','Raymond',33050,5)
            ,(10346,'Philip','Jones',46356,2)
            ,(10347,'Seth','Gross',25681,5)
            ,(10348,'Edwin','Johnson',35144,5)
            ,(10349,'Ryan','Barnes',25085,1)
            ,(10350,'Patrick','Booth',39940,1)
            ,(10351,'Andrew','Lopez',18997,3)
            ,(10352,'Sarah','Mcknight',31082,5)
            ,(10353,'Patricia','Lawson',15808,1)
            ,(10354,'Taylor','Tucker',20225,3)
            ,(10355,'Aaron','Fischer',45787,1)
            ,(10356,'Wendy','Brown',30432,4)
            ,(10357,'Michael','Robertson',47657,5)
            ,(10358,'Edward','Wolf',45649,1)
            ,(10359,'Jacob','Brown',28782,6)
            ,(10360,'Randy','Lee',45121,4)
            ,(10361,'Xavier','Pace',18842,3)
            ,(10362,'Anita','Chen',19669,6)
            ,(10363,'David','Chapman',15426,4)
            ,(10364,'Elijah','Potter',44472,2)
            ,(10365,'Craig','West',37278,1)
            ,(10366,'Heather','Schroeder',40546,3)
            ,(10367,'Jeremy','Phillips',36605,4)
            ,(10368,'William','Hall',20534,4)
            ,(10369,'Kimberly','White',31456,3)
            ,(10370,'Susan','Fisher',32308,1)
            ,(10371,'Deborah','Duncan',18517,6)
            ,(10372,'Lawrence','Smith',11636,3)
            ,(10373,'Meghan','Martinez',12993,2)
            ,(10374,'Paige','Mills',19448,6)
            ,(10375,'Michael','Johnson',34888,6)
            ,(10376,'Lori','Burns',14603,3)
            ,(10377,'Stephanie','Chavez',30196,4)
            ,(10378,'Luis','Sheppard',23532,6)
            ,(10379,'Rebecca','Turner',28312,2)
            ,(10380,'Justin','Jones',31170,6)
            ,(10381,'Stephanie','Mejia',11913,3)
            ,(10382,'Sharon','Liu',34620,5)
            ,(10383,'Jonathan','Lester',30517,2)
            ,(10384,'Olivia','Hoffman',44696,3)
            ,(10385,'Michelle','Miller',36911,2)
            ,(10386,'Jacob','Carr',20676,2)
            ,(10387,'Ashley','Todd',49926,6)
            ,(10388,'Michael','Harvey',18280,3)
            ,(10389,'Anthony','Molina',26304,3)
            ,(10390,'Maria','Warren',20599,5)
            ,(10391,'Kenneth','Smith',28762,6)
            ,(10392,'Melissa','Nichols',35266,4)
            ,(10393,'Lori','Page',24569,3)
            ,(10394,'Jacqueline','Stewart',41454,4)
            ,(10395,'Victor','Robinson',28034,6)
            ,(10396,'Meghan','Henderson',28733,2)
            ,(10397,'Heather','Kelly',42487,6)
            ,(10398,'Alexander','Abbott',15334,2)
            ,(10399,'Christopher','Ryan',33224,3)
            ,(10400,'Chelsea','Gonzalez',20785,1)

        CREATE TABLE db_dept(
            id              int
            , department    varchar(50)
        ) 

        INSERT INTO db_dept VALUES
            (1,'engineering')
            ,(2,'human resource')
            ,(3,'operation')
            ,(4,'marketing')
            ,(5,'sales')
            ,(6,'customer care')                   

--     2.2 Get the basics working to check test data correct etc.
--
        SELECT 
              id
            , first_name
            , last_name
            , salary
            , department_id

        FROM db_employee

        SELECT
              id
            , department

        FROM db_dept

--     3. Get the joins right (One join at a time)

        SELECT *
        FROM db_employee AS emp

        INNER JOIN db_dept AS dt
        ON dt.id = emp.department_id
        AND dt.department = 'marketing'

        SELECT *
        FROM db_employee AS emp

        INNER JOIN db_dept AS dt
        ON dt.id = emp.department_id
        AND dt.department = 'engineering'

--
--     4. Write any expressions and verify them (starting in the SELECT clause > WHERE clause)
--

        SELECT MAX(emp.salary)  -- maximum salary from each department

--        ABS(MAX([engineering].emp.salary) - MAX([marketing].emp.salary))
--
--          where [engineering] is the joint table from engineerign department
--          where [marketing] is the joint table from marketing department
--
--     5. Write any where clause expressions and verify them
--     
--     6. Arrange the columns and rows in preparation for grouping
--
--     7. Add the grouping, visually verfiy
--
--     8. Add the having
--
--     9. Add the order by
--
--    10. Tidy up the code
--
            SELECT ABS(
                (SELECT MAX(emp.salary)
                FROM db_employee AS emp

                INNER JOIN db_dept AS dt
                    ON dt.id = emp.department_id
                        AND dt.department = 'marketing')
            -
                (SELECT MAX(emp.salary)
                FROM db_employee AS emp

                INNER JOIN db_dept AS dt
                    ON dt.id = emp.department_id
                        AND dt.department = 'engineering') 
            )AS salary_difference

--
-- CHANGE HISTORY
--   