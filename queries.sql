SELECT r.value, s.units, r.datetime
FROM Reading as r,Device as d natural join Sensor as s,Connects as c,Wears as w, Patient as p
WHERE r.snum=d.serialnum
AND d.serialnum=c.snum
AND d.description like'%Blood Pressure%' -- read project
AND w.pan=c.pan
AND w.patient=p.number
AND p.name = 'José Portela'
AND d.serialnum=s.snum
AND timestampdiff(month,r.datetime, '2015-11-25')<=6;

SELECT s.value,a.units,s.datetime
FROM Setting as s, Device as d natural join Actuator as a, Connects as c, Wears as w,Patient as p
WHERE s.snum=d.serialnum
and d.serialnum=c.snum
and w.pan=c.pan
and w.patient=p.number
and p.name='José Portela'
and d.serialnum=a.snum; -- query php


select r.value
from Reading as r,Device as d,Connects as c,Wears as w
where r.snum=d.serialnum
and d.serialnum=c.snum
and d.description like'%Blood Pressure%' -- read project
and w.pan=c.pan
and w.patient=13998411
and timestampdiff(month,r.datetime, '2015-11-25')<=6; -- Query for 3a

select m.name
from Municipality as m Lives as l,Patient as p,Connects as c
where c.manuf="Philips"
and l.patient=p.number
and m.nut4code=l.muni;
