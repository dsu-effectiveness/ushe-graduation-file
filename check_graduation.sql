/***************************************************************************************************
-- Set Paremeters :gradstart = 'DD-MMM-YY' i.e '30-JUN-20'
                  :gradend = 'DD-MMM-YY' i.e '01-JUL-21'
***************************************************************************************************/

 ----------------------------------------------------------------------------------------------------
 -- Graduation Verification Scripts
 ----------------------------------------------------------------------------------------------------

 TRUNCATE TABLE error_log;   
    
 -- G-00 counts vs. students ------------------------------------------------------------------------
    INSERT INTO error_log VALUES ('G-00', 
           (
             CASE WHEN (SELECT count(*)                    FROM dxgrad_current) = 
                       (SELECT count(DISTINCT dxgrad_pidm) FROM dxgrad_current) 
                  THEN 1 ELSE 0 END
           ));
    
 -- G-01 dxgrad_inst --------------------------------------------------------------------------------
    INSERT INTO error_log VALUES ('G-01', 
           (
             SELECT count(*)
          -- SELECT dxgrad_ssn, dxgrad_id, dxgrad_last_name, dxgrad_first_name
             FROM   dxgrad_current
             WHERE  dxgrad_inst != '3671'
           ));
    
 -- G-01a dxgrad_inst -------------------------------------------------------------------------------
    INSERT INTO error_log VALUES ('G-01a', 
           (
             SELECT count(*)
          -- SELECT dxgrad_ssn, dxgrad_id, dxgrad_last_name, dxgrad_first_name
             FROM   dxgrad_current
             WHERE  dxgrad_inst IS NULL
           ));
    
 -- G-02 dxgrad_ssn ---------------------------------------------------------------------------------
    INSERT INTO error_log VALUES ('G-02', 
           (
             SELECT count(*)
          -- SELECT dxgrad_ssn, dxgrad_id, dxgrad_last_name, dxgrad_first_name
             FROM   dxgrad_current
             WHERE  dxgrad_ssn IS NULL 
             OR     dxgrad_ssn IN ('','0')
           ));
    
 -- G-02a dxgrad_ssn --------------------------------------------------------------------------------
    INSERT INTO error_log VALUES ('G-02a', 
           (
             SELECT count(*)
          -- SELECT dxgrad_ssn, dxgrad_id, dxgrad_last_name, dxgrad_first_name
             FROM   dxgrad_current
             WHERE  dxgrad_ssn   < '00000001'
           ));
    
 -- CHECK ID IN STUDENT FILE
 -- G-02b dxgrad_ssn --------------------------------------------------------------------------------
    INSERT INTO error_log VALUES ('G-02b', 
           (
             SELECT count(*)
         -- SELECT DISTINCT dxgrad_ssn, dxgrad_id, dxgrad_last_name, dxgrad_first_name
             FROM   dxgrad_current c1
             WHERE  dxgrad_pidm NOT IN 
                    (
                      SELECT dsc_pidm
                      FROM   bailey.students03@dscir
                   -- WHERE  dsc_pidm IN (SELECT dxgrad_pidm FROM dxgrad_current)
                    )
           ));
    
 -- G-03a dxgrad_last_name --------------------------------------------------------------------------
    INSERT INTO error_log VALUES ('G-03a', 
           (
             SELECT count(*) 
          -- SELECT dxgrad_ssn, dxgrad_id, dxgrad_last_name, dxgrad_first_name
             FROM   dxgrad_current
             WHERE  dxgrad_last_name IS NULL 
             OR     dxgrad_last_name = ''
           ));
    
    
 -- G-03b dxgrad_first_name -------------------------------------------------------------------------
    INSERT INTO error_log VALUES ('G-03b', 
           (
             SELECT count(*) 
          -- SELECT dxgrad_ssn, dxgrad_id, dxgrad_last_name, dxgrad_first_name
             FROM   dxgrad_current
             WHERE  dxgrad_first_name IS NULL 
             OR     dxgrad_first_name = ''
           ));
    
    
 -- G-04 dxgrad_ut_cnty_code ------------------------------------------------------------------------
    INSERT INTO error_log VALUES ('G-04', 
           (
             SELECT count(*) 
           --SELECT dxgrad_ssn, dxgrad_id, dxgrad_last_name, dxgrad_first_name, dxgrad_ut_cnty_code, dxgrad_state_origin, dxgrad_country_origin
             FROM   dxgrad_current
             WHERE  dxgrad_ut_cnty_code IS NULL 
             OR     dxgrad_ut_cnty_code = ''
           ));
    
    
 -- G-04a dxgrad_ut_cnty_code -----------------------------------------------------------------------
    INSERT INTO error_log VALUES ('G-04a', 
           (
             SELECT count(*)
          -- SELECT dxgrad_ssn, dxgrad_id, dxgrad_last_name, dxgrad_first_name, dxgrad_ut_cnty_code
             FROM   dxgrad_current 
             WHERE  dxgrad_ut_cnty_code IS NULL
             OR     dxgrad_ut_cnty_code NOT IN 
                    (
                      'UT001','UT003','UT005','UT007','UT009','UT011','UT013','UT015','UT017','UT019','UT021',
                      'UT023','UT025','UT027','UT029','UT030','UT031','UT033','UT035','UT037','UT039','UT041',
                      'UT043','UT045','UT047','UT049','UT051','UT053','UT055','UT057','UT097','UT099'
                    )
           ));
    
    
 -- G-05 dxgrad_birth_dt ----------------------------------------------------------------------------
    INSERT INTO error_log VALUES ('G-05', 
           (
             SELECT count(*)
          -- SELECT dxgrad_ssn, dxgrad_id, dxgrad_last_name, dxgrad_first_name, dxgrad_birth_dt
             FROM   dxgrad_current
             WHERE  dxgrad_birth_dt IS NULL 
             OR     dxgrad_birth_dt IN ''
           ));
    
    
 -- G-06 dxgrad_sex ---------------------------------------------------------------------------------
    INSERT INTO error_log VALUES ('G-06', 
           (
             SELECT count(*) 
          -- SELECT dxgrad_ssn, dxgrad_id, dxgrad_last_name, dxgrad_first_name, dxgrad_sex
             FROM   dxgrad_current
             WHERE  dxgrad_sex IS NULL 
             OR     dxgrad_sex NOT IN ('M','F')
           ));
    
    
 -- G-07 Ethnicity Hispanic -------------------------------------------------------------------------
    INSERT INTO error_log VALUES ('G-07h', 
           (
             SELECT	count(*)
          -- SELECT dxgrad_id, dxgrad_last_name, dxgrad_first_name, dxgrad_sex, dxgrad_ethn_code, dxgrad_ethn_h
             FROM   dxgrad_current
             WHERE  dxgrad_ethn_h NOT IN ('H',' ')
             AND    dxgrad_ethn_h IS NOT NULL
           ));
    
    
 -- G-07a Ethnicity Asian ---------------------------------------------------------------------------
    INSERT INTO error_log VALUES ('G-07h', 
           (
             SELECT 	count(*)
          -- SELECT dxgrad_id, dxgrad_last_name, dxgrad_first_name, dxgrad_sex, dxgrad_ethn_code, dxgrad_ethn_a
             FROM   dxgrad_current
             WHERE  dxgrad_ethn_a NOT IN ('A',' ')
             AND    dxgrad_ethn_a IS NOT NULL
           ));
    
    
 -- G-07b Ethnicity Black ---------------------------------------------------------------------------
    INSERT INTO error_log VALUES ('G-07b', 
           (
             SELECT count(*)
          -- SELECT dxgrad_id, dxgrad_last_name, dxgrad_first_name, dxgrad_sex, dxgrad_ethn_code, dxgrad_ethn_b
             FROM   dxgrad_current
             WHERE  dxgrad_ethn_b NOT IN ('B',' ')
             AND    dxgrad_ethn_b IS NOT NULL
           ));
    
    
 -- G-07i Ethnicity American Indian -----------------------------------------------------------------
    INSERT INTO error_log VALUES ('G-07i', 
           (
             SELECT count(*)
          -- SELECT dxgrad_id, dxgrad_last_name, dxgrad_first_name, dxgrad_sex, dxgrad_ethn_code, dxgrad_ethn_i
             FROM   dxgrad_current
             WHERE  dxgrad_ethn_i  NOT IN ('I',' ')
             AND    dxgrad_ethn_i IS NOT NULL
           ));
    
    
 -- G-07p Ethnicity Pacific Islander ----------------------------------------------------------------
    INSERT INTO error_log VALUES ('G-07p', 
           (
             SELECT count(*)
          -- SELECT dxgrad_id, dxgrad_last_name, dxgrad_first_name, dxgrad_sex, dxgrad_ethn_code, dxgrad_ethn_p
             FROM   dxgrad_current
             WHERE  dxgrad_ethn_p NOT IN ('P',' ')
             AND    dxgrad_ethn_p IS NOT NULL
           ));
    
    
 -- G-07w Ethnicity White ---------------------------------------------------------------------------
    INSERT INTO error_log VALUES ('G-07w', 
           (
             SELECT count(*)
          -- SELECT dxgrad_id, dxgrad_last_name, dxgrad_first_name, dxgrad_sex, dxgrad_ethn_code, dxgrad_ethn_w
             FROM   dxgrad_current
             WHERE  dxgrad_ethn_w NOT IN ('W',' ')
             AND    dxgrad_ethn_w IS NOT NULL
           ));
    
    
 -- G-07n Ethnicity Non-Resident Alien --------------------------------------------------------------
    INSERT INTO error_log VALUES ('G-07n', 
           (
             SELECT count(*)
          -- SELECT dxgrad_id, dxgrad_last_name, dxgrad_first_name, dxgrad_sex, dxgrad_ethn_code, dxgrad_ethn_n
             FROM   dxgrad_current
             WHERE  dxgrad_ethn_n NOT IN ('N',' ')
             AND    dxgrad_ethn_n IS NOT NULL
           ));
    
    
 -- G-07u Ethnicity Unspecified ---------------------------------------------------------------------
    INSERT INTO error_log VALUES ('G-07u', 
           (
             SELECT count(*)
          -- SELECT dxgrad_id, dxgrad_last_name, dxgrad_first_name, dxgrad_sex, dxgrad_ethn_code, dxgrad_ethn_u
             FROM   dxgrad_current
             WHERE  dxgrad_ethn_u NOT IN ('U',' ')
             AND    dxgrad_ethn_u IS NOT NULL
           ));
    
    
 -- G-07us Ethnicity Unspecified When already specified. --------------------------------------------
    INSERT INTO error_log VALUES ('G-07us', 
           (
          -- These records are marked 'U' though they have an ethnicity marked elsewhere in the same record.
             SELECT count(*)
          /* SELECT dxgrad_id, dxgrad_last_name, dxgrad_first_name, dxgrad_sex, dxgrad_ethn_code, 
                    dxgrad_ethn_u, dxgrad_ethn_h, dxgrad_ethn_a, dxgrad_ethn_b, dxgrad_ethn_i, 
                    dxgrad_ethn_p, dxgrad_ethn_w, dxgrad_ethn_n /**/
             FROM   dxgrad_current
             WHERE  dxgrad_ethn_u NOT IN ('U',' ')
             AND    dxgrad_ethn_h IS NOT NULL 
             AND    (
                             dxgrad_ethn_a IS NOT NULL 
                      OR     dxgrad_ethn_b IS NOT NULL 
                      OR     dxgrad_ethn_i IS NOT NULL 
                      OR     dxgrad_ethn_p IS NOT NULL 
                      OR     dxgrad_ethn_w IS NOT NULL 
                      OR     dxgrad_ethn_n IS NOT NULL
                    )
           ));
    
    
 -- G-08 dxgrad_dsugrad_dt --------------------------------------------------------------------------
    INSERT INTO error_log VALUES ('G-08', 
           (
             SELECT count(*)
             FROM   dxgrad_current 
             WHERE  dxgrad_dsugrad_dt IS NULL
           ));
    
    
 -- G-08a dxgrad_dsugrad_dt -------------------------------------------------------------------------
    INSERT INTO error_log VALUES ('G-08a', 
           (
             SELECT count(*) AS "G-08a"
          -- SELECT DISTINCT dxgrad_id, dxgrad_last_name, dxgrad_first_name, dxgrad_dsugrad_dt, to_date(:gradstart) AS start_date, to_date(:gradend) AS end_date
             FROM   dxgrad_current
             WHERE  dxgrad_dsugrad_dt < to_date(:gradstart)
             OR     dxgrad_dsugrad_dt > to_date(:gradend)
           ));



                     
    
    
 -- G-09 dxgrad_cipc_code ---------------------------------------------------------------------------
    INSERT INTO error_log VALUES ('G-09', 
           (
             SELECT count(*)
          -- SELECT dxgrad_id, dxgrad_last_name, dxgrad_first_name, dxgrad_cipc_code
             FROM   dxgrad_current 
             WHERE  dxgrad_cipc_code NOT IN (SELECT DISTINCT cip_code FROM cip2010)
           ));
    
    
 -- G-09a dxgrad_cipc_code --------------------------------------------------------------------------
    INSERT INTO error_log VALUES ('G-09a', 
           (
             SELECT count(*)
          -- SELECT dxgrad_id, dxgrad_last_name, dxgrad_first_name, dxgrad_cipc_code
             FROM   dxgrad_current 
             WHERE  dxgrad_cipc_code IS NULL 
             OR     dxgrad_cipc_code IN ('','000000','005000')
           ));
  
    /*
 -- G-10 dxgrad_degc_code ---------------------------------------------------------------------------
    INSERT INTO error_log VALUES ('G-10', 
           (
             SELECT count(*) 
          -- SELECT dxgrad_id, dxgrad_last_name, dxgrad_first_name, dxgrad_degc_code
             FROM   dxgrad_current 
             WHERE  dxgrad_degc_code NOT IN 
                    (
                      SELECT DISTINCT dxgrad_degc_code 
                      FROM   REFERENCE.dbo.degree_type
                    )
           ));
    */
    
 -- G-10a dxgrad_degc_code --------------------------------------------------------------------------
    INSERT INTO error_log VALUES ('G10a-', 
           (
             SELECT count(*) AS "G-10a"
          -- SELECT dxgrad_degc_code, count(*)
             FROM   dxgrad_current 
             WHERE  dxgrad_degc_code IS NULL 
             OR     dxgrad_degc_code = ''
           ));
    
    /*
 -- G-10b dxgrad_degc_code --------------------------------------------------------------------------
    INSERT INTO error_log VALUES ('G-10b', 
           (
             SELECT count(*)
          -- SELECT dxgrad_cipc_code, dxgrad_degc_code
             FROM   dxgrad_current
             WHERE  NOT EXISTS (SELECT inst,cip,dedxgrad_type FROM   REFERENCE.dbo.program_of_study) 
           ));
    */
    
 -- G-11 dxgrad_gpa ---------------------------------------------------------------------------------
    INSERT INTO error_log VALUES ('G-11', 
           (
             SELECT count(*)
          -- SELECT dxgrad_ssn, dxgrad_id, dxgrad_last_name, dxgrad_first_name, dxgrad_gpa
             FROM   dxgrad_current
             WHERE  dxgrad_gpa IS NULL 
             OR     dxgrad_gpa IN ('','0')
             OR     dxgrad_gpa > '4.000'
           ));


    
 -- G-12 dxgrad_trans_hrs ---------------------------------------------------------------------------
    INSERT INTO error_log VALUES ('G-12',
           (
             SELECT count(*)
          -- SELECT dxgrad_ssn, dxgrad_id, dxgrad_last_name, dxgrad_first_name, dxgrad_trans_hrs
             FROM   dxgrad_current
             WHERE  dxgrad_trans_hrs IS NULL 
             OR     nvl(lpad(to_char(dxgrad_trans_hrs), 5,'0'),'00000') IN ('','0')
--              OR     nvl(lpad(to_char(dxgrad_trans_hrs), 5,'0'),'00000') LIKE '%.%'
           ));
   
    
 -- G-13 dxgrad_grad_hrs ----------------------------------------------------------------------------
    INSERT INTO error_log VALUES ('G-13', 
           (
             SELECT count(*)
          -- SELECT dxgrad_ssn, dxgrad_id, dxgrad_last_name, dxgrad_first_name,dxgrad_grad_hrs, dxgrad_grad_hrs
             FROM   dxgrad_current
             WHERE  dxgrad_grad_hrs IS NULL
             OR     nvl(lpad(to_char(dxgrad_grad_hrs), 4, '0'),'0000') IN ('','0')
           ));


    
 -- G-14 dxgrad_hrs_other ---------------------------------------------------------------------------
    INSERT INTO error_log VALUES ('G-14', 
           (
             SELECT count(*)
          -- SELECT dxgrad_ssn, dxgrad_id, dxgrad_last_name, dxgrad_first_name, dxgrad_other_hrs
             FROM   dxgrad_current
             WHERE  dxgrad_other_hrs IS NULL 
             OR     nvl(lpad(to_char(dxgrad_other_hrs), 4, '0'),'0000') IN ('','0')
           ));
    
    
 -- G-15 dxgrad_remedial_hrs ------------------------------------------------------------------------
    INSERT INTO error_log VALUES ('G-15', 
           (
             SELECT count(*)
          -- SELECT dxgrad_ssn, dxgrad_id, dxgrad_last_name, dxgrad_first_name, dxgrad_remedial_hrs
             FROM   dxgrad_current
             WHERE  dxgrad_remed_hrs IS NULL 
             OR     nvl(lpad(to_char(dxgrad_remed_hrs), 4, '0'),'0000') IN ('','0') 
             OR     nvl(lpad(to_char(dxgrad_remed_hrs), 4, '0'),'0000') LIKE '%.%'
           ));
    
    
 -- G-16 dxgrad_prev_dedxgrad_type ------------------------------------------------------------------
    INSERT INTO error_log VALUES ('G-16', 
           (
             SELECT count(*) AS "G-16"
          -- SELECT dxgrad_ssn, dxgrad_id, dxgrad_last_name, dxgrad_first_name, dxgrad_prev_degr
             FROM   dxgrad_current
             WHERE  dxgrad_prev_degr NOT IN (' ','01','02','03','04','05','06','07','08','17','18','19')
           ));
    
    
 -- G-17 dxgrad_ipeds_levl --------------------------------------------------------------------------
    INSERT INTO error_log VALUES ('G-17', 
           (
             SELECT count(*)
          -- SELECT dxgrad_ssn, dxgrad_id, dxgrad_last_name, dxgrad_first_name, dxgrad_ipeds_levl, dxgrad_degc_code, dxgrad_dgmr_prgm
             FROM   dxgrad_current
             WHERE  dxgrad_ipeds_levl NOT IN ('1A', '1B','02','03','04','05','06','07','08','17','18','19')
             OR     dxgrad_ipeds_levl IS NULL
           ));


    
 -- G-18 dxgrad_redxgrad_hrs_deg --------------------------------------------------------------------
    INSERT INTO error_log VALUES ('G-18', 
           (
             SELECT count(*)
          -- SELECT dxgrad_ssn, dxgrad_id, dxgrad_last_name, dxgrad_first_name, dxgrad_req_hrs_deg
             FROM   dxgrad_current
             WHERE  dxgrad_req_hrs IS NULL 
             OR     nvl(lpad(to_char(dxgrad_req_hrs), 3, '0'),'000') IN ('','0') 
             OR     nvl(lpad(to_char(dxgrad_req_hrs), 3, '0'),'000') LIKE '%.%'
           ));
    
 /*   
 -- G-19 dxgrad_highschool --------------------------------------------------------------------------
    INSERT INTO error_log VALUES ('G-19', 
           (
             SELECT count(*) AS "G-19"
          -- SELECT dxgrad_id, dxgrad_last_name, dxgrad_first_name, dxgrad_hs_code
             FROM   dxgrad_current
             WHERE  dxgrad_hs_code IS NULL 
             OR     dxgrad_hs_code NOT IN (SELECT DISTINCT act FROM REFERENCE.dbo.highschools))
           ));
 */       
    
 -- G-21b dxgrad_id 8 digit -------------------------------------------------------------------------
    INSERT INTO error_log VALUES ('G-21b', 
           (
          -- There should be a valid institutionally assigned ID for all records.
             SELECT count(*)
          -- SELECT dxgrad_ssn, dxgrad_id, dxgrad_last_name, dxgrad_first_name
             FROM   dxgrad_current
             WHERE  dxgrad_id IS NULL
             OR     dxgrad_id = ''
             OR     LENGTH(dxgrad_id) != 9
           ));
    
    
 -- G-21c duplicate graduation records. -------------------------------------------------------------
    INSERT INTO error_log VALUES ('G-21c', 
           (
             SELECT count(DISTINCT dxgrad_id)
          /* SELECT dxgrad_pidm, dxgrad_id, dxgrad_cipc_code, dxgrad_degc_code, dxgrad_grad_majr, dxgrad_dgmr_prgm, 
                    dxgrad_term_code_grad, dxgrad_dsugrad_dt /**/
          -- SELECT *
             FROM   dxgrad_current
             WHERE  dxgrad_id||dxgrad_dgmr_prgm IN
                    (
                      SELECT dxgrad_id||dxgrad_dgmr_prgm
                      FROM   dxgrad_current 
                      GROUP  BY dxgrad_cipc_code, dxgrad_id, dxgrad_degc_code, dxgrad_dgmr_prgm
                      HAVING count(dxgrad_id||dxgrad_dgmr_prgm) > 1
                    )
           ));
    
    
 -- G-24 dxgrad_acyr --------------------------------------------------------------------------------
    INSERT INTO error_log VALUES ('G-24', 
           (
             SELECT count(*)
          -- SELECT *
             FROM   dxgrad_current 
             WHERE  dxgrad_acyr IS NULL 
             OR     dxgrad_acyr != (SELECT DISTINCT dxgrad_acyr FROM dxgrad_current)
           ));
       
       
 -- G-25 dxgrad_ushe_term ---------------------------------------------------------------------------
    INSERT INTO error_log VALUES ('G-25', 
           (
             SELECT count(*)
          -- SELECT dxgrad_ssn, dxgrad_id, dxgrad_ushe_term
             FROM   dxgrad_current 
             WHERE  dxgrad_ushe_term IS NULL 
             OR     dxgrad_ushe_term NOT IN ('1','2','3')
           ));
    
    
 -- G-26 college ------------------------------------------------------------------------------------
    INSERT INTO error_log VALUES ('G-26', 
           (
             SELECT count(*)
          -- SELECT dxgrad_ssn, dxgrad_id, dxgrad_majr_coll
             FROM   dxgrad_current  
             WHERE  dxgrad_ushe_majr_coll IS NULL 
             OR     dxgrad_ushe_majr_coll IN ('','0')
           ));
    
 -- G-27a major -------------------------------------------------------------------------------------
    INSERT INTO error_log VALUES ('G-27a', 
           (
             SELECT count(*)
          -- SELECT dxgrad_ssn, dxgrad_id, dxgrad_ushe_majr_desc, dxgrad_majr_desc
             FROM   dxgrad_current  
             WHERE  dxgrad_ushe_majr_desc IS NULL 
             OR     dxgrad_ushe_majr_desc IN ('','0')
           ));
    
    SELECT * FROM error_log WHERE err_cnt > 0 ORDER BY label;


 -- DSU Internal Check - Checks for Graduates where the graduation date, academic year, and term code don't align
 -- send this to the Graduation Coordinator */
SELECT shrdgmr_pidm,
       f_format_name(shrdgmr_pidm, 'FL') AS name,
       spriden_id AS banner_id,
       shrdgmr_degc_code,
       shrdgmr_degs_code,
       shrdgmr_term_code_grad,
       shrdgmr_acyr_code,
       shrdgmr_grad_date,
       shrdgmr_program
FROM shrdgmr a
LEFT JOIN spriden b ON b.spriden_pidm = a.shrdgmr_pidm
WHERE shrdgmr_grad_date between TO_DATE(:gradstart) and TO_DATE(:gradend)
AND shrdgmr_degs_code = 'AW'
AND (shrdgmr_acyr_code != EXTRACT(year FROM SYSDATE)
OR shrdgmr_term_code_grad NOT IN ('202030', '202040', '202120'))
AND spriden_change_ind IS NULL
ORDER BY shrdgmr_term_code_grad;

 -- DSU Internal Check - Checks for Graduates where the graduation hours are less than required hours
 SELECT dxgrad_pidm,
        dxgrad_id,
        dxgrad_acyr,
        dxgrad_dgmr_prgm,
        dxgrad_term_code_grad,
        dxgrad_grad_hrs,
        dxgrad_req_hrs
FROM ENROLL.dxgrad_current
WHERE dxgrad_grad_hrs < dxgrad_req_hrs;


    -- Graduates Tab
    SELECT (SELECT count(DISTINCT dxgrad_pidm) FROM dxgrad_current) AS distinct_hc,
           (SELECT count(*) FROM dxgrad_current)                    AS degree_count
    FROM   dual;
 
    -- IPEDS Tab
    SELECT dxgrad_ipeds_levl, count(*)
    FROM   dxgrad_current
    GROUP  BY dxgrad_ipeds_levl
    ORDER  BY dxgrad_ipeds_levl;


    -- Gender Tab
    SELECT (SELECT count(*) FROM dxgrad_current WHERE dxgrad_sex = 'F') 
           AS f_degrees,
           (SELECT count(*) FROM dxgrad_current WHERE dxgrad_sex = 'M') 
           AS m_degrees,
           (SELECT count(distinct dxgrad_pidm) FROM dxgrad_current WHERE dxgrad_sex = 'F') 
           AS undup_f_hc,
           (SELECT count(distinct dxgrad_pidm) FROM dxgrad_current WHERE dxgrad_sex = 'M') 
           AS undup_m_hc
    FROM   DUAL;
    
    -- CIP Tab
    SELECT dxgrad_cipc_code||'-'||dxgrad_ushe_majr_desc AS cip, 
           count(*) as graduates
    FROM   dxgrad_current
    GROUP  BY dxgrad_cipc_code, dxgrad_ushe_majr_desc;

 ----------------------------------------------------------------------------------------------------

-- end of file