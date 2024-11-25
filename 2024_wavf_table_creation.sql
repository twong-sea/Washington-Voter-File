/* Setting up a Postgres database for my purposes

1.  Install PostGIS
2.  Install geocoder
3.  Install what else? 
*/

CREATE EXTENSION postgis;
CREATE EXTENSION postgis_topology;
CREATE EXTENSION fuzzystrmatch;
CREATE EXTENSION postgis_tiger_geocoder;
CREATE EXTENSION address_standardizer;
CREATE EXTENSION tablefunc;

/*
psql -h census.curqunhzk3h8.us-east-1-beta.rds.amazonaws.com -p 5432 -U susubear -d wavf17
*/
CREATE SCHEMA wavf_raw
;
CREATE TABLE wavf_raw.wavf -- changes in 2024 file are commented out
(wavfid bigserial PRIMARY KEY
,statevoterid varchar(25)
--,countyvoterid varchar(25)
--,title varchar(10)
,fname varchar(55)
,mname varchar(55)
,lname varchar(55)
,namesuffix varchar(15)
--,birthdate date
,birthyear varchar(6) -- yearofbirth in docs
,gender varchar(6)
,regstnum varchar(25)
,regstfrac varchar(25)
,regstname varchar(200)
,regsttype varchar(55)
,regunittype varchar(55)
,regstpredirection varchar(55)
,regstpostdirection varchar(55)
,regstunitnum varchar(55) -- should be regunitnum as in docs but file is mislabeled
,regcity varchar(200)
,regstate varchar(15)
,regzipcode varchar(15)
,countycode varchar(7)
,precinctcode varchar(25)
,precinctpart varchar(25)
,legislativedistrict varchar(4)
,congressionaldistrict varchar(4)
,mail1 varchar(200)
,mail2 varchar(200)
,mail3 varchar(200)
,mailcity varchar(200)
,mailstate varchar(7)
,mailzip varchar(15)
,mailcountry varchar(55)
,registrationdate date
--,absenteetype varchar(6)
,lastvoted date
,statuscode varchar(55)
--,dflag varchar(7)
)
;
CREATE TABLE wavf_raw.wavf2 -- changes in 2024 file are commented out
(statevoterid varchar(25) PRIMARY KEY
--,countyvoterid varchar(25)
--,title varchar(10)
,fname varchar(55)
,mname varchar(55)
,lname varchar(55)
,namesuffix varchar(15)
--,birthdate date
,birthyear varchar(6) -- yearofbirth in docs
,gender varchar(6)
,regstnum varchar(25)
,regstfrac varchar(25)
,regstname varchar(200)
,regsttype varchar(55)
,regunittype varchar(55)
,regstpredirection varchar(55)
,regstpostdirection varchar(55)
,regstunitnum varchar(55) -- should be regunitnum as in docs but file is mislabeled
,regcity varchar(200)
,regstate varchar(15)
,regzipcode varchar(15)
,countycode varchar(7)
,precinctcode varchar(25)
,precinctpart varchar(25)
,legislativedistrict varchar(4)
,congressionaldistrict varchar(4)
,mail1 varchar(200)
,mail2 varchar(200)
,mail3 varchar(200)
,mailcity varchar(200)
,mailstate varchar(7)
,mailzip varchar(15)
,mailcountry varchar(55)
,registrationdate date
--,absenteetype varchar(6)
,lastvoted date
,statuscode varchar(55)
--,dflag varchar(7)
)
;
CREATE TABLE wavf_raw.county
(countycode varchar(2)
,county varchar)
;
INSERT INTO wavf_raw.county
VALUES
('AD', 'Adams' )
,('AS', 'Asotin' )
,('BE', 'Benton' )
,('CH', 'Chelan' )
,('CM', 'Clallam' )
,('CR', 'Clark' )
,('CU', 'Columbia' )
,('CZ', 'Cowlitz' )
,('DG', 'Douglas' )
,('FE', 'Ferry' )
,('FR', 'Franklin' )
,('GA', 'Garfield' )
,('GR', 'Grant' )
,('GY', 'Grays Harbor' )
,('IS', 'Island' )
,('JE', 'Jefferson' )
,('KI', 'King' )
,('KP', 'Kitsap' )
,('KS', 'Kittitas' )
,('KT', 'Klickitat' )
,('LE', 'Lewis' )
,('LI', 'Lincoln' )
,('MA', 'Mason' )
,('OK', 'Okanogan' )
,('PA', 'Pacific' )
,('PE', 'Pend Oreille' )
,('PI', 'Pierce' )
,('SJ', 'San Juan' )
,('SK', 'Skagit' )
,('SM', 'Skamania' )
,('SN', 'Snohomish' )
,('SP', 'Spokane' )
,('ST', 'Stevens' )
,('TH', 'Thurston' )
,('WK', 'Wahkiakum' )
,('WL', 'Walla Walla' )
,('WM', 'Whatcom' )
,('WT', 'Whitman' )
,('YA', 'Yakima' )
;
CREATE TABLE wavf_raw.precincts
(countycode varchar
,county varchar
,districttype varchar
,districtcode varchar
,districtname varchar
,precinctcode varchar
,precinctname varchar
,precinctpart varchar
)
;
CREATE TABLE wavf_raw.votehistory
(vhid bigserial PRIMARY KEY
,countycode varchar
,statevoterid varchar
,electiondate varchar
,votinghistoryid varchar
)
;


\copy wavf_raw.wavf (statevoterid,fname,mname,lname,namesuffix,birthyear,gender,regstnum,regstfrac,regstname,regsttype,regunittype,regstpredirection,regstpostdirection,regstunitnum,regcity,regstate,regzipcode,countycode,precinctcode,precinctpart,legislativedistrict,congressionaldistrict,mail1,mail2,mail3,mailcity,mailzip,mailstate,mailcountry,registrationdate,lastvoted,statuscode) FROM '/Users/trevorwong/github/Washington-Voter-File/6741184014wa/20240801_VRDB_Extract.txt' WITH DELIMITER AS '|' CSV header;



\copy fcd_in ("column_1", "column_2", "column_3") FROM PROGRAM 'unzip -p c:\tmp\tmp.zip' WITH DELIMITER AS ';' NULL as 'null' CSV header;



cat 20240801_VRDB_Extract.txt | parallel --header : --pipe -N250000 'cat >20240801_VRDB_Extract_{#}.txt'
