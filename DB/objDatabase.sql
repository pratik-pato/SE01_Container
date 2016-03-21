drop table nonContainerObjectProperties CASCADE;
drop table nonContainerObjects CASCADE;
drop table containerConcreteTypeProperties CASCADE;
drop table containerObjects CASCADE;
drop table nonContainerConcreteTypes CASCADE;
drop table Unit_List CASCADE;
drop table properties CASCADE;
drop table containerConcreteTypeFaces CASCADE; 
drop table containerConcreteTypes CASCADE;
drop table typeInheritance CASCADE;
drop table types CASCADE;
drop table objects CASCADE;
drop table propertyTypes CASCADE;
drop table measurementunits CASCADE;
drop table physicalEntities CASCADE;
drop table abstractWall CASCADE;
drop table concreteWall CASCADE;

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

create table abstractWall(
    abstractwallId integer primary key,
    wallLengthAB integer check(wallLengthAB>0),
    wallLengthAD integer check(wallLengthAD>0),
    colorR integer check(colorR>=0 AND colorR<=255),
    colorG integer check(colorG>=0 AND colorG<=255),
    colorR integer check(colorB>=0 AND colorB<=255)
)


create table containerConcreteTypes (
    containerConcreteTypeId text primary key references types(type_id),
    containerLengthAB integer, 
    containerLengthAD integer, 
    containerLengthAE integer, 
    containerThickness integer,
    userObjectCommentGlobal text
);

create table containerConcreteTypeFaces (
    containerConcreteTypeId text references containerConcreteTypes (containerConcreteTypeId),
    containerConcreteRoof text,
    containerConcreteFloor text, 
    containerConcreteRight text,
    containerConcreteLeft text,
    containerConcreteFront text,
    containerConcreteBack text
);
create table nonContainerConcreteTypes (
    nonContainerConcreteTypeId text primary key references types(type_id),
    nonContainerLengthAB integer, 
    nonContainerLengthAD integer, 
    nonContainerLengthAE integer, 
    userObjectCommentGlobal text
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
    propertyValue text,
    measurementUnitID text references measurementUnits(measurementUnitID),  
    userCommentGlobal text,
    primary key(containerConcreteTypeId, propertyID)
);



create table containerObjects (
    objectID text primary key,
    containerConcreteTypeId text references containerConcreteTypes (containerConcreteTypeId),
    userLabel text,
    userObjectCommentLocal text
);

create table nonContainerObjects (
    objectID text primary key,
    nonContainerConcreteTypeId text references nonContainerConcreteTypes (nonContainerConcreteTypeId),
    userLabel text,
    userObjectCommentLocal text
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

