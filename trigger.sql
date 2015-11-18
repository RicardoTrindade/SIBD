delimiter $$

create trigger overlap before insert on Connects
for each row
begin

if old.start=new.start && old.end=new.end then 

insert into Connects values (old.start,
                      old.end,
                      new.snum,
                      new.manuf,
                      new.pan);

insert into Wears values (old.start,
                  old.end,
                  new.patien,
                  new.pan);

else 

insert into Connects values (new.start,
                      new.end,
                      new.snum,
                      new.manuf,
                      new.pan);
insert into Wears values (new.start, 
                  new.end,
                  new.patien,
                  new.pan);
insert into Period values (new.start,
                     new.end);

end if;

end &&

delimiter ;