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
,zip
,county
,household_size int
,household_lnames int)

INSERT INTO wavf.addresses
(addressname,regstnum,regstfrac,regstpredirection,regstname,regsttype,regstpostdirection,regunittype,regunitnum,city,state,household_size,household_lnames)
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
	,county

FROM wavf_raw.wavf
WHERE statuscode='A'