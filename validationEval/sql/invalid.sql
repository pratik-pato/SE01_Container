update objects set objectid = 'nc11' where objectid = 'c1';
insert into objects values('anc1');
insert into containerConcreteTypes values('ict1',6100,13600,3180,280,''); 
insert into properties values('rpr1','fragile','pT1',''); 
insert into abstractWall values('w01',13600,3180,255,250,205),('iw01',13600,3180,255,250,205),('w01',6100,3180,255,250,205); 
insert into unitList values('su01','degree-celcius','C','pr3');
insert into WallDoor values('w01','d1',4100,1130,'BCDA'),('w01','d1',5650,1130,'DACB');
insert into containerObjects values('f1','ct1','classRoom','');
insert into nonContainerObjects values('ec1','nct1','beam',''); -- object id not start with 'c'

insert into containerObjectProperties values('c1','UID01','pr1','true','','amp boxP'),('c1','UID02','pr1','true','','roomP');
		-- object-id and property-id  not unique

insert into nonContainerObjectProperties values('nc1','UID03','pr2',100,'','beamP'),('nc1','UID04','pr2',200,'','benchP');
		-- object-id and property-id  not unique

insert into containerConcreteTypeFaces values('ct1','w01','w02','w03','w04','w05','w06'),('ct1','w07','w08','w09','w10','w11','w12');
		-- container concrete type-id not unique

insert into nonContainerConcreteTypeFaces values('nct1','w19','w20','w21','w22','w23','w24'),('nct1','w25','w26','w27','w28','w29','w30');	      -- container concrete type-id not unique

insert into containerConcreteTypeProperties values('ct1','pr3',20,'u01',''),('ct1','pr3',20,'u04','');
		-- container concrete type-id and property id not unique

insert into nonContainerConcreteTypeProperties values('nct1','pr2',50,'u02',''),('nct2','pr4','ABCD','u03',''),('nct3','pr4','ABCD','u03',''),('nct4','pr3',10,'u01','');  -- container concrete type-id and property id not unique

--insert into directChild_parent values('nc1','c1',1,2420,1,'ABCD','ABCD'),('nc2','c1',900,5560,2430,'DABC','ABCD'),('nc3','c1',6099,7820,1900,'CDAB','ABCD'),('c2','c1',6100,650,1500,'DABC','ABCD'),('c3','c1',6090,3041,2430,'ABCD','ABCD'),('nc4','c2',150,150,200,'ABCD','BCDA');

insert into directChild_parent values('nc1','c1',1,2420,1,'ABCD','ABCD'),('nc2','c1',900,5560,2430,'DABC','ABCD'),('nc4','c2',6099,7820,1900,'CDAB','ABCD'),('nc3','c3',6100,650,1500,'DABC','ABCD'),('c2','c3',6090,3041,2430,'ABCD','ABCD'),('c4','c1',150,150,200,'ABCD','BCDA'),('nc5','c4',150,150,200,'ABCD','BCDA'),('nc6','c4',150,150,200,'ABCD','BCDA'),('c5','c4',150,150,200,'ABCD','BCDA'),('nc7','c5',150,150,200,'ABCD','BCDA');

--('c1','c2',150,150,200,'ABCD','BCDA');


