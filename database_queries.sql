-- list of addresses on the island.  The _WS means that the first item is used as a delimiter.
select
CONCAT_WS(' '
    ,regstnum
    ,regstfrac
    ,regstpredirection
    ,regstname
    ,regstpostdirection
    ,regunittype
    ,regunitnum
	)
,count(*)

from wavf_raw.wavf
where statuscode='A' and regcity ilike '%MERCER ISLAND%' 
and countycode='KI'
--and regunitnum is not null
group by 1 order by 2 desc 
limit 200