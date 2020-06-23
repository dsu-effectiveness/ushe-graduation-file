

 ----------------------------------------------------------------------------------------------------
 -- Create and Define Variables.                                                                   --
 ----------------------------------------------------------------------------------------------------
 
    -- Make sure all the records in the dxgrad_current table are in the dxgrad_all table first. 
    /* SELECT * 
       FROM   dxgrad_current 
       WHERE  dxgrad_pidm||dxgrad_dgmr_prgm NOT IN ( SELECT dxgrad_pidm||dxgrad_dgmr_prgm FROM dxgrad_all); 
    */
 
    SET verify OFF;
    
    undefine v_acyr;
    undefine v_gradstart;
    undefine v_gradend;
    undefine v_term_end;

    -- Manual Variables -----------------------------------------------------------------------------
    -- Set these before running the script.

    -- Academic Year:
    -- Set this variable to the academic year in which the students graduated.
    -- Currently broken, just copy/replace all instances of '1920' for the time being...
    define v_acyr = '1920';

    -- Automatic Variables --------------------------------------------------------------------------
    -- Do not modify these variables. 

    -- Lookup Date:
    -- This variable is set to the date whose data you are wanting to pull. Defaults to Today.
    define v_gradstart = ('30-JUN-'||substr('1920',0,2));

    -- USHE Year:
    -- This variable is set to the USHE Academic Year for the current reporting term.
    define v_gradend =  ('01-JUL-'||substr('1920',2,2));

    define v_term_end = '20'||substr('1920',3,2)||'20';
    
 ----------------------------------------------------------------------------------------------------
 -- Create Backup Tables.                                                                          --
 ----------------------------------------------------------------------------------------------------

    -- Note: this step is only performed once a year.
    -- RENAME dxgrad_current TO dxgrad_bk||to_char(to_date(TRUNCATE(SYSDATE),'MMDDYY'));

 ----------------------------------------------------------------------------------------------------
 -- Drop / Create New Tables.                                                                      --
 ----------------------------------------------------------------------------------------------------

 ----------------------------------------------------------------------------------------------------------------------------------- total awards is 2309, fewer students
    DROP   TABLE dxgrad_current;
    CREATE TABLE dxgrad_current
    (
      dxgrad_pidm           NUMBER(8,0),
      dxgrad_id             VARCHAR2(9 BYTE),
      dxgrad_ssn            NUMBER(9),
      dxgrad_ssid           VARCHAR2(10 BYTE),
      dxgrad_acyr           VARCHAR2(4 BYTE),
      dxgrad_term_code_grad VARCHAR2(6 BYTE),
      dxgrad_dsugrad_dt     DATE,
      dxgrad_last_name      VARCHAR2(60 BYTE),
      dxgrad_first_name     VARCHAR2(15 BYTE),
      dxgrad_middle         VARCHAR2(15 BYTE),
      dxgrad_suffix         VARCHAR2(4 BYTE),
      dxgrad_birth_dt       DATE,
      dxgrad_age            NUMBER(3,0),
      dxgrad_sex            VARCHAR2(1 BYTE),
      dxgrad_ethn_code      VARCHAR2(1 BYTE),
      dxgrad_ethnic_desc    VARCHAR2(30 BYTE),
      dxgrad_ethn_h         VARCHAR2(1 BYTE),
      dxgrad_ethn_a         VARCHAR2(1 BYTE),
      dxgrad_ethn_b         VARCHAR2(1 BYTE),
      dxgrad_ethn_i         VARCHAR2(1 BYTE),
      dxgrad_ethn_p         VARCHAR2(1 BYTE),
      dxgrad_ethn_w         VARCHAR2(1 BYTE),
      dxgrad_ethn_n         VARCHAR2(1 BYTE),
      dxgrad_ethn_u         VARCHAR2(1 BYTE),
      dxgrad_prev_degr      VARCHAR2(6 BYTE),
      dxgrad_hs_code        VARCHAR2(6 BYTE),
      dxgrad_hsgrad_dt      NUMBER(8,0),
      dxgrad_ut_cnty_code   VARCHAR2(5 BYTE),
      dxgrad_state_origin   VARCHAR2(2 BYTE),
      dxgrad_country_origin VARCHAR2(2 BYTE),
      dxgrad_initial_ea     VARCHAR2(6 BYTE),
      dxgrad_initial_term   VARCHAR2(6 BYTE),
      dxgrad_initial_pt_ft  VARCHAR2(1 BYTE),
      dxgrad_initial_degint VARCHAR2(1 BYTE),
      dxgrad_initial_sport  VARCHAR2(4 BYTE),
      dxgrad_pell_pd        VARCHAR2(1 BYTE),  
      dxgrad_gpa            NUMBER(8,0),
      dxgrad_grad_hrs       NUMBER(8,1),
      dxgrad_other_hrs      NUMBER(8,1),
      dxgrad_trans_hrs      NUMBER(8,1),
      dxgrad_remed_hrs      NUMBER(8,1),
      dxgrad_req_hrs        NUMBER(3,0),
      dxgrad_grad_majr      VARCHAR2(4 BYTE),
      dxgrad_majr_desc      VARCHAR2(100 BYTE),
      dxgrad_majr_conc1     VARCHAR2(4 BYTE),
      dxgrad_majr_conc2     VARCHAR2(4 BYTE),
      dxgrad_grad_minr1     VARCHAR2(4 BYTE),
      dxgrad_grad_minr2     VARCHAR2(4 BYTE),
      dxgrad_cipc_code      VARCHAR2(6 BYTE),
      dxgrad_ipeds_levl     VARCHAR2(2 BYTE),
      dxgrad_levl_code      VARCHAR2(2 BYTE),
      dxgrad_dgmr_seqno     NUMBER(2,0),
      dxgrad_dgmr_prgm      VARCHAR2(12 BYTE),
      dxgrad_degc_code      VARCHAR2(6 BYTE),
      dxgrad_degc_desc      VARCHAR2(100),
      dxgrad_activity_dt    DATE,
      dxgrad_inst           VARCHAR2(4 BYTE),
      dxgrad_ushe_term      NUMBER(1,0),
      dxgrad_ushe_majr_coll VARCHAR2(100),
      dxgrad_ushe_majr_desc VARCHAR2(100)
    )
    TABLESPACE users
    PCTUSED    0
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                 INITIAL       64K
                 NEXT          64K
                 MINEXTENTS    1
                 MAXEXTENTS    2147483645
                 PCTINCREASE   0
                 BUFFER_POOL   DEFAULT
               )
    NOLOGGING 
    NOCACHE
    NOPARALLEL;

 ----------------------------------------------------------------------------------------------------
 -- Insert data from SPRIDEN, SPBPERS, SHRDGMR and STVMAJR
 ----------------------------------------------------------------------------------------------------
 -- Create database link PRODDB connect to ENROLL identified BY ww19swhme using 'ENROLL' <<dblink>>
    
    INSERT INTO  dxgrad_current
                 (
                   dxgrad_pidm,       dxgrad_id,             dxgrad_ssn,         
                   dxgrad_acyr,       dxgrad_term_code_grad, dxgrad_dsugrad_dt, dxgrad_last_name,  
                   dxgrad_first_name, dxgrad_middle,         dxgrad_suffix,     dxgrad_birth_dt,   
                   dxgrad_sex,        dxgrad_levl_code,      dxgrad_dgmr_seqno, dxgrad_degc_code,  
                   dxgrad_degc_desc,  dxgrad_grad_majr,      dxgrad_dgmr_prgm,  dxgrad_activity_dt, 
                   dxgrad_inst,       dxgrad_ushe_majr_coll, dxgrad_grad_minr1, dxgrad_grad_minr2
                 )
                 (
                   SELECT shrdgmr_pidm,                    -- dxgrad_pidm
                          spriden_id,                      -- dxgrad_id
                          spbpers_ssn,                     -- dxgrad_ssn
                          '1920',                          -- dxgrad_acyr
                          shrdgmr_term_code_grad,          -- dxgrad_term_code_grad
                          shrdgmr_grad_date,               -- dxgrad_dsugrad_dt
                          substr(spriden_last_name,1,15),  -- dxgrad_last_name
                          substr(spriden_first_name,1,15), -- dxgrad_first_name
                          substr(spriden_mi,1,15),         -- dxgrad_middle
                          substr(spbpers_name_suffix,1,4), -- dxgrad_suffix
                          spbpers_birth_date,              -- dxgrad_birth_dt
                          spbpers_sex,                     -- dxgrad_sex
                          shrdgmr_levl_code,               -- dxgrad_levl_code
                          shrdgmr_seq_no,                  -- dxgrad_dgmr_seqno
                          substr(shrdgmr_degc_code,1,4),   -- dxgrad_degc_code
                          stvdegc_desc,                    -- dxgrad_degc_desc
                          shrdgmr_majr_code_1,             -- dxgrad_grad_majr
                          shrdgmr_program,                 -- dxgrad_dgmr_prgm
                          shrdgmr_activity_date,           -- dxgrad_activity_dt
                          '3671',                          -- dxgrad_inst
                          shrdgmr_coll_code_1,             -- dxgrad_ushe_majr_coll
                          shrdgmr_majr_code_minr_1,        -- dxgrad_grad_minr1
                          shrdgmr_majr_code_minr_2         -- dxgrad_grad_minr2
                   FROM   spbpers, 
                          stvmajr, 
                          shrdgmr, 
                          spriden,
                          stvdegc
                   WHERE  shrdgmr_pidm        = spbpers_pidm(+)
                   AND    shrdgmr_pidm        = spriden_pidm
                   AND    shrdgmr_majr_code_1 = stvmajr_code
                   AND    shrdgmr_degc_code   = stvdegc_code
                   AND    shrdgmr_degs_code   = 'AW'
--                   AND    shrdgmr_degs_code IN ('AW','PN') -- DELETE THIS BEFORE FINAL PROCESSING in 2019
                   AND    spriden_change_ind IS NULL
                   AND    shrdgmr_grad_date BETWEEN to_date('01-JUL-19') AND to_date('30-JUN-20')  -- change every year
                 );

 -- G-02 --------------------------------------------------------------------------------------------
 -- ELEMENT NAME: Student ID
 -- FIELD NAME:   G_ID 
 /* DEFINITION:   Use a Unique Identifier for graduating student. Social Security Number shall be 
                  used (to facilitate student tracking) except in the rare case where the student 
                  does not have SSN (i.e. international student) where an institutionally defined 
                  number is used.                                                                  */
 ----------------------------------------------------------------------------------------------------

 -- Use Banner ID where no SSN is found
    UPDATE dxgrad_current
    SET    dxgrad_ssn = dxgrad_id
    WHERE  dxgrad_ssn IS NULL
    OR     LENGTH(dxgrad_ssn) <> '9'
    OR     dxgrad_ssn IN ('00000','000000000','');
    
 -- G-03 --------------------------------------------------------------------------------------------
 /* ELEMENT NAME: Name
    FIELD NAME:   G_LAST, G_FIRST, G_MIDDLE, G_SUFFIX
    DEFINITION:   The legal combination of names by which the student is known.                    */
 ----------------------------------------------------------------------------------------------------

    UPDATE dxgrad_current
    SET    dxgrad_suffix = upper(REPLACE(dxgrad_suffix,'.',''))
    WHERE  dxgrad_suffix IS NOT NULL;

 -- Check for bogus suffixes
    SELECT dxgrad_pidm, dxgrad_id, dxgrad_suffix
    FROM   dxgrad_current
    WHERE  dxgrad_suffix IS NOT NULL
    AND    upper(dxgrad_suffix) NOT IN ('JR','SR','II','III','IV');
    --

    -- Use this query to fix bogus suffixes
    /*
       UPDATE dxgrad_current
       SET    dxgrad_suffix = NULL
       WHERE  dxgrad_pidm IN (<<pidmshere>>)
       --
    */
    
    /*
       UPDATE dxgrad_current
       SET    dxgrad_suffix = NULL
       WHERE  dxgrad_pidm IN ('109994','176556','270531');
    */


 -- G-04 --------------------------------------------------------------------------------------------
 -- ELEMENT NAME: Utah County Code
 -- FIELD NAME:   G_COUNTY_ORIGIN
 /* DEFINITION:   The Utah county code indicating the students county of origin as described at the 
                  time of first application to the institution, and if the S_STATE_ORIGIN is UT. 
                  Enter UT030 if county is Unknown. Enter UT097 if student is Out of State, Out of 
                  US. Enter UT099 if student is Out of State, In the US.                           */
 ----------------------------------------------------------------------------------------------------

 -- Fetch county code from SABSUPL table.
    UPDATE dxgrad_current
    SET    dxgrad_ut_cnty_code =  
           (
             SELECT (c.sabsupl_cnty_code_admit)
             FROM   sabsupl c
             WHERE  c.sabsupl_pidm = dxgrad_pidm
             AND    c.sabsupl_appl_no||c.sabsupl_term_code_entry = 
                    (
                      SELECT MIN(d.sabsupl_appl_no||d.sabsupl_term_code_entry )
                      FROM   sabsupl d
                      WHERE  d.sabsupl_pidm = dxgrad_pidm
                    )
           )
    WHERE  dxgrad_ut_cnty_code IS NULL;
    --
    
    UPDATE dxgrad_current
    SET    dxgrad_ut_cnty_code = 
           CASE LENGTH(dxgrad_ut_cnty_code) 
                WHEN 1 THEN 'UT00'||dxgrad_ut_cnty_code
                WHEN 2 THEN 'UT0' ||dxgrad_ut_cnty_code
                WHEN 3 THEN 'UT'  ||dxgrad_ut_cnty_code
                WHEN 4 THEN 'UT'  ||substr(dxgrad_ut_cnty_code,2,3)
                WHEN 5 THEN 'UT'  ||substr(dxgrad_ut_cnty_code,3,3)
                ELSE dxgrad_ut_cnty_code
                END
    WHERE  dxgrad_ut_cnty_code NOT LIKE 'UT%';
    --
    
    UPDATE dxgrad_current
    SET    dxgrad_ut_cnty_code   = 'UT099'
    WHERE  dxgrad_country_origin = 'US'
    AND    dxgrad_state_origin  <> 'UT'
    AND    dxgrad_ut_cnty_code  IS NULL;
    --
    
    UPDATE dxgrad_current
    SET    dxgrad_ut_cnty_code    = 'UT097'
    WHERE  dxgrad_country_origin <> 'US'
    AND    dxgrad_ut_cnty_code   IS NULL;
    --

 -- G-07 --------------------------------------------------------------------------------------------
 -- ELEMENT NAME: Ethnic Origin
 -- FIELD NAME:   G_ETHNIC 
 /* DEFINITION:   The racial and ethnic categories used to classify students.                      */
 ----------------------------------------------------------------------------------------------------
 
 -- Set Non-Resident Aliens where spbpers_citz_code = '2'
    UPDATE dxgrad_current
    SET    dxgrad_ethn_n = 'N'
    WHERE  EXISTS 
           (
             SELECT spbpers_citz_code 
             FROM   spbpers
             WHERE  spbpers_pidm = dxgrad_pidm
             AND    spbpers_citz_code = '2'
           )
    AND    dxgrad_ethn_n IS NULL;
    --
    
    UPDATE dxgrad_current
    SET    dxgrad_ethn_code  = dxgrad_ethn_n
    WHERE  dxgrad_ethn_code IS NULL
    AND    dxgrad_ethn_n    IS NOT NULL;
    --

 -- Set Hispanic where spbpers_ethn_cde = '2'
    UPDATE dxgrad_current
    SET    dxgrad_ethn_h = 'H'
    WHERE  EXISTS 
           (
             SELECT spbpers_ethn_cde
             FROM   spbpers
             WHERE  spbpers_pidm = dxgrad_pidm
             AND    spbpers_ethn_cde = '2'
           )
    AND    dxgrad_ethn_h IS NULL
    AND    dxgrad_ethn_n IS NULL;
    --

    UPDATE dxgrad_current
    SET    dxgrad_ethn_code  = dxgrad_ethn_h
    WHERE  dxgrad_ethn_code IS NULL
    AND    dxgrad_ethn_h    IS NOT NULL;
    --

 -- Set Hispanic where spbpers_ethn_code = 'H'
    UPDATE dxgrad_current
    SET    dxgrad_ethn_code = 'H',
           dxgrad_ethn_H    = 'H'
    WHERE  dxgrad_pidm IN 
           (
             SELECT spbpers_pidm
             FROM   spbpers
             WHERE  dxgrad_pidm = spbpers_pidm
             AND    spbpers_ethn_code = 'H'
           )
    AND    dxgrad_ethn_code IS NULL;
    --

 -- Set Asian where gorprac_race_cde = 'A'
    UPDATE dxgrad_current
    SET    dxgrad_ethn_a = 
           (
             SELECT gorprac_race_cde
             FROM   gorprac
             WHERE  gorprac_pidm = dxgrad_pidm
             AND    gorprac_race_cde = 'A'
           )
    WHERE  dxgrad_ethn_h IS NULL
    AND    dxgrad_ethn_n IS NULL;
    --

    UPDATE dxgrad_current
    SET    dxgrad_ethn_code = dxgrad_ethn_a
    WHERE  dxgrad_ethn_h IS NULL
    AND    dxgrad_ethn_n IS NULL
    AND    dxgrad_ethn_a IS NOT NULL;
    --

 -- Set Black/African-American where gorprac_race_cde = 'B'
    UPDATE dxgrad_current
    SET    dxgrad_ethn_b = 
           (
             SELECT gorprac_race_cde
             FROM   gorprac
             WHERE  gorprac_pidm = dxgrad_pidm
             AND    gorprac_race_cde = 'B'
           )
    WHERE  dxgrad_ethn_h IS NULL 
    AND    dxgrad_ethn_n IS NULL;
    --

    UPDATE dxgrad_current
    SET    dxgrad_ethn_code = dxgrad_ethn_b
    WHERE  dxgrad_ethn_h IS NULL
    AND    dxgrad_ethn_n IS NULL
    AND    dxgrad_ethn_b IS NOT NULL;
    --

  -- Set Native-American/American-Indian where gorprac_race_cde = 'I'
    UPDATE dxgrad_current
    SET    dxgrad_ethn_i = 
           (
             SELECT gorprac_race_cde
             FROM   gorprac
             WHERE  gorprac_pidm = dxgrad_pidm
             AND    gorprac_race_cde = 'I'
           )
    WHERE  dxgrad_ethn_h IS NULL
    AND    dxgrad_ethn_n IS NULL; 
    --

    UPDATE dxgrad_current
    SET    dxgrad_ethn_code  = dxgrad_ethn_i
    WHERE  dxgrad_ethn_h IS NULL
    AND    dxgrad_ethn_n IS NULL
    AND    dxgrad_ethn_i IS NOT NULL;
    --

 -- Set Native-Hawaiian/Pacific-Islander where gorprac_race_cde = 'P'
    UPDATE dxgrad_current 
    SET    dxgrad_ethn_p = 
           (
            SELECT gorprac_race_cde
            FROM   gorprac
            WHERE  gorprac_pidm = dxgrad_pidm
            AND    gorprac_race_cde = 'P'
           )
    WHERE  dxgrad_ethn_h IS NULL
    AND    dxgrad_ethn_n IS NULL
    AND    dxgrad_ethn_i IS NOT NULL;
    --

    UPDATE dxgrad_current
    SET    dxgrad_ethn_code = dxgrad_ethn_p
    WHERE  dxgrad_ethn_h IS NULL
    AND    dxgrad_ethn_n IS NULL
    AND    dxgrad_ethn_p IS NOT NULL;
    --

 -- Set White/Caucasian where gorprac_race_cde = 'W'
    UPDATE dxgrad_current
    SET    dxgrad_ethn_w = 
          (
            SELECT gorprac_race_cde
            FROM   gorprac
            WHERE  gorprac_pidm = dxgrad_pidm
            AND    gorprac_race_cde = 'W'
          )
    WHERE  dxgrad_ethn_h IS NULL
    AND    dxgrad_ethn_n IS NULL;
    --

    UPDATE dxgrad_current
    SET    dxgrad_ethn_code  = dxgrad_ethn_w
    WHERE  dxgrad_ethn_h IS NULL
    AND    dxgrad_ethn_n IS NULL
    AND    dxgrad_ethn_w IS NOT NULL;
    --
 
 -- Set ethn code to '2' where students have more than one ethn code
    UPDATE dxgrad_current d1
    SET    d1.dxgrad_ethn_code = '2' 
    WHERE  d1.dxgrad_ethn_h IS NULL
    AND    d1.dxgrad_ethn_n IS NULL
    AND    d1.dxgrad_pidm IN 
           (
             SELECT DISTINCT d2.dxgrad_pidm
             FROM   dxgrad_current d2
             WHERE  LENGTH(d2.dxgrad_ethn_a||d2.dxgrad_ethn_b||d2.dxgrad_ethn_h||
                           d2.dxgrad_ethn_i||d2.dxgrad_ethn_p||d2.dxgrad_ethn_w) > 1
           );   
    --
 
 -- Set ethn code to '2' where ethnicity is unknown
    UPDATE dxgrad_current
    SET    dxgrad_ethn_code  = 'U',
           dxgrad_ethn_u     = 'U'
    WHERE  dxgrad_ethn_code IS NULL; 
    --

 -- Show a count of each ethnic/race code
    SELECT dxgrad_ethn_code, count(DISTINCT(dxgrad_pidm))
    FROM   dxgrad_current
    GROUP  BY dxgrad_ethn_code;
    --

 -- SET the ethnic/race description based on validation table STVETHN
    UPDATE dxgrad_current
    SET    dxgrad_ethnic_desc = 
           (
             SELECT stvethn_desc
             FROM   stvethn
             WHERE  dxgrad_ethn_code = stvethn_code
           );
    --
        
    UPDATE dxgrad_current
    SET    dxgrad_ethnic_desc = 'Two or More Races'
    WHERE  dxgrad_ethn_code   = '2';
    --

    UPDATE dxgrad_current
    SET    dxgrad_ethnic_desc = 'Non-Resident Alien'
    WHERE  dxgrad_ethn_code   = 'N';
    --

 -- G-08 --------------------------------------------------------------------------------------------
 -- ELEMENT NAME: Date of Graduation
 -- FIELD NAME:   G_DATE 
 /* DEFINITION:   The calendar date the formal award was conferred by the institution.             */
 ----------------------------------------------------------------------------------------------------
 
 /* First, check for invalid graduation dates. Dates in the future should not be in this table. Run 
    the below query and email results (if any) to Graduation Office and have them correct grad date 
    if they belong in current year grad file

  * This picks up any with prior term code grads that will be in next years report but may really be 
    coded wrong. If so, need to do special INSERT to add the pidm with shrdgmr_grad_date in error if 
    Sheri Gowers hasn't fixed yet, but intends to. */

    SELECT shrdgmr_pidm       AS "PIDM", 
           spriden_id         AS "Banner ID", 
           spriden_last_name  AS "Last", 
           spriden_first_name AS "First", 
           spriden_mi         AS "MI",
           shrdgmr_seq_no,    shrdgmr_degc_code, shrdgmr_degs_code,     shrdgmr_majr_code_1,
           shrdgmr_appl_date, shrdgmr_grad_date, shrdgmr_activity_date, shrdgmr_term_code_grad, 
           shrdgmr_acyr_code, shrdgmr_user_id
    FROM   shrdgmr, spriden 
    WHERE  shrdgmr_pidm       = spriden_pidm
    AND    shrdgmr_degs_code  = 'AW'
    AND    spriden_entity_ind = 'P'
    AND    shrdgmr_grad_date >= to_date('30-JUN-20')  -- change every year
    AND    spriden_change_ind IS NULL;
    -- 
 
 -- G-09 --------------------------------------------------------------------------------------------
 -- ELEMENT NAME: CIP Code
 -- FIELD NAME:   G_CIP 
 /* DEFINITION:   Use the 2010 version of the Classification of Instructional Programs (CIP) to best 
                  identify the specific programs in which the degree is awarded. Thus, report a 
                  bachelors degree in Business Administration with a business economics major in 
                  Business/Managerial Economics (520601), not in Business, General (520101).       */
 ----------------------------------------------------------------------------------------------------

    -- Fetch CIP Codes from CIP2010 Table
    UPDATE dxgrad_current
    SET    dxgrad_cipc_code =  
           (
               SELECT lpad(stvmajr_cipc_code,6,'0')
               FROM stvmajr, shrdgmr
               WHERE stvmajr_code = shrdgmr_majr_code_1
--              SELECT lpad(cipc_code,6,'0')
--              FROM   dsc_programs_all
--              WHERE  acyr_code = '1920'
--              AND    (YEAR_END = 0 OR YEAR_END > 20||substr('1920',0,2))
--              AND    prgm_code = dxgrad_dgmr_prgm
--              GROUP  BY cipc_code
          );

    --
   
    -- Fetch any remaining CIP Codes using STVMAJR
--     UPDATE dxgrad_current
--     SET    dxgrad_cipc_code =
--            (
--              SELECT lpad(stvmajr_cipc_code,6,'0')
--              FROM   stvmajr
--              WHERE  stvmajr_code = dxgrad_grad_majr
--            )
--     WHERE  dxgrad_cipc_code IS NULL;
    -- 
   
    -- This query checks for null CIP Codes as there should always be a CIP Code.
    SELECT (
             CASE WHEN 
                  (
                    SELECT count(*)
                    FROM   dxgrad_current 
                    WHERE  dxgrad_dsugrad_dt IS NULL 
                    OR     dxgrad_cipc_code  IS NULL
                  ) > 0 THEN 'YES' ELSE 'NO' END
           ) AS "MISSING CIP CODE?"
    FROM DUAL;
    -- 
 
 -- G-10 --------------------------------------------------------------------------------------------
 -- ELEMENT NAME: Degree Type
 -- FIELD NAME:   G_DEG_TYPE 
 /* DEFINITION:   The Level of Degree or Certificate Completed for the award conferred. Refer to the 
                  Degree Type Table for all degrees.                                               */
 ----------------------------------------------------------------------------------------------------

 -- Fix errors that sometimes occur, producing an invalid majr code

--     -- RN, GE, PARA, then GC
--     UPDATE dxgrad_current SET dxgrad_grad_majr = 'RN'   WHERE dxgrad_dgmr_prgm = 'AAS-ADN';     --
--     UPDATE dxgrad_current SET dxgrad_grad_majr = 'GE'   WHERE dxgrad_dgmr_prgm = 'AS-GENED';    --
--     UPDATE dxgrad_current SET dxgrad_grad_majr = 'PARA' WHERE dxgrad_dgmr_prgm = 'CERT-PARA';   --
--     UPDATE dxgrad_current SET dxgrad_grad_majr = 'GC'   WHERE dxgrad_dgmr_prgm = 'CERT-GCOM-C'; --
    --

    -- LPN
--     UPDATE dxgrad_current
--     SET    dxgrad_grad_majr = 'LPN'
--     WHERE  dxgrad_pidm IN
--            (
--              SELECT dxgrad_pidm
--              FROM   dxgrad_current
--              WHERE  dxgrad_dgmr_prgm  = 'CERT-LPN'
--              AND    dxgrad_grad_majr <> 'LPN'
--            )
--     AND    dxgrad_degc_code = 'CER'
--     AND    dxgrad_grad_majr = 'NURS';
    --
    
    -- EMS    
--     UPDATE dxgrad_current
--     SET    dxgrad_grad_majr = 'EMS'
--     WHERE  dxgrad_dgmr_prgm = 'CERT-EMT-I'
--     AND    dxgrad_grad_majr = 'EMT';


    --
 
 -- G-11 --------------------------------------------------------------------------------------------
 -- ELEMENT NAME: Graduation GPA
 -- FIELD NAME:   G_GPA 
 /* DEFINITION:   Student's overall cumulative GPA tied to their graduation award. All credit hours 
                  should represent average course grade on a 4.0 scale.                            */
 ----------------------------------------------------------------------------------------------------
--select * from student_courses@dscir where dsc_pidm = '252747'
-- select * from shrtgpa where shrtgpa_pidm = '252747'

 -- Calculate and populate the GPA from SHRTGPA 
    UPDATE dxgrad_current
    SET    dxgrad_gpa = 
           (
             SELECT lpad((sum(shrtgpa_quality_points)/sum(shrtgpa_gpa_hours) * 1000),4,'0')
             FROM   shrtgpa
             WHERE  shrtgpa_pidm       = dxgrad_pidm
             AND    shrtgpa_levl_code  = dxgrad_levl_code
             AND    shrtgpa_term_code <= dxgrad_term_code_grad
           )
    WHERE  dxgrad_gpa IS NULL;


    --
 
 -- G-12 --------------------------------------------------------------------------------------------
 -- ELEMENT NAME: Cumulative Undergraduate Transfer Semester Credit Hours Accepted
 -- FIELD NAME:   G_TRANS 
 /* DEFINITION:   Total number of undergraduate credit hours accepted to date at your institution. 
                  (e.g. Transfer credit from another institution). This does not include credits 
                  earned at your institution (see S-20). This does not include AP, CLEP, Challenge, 
                  or Military Credit. These hours are included in the G_HRS_OTHER field. Hours 
                  should all be converted to semester hours.                                       */
 ----------------------------------------------------------------------------------------------------

 -- Calculate and populate transfer hours (if any) from SHTRGPA
    UPDATE dxgrad_current
    SET    dxgrad_trans_hrs = 
           (
--              SELECT round(sum(shrtgpa_hours_earned),1) * 10
--              FROM   shrtgpa, shrtrit
--              WHERE  shrtgpa_levl_code    = dxgrad_levl_code
--              AND    shrtgpa_trit_seq_no  = shrtrit_seq_no
--              AND    shrtgpa_pidm         = shrtrit_pidm
--              AND    shrtgpa_pidm         = dxgrad_pidm
--              AND    shrtgpa_gpa_type_ind = 'T'
--              AND    shrtgpa_term_code   <= dxgrad_term_code_grad
--              AND    shrtrit_sbgi_code  NOT LIKE 'CLEP%'
--              AND    shrtrit_sbgi_code  NOT LIKE 'CLP%'
--              AND    shrtrit_sbgi_code  NOT LIKE 'FL%'
--              AND    shrtrit_sbgi_code  NOT LIKE 'VERT%'
--              AND    shrtrit_sbgi_code  NOT LIKE 'AP%'
--              AND    shrtrit_sbgi_code  NOT LIKE 'MIL%'
--              AND    shrtrit_sbgi_code  NOT LIKE 'MLASP%'
--              GROUP  BY shrtgpa_pidm
               SELECT round(sum(shrtgpa_hours_earned),1) * 10
                 FROM   shrtgpa, shrtrit, stvsbgi
                 WHERE  shrtgpa_levl_code    = dxgrad_levl_code
                 AND    shrtgpa_trit_seq_no  = shrtrit_seq_no
                 AND    shrtgpa_pidm         = shrtrit_pidm
                 AND    shrtgpa_pidm         = dxgrad_pidm
                 AND    shrtgpa_gpa_type_ind = 'T'
                 AND    shrtgpa_term_code   <= dxgrad_term_code_grad
                 AND    shrtrit_sbgi_code    = stvsbgi_code
                 AND    stvsbgi_code         > '999999'
                 AND    stvsbgi_srce_ind     is null
                 AND    stvsbgi_code         not in ('DSU001', 'ELC')
               GROUP  BY shrtgpa_pidm
           )
    WHERE  dxgrad_trans_hrs IS NULL;

-- ones' that start with E with numbers after them.  ELC is not transfer credit.  Source indicator should be null
-- srce_ind


    --

 -- G-13 --------------------------------------------------------------------------------------------
 -- ELEMENT NAME: Total Hours at Graduation                              
 -- FIELD NAME:   G_GRAD_HRS 
 /* DEFINITION:   Total number of overall undergraduate hours when the student graduated. This field 
                  should include all hours, except for remedial hours which should not be included 
                  (i.e. S20 + G07 + G09  G10 = G08). Hours should be converted to semester hours. */
 ----------------------------------------------------------------------------------------------------
 -- this query needs to be at the bottom because, for some unknown reason, running it earlier in the
 -- script will not populate most of the students a problem to solve another day.

    -- Prime the field with zeros
    UPDATE dxgrad_current SET dxgrad_grad_hrs  = '0' WHERE dxgrad_grad_hrs  IS NULL;
  
  

 -- Calculate and populate total hours from SHRTGPA minus remedial hours
    UPDATE dxgrad_current a
    SET    A.dxgrad_grad_hrs = 
           ( -- Total Hours
             SELECT round(sum(shrtgpa_hours_earned),1) * 10
             FROM   shrtgpa 
             WHERE  shrtgpa_pidm       = a.dxgrad_pidm 
             AND    shrtgpa_levl_code  = dxgrad_levl_code 
             AND    shrtgpa_term_code <= dxgrad_term_code_grad
             GROUP  BY shrtgpa_pidm
           ) - dxgrad_remed_hrs;
           

               

    --

 -- G-14 --------------------------------------------------------------------------------------------
 -- ELEMENT NAME: Accepted Credit from Other Sources
 -- FIELD NAME:   G_HRS_OTHER 
 /* DEFINITION:   Hours from AP credit, CLEP test, Language test, Challenge, Military etc. Hours 
                  should all be converted to semester hours.                                       */
 ----------------------------------------------------------------------------------------------------

 -- Calculate and populate other hours from SHRTRCE and SHRTRIT
    UPDATE dxgrad_current
    SET    dxgrad_other_hrs = 
           (
            SELECT round(sum(shrtrce_credit_hours),1) * 10
            FROM   shrtrce, shrtrit
            WHERE  shrtrce_pidm        = dxgrad_pidm
            AND    shrtrce_pidm        = shrtrit_pidm
            AND    shrtrce_trit_seq_no = shrtrit_seq_no
            AND    (
                        shrtrit_sbgi_code LIKE 'CLEP%'
                     OR shrtrit_sbgi_code LIKE 'CLP%'
                     OR shrtrit_sbgi_code LIKE 'FL%'
                     OR shrtrit_sbgi_code LIKE 'VERT%'
                     OR shrtrit_sbgi_code LIKE 'AP%'
                     OR shrtrit_sbgi_code LIKE 'MIL%'
                     OR shrtrit_sbgi_code LIKE 'MLA%'
                   )
            GROUP  BY shrtrce_pidm
           );

/*
                  AND    shrtrit_sbgi_code    = stvsbgi_code
                 AND    stvsbgi_code         > '999999'
                 AND    stvsbgi_srce_ind     is null
                 AND    stvsbgi_code         not in ('DSU001', 'ELC')
 */
    --
 
 -- G-15 --------------------------------------------------------------------------------------------
 -- ELEMENT NAME: Remedial Hours
 -- FIELD NAME:   G_REMEDIAL_HRS 
 /* DEFINITION:   Remedial Hours included in S-20. Should all be converted to semester hours.      */
 ----------------------------------------------------------------------------------------------------

 /* How many graduates have remedial education credits ATTEMPTED from DSC. This is used to update 
    students in dxgrad_current (most recent graduates) with a value to indicate the total amount of 
    DevEd credits (no earned on shrtckg) SLCC -DevEd courses are determined by which departments owns 
    the courses. SLCC uses department code but DSC will have to use subjects and course numbers which 
    are different quarter and semester.
  * This will add up remedial hours, including hours for repeats that were taken as of term code grad
  * 8/7/07 after sending grad0607 McKell called about -hours in G-08 g_grad_hrs. Found that when stu 
    took remedial and they were minused FROM G-08 below that if rem hrs more than actually earned 
    cased -hrs in cum. example: if student took 23 cum atmpt, but earned 8 and had 11 rem hrs then.
  * 8/6/12 first time repeated remedial hrs were excluded. prior gradfiles has repeats in rem hrs
  * 8/6/12 originally used using shrtckn_repeat_sys_ind <> 'M' and should have been using 
    shrtckn_repeat_course_ind <> 'E' (E = not counted in GPA, I = Repeat counted in GPA) */

 -- Calculate and populate remedial hours from SHRTCKG and SHRTCKN
    UPDATE dxgrad_current
    SET    dxgrad_remed_hrs = 
           (
             SELECT round(sum(shrtckg_credit_hours),1)* 10
             FROM   shrtckg, shrtckn
             WHERE  shrtckg_term_code   = shrtckn_term_code
             AND    shrtckg_tckn_seq_no = shrtckn_seq_no
             AND    shrtckg_pidm        = shrtckn_pidm
             AND    shrtckg_pidm        = dxgrad_pidm
             AND    shrtckn_subj_code IN ('ENGL','MATH','ESL','ESOL')
             AND    shrtckn_crse_numb <  '1000'
             AND    NOT shrtckg_grde_code_final IN ('AU','F','WF','W')
             AND    (
                         shrtckn_repeat_course_ind <> 'E' 
                      OR shrtckn_repeat_course_ind IS NULL 
                    ) 
             AND    shrtckn_term_code <= dxgrad_term_code_grad                      
             GROUP  BY shrtckg_pidm
           );
    --          
    
 -- G-16 --------------------------------------------------------------------------------------------
 -- ELEMENT NAME: Previous Degree Type
 -- FIELD NAME:   G_PREV_DEG_TYPE 
 /* DEFINITION:   Type of highest degree awarded earned prior to this reporting period at any 
                  institution; including your own institution.                                     */
 ----------------------------------------------------------------------------------------------------

 -- To compile the previous degree type, we will have to create a table for previous, load it with 
 -- data, and query against it with the dxgrad table. 
 
 -- First, back up the old table
 -- CREATE TABLE prevdegrees1920 AS SELECT * FROM previous_degrees@tst1db;
    DROP   TABLE previous_degrees;
    CREATE TABLE previous_degrees AS SELECT * FROM previous_degrees_special; -- nts::replace with variable
    --

 -- Next, clear the current table
    TRUNCATE TABLE previous_degrees;
    alter table previous_degrees modify pg_degconc VARCHAR(30);
    --

 -- Get the degrees from other institution coded by Admissions in SOAPCOL and SHRTRAN
    INSERT INTO previous_degrees
           SELECT sordegr_pidm, 
                  spriden_id, 
                  MAX(stvdegc_acat_code) AS "ACAT", 
                  sordegr_degc_date, 
                  sordegr_degc_code, 
                  sordegr_sbgi_code, 
                  MIN(decode(stvdegc_dlev_code,
                             'DR','0',
                             'MA','0',
                             'BA','1',
                             'AS','2',
                             'LA','3',
                                  '4')) AS degsort,
                  sordegr_pidm||sordegr_degc_code||sordegr_degc_date AS combined, 
                  SYSDATE
           FROM   "SATURN"."SORDEGR", 
                  "SATURN"."STVDEGC",
                  spriden
           WHERE  sordegr_pidm        = spriden_pidm
           AND    sordegr_degc_code   = stvdegc_code
           AND    stvdegc_acat_code  >= 20
           AND    sordegr_degc_code  <> '000000'
           AND    spriden_change_ind IS NULL
           AND    sordegr_degc_date <= to_date('30-JUN-19') --change every year; one year lag
           GROUP  BY sordegr_pidm, spriden_id, stvdegc_acat_code, sordegr_degc_date,
                     sordegr_degc_code, SYSDATE, sordegr_sbgi_code
           ORDER  BY sordegr_pidm, stvdegc_acat_code DESC, sordegr_degc_date DESC;
    --
    
 -- Get the degrees from SHRTRAM and SHATRAM that are not on SOAPCOL/SORDEGR   
    INSERT INTO previous_degrees 
           SELECT shrtram_pidm, 
                  spriden_id, 
                  MAX(stvdegc_acat_code) AS "ACAT", 
                  shrtram_attn_end_date, 
                  shrtram_degc_code, 
                  '',  
                  MIN(decode(stvdegc_dlev_code, 
                             'DR','0', 
                             'MA','0', 
                             'BA','1', 
                             'AS','2', 
                             'LA','3',
                                  '4')) AS degsort, 
                  shrtram_pidm||shrtram_degc_code||shrtram_attn_end_date AS combined, 
                  SYSDATE 
           FROM   STVDEGC, 
                  shrtram, 
                  spriden 
           WHERE  shrtram_pidm        = spriden_pidm
           AND    shrtram_degc_code   = stvdegc_code 
           AND    stvdegc_acat_code  >= 20 
           AND    shrtram_degc_code  <> '000000'  
           AND    spriden_change_ind IS NULL 
         /*  AND    NOT EXISTS (
                               SELECT 'X' 
                               FROM   previous_degrees b 
                               WHERE  b.pg_pidm||pg_degcode = shrtram_pidm||shrtram_degc_code
                             ) */ 
           GROUP  BY shrtram_pidm, spriden_id, stvdegc_acat_code, shrtram_attn_end_date, 
                     shrtram_degc_code, SYSDATE;
    --
    
 -- Get the degrees from SHADEGR (DSU Awards)
    INSERT INTO previous_degrees 
           SELECT s1.shrdgmr_pidm AS pidm, 
                  spriden_id,
                  MAX (stvdegc_acat_code) AS hideg, 
                  temp1.degdate,
                  temp1.shrdgmr_degc_code AS degreecode, 
                  '4272' AS sbgi,
                  MIN(decode(stvdegc_dlev_code,'BA','1','AS','2','LA','3',4)) AS degsort,
                  degrec AS degconc, 
                  SYSDATE
           FROM   shrdgmr s1, 
                  stvdegc, 
                  spriden,
                  (
                    SELECT s2.shrdgmr_pidm, 
                           s2.shrdgmr_grad_date AS degdate, 
                           s2.shrdgmr_degc_code,
                           s2.shrdgmr_pidm||s2.shrdgmr_degc_code||s2.shrdgmr_grad_date AS degrec
                    FROM   shrdgmr s2
                    WHERE  s2.shrdgmr_degs_code  = 'AW'
                    AND    s2.shrdgmr_grad_date <= to_date('30-JUN-19')  -- change every year; one year lag
                    AND    s2.shrdgmr_grad_date IS NOT NULL 
                  ) temp1
           WHERE  temp1.shrdgmr_degc_code = stvdegc_code
           AND    s1.shrdgmr_pidm         = spriden_pidm
           AND    s1.shrdgmr_pidm         = temp1.shrdgmr_pidm
           AND   (s1.shrdgmr_pidm||s1.shrdgmr_degc_code||s1.shrdgmr_grad_date) = degrec 
           AND    spriden_change_ind IS NULL
           GROUP  BY s1.shrdgmr_pidm, degrec, temp1.degdate, temp1.shrdgmr_degc_code, spriden_id;


    
 -- Now, update the dxgrad_current table with the highest level previous degree type from the table
    UPDATE dxgrad_current
    SET    dxgrad_prev_degr = 
           (
             SELECT substr(MAX(temp2.onerec),2,5)
             FROM   previous_degrees A 
                    LEFT JOIN 
                    (
                      SELECT pg_pidm, MIN(minsort)||pg_degcode AS onerec
                      FROM   previous_degrees,
                             (
                               SELECT b.pg_pidm AS pidm, 
                                      MIN(b.pg_degsort)minsort
                               FROM   previous_degrees b
                               GROUP  BY b.pg_pidm
                             ) temp
                      WHERE  pg_pidm    = temp.pidm
                      AND    pg_degsort = minsort
                      GROUP  BY pg_pidm, pg_degcode
                    ) temp2
                    ON pg_degsort||A.pg_degcode = temp2.onerec
             WHERE  a.pg_pidm = temp2.pg_pidm
             AND    a.pg_pidm = dxgrad_pidm
             GROUP  BY a.pg_pidm
           );
    --
    
 -- Now change the degree to the IMC standard for previous degree
    UPDATE dxgrad_current
    SET    dxgrad_prev_degr = 
           (
            CASE WHEN dxgrad_prev_degr LIKE 'CER0' THEN '01'
                 WHEN dxgrad_prev_degr LIKE 'CER1' THEN '02' 
                 WHEN dxgrad_prev_degr LIKE 'A%'   THEN '03'
                 WHEN dxgrad_prev_degr LIKE 'B%'   THEN '05'
                 WHEN dxgrad_prev_degr LIKE 'M%'   THEN '07' 
                 END
           );
    --
 
 -- Use this query to view records that were just updated
 /* SELECT * 
    FROM   dxgrad_current 
    WHERE  dxgrad_prev_degr IS NOT NULL;
 */ --

 -- G-17 --------------------------------------------------------------------------------------------
 -- ELEMENT NAME: IPEDS Award Level Code
 -- FIELD NAME:   G_IPEDS 
 /* DEFINITION:   The Award Level codes that correspond with the IPEDS Completion Survey.          */
 ----------------------------------------------------------------------------------------------------
 
 -- Set IPEDS Level based on degc_code
    UPDATE dxgrad_current 
    SET    dxgrad_ipeds_levl = decode
           (
             dxgrad_degc_code,
          -- |    01    | |    02    | |    03    | |    05     |     07     | --
             'CER0','01', 'CER1','02', 'AA',  '03', 'BA',  '05', 'MACC','07',
             'CERT','01',              'AC',  '03', 'BS',  '05',
                                       'AB',  '03', 'BSN', '05',
                                       'AS',  '03', 'BIS', '05',
                                       'AAS', '03', 'BFA', '05',
                                       'APE', '03'
           );
           
           
           

 -- G-18 --------------------------------------------------------------------------------------------
 -- ELEMENT NAME: Required Hours for Degree
 -- FIELD NAME:   G_REQ_HRS_DEG 
 /* DEFINITION:   The minimum number of credit hours required for the degree including any course 
                  pre-requisites. Not to include any major remedial hours. Hours should all be 
                  converted to semester hours.                                                     */
 ----------------------------------------------------------------------------------------------------

 -- To compile the degrees' required hours, we will have to create a table for hours, load it with 
 -- data, and query against it with the dxgrad table. 
 



 -- Fetch hours for degree from the hrstodegAYAY table where AYAY is the graduating year
    UPDATE dxgrad_current
    SET    dxgrad_req_hrs = 
           (
             SELECT HRS_THIS_YR --nts::replace with variable.
             FROM   dsc_programs_all
             WHERE  acyr_code = '1920'
             AND    dxgrad_dgmr_prgm = prgm_code
             AND    (
                      dxgrad_degc_code = degc_code
                      OR 
                      dxgrad_grad_majr = majr_code
                    )
             AND    ROWNUM = 1 -- nts::need to clean up dsc_programs_all table so this isn't necessary.
           );
    --

    -- Fix IPEDS Levels for Certificate Courses
    UPDATE dxgrad_current
    SET    dxgrad_ipeds_levl  = '01'
    WHERE  dxgrad_req_hrs     < '30'
    AND    dxgrad_ipeds_levl <> '01'
    AND    dxgrad_dgmr_prgm LIKE 'CER%';
    -- 0 Corrections
    
    UPDATE dxgrad_current
    SET    dxgrad_ipeds_levl    = '02'
    WHERE  dxgrad_ipeds_levl   <> '02'
    AND    dxgrad_req_hrs BETWEEN '30' AND '59';
    -- 0 Corrections

 -- Check to make sure no other IPEDS Levels were incorrectly assigned.
    SELECT count(*)                   AS "Count", 
           nvl(dxgrad_ipeds_levl,'x') AS "Level", 
           dxgrad_degc_code           AS "DEGC ", 
           dxgrad_cipc_code           AS "CIPC ",
           dxgrad_req_hrs             AS "REQ HRS"
    FROM   dxgrad_current
    GROUP  BY dxgrad_ipeds_levl, dxgrad_degc_code, dxgrad_cipc_code, dxgrad_req_hrs;
    
 /* Now CHECK FOR NULLS.
    Aug08 found one stu with AAS-GCOM DGMR_PRGM and in dsc_programs
    it is AAS-GC (which the other 2 grads had as pgm code (soacurr has AAS-GC not GCOM))  
    There's always gotta be one glitch.  I don't know why both are active in Banner Soacurr
    but I only added the one in dsc_programs
  * Aug09 CONM which ended before 0910 has students in teachout graduating 0910 
    This will always be the case with 'most' ended programs, so UPDATE the NULLs found here
  * Aug10 CERT-GC was missing FROM dsc_programs0910, and also the ENGL-lit ptw etc soacurr
    codes, so I changed the UPDATE above to the 1011 version (current which had them) and
    ran again, BUT MAKE SURE YOU ADD:  WHERE dxgrad_req_hrs IS NULL OR all others will be null */

    /*
       SELECT dxgrad_pidm, dxgrad_id, dxgrad_req_hrs, dxgrad_dgmr_prgm, dxgrad_degc_code, 
              dxgrad_grad_majr, dxgrad_majr_conc1
       FROM   "ENROLL"."DXGRAD"
       WHERE  dxgrad_req_hrs IS NULL
       ORDER  BY dxgrad_degc_code, dxgrad_grad_majr;
    */
  

 -- G-19 --------------------------------------------------------------------------------------------
 -- ELEMENT NAME: High School Codes
 -- FIELD NAME:   G_HIGH_SCHOOL
 /* DEFINITION:   Refer to S_HIGH_SCHOOL in the Students Data Dictionary for a complete list of high 
                  schools. The High School or Special Secondary School code which uniquely identifies 
                  each students secondary institution. The codes for any secondary institution 
                  located within the United States can be found by accessing the URL 
                  http://www.act.org/aap/regist/lookuphs.html                                      */
 ----------------------------------------------------------------------------------------------------

 -- Fetch High School Code (match what is sent in enrollment).
    UPDATE dxgrad_current 
    SET    dxgrad_hs_code = 
           (
             SELECT a.sorhsch_sbgi_code 
             FROM   sorhsch A 
             WHERE  a.sorhsch_pidm = dxgrad_pidm 
             AND    a.sorhsch_graduation_date IS NOT NULL
             AND    a.sorhsch_trans_recv_date IS NOT NULL
             AND    a.sorhsch_graduation_date =
                    (
                      SELECT MAX(b.sorhsch_graduation_date)
                      FROM   sorhsch b
                      WHERE  b.sorhsch_pidm = dxgrad_pidm
                      AND    b.sorhsch_pidm = a.sorhsch_pidm
                      AND    b.sorhsch_trans_recv_date IS NOT NULL
                      AND    b.sorhsch_pidm ||b.sorhsch_trans_recv_date =
                             (
                               SELECT MAX(c.sorhsch_pidm||c.sorhsch_trans_recv_date)
                               FROM   sorhsch c
                               WHERE  c.sorhsch_pidm = dxgrad_pidm
                               AND    c.sorhsch_pidm = b.sorhsch_pidm
                               AND    c.sorhsch_trans_recv_date IS NOT NULL 
                               GROUP  BY c.sorhsch_pidm
                             )
                      GROUP  BY b.sorhsch_pidm
                    )
           )
    WHERE  dxgrad_hs_code IS NULL;
    --

 -- Fetch high school codes that weren't found in the above query using the older method.
    UPDATE dxgrad_current 
    SET    dxgrad_hs_code = 
         (
           SELECT sorhsch_sbgi_code 
           FROM   sorhsch 
           WHERE  sorhsch_pidm = dxgrad_pidm 
           AND    ROWNUM < 2
         ) 
    WHERE dxgrad_hs_code IS NULL;

 -- Change out of country to 459150
    UPDATE dxgrad_current
    SET    dxgrad_hs_code = '459150'
    WHERE  dxgrad_hs_code = '459999';
    --

 -- Change unknowns 459996 and 999999 to 459200  
    UPDATE dxgrad_current
    SET    dxgrad_hs_code = '459200'
    WHERE  dxgrad_hs_code IN ('459996','999999');
    --

 -- Set home schooling IMC outside of Utah 459600
    UPDATE dxgrad_current
    SET    dxgrad_hs_code = '459500'
    WHERE  dxgrad_hs_code IN ('459998','969999');
    --

 -- Set Other In-State HS   
    UPDATE dxgrad_current
    SET    dxgrad_hs_code = '459000'
    WHERE  dxgrad_hs_code = '459994';
    --

 -- Set out of st HS   
    UPDATE dxgrad_current
    SET    dxgrad_hs_code = '459100'
    WHERE  dxgrad_hs_code = '459997';
    --

 -- Set Adult HS Diploma (UT)
    UPDATE students_20132e
    SET    s_high_school = '459050'
    WHERE  s_high_school IN ('459993');
    --

 -- GED to UT GED
    UPDATE dxgrad_current
    SET    dxgrad_hs_code = '459300'
    WHERE  dxgrad_hs_code = '459995';
    --

 -- GED 2 to UT GED 2
    UPDATE dxgrad_current
    SET    dxgrad_hs_code = '459400'
    WHERE  dxgrad_hs_code = '969999';
    --
 
 -- Search for those with HS unknown to see if they have a second hs coded in banner
    /*
       SELECT sorhsch_sbgi_code, dxgrad_id, dxgrad_pidm, dxgrad_hs_code
       FROM   sorhsch, dxgrad_current
       WHERE  sorhsch_pidm       = dxgrad_pidm  
       AND    dxgrad_hs_code     = '459200'
       AND    sorhsch_sbgi_code <> '459996';
       --
    */
 
 -- G-20 --------------------------------------------------------------------------------------------
 -- ELEMENT NAME: Unique USOE State Student Identifier
 -- FIELD NAME:   G_SSID
 /* DEFINITION:   The unique Utah State Student Identifier as assigned to each Utah public education 
                  student by the Utah State Office of Education. This 9 digit number will appear on 
                  all high school transcripts beginning the 2006-2007 academic year. Purpose: to 
                  coordinate public education and higher education information technology systems to 
                  allow individual student academic achievement to be tracked through both education 
                  systems in accordance with 53A-1-603.5 and 53B-1-109.                            */
 ----------------------------------------------------------------------------------------------------

 -- Fetch known SSIDs from GORADID.
    UPDATE dxgrad_current
    SET    dxgrad_ssid =
           (
             SELECT substr(goradid_additional_id,0,10)
             FROM   goradid g1
             WHERE  goradid_pidm = dxgrad_pidm 
             AND    goradid_adid_code = 'SSID'
             AND    goradid_additional_id <> '*'
             AND    goradid_version =
                    (
                      SELECT g2.goradid_version
                      FROM   goradid g2
                      WHERE  g2.goradid_pidm = dxgrad_pidm 
                      AND    g2.goradid_adid_code = 'SSID'
                      AND    g2.goradid_additional_id <> '*'
                    )
           )
    WHERE  dxgrad_ssid IS NULL;
    --

 -- Fetch known SSIDs from SOAHSCH.
    UPDATE dxgrad_current
    SET    dxgrad_ssid = 
           (
             SELECT sorhsbj_subj_gpa
             FROM   sorhsbj
             WHERE  sorhsbj_pidm = dxgrad_pidm
             AND    sorhsbj_sbjc_code = 'SSID'
           )
    WHERE  dxgrad_ssid IS NULL;
    --

 -- Fetch known SSIDs from the SSID table (grad date <= 2008).
    UPDATE dxgrad_current
    SET    dxgrad_ssid = 
           (
             SELECT i.ssid_ushe
             FROM   ssid i
             WHERE  dxgrad_hs_code BETWEEN '450000' AND '458999'
             AND    dxgrad_pidm = i.pidm
             AND    dxgrad_hs_code = hscode_ushe
             AND    dxgrad_ssid IS NULL
           )
    WHERE dxgrad_ssid IS NULL;
    --
    
 -- Set invalid SSID to blank
    UPDATE dxgrad_current
    SET    dxgrad_ssid = NULL
    WHERE  dxgrad_ssid LIKE '3%'
    OR     dxgrad_ssid LIKE '#%'
    OR     dxgrad_ssid LIKE '%.%'
    OR     dxgrad_ssid LIKE '%*%';
    --

 -- G-25 --------------------------------------------------------------------------------------------
 /* ELEMENT NAME: Term of Graduation
    FIELD NAME:   G_TERM 
    DEFINITION:   The current (USHE) term in which the student graduated.                          */
 ----------------------------------------------------------------------------------------------------

    UPDATE dxgrad_current
    SET    dxgrad_ushe_term = 
           CASE substr(dxgrad_term_code_grad,5,1) 
                WHEN '3' THEN  '1'
                WHEN '4' THEN  '2'
                WHEN '2' THEN  '3'
                END;
    -- 

 -- G-27 --------------------------------------------------------------------------------------------
 -- ELEMENT NAME: Major Description
 -- FIELD NAME:   dxgrad_ushe_majr_desc
 /* DEFINITION:   Major Description is now used by USHE and should match CIP Code. This query pulls
                  the description from a table which has data directly from USHE.                  */
 ---------------------------------------------------------------------------------------------------- 
    
    UPDATE dxgrad_current 
    SET    dxgrad_ushe_majr_desc = 
           (
             SELECT ciptitle
             FROM   ushe_ref_cip2010
             WHERE  cip_code = dxgrad_cipc_code
           );
--           
--    UPDATE dxgrad_current 
--    SET    dxgrad_ushe_majr_desc = 'General Education'
--    WHERe  dxgrad_dgmr_prgm      = 'CERT-GENED';
--    --
 
 -- DSU - Age ---------------------------------------------------------------------------------------
 -- ELEMENT NAME: Age
 -- FIELD NAME:   dxgrad_age (not required for USHE File) 
 /* DEFINITION:   The age of the student at the time of graduation.                                */
 ----------------------------------------------------------------------------------------------------

    UPDATE dxgrad_current
    SET    dxgrad_age =
           (
             SELECT f_calculate_age(dxgrad_dsugrad_dt, spbpers_birth_date, spbpers_dead_date)
             FROM   spbpers
             WHERE  spbpers_pidm = dxgrad_pidm
           );
           
    --

 -- DSU-Concentration -------------------------------------------------------------------------------
 -- ELEMENT NAME: Concentration Code Outcomes
 -- FIELD NAME:   dxgrad_majr_conc1, dxgrad_majr_conc2 
 /* DEFINITION:   Concentrations are not used by USHE.                                             */
 ----------------------------------------------------------------------------------------------------

 -- Set first concentration
    UPDATE dxgrad_current  
    SET    dxgrad_majr_conc1 =  
           (
             SELECT MAX(a.shvacur_majr_code_conc_1) 
             FROM   shvacur a  
             WHERE  a.shvacur_pidm      = dxgrad_pidm 
             AND    a.shvacur_program   = dxgrad_dgmr_prgm 
             AND    a.shvacur_key_seqno = dxgrad_dgmr_seqno   
             AND    a.shvacur_cact_code = 'ACTIVE'  
             AND    a.shvacur_order     > 0
           );
    --

 -- Set second concentration
    UPDATE dxgrad_current  
    SET    dxgrad_majr_conc2 =  
           (
             SELECT MAX(a.shvacur_majr_code_conc_2) 
             FROM   shvacur a  
             WHERE  a.shvacur_pidm      = dxgrad_pidm  
             AND    a.shvacur_key_seqno = dxgrad_dgmr_seqno  
             AND    a.shvacur_program   = dxgrad_dgmr_prgm 
             AND    a.shvacur_cact_code = 'ACTIVE'  
             AND    a.shvacur_order     > 0
           );
    --
 
 -- DSU-Major-Description ---------------------------------------------------------------------------
 -- ELEMENT NAME: Major Description
 -- FIELD NAME:   dxgrad_majr_conc1, dxgrad_majr_conc2 
 /* DEFINITION:   Major Description is not used by USHE.                                           */
 ----------------------------------------------------------------------------------------------------

 -- Set the major description by majr_code using STVMAJR
    UPDATE dxgrad_current
    SET    dxgrad_majr_desc = 
           (
             SELECT majr_desc
             FROM   dsc_programs_current
             WHERE  prgm_code = dxgrad_dgmr_prgm
           );
           
    UPDATE dxgrad_current 
    SET    dxgrad_majr_desc = 'General Education'
    WHERe  dxgrad_dgmr_prgm = 'CERT-GENED';
    --
  
 -- DSU - HS Grad Date ------------------------------------------------------------------------------
 -- ELEMENT NAME: High School Grad Date
 -- FIELD NAME:   dxgrad_gsgrad_dt (not required for USHE File) 
 /* DEFINITION:   The date on which the student graduated high school.                             */
 ----------------------------------------------------------------------------------------------------

 -- Fetch known graduation dates from SORHSCH.
    UPDATE dxgrad_current
    SET    dxgrad_hsgrad_dt = 
           (
             SELECT to_char(A.sorhsch_graduation_date, 'YYYYMMDD')
             FROM   sorhsch A 
             WHERE  a.sorhsch_pidm = dxgrad_pidm
             AND    a.sorhsch_graduation_date IS NOT NULL
             --AND    a.sorhsch_trans_recv_date IS NOT NULL
             AND    a.sorhsch_graduation_date =
                    (
                      SELECT MAX(b.sorhsch_graduation_date)
                      FROM   sorhsch b
                      WHERE  b.sorhsch_pidm = dxgrad_pidm
                      AND    b.sorhsch_pidm = A.sorhsch_pidm  
                      --AND    b.sorhsch_trans_recv_date IS NOT NULL 
--                      AND    b.sorhsch_pidm ||b.sorhsch_trans_recv_date =
--                             (
--                               SELECT MAX(c.sorhsch_pidm||c.sorhsch_trans_recv_date)        
--                               FROM   sorhsch c
--                               WHERE  c.sorhsch_pidm = dxgrad_pidm
--                               AND    c.sorhsch_pidm = b.sorhsch_pidm
--                               AND    c.sorhsch_trans_recv_date IS NOT NULL 	     
--                               GROUP  BY c.sorhsch_pidm
--                             )
                      GROUP  BY b.sorhsch_pidm
                    )
           );
    --
 
 -- DSU - Country of Origin -------------------------------------------------------------------------
 -- ELEMENT NAME: Country of Origin
 -- FIELD NAME:   dxgrad_country_origin (not required for USHE File) 
 /* DEFINITION:   The student's country of residence at the time of application.                   */
 ----------------------------------------------------------------------------------------------------
 
 -- Fetch students country of origin.
    UPDATE dxgrad_current
    SET    dxgrad_country_origin = 
           (
             SELECT a.sabsupl_natn_code_admit
             FROM   sabsupl A 
             WHERE  a.sabsupl_pidm = dxgrad_pidm 
             AND    a.sabsupl_appl_no||A.sabsupl_term_code_entry = 
                    (
                      SELECT MIN(b.sabsupl_appl_no||b.sabsupl_term_code_entry ) 
                      FROM sabsupl b 
                      WHERE b.sabsupl_pidm = dxgrad_pidm
                    )
           );
    --

 -- DSU - State of Origin ---------------------------------------------------------------------------
 -- ELEMENT NAME: State of Origin
 -- FIELD NAME:   dxgrad_state_origin (not required for USHE File) 
 /* DEFINITION:   The student's state of residence at the time of application.                     */
 ----------------------------------------------------------------------------------------------------
 
 -- Fetch students country of origin.                                        
    UPDATE dxgrad_current
    SET    dxgrad_state_origin =  
           (
             SELECT a.sabsupl_stat_code_admit 
             FROM   sabsupl A
             WHERE  a.sabsupl_pidm = dxgrad_pidm
             AND    a.sabsupl_appl_no||A.sabsupl_term_code_entry = 
                    (
                      SELECT MIN(b.sabsupl_appl_no||b.sabsupl_term_code_entry )
                      FROM   sabsupl b
                      WHERE  b.sabsupl_pidm = dxgrad_pidm
                    )
           );
    --
 
 -- DSU-Initial-Term --------------------------------------------------------------------------------
 -- ELEMENT NAME: Initial Term
 -- FIELD NAME:   dxgrad_initial_term
 /* DEFINITION:   The term code for student's first term at DSU.                                   */
 ----------------------------------------------------------------------------------------------------

    UPDATE dxgrad_current
    SET    dxgrad_initial_term = 
           nvl((
                 SELECT MIN(banner_term)
                 FROM   students03@dscir
                 WHERE  dxgrad_pidm = dsc_pidm
                 AND    s_entry_action IN ('FF','FH','TU')
              ),(
                 SELECT MIN(banner_term)
                 FROM   students03@dscir
                 WHERE  dxgrad_pidm = dsc_pidm
              ));
    --

 -- DSU-Initial-Entry-Action ------------------------------------------------------------------------
 -- ELEMENT NAME: Entry Action
 -- FIELD NAME:   dxgrad_initial_ea
 /* DEFINITION:   The entry action code for student's first term at DSU (FF, FH or TU).            */
 ----------------------------------------------------------------------------------------------------

 -- s_entry_action first get those in DSCIR
    UPDATE dxgrad_current
    SET    dxgrad_initial_ea = 
           (
             SELECT DISTINCT s_entry_action
             FROM   bailey.students03@dscir
             WHERE  dxgrad_pidm = dsc_pidm                       
             AND    substr(dsc_term_code,0,5)||0 = dxgrad_initial_term
             AND    substr(dsc_term_code,5,2) IN ('3E','43','23') -- Only Sum EOT, Fall 3rd and Spr 3rd 
           );
    --
 
 -- Need to fix any records with CS, HS, or RS:
 
     -- Check for a transfer record. If student has one, assign TU.
        UPDATE dxgrad_current
        SET    dxgrad_initial_ea = 'TU'
        WHERE  dxgrad_pidm IN 
               (
                 SELECT b.sgbstdn_pidm
                 FROM   sgbstdn b
                 WHERE  b.sgbstdn_styp_code IN ('T')
                 AND    b.sgbstdn_pidm = dxgrad_pidm
                 AND    b.sgbstdn_term_code_eff = 
                        (
                          SELECT MAX(a.sgbstdn_term_code_eff)
                          FROM   sgbstdn a, dxgrad_current d
                          WHERE  a.sgbstdn_pidm = b.sgbstdn_pidm
                          AND    a.sgbstdn_pidm = d.dxgrad_pidm
                          AND    a.sgbstdn_term_code_eff <= dxgrad_term_code_grad
                        )
               )
        AND    (
                 dxgrad_initial_ea IN ('F','C','H','R','CS','HS','RS')  
                 OR 
                 dxgrad_initial_ea IS NULL
               );
        -- 
     
     -- If student is not a transfer, determine FF or FH by High School Grad Date and Age
        UPDATE dxgrad_current
        SET    dxgrad_initial_ea = 
               CASE WHEN dxgrad_hsgrad_dt IS NULL 
                         THEN (
                                CASE WHEN dxgrad_age <= 18 THEN 'FH'
                                     WHEN dxgrad_age >  18 THEN 'FF'
                                     ELSE 'FF' 
                                     END
                              )                            
                    WHEN (
                           CASE WHEN substr(dxgrad_initial_term,5,1) = '1' 
                                     THEN to_number(substr(dxgrad_initial_term,0,4)||'0101')
                                WHEN substr(dxgrad_initial_term,5,1) = '2' 
                                     THEN to_number(substr(dxgrad_initial_term,0,4)||'0801')
                                WHEN substr(dxgrad_initial_term,5,1) = '3' 
                                     THEN to_number(substr(dxgrad_initial_term,0,4)||'0501')
                                END
                         ) - to_number(dxgrad_hsgrad_dt) > '10000' THEN 'FF'
                    ELSE 'FH'
                    END 
        WHERE  (
                 dxgrad_initial_ea IN ('F','C','H','R','CS','HS','RS') 
                 OR 
                 dxgrad_initial_ea IS NULL
               );
        -- 

 -- DSU-Initial-PT-FT-Status ------------------------------------------------------------------------
 -- ELEMENT NAME: Part-Time / Full-Time Status
 -- FIELD NAME:   dxgrad_initial_pt_ft
 /* DEFINITION:   The part-time or full-time status for student's first term at DSU (PT or FT).    */
 ----------------------------------------------------------------------------------------------------

    UPDATE dxgrad_current
    SET    dxgrad_initial_pt_ft = 
           (
             SELECT s_pt_ft
             FROM   bailey.students03@dscir 
             WHERE  dxgrad_pidm = dsc_pidm
             AND    substr(dxgrad_initial_term,'0','5') = substr(dsc_term_code,'0','5')
             AND    substr(dsc_term_code,'6','1') = 
                    CASE DXGRAD_USHE_TERM 
                         WHEN 1 THEN 'E' 
                         WHEN 2 THEN '3' 
                         WHEN 3 THEN '3' 
                         END
           )
    WHERE dxgrad_initial_term IS NOT NULL;
    --

    UPDATE dxgrad_current
    SET    dxgrad_initial_pt_ft = 'F'
    WHERE  EXISTS
           (
             SELECT sum(sfrstcr_credit_hr) 
             FROM   sfrstcr, stvrsts  
	           WHERE  sfrstcr_pidm           = dxgrad_pidm 
	           AND    sfrstcr_rsts_code      = stvrsts_code 
	           AND    stvrsts_incl_sect_enrl = 'Y' 
	           AND    sfrstcr_term_code     <= dxgrad_initial_term 
             AND    sfrstcr_camp_code     <> 'XXX'
	           GROUP  BY sfrstcr_pidm 
	           HAVING SUM(sfrstcr_credit_hr) > 11.99
           )
    AND    dxgrad_initial_pt_ft NOT IN ('F','P')
    OR     dxgrad_initial_pt_ft IS NULL;
    --

    UPDATE dxgrad_current
    SET    dxgrad_initial_pt_ft  = 'P'
    WHERE  dxgrad_initial_pt_ft NOT IN ('F','P')
    OR     dxgrad_initial_pt_ft IS NULL;
    --

 -- DSU-Initial-Degree-Intent -----------------------------------------------------------------------
 -- ELEMENT NAME: Initial Degree Intent
 -- FIELD NAME:   dxgrad_initial_degint
 /* DEFINITION:   The Degree Intent for student's first term at DSU (i.e. 0, 1, 2, 4, etc.)        */
 ----------------------------------------------------------------------------------------------------
  
    UPDATE dxgrad_current
    SET    dxgrad_initial_degint = 
           (
             SELECT s_deg_intent
             FROM   bailey.students03@dscir
             WHERE  dxgrad_pidm = dsc_pidm  
             AND    dxgrad_initial_term = dsc_term_code
           )
    WHERE  dxgrad_initial_term IS NOT NULL;
    --

    UPDATE dxgrad_current 
    SET    dxgrad_initial_degint   = NULL
    WHERE  dxgrad_initial_degint NOT IN ('1','2','3','4','5');
    --
    
    UPDATE dxgrad_current
    SET    dxgrad_initial_degint   = '4'
    WHERE  dxgrad_degc_code     LIKE 'B%'
    AND    dxgrad_initial_degint  IS NULL;
    --

    UPDATE dxgrad_current
    SET    dxgrad_initial_degint   = '3'
    WHERE  dxgrad_dgmr_prgm       IN ('AAS-RADT', 'AAS-RSTH', 'AAS-PTA', 'AAS-DHYG')
    AND    dxgrad_initial_degint  IS NULL;
    --

    UPDATE dxgrad_current
    SET    dxgrad_initial_degint   = '2'
    WHERE  dxgrad_degc_code     LIKE 'A%'
    AND    dxgrad_initial_degint  IS NULL;
    --
    
    UPDATE dxgrad_current
    SET    dxgrad_initial_degint   = '1'
    WHERE  dxgrad_degc_code     LIKE 'C%'
    AND    dxgrad_initial_degint  IS NULL;
    --

 -- DSU-Initial-Sport -------------------------------------------------------------------------------
 -- ELEMENT NAME: Initial Sport
 -- FIELD NAME:   dxgrad_initial_sport
 /* DEFINITION:   If/What sport a student participated in during their first term at DSU.          */
 ----------------------------------------------------------------------------------------------------

    -- 
    UPDATE dxgrad_current
    SET    dxgrad_initial_sport =
           (
             SELECT max(sgrsprt_actc_code)
             FROM   sgrsprt
             WHERE  sgrsprt_pidm = dxgrad_pidm
             AND    dxgrad_initial_term = sgrsprt_term_code
           );
    --

 -- DSU-Pell-Paid -----------------------------------------------------------------------------------
 -- ELEMENT NAME: Pell Paid
 -- FIELD NAME:   dxgrad_pell_pd
 /* DEFINITION:   Whether the student received Pell Grant Funding while earning the degree from which
                  they are now graduating.                                                         */
 ----------------------------------------------------------------------------------------------------

    -- Mark students who have received Pell funding using RPRATRM. **This script can take a while.**
    UPDATE dxgrad_current
    SET    dxgrad_pell_pd = 'Y'
    WHERE  dxgrad_pidm IN 
           (
             SELECT rpratrm_pidm
             FROM   rpratrm
             WHERE  rpratrm_pidm = dxgrad_pidm
             AND    rpratrm_term_code <= dxgrad_term_code_grad
             AND    rpratrm_fund_code IN ('FPELL','FPELL1')
             GROUP  BY rpratrm_pidm
             HAVING sum(rpratrm_paid_amt) > 0
           )
    AND    dxgrad_pell_pd IS NULL;
    --
    
    UPDATE dxgrad_current
    SET    dxgrad_pell_pd = 'N'
    WHERE  dxgrad_pell_pd IS NULL;
    --

 -- Change-Nulls ------------------------------------------------------------------------------------
 ----------------------------------------------------------------------------------------------------

 -- Set [Nulls] to [Zero]:   
    UPDATE dxgrad_current SET dxgrad_hsgrad_dt = '0'      WHERE dxgrad_hsgrad_dt IS NULL; --
    UPDATE dxgrad_current SET dxgrad_grad_hrs  = '0'      WHERE dxgrad_grad_hrs  IS NULL; --
    UPDATE dxgrad_current SET dxgrad_req_hrs   = '0'      WHERE dxgrad_req_hrs   IS NULL; --
    UPDATE dxgrad_current SET dxgrad_remed_hrs = '0000'   WHERE dxgrad_remed_hrs IS NULL; --
    UPDATE dxgrad_current SET dxgrad_other_hrs = '0000'   WHERE dxgrad_other_hrs IS NULL; --
    UPDATE dxgrad_current SET dxgrad_trans_hrs = '00000'  WHERE dxgrad_trans_hrs IS NULL; --


 ----------------------------------------------------------------------------------------------------
 -- Re-Calculate and populate total hours from SHRTGPA minus remedial hours (sometimes the script 
 -- above does not stick and there are a great number of zeros for grad hours that are fixed by 
 -- running this script again at the end. A problem to fix another day. 
 
    UPDATE dxgrad_current a
    SET    A.dxgrad_grad_hrs = 
           ( -- Total Hours
             SELECT round(sum(shrtgpa_hours_earned),1) * 10
             FROM   shrtgpa 
             WHERE  shrtgpa_pidm       = a.dxgrad_pidm 
             AND    shrtgpa_levl_code  = dxgrad_levl_code 
             AND    shrtgpa_term_code <= dxgrad_term_code_grad
             GROUP  BY shrtgpa_pidm
           ) - dxgrad_remed_hrs;
    --

 -- Re-Fetch county code from SABSUPL table.
    UPDATE dxgrad_current
    SET    dxgrad_ut_cnty_code =  
           (
             SELECT (c.sabsupl_cnty_code_admit)
             FROM   sabsupl c
             WHERE  c.sabsupl_pidm = dxgrad_pidm
             AND    c.sabsupl_appl_no||c.sabsupl_term_code_entry = 
                    (
                      SELECT MIN(d.sabsupl_appl_no||d.sabsupl_term_code_entry )
                      FROM   sabsupl d
                      WHERE  d.sabsupl_pidm = dxgrad_pidm
                    )
           )
    WHERE  dxgrad_ut_cnty_code IS NULL;
    --
    
    UPDATE dxgrad_current
    SET    dxgrad_ut_cnty_code = 
           CASE LENGTH(dxgrad_ut_cnty_code) 
                WHEN 1 THEN 'UT00'||dxgrad_ut_cnty_code
                WHEN 2 THEN 'UT0' ||dxgrad_ut_cnty_code
                WHEN 3 THEN 'UT'  ||dxgrad_ut_cnty_code
                WHEN 4 THEN 'UT'  ||substr(dxgrad_ut_cnty_code,2,3)
                WHEN 5 THEN 'UT'  ||substr(dxgrad_ut_cnty_code,3,3)
                ELSE dxgrad_ut_cnty_code
                END
    WHERE  dxgrad_ut_cnty_code NOT LIKE 'UT%';
    --
    
    UPDATE dxgrad_current
    SET    dxgrad_ut_cnty_code   = 'UT099'
    WHERE  dxgrad_country_origin = 'US'
    AND    dxgrad_state_origin  <> 'UT'
    AND    dxgrad_ut_cnty_code  IS NULL;
    --
    
    UPDATE dxgrad_current
    SET    dxgrad_ut_cnty_code    = 'UT097'
    WHERE  dxgrad_country_origin <> 'US'
    AND    dxgrad_ut_cnty_code   IS NULL;
    --

    -- delete grads outside the date range. These shouldn't be showing up, but are somehow are.
    DELETE 
 -- SELECT *
    FROM   dxgrad_current
    WHERE  dxgrad_dsugrad_dt < to_date('30-JUN-19')  -- update each year
    OR     dxgrad_dsugrad_dt > to_date('01-JUL-20'); -- update each year
    --
    
    -- SELECT * FROM dxgrad_current WHERE dxgrad_gpa > 400
    
 ----------------------------------------------------------------------------------------------------
 -- Other fixes
 
    -- G-02d - USHE states SSN's can't start with 9, so change those SSNs to Banner IDs.
    UPDATE dxgrad_current
    SET    dxgrad_ssn = dxgrad_id
    WHERE  dxgrad_ssn LIKE '9%';
    -- 0 updates

 -- One-Time Fixes
 -- UPDATE dxgrad_current SET dxgrad_ut_cnty_code = 'UT053' WHERE dxgrad_id = '00044185';
    
 -- Find missing County Codes   
    UPDATE dxgrad_current 
    SET    dxgrad_ut_cnty_code = 
           (
             SELECT s_county_origin
             FROM   students03@dscir s1
             WHERE  dsc_pidm = dxgrad_pidm
             AND    dsc_term_code =
                    (
                      SELECT MAX(dsc_term_code)
                      FROM   students03@dscir s2
                      WHERE  dsc_pidm     = dxgrad_pidm
                      AND    banner_term <= dxgrad_term_code_grad
                    )
           )
    WHERE  dxgrad_ut_cnty_code IS NULL;
    
 -- Find missing State of Origin   
    UPDATE dxgrad_current 
    SET    dxgrad_state_origin = 
           (
             SELECT s_state_origin
             FROM   students03@dscir s1
             WHERE  dsc_pidm = dxgrad_pidm
             AND    dsc_term_code =
                    (
                      SELECT MAX(dsc_term_code)
                      FROM   students03@dscir s2
                      WHERE  dsc_pidm     = dxgrad_pidm
                      AND    banner_term <= dxgrad_term_code_grad
                    )
           )
    WHERE  dxgrad_state_origin IS NULL;
    
 ----------------------------------------------------------------------------------------------------
 ----------------------------------------------------------------------------------------------------    
 ----------------------------------------------------------------------------------------------------


 /**************************************************************************************************\
 |                    STOP HERE AND RUN REPORTS FIRST BEFORE CREATING USHE's FILE                   |
 \**************************************************************************************************/

 ----------------------------------------------------------------------------------------------------
 -- UPDATES: 06.01.2015: G-17 | USHE removed leading zeros from numbers 1-9 to match IPEDS format.

 SELECT dxgrad_inst                           AS g_inst,             -- G-01
        CASE WHEN LENGTH(dxgrad_ssn) <> '9' THEN lpad(dxgrad_ssn,8,'0') ELSE to_char(dxgrad_ssn) END
                                              AS g_id,               -- G-02
        dxgrad_last_name                      AS g_last,             -- G-03
        dxgrad_first_name                     AS g_first,            -- "
        dxgrad_middle                         AS g_middle,           -- "
        dxgrad_suffix                         AS g_suffix,           -- "
        dxgrad_ut_cnty_code                   AS g_county_origin,    -- G-04
        to_char(dxgrad_birth_dt, 'YYYYMMDD')  AS g_dob,              -- G-05
        dxgrad_sex                            AS g_gender,           -- G-06
        dxgrad_ethn_h                         AS g_ethnic_h,         -- G-07
        dxgrad_ethn_a                         AS g_ethnic_a,         -- "
        dxgrad_ethn_b                         AS g_ethnic_b,         -- "
        dxgrad_ethn_i                         AS g_ethnic_i,         -- "
        dxgrad_ethn_p                         AS g_ethnic_p,         -- "
        dxgrad_ethn_w                         AS g_ethnic_w,         -- "
        dxgrad_ethn_n                         AS g_ethnic_n,         -- "
        dxgrad_ethn_u                         AS g_ethnic_u,         -- "
        to_char(dxgrad_dsugrad_dt,'YYYYMMDD') AS g_date,             -- G-08
        dxgrad_cipc_code                      AS g_cip,              -- G-09
        dxgrad_degc_code                      AS g_deg_type,         -- G-10
        lpad(dxgrad_gpa,4,'0')                AS g_gpa,              -- G-11 - must be 4 digits
        lpad(nvl(to_char(dxgrad_trans_hrs), '00000'), 5, '0')
                                              AS g_trans_total,      -- G-12 - must be 5 digits
        lpad(nvl(to_char(dxgrad_grad_hrs),  '0000'),  4, '0')
                                              AS g_grad_hrs,         -- G-13
        lpad(nvl(to_char(dxgrad_other_hrs), '0000'),  4, '0')
                                              AS g_hrs_other,        -- G-14 - must be 4 digits
        lpad(nvl(to_char(dxgrad_remed_hrs), '0000'),  4, '0')
                                              AS g_remedial_hrs,     -- G-15 - must be 4 digits
        dxgrad_prev_degr                      AS g_prev_deg_type,    -- G-16
        ltrim(to_number(dxgrad_ipeds_levl))   AS g_ipeds,            -- G-17
        nvl(lpad(to_char(dxgrad_req_hrs), 3, '0'),'000')
                                              AS g_req_hrs_deg,      -- G-18 - must be 3 digits
        dxgrad_hs_code                        AS g_high_school,      -- G-19
        dxgrad_ssid                           AS g_ssid,             -- G-20
        dxgrad_id                             AS g_banner_id,        -- G-21
        ''                                    AS g_we_earn_cont_hrs, -- G-22
        ''                                    AS g_we_prgm_hrs,      -- G-23
        dxgrad_acyr                           AS g_fis_year,         -- G-24
        dxgrad_ushe_term                      AS g_term,             -- G-25
        dxgrad_ushe_majr_coll                 AS g_college,          -- G-26
        (SELECT ciptitle FROM ushe_ref_cip2010 WHERE dxgrad_cipc_code = cip_code) 
                                              AS g_major,            -- G-27
        dxgrad_degc_desc                      AS g_deg_type_name     -- G-28
 FROM   dxgrad_current;


 COMMIT;

 -- If all looks good, COMMIT;
 -- Save the pipe-delimited data as dsc-grad-YY.txt where YY = AY End

 /**************************************************************************************************\
 |                    YOU ARE DONE! YOU CAN USE THE BELOW QUERIES FOR 2AB REPORT.                   |
 \**************************************************************************************************/

 -- Checks for which USHE may ask you to verify numbers / counts: ------------------------------------
 
 -- Count (Unduplicated)
    SELECT count(DISTINCT dxgrad_pidm) AS "G-36"
    FROM   dxgrad_current;
    
 -- Count (Duplicated)
    SELECT count(dxgrad_pidm) AS "G-37"
    FROM   dxgrad_current;

 -- IPEDS Level Breakdown (Duplicated)
    SELECT dxgrad_ipeds_levl,
           count(dxgrad_pidm) AS "G-38"
    FROM   dxgrad_current 
    GROUP  BY dxgrad_ipeds_levl
    ORDER  BY dxgrad_ipeds_levl;    

 -- Gender Breakdown (Duplicated)
    SELECT dxgrad_sex,
           count(dxgrad_pidm) AS "G-39"      
    FROM   dxgrad_current 
    GROUP  BY dxgrad_sex
    ORDER  BY dxgrad_sex;

 -- Gender Breakdown (Unduplicated)
    SELECT dxgrad_sex,
           count(DISTINCT dxgrad_pidm) AS "G-40"          
    FROM   dxgrad_current 
    GROUP  BY dxgrad_sex
    ORDER  BY dxgrad_sex;

 -- CIP Code Breakdown (Duplicated)
    SELECT dxgrad_cipc_code, 
          -- dxgrad_majr_desc,
           count(dxgrad_pidm) AS "G-41"
    FROM   dxgrad_current 
    GROUP  BY dxgrad_cipc_code
    ORDER  BY dxgrad_cipc_code;
    /** /
    ---------------------------------------------
    ALTER TABLE dxgrad_all MODIFY dxgrad_majr_desc VARCHAR(100);
    ALTER TABLE dxgrad_all MODIFY dxgrad_ushe_majr_coll VARCHAR(100);
    ALTER TABLE dxgrad_all MODIFY dxgrad_majr_desc VARCHAR(100);
    
 -- Once a year, import _current data into _all tabl e   
    CREATE TABLE dxgrad_all_bk10092018 AS SELECT * FROM dxgrad_all;
   
    INSERT INTO dxgrad_all 
    (
      dxgrad_pidm, dxgrad_id, dxgrad_acyr, dxgrad_term_code_grad, dxgrad_dsugrad_dt, 
      dxgrad_last_name, dxgrad_first_name, dxgrad_middle, dxgrad_birth_dt, dxgrad_age, dxgrad_sex, 
      dxgrad_ethn_code, dxgrad_ethnic_desc, dxgrad_ethn_h, dxgrad_ethn_a, dxgrad_ethn_b, 
      dxgrad_ethn_i, dxgrad_ethn_p, dxgrad_ethn_w, dxgrad_ethn_n, dxgrad_ethn_u, dxgrad_prev_degr, 
      dxgrad_hs_code, dxgrad_hsgrad_dt, dxgrad_ut_cnty_code, dxgrad_state_origin, 
      dxgrad_country_origin, dxgrad_initial_ea, dxgrad_initial_term, dxgrad_initial_pt_ft, 
      dxgrad_initial_degint, dxgrad_initial_sport, dxgrad_pell_pd, dxgrad_gpa, dxgrad_grad_hrs, 
      dxgrad_other_hrs, dxgrad_trans_hrs, dxgrad_remed_hrs, dxgrad_req_hrs, dxgrad_degc_code, 
      dxgrad_grad_majr, dxgrad_majr_desc, dxgrad_majr_conc1, dxgrad_majr_conc2, dxgrad_cipc_code, 
      dxgrad_ipeds_levl, dxgrad_levl_code, dxgrad_dgmr_seqno, dxgrad_dgmr_prgm, dxgrad_activity_dt,
      dxgrad_ushe_majr_coll, dxgrad_ushe_majr_desc
    )
    
    SELECT dxgrad_pidm, dxgrad_id, dxgrad_acyr, dxgrad_term_code_grad, dxgrad_dsugrad_dt, 
           dxgrad_last_name, dxgrad_first_name, dxgrad_middle, dxgrad_birth_dt, dxgrad_age, 
           dxgrad_sex, dxgrad_ethn_code, dxgrad_ethnic_desc, dxgrad_ethn_h, dxgrad_ethn_a, 
           dxgrad_ethn_b, dxgrad_ethn_i, dxgrad_ethn_p, dxgrad_ethn_w, dxgrad_ethn_n, dxgrad_ethn_u, 
           dxgrad_prev_degr, dxgrad_hs_code, dxgrad_hsgrad_dt, dxgrad_ut_cnty_code, 
           dxgrad_state_origin, dxgrad_country_origin, dxgrad_initial_ea, dxgrad_initial_term, 
           dxgrad_initial_pt_ft, dxgrad_initial_degint, dxgrad_initial_sport, dxgrad_pell_pd, 
           dxgrad_gpa, dxgrad_grad_hrs, dxgrad_other_hrs, dxgrad_trans_hrs, dxgrad_remed_hrs, 
           dxgrad_req_hrs, dxgrad_degc_code, dxgrad_grad_majr, dxgrad_majr_desc, dxgrad_majr_conc1, 
           dxgrad_majr_conc2, dxgrad_cipc_code, dxgrad_ipeds_levl, dxgrad_levl_code, 
           dxgrad_dgmr_seqno, dxgrad_dgmr_prgm, dxgrad_activity_dt, dxgrad_ushe_majr_coll,
           dxgrad_ushe_majr_desc
    FROM   dxgrad_current;
    
    -- TRUNCATE TABLE dxgrad_current;
    
   -- COMMIT;
   select * from spbpers where spbpers_pidm = dsc.f_get_pidm('00177625')
    
 */
 -----------------------------------------------------------------------------------------------------
--select * from dsc_programs_current ---eced need to have deprartment to FSHD 
--update dsc_programs_all SET dept_code = 'FSHD' WHERE majr_code = 'ECED' AND acyr_code = '1920'
--
--select * from stvrelg

--SELECT DISTINCT dsc_pidm, s_banner_id, 's_id' as old_label, s_id AS old_data, spbpers_ssn AS new_data 
--FROM   students03@dscir, spbpers
--WHERE  spbpers_pidm = dsc_pidm 
--AND    s_id        != spbpers_ssn 
--AND    spbpers_ssn NOT LIKE '000%'
--AND    spbpers_ssn NOT LIKE '9%' 
--AND    substr(spbpers_ssn,4,2) != '00'  
--AND    substr(spbpers_ssn,6,4) != '0000' 
--AND    dsc_pidm IN (SELECT dsc_pidm FROM students03@dscir WHERE s_year = '2019');

   -- COMMIT;
   -- SELECT * FROM dxgrad_current;
   -- SELECT * FROM shrdgmr where shrdgmr_term_code_grad BETWEEN 201830 AND 201920;



-- end of file
