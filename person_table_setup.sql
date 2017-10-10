-- Rebuilding the wavf_raw schema into usable format
-- Max Address Label length:  55 char name, 42 char address

CREATE SCHEMA IF NOT EXISTS wavf;

CREATE TABLE wavf.person AS
(SELECT wavfid
	,statevoterid
	,countyvoterid
	,title
	,fname
	,mname
	,lname
	,namesuffix
	,birthdate
	-- Change to Election Day required.  Returns age on election day
	,EXTRACT(YEAR FROM age('2017-11-07',birthdate)) as age
	,gender
	,addressid
	,


FROM wavf_raw.person
WHERE regcity='MERCER ISLAND'
AND statuscode='A'