-- Need to create tables for ethnicity
CREATE SCHEMA IF NOT EXISTS ethnicity;

CREATE TABLE ethnicity.census_temp
(nameid serial PRIMARY KEY
,last_name varchar(255)
,rank int
,num_people int
,num_per_100k varchar(15)
,cum_per_100k varchar(15)
,pct_white varchar(25)
,pct_black varchar(25)
,pct_aapi varchar(25)
,pct_native varchar(25)
,pct_mixed varchar(25)
,pct_latino varchar(25)
)

-- Run Copy statement

;
CREATE TABLE ethnicity.census AS
(SELECT nameid
,last_name
,num_people
,num_per_100k
,CASE WHEN pct_white ~ '^([0-9]+[.]?[0-9]*|[.][0-9]+)$' THEN pct_white::float/100
	ELSE 0 END AS pct_white
,CASE WHEN pct_black ~ '^([0-9]+[.]?[0-9]*|[.][0-9]+)$' THEN pct_black::float/100
	ELSE 0 END AS pct_black
,CASE WHEN pct_aapi ~ '^([0-9]+[.]?[0-9]*|[.][0-9]+)$' THEN pct_aapi::float/100
	ELSE 0 END AS pct_aapi
,CASE WHEN pct_latino ~ '^([0-9]+[.]?[0-9]*|[.][0-9]+)$' THEN pct_latino::float/100
	ELSE 0 END AS pct_latino
,CASE WHEN pct_native ~ '^([0-9]+[.]?[0-9]*|[.][0-9]+)$' THEN pct_native::float/100
	ELSE 0 END AS pct_native
,CASE WHEN pct_mixed ~ '^([0-9]+[.]?[0-9]*|[.][0-9]+)$' THEN pct_mixed::float/100
	ELSE 0 END AS pct_mixed
FROM ethnicity.census_temp
)
;
DROP TABLE IF EXISTS ethnicity.census_temp;
ALTER TABLE ethnicity.census
ADD COLUMN pct_known double precision
;
UPDATE ethnicity.census
SET pct_known = pct_white+pct_black+pct_aapi+pct_latino+pct_native+pct_mixed
;
/*
select last_name
,pct_aapi
,greatest(pct_white,pct_black,pct_latino,pct_native,pct_mixed)
as max_non_aapi
from ethnicity.census
where pct_aapi>.8
order by num_people desc
*/