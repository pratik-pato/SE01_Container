create table objects(
    objectID varchar(10) primary key check(objectID ~ 'nc[0-9]+' OR objectID ~ 'c[0-9]+') 
);--objectID for container should start with c and container should start with nc

create table types(
    typeID varchar(10) primary key,
    typeName varchar(20) NOT NULL,
    description varchar(40) check(typeID ~ 'nct[0-9]+' OR typeID ~ 'ct[0-9]+')
);--typeID for container should start with ct and container should start with nct

create table containerConcreteTypes (
    containerConcreteTypeId varchar(10) references types(typeID)ON UPDATE RESTRICT UNIQUE check(containerConcreteTypeID ~ 'ct[0-9]+'),
    containerLengthAB integer check(containerLengthAB>0), 
    containerLengthAD integer check(containerLengthAD>0), 
    containerLengthAE integer check(containerLengthAE>0), 
    containerThickness integer check(containerThickness>0), 
    userObjectCommentGlobal varchar(40)
    
);--containerConcreteTypeID should be of container type and all length should be non zero update not allowed on typeID

create table abstractDoor(
    doorID varchar(10) primary key check(doorID ~ 'd[0-9]+'),
    doorLengthAB integer check(DoorLengthAB>0),
    doorLengthAD integer check(DoorLengthAD>0),
    doorColorR integer check(doorColorR>=0 AND doorColorR<=255),
    doorColorG integer check(doorColorG>=0 AND doorColorG<=255),
    doorColorB integer check(doorColorB>=0 AND doorColorB<=255)
);--doorId should start with d and color values should be in valid range and all lengths must be non zero

create table abstractWall(
    WallID varchar(10) primary key check(WallID ~ 'w[0-9]+'),
    WallLengthAB integer check(WallLengthAB>0),
    WallLengthAD integer check(WallLengthAD>0),
    WallColorR integer check(WallColorR>=0 AND WallColorR<=255),
    WallColorG integer check(WallColorG>=0 AND WallColorG<=255),
    WallColorB integer check(WallColorB>=0 AND WallColorB<=255),
    userWallComment varchar(40)
);--WallId should start with W and color values should be in valid range and all lengths must be non zero

create table WallDoor(
    wallID varchar(10) references abstractWall(WallID) ON UPDATE RESTRICT,
    doorID varchar(10) references abstractDoor(doorID) ON UPDATE RESTRICT UNIQUE,
    DisplacementAB integer check(DisplacementAB>0), 
    DisplacementAD integer check(DisplacementAD>0), 
    orientation varchar(4) check(orientation like 'ABCD' OR orientation like 'BCDA' OR orientation like 'CDAB' OR orientation like 'DABC' OR orientation like 'BADC' OR orientation like 'ADCB' OR orientation like 'DCBA' OR orientation like 'CBAD' ), 
    primary key(wallID,doorID)
);--doorID should not repeate and must be from existing doors and orientation must be valid string from given range
    

create table containerConcreteTypeFaces (
    containerConcreteTypeId varchar(10) references containerConcreteTypes (containerConcreteTypeId) ON UPDATE RESTRICT UNIQUE,
    concreteRoof varchar(10) references abstractWall (WallID) ON UPDATE RESTRICT NOT NULL,
    concreteFloor varchar(10) references abstractWall (WallID) ON UPDATE RESTRICT NOT NULL,
    concreteRight varchar(10) references abstractWall (WallID) ON UPDATE RESTRICT NOT NULL,
    concreteLeft varchar(10) references abstractWall (WallID) ON UPDATE RESTRICT NOT NULL,
    concreteFront varchar(10) references abstractWall (WallID) ON UPDATE RESTRICT NOT NULL,
    concreteBack varchar(10) references abstractWall (WallID) ON UPDATE RESTRICT NOT NULL
);

create table nonContainerConcreteTypes (
    nonContainerConcreteTypeId varchar(10) references types(typeID) ON UPDATE RESTRICT UNIQUE check(nonContainerConcreteTypeID like 'nct%'),
    nonContainerLengthAB integer check(nonContainerLengthAB>0), 
    nonContainerLengthAD integer check(nonContainerLengthAD>0), 
    nonContainerLengthAE integer check(nonContainerLengthAE>0), 
    userObjectCommentGlobal varchar(10)
);--nonContainerConcreteTypeID should be of non-container type and all length should be non zero

create table nonContainerConcreteTypeFaces (
    nonContainerConcreteTypeId varchar(10) references nonContainerConcreteTypes(nonContainerConcreteTypeId) ON UPDATE RESTRICT UNIQUE,
    concreteRoof varchar(10) references abstractWall (WallID) ON UPDATE RESTRICT NOT NULL,
    concreteFloor varchar(10) references abstractWall (WallID) ON UPDATE RESTRICT NOT NULL,
    concreteRight varchar(10) references abstractWall (WallID) ON UPDATE RESTRICT NOT NULL,
    concreteLeft varchar(10) references abstractWall (WallID) ON UPDATE RESTRICT  NOT NULL,
    concreteFront varchar(10) references abstractWall (WallID) ON UPDATE RESTRICT NOT NULL,
    concreteBack varchar(10) references abstractWall (WallID) ON UPDATE RESTRICT NOT NULL
);

create table propertyTypes (
    propertyType varchar(10) primary key check(propertyType ~ 'pT[0-9]+'),
    userDescription varchar(40)
);-- property type should start with pT

create table properties (
    propertyID varchar(10) primary key check(propertyID ~ 'pr[0-9]+'),
    propertyName varchar(10) NOT NULL,
    propertyType varchar(10) references propertyTypes(propertyType),
    userDescription varchar(40)
);-- property id should start with pr

create table unitList (
    unitID varchar(10) primary key check(unitID ~ 'u[0-9]+'),
    unitName varchar(20) NOT NULL,
    unitAbbr varchar(10),
    propertyID varchar(10) references properties( propertyID)
);

create table containerConcreteTypeProperties (
    containerConcreteTypeId varchar(10) references containerConcreteTypes(containerConcreteTypeId) ON UPDATE RESTRICT,
    propertyID varchar(10) references properties(propertyID) ON UPDATE RESTRICT,
    propertyValue varchar(10) NOT NULL,
    measurementUnitID varchar(10) references unitList(unitID),
    userCommentGlobal varchar(40),
    primary key(containerConcreteTypeId, propertyID)
);-- containerConcreteTypeId and propertyID make composite key

create table nonContainerConcreteTypeProperties (
    nonContainerConcreteTypeId varchar(10) references nonContainerConcreteTypes(nonContainerConcreteTypeId),
    propertyID varchar(10) references properties(propertyID) ON UPDATE RESTRICT,
    propertyValue varchar(10) NOT NULL,
    measurementUnitID varchar(10) references unitList(unitID),  
    userCommentGlobal varchar(40),
    primary key(nonContainerConcreteTypeId, propertyID)
);-- noncontainerConcreteTypeId and propertyID make composite key

create table containerObjects (
    objectID varchar(10) references objects(objectID) ON UPDATE RESTRICT UNIQUE check(objectID ~ 'c[0-9]+'),
    containerConcreteTypeId varchar(10) references containerConcreteTypes (containerConcreteTypeId),
    userLabel varchar(20) NOT NULL,
    userObjectCommentLocal varchar(40) 
);--objectId should be of container

create table nonContainerObjects (
    objectID varchar(10) references objects(objectID) ON UPDATE RESTRICT UNIQUE,
    nonContainerConcreteTypeId varchar(10) references nonContainerConcreteTypes (nonContainerConcreteTypeId),
    userLabel varchar(20),
    userObjectCommentLocal varchar(40) check(objectID ~ 'nc[0-9]+')
);--objectId should be of container

create table directChild_parent(
    childID varchar(10) references objects(objectID) ON UPDATE RESTRICT UNIQUE,
    parentID varchar(10) references objects(objectID) ON UPDATE RESTRICT check(parentID ~ 'c[0-9]+' AND childID <> parentID) ,
    DisplacementAB integer check(DisplacementAB>0), 
    DisplacementAD integer check(DisplacementAD>0), 
    DisplacementAE integer check(DisplacementAE>0), 
    orientation_FrontFace varchar(4) check(orientation_FrontFace like 'ABCD' OR orientation_FrontFace like 'BCDA' OR orientation_FrontFace like 'CDAB' OR orientation_FrontFace like 'DABC' OR orientation_FrontFace like 'BADC' OR orientation_FrontFace like 'ADCB' OR orientation_FrontFace like 'DCBA' OR orientation_FrontFace like 'CBAD'), 
    orientation_RoofFace  varchar(4) check(orientation_RoofFace like 'ABCD' OR orientation_RoofFace like 'BCDA' OR orientation_RoofFace like 'CDAB' OR orientation_RoofFace like 'DABC' OR orientation_RoofFace like 'BADC' OR orientation_RoofFace like 'ADCB' OR orientation_RoofFace like 'DCBA' OR orientation_RoofFace like 'CBAD'),
    primary key(childId, parentID)
);

create table nonContainerObjectProperties (
    objectID varchar(10) references nonContainerObjects(objectID) ON UPDATE RESTRICT,
    userAssignedID varchar(10) NOT NULL,
    propertyID varchar(10) references properties(propertyID), 
    propertyValue varchar(10) NOT NULL,
    userCommentLocal varchar(10),
    userLabel varchar(10) NOT NULL,
    primary key(objectID, propertyID)
);

create table containerObjectProperties (
    objectID varchar(10) references containerObjects(objectID) ON UPDATE RESTRICT,
    userAssignedID varchar(10) NOT NULL,
    propertyID varchar(10) references properties(propertyID), 
    propertyValue varchar(10) NOT NULL,
    userCommentLocal varchar(10),
    userLabel varchar(10) NOT NULL,
    primary key(objectID, propertyID)
);
