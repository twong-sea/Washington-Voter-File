-- Need to create tables for addresses
CREATE SCHEMA IF NOT EXISTS wavf;

CREATE TABLE wavf.addresses
(addressid BIGSERIAL PRIMARY KEY
,addressname varchar(255)
,regstnum varchar(15)
,regstfrac varchar(15)
,regstpredirection varchar(15)
,regstname varchar(55)
,regsttype varchar(25)
,regstpostdirection varchar(15)
,regunittype varchar(15)
,regunitnum varchar(15)
,city varchar(55)
,state varchar(7)
,zip varchar(15)
,county varchar(55)
,household_size int
,household_lnames int)
;
INSERT INTO wavf.addresses
(addressname,regstnum,regstfrac,regstpredirection,regstname,regsttype,regstpostdirection,regunittype,regunitnum,city,state,county,household_size,household_lnames)
SELECT 
CONCAT_WS(' '
    ,regstnum
    ,regstfrac
    ,regstpredirection
    ,regstname
    ,regstpostdirection
    ,regunittype
    ,regunitnum
	) as addressname
	,regstnum
	,regstfrac
	,regstpredirection
	,regstname
	,regsttype
	,regstpostdirection
	,regunittype
	,regunitnum
	,regcity as city
	,regstate as state
	,c.county as county
	,count(*) as household_size
	,count(distinct lname) as household_lnames

FROM wavf_raw.wavf w
LEFT JOIN wavf_raw.county c ON c.countycode=w.countycode
WHERE statuscode='A'
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12
