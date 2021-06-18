SELECT '3671' AS g_inst,
       b.last_name,
       b.first_name,
       b.middle_name,
       b.name_suffix,
       b.ssn,
       b.first_admit_county_code,
       b.birth_date, --'YYYYMMDD'
       b.gender_code,
       b.ipeds_race_ethnicity,
       b.ethnicity_code,
       b.ethnicity_desc,
       b.is_hispanic_latino_ethnicity,
       --g_ethnic formating goes here
       b.is_asian,
       b.is_black,
       b.is_american_indian_alaskan,
       b.is_hawaiian_pacific_islander,
       b.is_white,
       b.is_international,
       --end g_ethnic
       a.graduation_date, --'YYYYMMDD',
       c.cip_code,
       a.degree_id,
       b.primary_level_overall_cumulative_gpa,  --GPA needs to be looked at: see PIDM:91093830 GPA should be 2.97
       d.transfer_cumulative_credits_earned, -- Need to check on this calculation to see if it is excluding CLEP, AP, MIL, LANG, DANTE'S, etc...)
       --overall_credits_earned, this excludes remedial credits,
       -- g_hrs_other (Other Hours),
       -- g_remedial_hrs remedial_hrs
       -- g_prev_deg_type previous_degree coded as ipeds award level
       --g_ipeds ipeds award level degree code
       -- g_req_hrs_deg required hours for degree
       e.dixie_high_school_ceeb, -- high school data doesn't go back far enough currently (Pulling from Prospects)
       -- g_ssid (This is the State student ID)
       'D' || a.student_id AS g_banner_id,
       ' ' AS g_we_earned_contact_hrs,
       ' ' g_we_program_hrs,
       '2021' AS g_year_fis_year,
       CASE
          WHEN f.term_type = 'Summer' THEN '1'
          WHEN f.term_type = 'Fall' THEN '2'
          WHEN f.term_type = 'Spring' THEN '3'
       END AS g_term,
       a.primary_major_college_desc,
       a.primary_major_desc,
       a.degree_desc
       --g_college
FROM degrees_awarded a
INNER JOIN student b ON b.student_id = a.student_id
INNER JOIN major c ON c.major_id = a.primary_major_id
LEFT JOIN student_term_level d ON d.student_id = a.student_id
   AND d.level_id = a.level_id
   AND a.graduated_term_id = d.term_id
LEFT JOIN prospect e ON e.student_id = a.student_id
LEFT JOIN term f ON f.term_id = a.graduated_term_id
   --AND enrollment_pipeline_status = 'Applicant'
WHERE graduation_date BETWEEN  TO_DATE('2020-07-01','YYY-MM-DD') AND  TO_DATE('2021-06-30','YYY-MM-DD');