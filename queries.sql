select r.value
from Reading as r,Device as d,Connects as c,Wears as w
where r.snum=d.serialnum
and d.serialnum=c.snum
and d.description like'%Blood Pressure%' -- read project
and w.pan=c.pan
and w.patient=13998411
and timestampdiff(month,r.datetime, '2015-11-25')<=6;