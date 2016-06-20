drop table directChild_parent CASCADE;
drop table nonContainerObjectProperties CASCADE;
drop table nonContainerObjects CASCADE;
drop table containerConcreteTypeProperties CASCADE;
drop table containerObjects CASCADE;
drop table Unit_List CASCADE;
drop table properties CASCADE;
drop table containerConcreteTypeFaces CASCADE; 
drop table containerConcreteTypes CASCADE;
drop table nonContainerConcreteTypeFaces CASCADE; 
drop table nonContainerConcreteTypes CASCADE;
drop table typeInheritance CASCADE;
drop table types CASCADE;
drop table objects CASCADE;
drop table propertyTypes CASCADE;
drop table measurementunits CASCADE;
drop table physicalEntities CASCADE;
drop table WallDoor CASCADE;
drop table abstractWall CASCADE;
drop table abstractDoor CASCADE;

create table objects(
    objectID text primary key
);

create table types(
    type_id text primary key,
    type_name text,
    description text
);

create table typeInheritance (
    type_id text references types(type_id),
    super_type_id text references types(type_id),
    primary key(type_id, super_type_id)
);

create table containerConcreteTypes (
    containerConcreteTypeId text primary key references types(type_id),
    containerLengthAB integer NOT NULL, 
    containerLengthAD integer NOT NULL, 
    containerLengthAE integer NOT NULL, 
    containerThickness integer NOT NULL,
    userObjectCommentGlobal text
    
);

create table abstractDoor(
    DoorID text primary key,
    DoorLenghtAB integer NOT NULL,
    DoorLenghtAD integer NOT NULL,
    DoorColour text
);

create table abstractWall(
    WallID text primary key,
    WallLenghtAB integer NOT NULL,
    WallLenghtAD integer NOT NULL,
    WallColorR integer check(WallColorR>=0 AND WallColorR<=255),
    WallColorG integer check(WallColorG>=0 AND WallColorG<=255),
    WallColorB integer check(WallColorB>=0 AND WallColorB<=255),
    userWallComment text
);

create table WallDoor(
    wallID text references abstractWall(WallID),
    DoorID text references abstractDoor(DoorID),
    DisplacementAB integer NOT NULL,
    DisplacementAD integer NOT NULL,
    orientation text NOT NULL, 
    primary key(wallID,DoorID,DisplacementAB,DisplacementAD)
);
    

create table containerConcreteTypeFaces (
    containerConcreteTypeId text references containerConcreteTypes (containerConcreteTypeId),
    containerConcreteRoof text references abstractWall (WallID) NOT NULL,
    containerConcreteFloor text references abstractWall (WallID) NOT NULL, 
    containerConcreteRight text references abstractWall (WallID) NOT NULL,
    containerConcreteLeft text references abstractWall (WallID) NOT NULL,
    containerConcreteFront text references abstractWall (WallID) NOT NULL,
    containerConcreteBack text references abstractWall (WallID) NOT NULL
);

create table nonContainerConcreteTypes (
    nonContainerConcreteTypeId text primary key references types(type_id),
    nonContainerLengthAB integer NOT NULL, 
    nonContainerLengthAD integer NOT NULL, 
    nonContainerLengthAE integer NOT NULL, 
    userObjectCommentGlobal text
);

create table nonContainerConcreteTypeFaces (
    nonContainerConcreteTypeId text references nonContainerConcreteTypes (nonContainerConcreteTypeId),
    nonContainerConcreteRoof text references abstractWall (WallID) NOT NULL,
    nonContainerConcreteFloor text references abstractWall (WallID) NOT NULL, 
    nonContainerConcreteRight text references abstractWall (WallID) NOT NULL,
    nonContainerConcreteLeft text references abstractWall (WallID) NOT NULL,
    nonContainerConcreteFront text references abstractWall (WallID) NOT NULL,
    nonContainerConcreteBack text references abstractWall (WallID) NOT NULL
);

create table physicalEntities(
    physicalEntityID text primary key,
    entity_name text
);

create table Unit_List (
    unit_id text primary key,
    unit_name text,
    unit_abbr text,
    physicalEntityID text references physicalEntities(physicalEntityID), 
    multiplication_factor float
);

create table propertyTypes (
    propertyType text primary key,
    physicalEntityID text references physicalEntities(physicalEntityID), 
    userDescription text
);

create table properties (
    propertyID text primary key,
    propertyType text references propertyTypes(propertyType),
    userDescription text
);

create table measurementUnits (
    measurementUnitID text primary key
);

create table containerConcreteTypeProperties (
    containerConcreteTypeId text references containerConcreteTypes (containerConcreteTypeId),
    propertyID text references properties(propertyID), 
    propertyValue text NOT NULL,
    measurementUnitID text references measurementUnits(measurementUnitID),  
    userCommentGlobal text,
    primary key(containerConcreteTypeId, propertyID)
);

create table containerObjects (
    objectID text primary key references objects(objectID),
    containerConcreteTypeId text references containerConcreteTypes (containerConcreteTypeId),
    userLabel text NOT NULL,
    userObjectCommentLocal text
);

create table nonContainerObjects (
    objectID text primary key references objects(objectID) ,
    nonContainerConcreteTypeId text references nonContainerConcreteTypes (nonContainerConcreteTypeId),
    userLabel text,
    userObjectCommentLocal text
);

create table directChild_parent(
    childID text references objects(objectID),
    parrentID text references objects(objectID),
    DisplacementAB integer NOT NULL,
    DisplacementAD integer NOT NULL,
    DisplacementAE integer NOT NULL,
    orientation_FrontFace text NOT NULL,
    orientation_RoofFace text NOT NULL,
    primary key(childId, parrentID,DisplacementAB,DisplacementAD,DisplacementAE)
);

create table nonContainerObjectProperties (
    objectID text references objects (objectID),
    userAssignedID text NOT NULL,
    propertyID text references properties(propertyID), 
    propertyValue text NOT NULL,
    userCommentLocal text,
    userLabel text NOT NULL,
    primary key(objectID, propertyID)
);
