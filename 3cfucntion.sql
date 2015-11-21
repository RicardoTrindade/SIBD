

delimiter $$

create function manufact_muni( description varchar(255))
returns varchar(255)
begin
declare manu varchar(255);

select d.manufacturer into manu
 from Device as d, Connects as c, PAN as p, Wears as w, Lives as l,Municipality as m, Patient as pa
  where d.description=description  
  and c.pan=p.domain 
  and d.serialnum=c.snum 
  and w.pan=p.domain 
  and w.patient=l.patient 
  and l.muni=m.nut4code 
  and w.patient=pa.number
  and w.start<=c.start
  and w.end>=c.end
  and timestampdiff(YEAR, c.end,current_timestamp)<=1 
  group by d.manufacturer
  having count(m.nut4code)>=(select count(m.nut4code)from Municipality as m);

return manu;

end$$

delimiter ;


select manufact_muni("Scale");