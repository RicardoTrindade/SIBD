drop table if exists Wears;
drop table if exists Lives;
drop table if exists Connects;
drop table if exists Reading;
drop table if exists Setting;
drop table if exists Sensor;
drop table if exists Actuator;
drop table if exists Patient;
drop table if exists PAN;
drop table if exists Device;
drop table if exists Municipality;
drop table if exists Period;

  create table Patient (
	  number integer,
	  name varchar(255),
	  address varchar(255),
	  primary key(number));
  
  
  create table PAN (
	  domain varchar(255),
	  phone integer,
	  primary key(domain));
	  
	  
  create table Device (
	 serialnum varchar(255), --   podem ser numeros e letras
	 manufacturer varchar(255),
	 description varchar(255),
	 primary key (serialnum,manufacturer));
	 
  create table Sensor (
	 snum varchar(255),
	 manuf varchar(255),
	 units varchar(255),
	 primary key(snum,manuf),
	 foreign key(snum,manuf) references Device(serialnum,manufacturer));
	 
  create table Actuator (
	 snum varchar(255),
	 manuf varchar(255),
	 units varchar(255),
	 primary key(snum,manuf),
	 foreign key(snum,manuf) references Device(serialnum,manufacturer)); 
	 
  create table Municipality (
	 nut4code char(5), --  ver
	 name varchar(255),
	 primary key (nut4code));
	 
  create table Period ( 
	 start varchar(255), --  pode ser data numeros letras etc
	 end varchar(255),
	 primary key(start, end));
	 
  create table Reading ( 
	 snum varchar(255),
	 manuf varchar(255),
	 datetime timestamp, --  será timestamp ou varchar?,
	 value double, --  ou float
	 primary key (snum,manuf,datetime),
	 foreign key (snum,manuf) references Sensor(snum,manuf)); --  mais uma vez pode ter de ser alterado
	 
	 
  create table Setting (
	 snum varchar(255),
	 manuf varchar(255),
	 datetime timestamp, -- será timestamp ou varchar?,
	 value double, -- ou float
	 primary key (snum,manuf,datetime),
	 foreign key (snum,manuf) references Actuator(snum,manuf)); --  mais uma vez pode ter de ser alterado
	 
  create table Wears (
	  start varchar(255),
	  end varchar(255),
	  patient integer,
	  pan varchar(255),
	  primary key (start,end,patient),
	  foreign key (patient) references Patient(number), --  ou Patient(patient)??
	  foreign key (start,end) references Period(start,end),
	  foreign key (pan) references PAN(domain) --  ou PAN??
	  );
	  
  create table Lives (
	  start varchar(255),
	  end varchar(255),
	  patient integer,
	  muni char(5),
	  primary key (start,end,patient),
	  foreign key (muni) references Municipality(nut4code),
	  foreign key (start,end) references Period(start,end),
	  foreign key (patient) references Patient(number) -- duvidas
	  );
	  
  create table Connects (
	  start varchar(255),
	  end varchar(255),
	  snum varchar(255),
	  manuf varchar(255),
	  pan varchar(255),
	  primary key (start,end,snum,manuf),
	  foreign key (start,end) references Period(start,end),
	  foreign key (snum,manuf) references Device(serialnum,manufacturer), --  duvida aqui..
	  foreign key (pan) references PAN(domain)); --  e neste tambem

insert into Patient values (14075632,'Ricardo Trindade','Rua Professor Alfredo Reis');
insert into Patient values (14200440,'Joana Faria','Rua das Maravilhas');
insert into Patient values (14138466,'Beatriz Almeida','Praça Duque de Cadaval');
insert into Patient values (13998411,'José Portela','Rua Professor Aires de Sousa');
insert into Patient values (14592044,'Mariana Sequeira','Campo');
insert into Patient values (13548484,'Susana Capucho','Rua Catarina Eufémia');

insert into PAN values ('pan001.healthunit.org',918239456);
insert into PAN values ('pan002.healthunit.org',926096827);
insert into PAN values ('pan003.healthunit.org',968166584); -- pan do zé
insert into PAN values ('pan004.healthunit.org',968873789);
insert into PAN values ('pan005.healthunit.org',916267734);
insert into PAN values ('pan006.healthunit.org',917687839);	

insert into Device values ('SS-100001','Samsung','Blood Pressure Meter');
insert into Device values ('PS-000001','Philips','Blood Pressure Meter');
insert into Device values ('SiS-58956','Siemens','Scale');	
insert into Device values ('PA-26548','Philips','Rotating Pump');
insert into Device values ('SA-6888558','Samsung','Insulin Pump');
insert into Device values ('SiS-6988524','Siemens','Glucose Meter');
insert into Device values ('SiS-784486','Siemens','Heart Rate Monitor');
insert into Device values ('PS-85775','Philips','Heart Rate Monitor');
insert into Device values ('PS-12387','Philips', 'Scale');
insert into Device values ('PA-75254','Philips','Rotating Pump');	

insert into Sensor values ('SS-100001','Samsung','mmHg');
insert into Sensor values ('PS-000001','Philips','mmHg');
insert into Sensor values ('SiS-58956','Siemens','Kg');
insert into Sensor values ('SiS-6988524','Siemens','mg/dL');
insert into Sensor values ('SiS-784486','Siemens','BPM');
insert into Sensor values ('PS-85775','Philips','BPM');
insert into Sensor values ('PS-12387','Philips','Kg');	

insert into Actuator values ('PA-26548','Philips','RPM');
insert into Actuator values ('SA-6888558','Samsung','mmol/L');
insert into Actuator values ('PA-75254','Philips','RPM');

insert into Municipality values ('10001','Lisboa');
insert into Municipality values ('20001','Madeira');
insert into Municipality values ('30001','Loures');
insert into Municipality values ('40001','Évora');

insert into Period values ('2014-05-02 08:00:23','2014-06-02 23:59:59');
insert into Period values ('2015-08-15 15:55:00','2015-10-12 18:26:01');
insert into Period values ('1993-07-17 12:50:00','2011-09-26 09:00:00');
insert into Period values ('2014-09-01 14:00:00','2014-12-25 00:00:00');
insert into Period values ('1993-09-19 08:30:50','2011-09-15 12:30:00');
insert into Period values ('2015-04-01 08:00:00','2015-11-25 08:00:00');	

	
insert into Reading values ('PS-12387','Philips','2014-10-17 07:30:00', 130);
insert into Reading values ('PS-12387','Philips','2014-12-17 07:30:00',  90);
insert into Reading values ('PS-12387','Philips','2015-01-05 07:30:00', 180);
insert into Reading values ('SiS-6988524','Siemens','2015-06-21 08:00:00',70);
insert into Reading values ('SiS-6988524','Siemens','2015-06-21 14:00:00',250);
-- readings do zé
insert into Reading values ('SS-100001','Samsung','2015-05-25 08:00:00',8);
insert into Reading values ('SS-100001', 'Samsung' ,'2015-05-26 08:00:00', 9);
insert into Reading values ('SS-100001', 'Samsung' ,'2015-06-14 08:00:00',9.2);
insert into Reading values ('SS-100001','Samsung' ,'2015-04-20 08:00:00', 10); -- este não deve aparecer na query 3a	
-- 


insert into Setting values ('PA-26548','Philips','2014-05-03 09:40:00',2500);
insert into Setting values ('SA-6888558','Samsung','2015-06-21 14:01:00',15);
insert into Setting values ('SA-6888558','Samsung','2015-06-21 14:05:00',6);	



insert into Wears values ('2015-08-15 15:55:00','2015-10-12 18:26:01',14075632,'pan002.healthunit.org');
insert into Wears values ('2015-04-01 08:00:00','2015-11-25 08:00:00',13998411,'pan003.healthunit.org'); -- pan do zé

insert into Lives values ('1993-09-19 08:30:50','2011-09-15 12:30:00',14200440,'20001');
insert into Lives values ('1993-07-17 12:50:00','2011-09-26 09:00:00',14075632,'40001');

insert into Connects values ('2015-04-01 08:00:00','2015-11-25 08:00:00','SS-100001','Samsung','pan003.healthunit.org'); -- pan do zé
insert into Connects values ('2014-09-01 14:00:00','2014-12-25 00:00:00','PS-000001','Philips','pan002.healthunit.org');	
	
