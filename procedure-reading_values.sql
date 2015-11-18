
delimiter $$
create procedure reading_values(in patient_num integer,
                                in descrip varchar(255),
                                out r_value integer)
begin
declare rvalue integer;
select r.value into rvalue
from Reading as r, Device as d,Connects as c, Wears as w
where r.snum=d.serialnum
and r.manuf=d.manufacturer
and d.serialnum=c.snum
and d.manufacturer=c.manuf
and w.pan=c.pan
and w.patient=patient_num
and timestampdiff(month,r.datetime, current_timestamp)<=6
and r.datetime>=c.start
and r.datetime<=c.end
and d.description like CONCAT('%', descrip, '%')
group by rvalue;
set r_value=rvalue;
 
 end $$

 delimiter; 

 call reading_values(13998411, 'Blood Pressure', @y);

 select  @y;
