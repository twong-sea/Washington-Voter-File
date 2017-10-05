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
psql -h [host] -p 5432 -U [user] -d wavf17
*/
CREATE SCHEMA wavf_raw
;
CREATE TABLE wavf_raw.wavf
(wavfid bigserial PRIMARY KEY
,statevoterid varchar(25)
,countyvoterid varchar(25)
,title varchar(10)
,fname varchar(55)
,mname varchar(55)
,lname varchar(55)
,namesuffix varchar(15)
,birthdate date
,gender varchar(6)
,regstnum varchar(15)
,regstfrac varchar(15)
,regstname varchar(55)
,regsttype varchar(25)
,regunittype varchar(15)
,regstpredirection varchar(15)
,regstpostdirection varchar(15)
,regunitnum varchar(15)
,regcity varchar(55)
,regstate varchar(7)
,regzipcode varchar(15)
,countycode varchar(7)
,precinctcode varchar(14)
,precinctpart varchar(15)
,legislativedistrict int
,congressionaldistrict int
,mail1 varchar(105)
,mail2 varchar(105)
,mail3 varchar(105)
,mail4 varchar(105)
,mailcity varchar(55)
,mailzip varchar(15)
,mailstate varchar(7)
,mailcountry varchar(55)
,registrationdate date
,absenteetype varchar(6)
,lastvoted date
,statuscode varchar(11)
,dflag varchar(7)
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
--
-- LC_ALL=C sed '/^$/d' thegeekstuff.txt -- Use just this one!!!

--$ sed 's/^ *//; s/ *$//; /^$/d; /^\s*$/d' file.txt > output.txt

--`s/^ *//`  => left trim
--`s/ *$//`  => right trim
--`/^$/d`    => remove empty line
--`/^\s*$/d` => delete lines which may contain white space
/*Sources:  
http://www.thegeekstuff.com/2009/09/unix-sed-tutorial-replace-text-inside-a-file-using-substitute-command/?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+TheGeekStuff+(The+Geek+Stuff)
https://stackoverflow.com/questions/16414410/delete-empty-lines-using-sed
https://stackoverflow.com/questions/11287564/getting-sed-error-illegal-byte-sequence-in-bash
http://edoras.sdsu.edu/doc/sed-oneliners.html
*/

/* or maybe this one
sed -n 'n;p' 201704_VRDB_Extract.txt > 2017_singleline.txt
https://stackoverflow.com/questions/2560411/how-to-remove-every-other-line-with-sed
*/

\copy wavf_raw.wavf (statevoterid,countyvoterid,title,fname,mname,lname,namesuffix,birthdate,gender,regstnum,regstfrac,regstname,regsttype,regunittype,regstpredirection,regstpostdirection,regunitnum,regcity,regstate,regzipcode,countycode,precinctcode,precinctpart,legislativedistrict,congressionaldistrict,mail1,mail2,mail3,mail4,mailcity,mailzip,mailstate,mailcountry,registrationdate,absenteetype,lastvoted,statuscode,dflag) FROM '/Users/trevor/Desktop/vrdb-current/2017_singleline.txt';