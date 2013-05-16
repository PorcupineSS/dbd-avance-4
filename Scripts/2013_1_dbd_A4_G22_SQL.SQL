-- *************************************************************************
--                                                     2013_1_A4_Gn_SQL.SQL
-- *************************************************************************
-- Versión para MS SQL Server 2005 o 2012
-- *************************************************************************
--  Sustentación Avance 4 - Mayo 15 / 2013
--  Curso de Diseño de Bases de Datos - Grupo de trabajo No. ___
-- *************************************************************************
-- Participantes:              <- Escritos en orden alfabético por apellido
--    Cortes Hernandez Sergio Andres
--    Lancheros Pinto Carlos Duvan
--    Rodriguez Portela Johan David
--    Rozo Bautista Jeisson David
--    Vergara Vargas Jeisson Andres
-- *************************************************************************
-- Historial de las actualizaciones:
--     Autor, fecha, hora, breve descripción
--     Autor, fecha, hora, breve descripción
--     Autor, fecha, hora, breve descripción
--     Autor, fecha, hora, breve descripción
-- *************************************************************************
--  Script de motor Ms SQL server para un sistema de bases de datos de una escuela
-- *************************************************************************
--  Comandos sql:
--      Bien presentados, 
--      Legibles y
--      Documentados apropiadamente

/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     15/05/2013 09:07:26 p.m.                     */
/*==============================================================*/


if exists (select 1
            from  sysindexes
           where  id    = object_id('ASIGNATURAS')
            and   name  = 'DICTA_FK'
            and   indid > 0
            and   indid < 255)
   drop index ASIGNATURAS.DICTA_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ASIGNATURAS')
            and   type = 'U')
   drop table ASIGNATURAS
go

if exists (select 1
            from  sysobjects
           where  id = object_id('BITACORA')
            and   type = 'U')
   drop table BITACORA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CONTROLB')
            and   type = 'U')
   drop table CONTROLB
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('DIRECTORIO')
            and   name  = 'ESTTIENETELEFONOS_FK'
            and   indid > 0
            and   indid < 255)
   drop index DIRECTORIO.ESTTIENETELEFONOS_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('DIRECTORIO')
            and   name  = 'PROFETIENETELEFONOS_FK'
            and   indid > 0
            and   indid < 255)
   drop index DIRECTORIO.PROFETIENETELEFONOS_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DIRECTORIO')
            and   type = 'U')
   drop table DIRECTORIO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ESTUDIANTES')
            and   type = 'U')
   drop table ESTUDIANTES
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('INSCRIPCION')
            and   name  = 'INSCRIPCION_FK'
            and   indid > 0
            and   indid < 255)
   drop index INSCRIPCION.INSCRIPCION_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('INSCRIPCION')
            and   name  = 'INSCRIPCION2_FK'
            and   indid > 0
            and   indid < 255)
   drop index INSCRIPCION.INSCRIPCION2_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('INSCRIPCION')
            and   type = 'U')
   drop table INSCRIPCION
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PROFESORES')
            and   type = 'U')
   drop table PROFESORES
go

/*==============================================================*/
/* Table: ASIGNATURAS                                           */
/*==============================================================*/
create table ASIGNATURAS (
   CODASIG              int                  not null,
   IDPROFE              varchar(11)          null,
   NOMBREASIG           varchar(40)          not null,
   HORASSEMANALASIGPRES int                  not null,
   NUMCREDITOSASIG      int                  not null,
   TIPOASIG             varchar(18)          not null,
   OFERTADAACTUAL       bit                  not null,
   constraint PK_ASIGNATURAS primary key nonclustered (CODASIG),
   constraint AK_IDNOMBREASIG_ASIGNATU unique (NOMBREASIG)
)
go

/*==============================================================*/
/* Index: DICTA_FK                                              */
/*==============================================================*/
create index DICTA_FK on ASIGNATURAS (
IDPROFE ASC
)
go

/*==============================================================*/
/* Table: BITACORA                                              */
/*==============================================================*/
create table BITACORA (
   IDR                  int                  not null,
   IP                   varchar(20)          null,
   IDMAQ                varchar(20)          null,
   IDUSUARIO            varchar(20)          null,
   TIPOOPER             varchar(20)          null,
   TABLA                varchar(20)          null,
   FECHAB               datetime             null,
   constraint PK_BITACORA primary key nonclustered (IDR)
)
go

/*==============================================================*/
/* Table: CONTROLB                                              */
/*==============================================================*/
create table CONTROLB (
   IDCONTROL            int                  not null,
   IPC                  varchar(20)          null,
   IDMAQC               varchar(20)          null,
   IDUSUARIOC           varchar(20)          null,
   TIPOOPERC            varchar(20)          null,
   FECHACB              datetime             null,
   constraint PK_CONTROLB primary key nonclustered (IDCONTROL)
)
go

/*==============================================================*/
/* Table: DIRECTORIO                                            */
/*==============================================================*/
create table DIRECTORIO (
   IDTEL                int                  not null,
   IDPROFE              varchar(11)          null,
   IDESTU               varchar(11)          null,
   NUMTELEFONO          varchar(10)          not null,
   NUMCELULAR           varchar(10)          not null,
   constraint PK_DIRECTORIO primary key nonclustered (IDTEL)
)
go

/*==============================================================*/
/* Index: PROFETIENETELEFONOS_FK                                */
/*==============================================================*/
create index PROFETIENETELEFONOS_FK on DIRECTORIO (
IDPROFE ASC
)
go

/*==============================================================*/
/* Index: ESTTIENETELEFONOS_FK                                  */
/*==============================================================*/
create index ESTTIENETELEFONOS_FK on DIRECTORIO (
IDESTU ASC
)
go

/*==============================================================*/
/* Table: ESTUDIANTES                                           */
/*==============================================================*/
create table ESTUDIANTES (
   IDESTU               varchar(11)          not null,
   NOMBRECOMPLETOESTU   varchar(40)          not null,
   DIRECCIONESTU        varchar(25)          null,
   GENEROESTU           char(1)              not null,
   FECHANACIMIENTOESTU  datetime             not null,
   FECHAINGRESOUESTU    datetime             not null,
   CODESTU              int                  not null,
   PROGESTU             varchar(40)          not null,
   ESTADOCIVILESTU      varchar(11)          not null,
   constraint PK_ESTUDIANTES primary key nonclustered (IDESTU),
   constraint AK_IDCODESTU_ESTUDIAN unique (CODESTU)
)
go

/*==============================================================*/
/* Table: INSCRIPCION                                           */
/*==============================================================*/
create table INSCRIPCION (
   CODASIG              int                  not null,
   IDESTU               varchar(11)          not null,
   NOTADEFINITIVA       int                  null,
   CONCEPTONOTA         varchar(30)          null,
   constraint PK_INSCRIPCION primary key nonclustered (CODASIG, IDESTU)
)
go

/*==============================================================*/
/* Index: INSCRIPCION2_FK                                       */
/*==============================================================*/
create index INSCRIPCION2_FK on INSCRIPCION (
CODASIG ASC
)
go

/*==============================================================*/
/* Index: INSCRIPCION_FK                                        */
/*==============================================================*/
create index INSCRIPCION_FK on INSCRIPCION (
IDESTU ASC
)
go

/*==============================================================*/
/* Table: PROFESORES                                            */
/*==============================================================*/
create table PROFESORES (
   IDPROFE              varchar(11)          not null,
   NOMBREPROFE          varchar(40)          not null,
   SUELDOPROFE          money                null,
   DIRECCIONPROFE       varchar(20)          null,
   GENEROPROFE          char(1)              not null,
   FECHANACIMIENTOPROFE datetime             not null,
   FECHAGRADOPROFE      datetime             not null,
   FECHAINGRESOUPROFE   datetime             not null,
   ESTADOCIVILPROFE     varchar(11)          not null,
   constraint PK_PROFESORES primary key nonclustered (IDPROFE)
)
go


/*==============================================================*/
/* REGLAS - SQL Server                                          */
/*==============================================================*/

CREATE RULE regla1 AS @IDESTU <= 11 AND @IDESTU LIKE '[0-9]%';
Go
sp_bindrule regla1, "ESTUDIANTES.IDESTU";
Go

CREATE RULE regla2 AS @IDPROFE <= 11 AND @IDESTU LIKE '[0-9]%';
Go
sp_bindrule regla2, "PROFESORES.IDPROFE";
Go

CREATE RULE regla3 AS @NUMTELEFONO LIKE '[5][7][1245678]%';
Go
sp_bindrule regla3, "DIRECTORIO.NUMTELEFONO";
Go

CREATE RULE regla4 AS @NUMCELULAR LIKE '[3][01][01256]%';
Go
sp_bindrule regla4, "DIRECTORIO.NUMCELULAR";
Go

CREATE RULE regla5 AS @FECHANACIMIENTOESTU <= GETDATE();
Go
sp_bindrule regla5, "ESTUDIANTES.FECHANACIMIENTOESTU";
Go

CREATE RULE regla6 AS @FECHANACIMIENTOPROFE <= GETDATE();
Go
sp_bindrule regla6, "PROFESORES.FECHANACIMIENTOPROFE";
Go

CREATE RULE regla7 AS @FECHANACIMIENTOPROFE <= FECHAGRADOPROFE();
Go
sp_bindrule regla7, "PROFESORES.FECHANACIMIENTOPROFE";
Go

CREATE RULE regla8 AS (GETDATE() - @FECHAGRADOPROFE) <= 4;
Go
sp_bindrule regla8, "PROFESORES.FECHAGRADOPROFE";
Go

CREATE RULE regla9 AS @GENEROESTU IN ('M', 'm', 'F', 'f');
Go
sp_bindrule regla9, "ESTUDIANTES.GENEROESTU";
Go

CREATE RULE regla10 AS @GENEROPROFE IN ('M', 'm', 'F', 'f');
Go
sp_bindrule regla10, "PROFESORES.GENEROPROFE";
Go

CREATE RULE regla11 AS @ESTADOCIVILESTU IN ('Soltero', 'Casado', 'Viudo', 'Divorciado');
Go
sp_bindrule regla11, "ESTUDIANTES.ESTADOCIVILESTU";
Go

CREATE RULE regla12 AS @ESTADOCIVILPROFE IN ('Soltero', 'Casado', 'Viudo', 'Divorciado');
Go
sp_bindrule regla12, "PROFESORES.ESTADOCIVILPROFE";
Go


/*==============================================================*/
/* VISTAS - SQL Server                                          */
/*==============================================================*/

-- Vista para profesor con mas de tres años en la universidad:
CREATE VIEW PROFEDETRESANOS AS SELECT * FROM PROFESORES WHERE DATEDIFF(yy, PROFESORES.FECHAINGRESOUPROFE, GETDATE()) > 3;

-- Vista para profesor que se graduo hace mas de 15 años:
CREATE VIEW PROFEDETRESANOS AS SELECT * FROM PROFESORES WHERE DATEDIFF(yy, PROFESORES.FECHAGRADOPROFE, GETDATE()) > 15;

-- Vista para el profesor con mayor salario:
CREATE VIEW PROFEMAYORSUELDO AS SELECT * FROM PROFESORES WHERE SUELDOPROFE = (SELECT MAX(SUELDOPROFE) FROM PROFESORES);

-- Vista para el profesor con menor salario:
CREATE VIEW PROFEMENORSUELDO AS SELECT * FROM PROFESORES WHERE SUELDOPROFE = (SELECT MIN(SUELDOPROFE) FROM PROFESORES);


/*==============================================================*/
/* TRIGGERS - SQL Server                                          */
/*==============================================================*/

--Trigger de eliminacion de estudiante:
create TRIGGER triger_delete_estu on ESTUDIANTES for delete as
begin
    INSERT INTO BITACORA (TABLA, IP, IDMAQ, IDUSUARIO, FECHA, TIPOOPER)
    VALUES ("Estudiantes", 
     SELECT client_net_address
    FROM sys.dm_exec_connections
    WHERE Session_id = @@SPID,
   SELECT HOST_NAME(),
   SELECT session_id
    FROM sys.dm_exec_connections
    WHERE Session_id = @@SPID,  
   SELECT GETDATE(), 
    "Delete")
end
go

--Trigger de creacion de estudiante:
create TRIGGER triger_insert_estu on ESTUDIANTES for insert as
begin
    INSERT INTO BITACORA (TABLA, IP, IDMAQ, IDUSUARIO, FECHA, TIPOOPER)
    VALUES ("Estudiantes", 
     SELECT client_net_address
    FROM sys.dm_exec_connections
    WHERE Session_id = @@SPID,
   SELECT HOST_NAME(),
   SELECT session_id
    FROM sys.dm_exec_connections
    WHERE Session_id = @@SPID,  
   SELECT GETDATE(), 
    "Insert")
end
go

-- Trigger de actualizacion de estudiante:
create TRIGGER triger_update_estu on ESTUDIANTES for update as
begin
    INSERT INTO BITACORA (TABLA, IP, IDMAQ, IDUSUARIO, FECHA, TIPOOPER)
    VALUES ("Estudiantes", 
     SELECT client_net_address
    FROM sys.dm_exec_connections
    WHERE Session_id = @@SPID,
   SELECT HOST_NAME(),
   SELECT session_id
    FROM sys.dm_exec_connections
    WHERE Session_id = @@SPID,  
   SELECT GETDATE(), 
    "Update")
end
go

--Trigger de eliminacion de profesor:
create TRIGGER triger_delete_profe on PROFESORES for delete as
begin
    INSERT INTO BITACORA (TABLA, IP, IDMAQ, IDUSUARIO, FECHA, TIPOOPER)
    VALUES ("Profesores", 
     SELECT client_net_address
    FROM sys.dm_exec_connections
    WHERE Session_id = @@SPID,
   SELECT HOST_NAME(),
   SELECT session_id
    FROM sys.dm_exec_connections
    WHERE Session_id = @@SPID,  
   SELECT GETDATE(), 
    "Delete")
end
go

--Trigger de creacion de profesor:
create TRIGGER triger_insert_profe on PROFESORES for insert as
begin
    INSERT INTO BITACORA (TABLA, IP, IDMAQ, IDUSUARIO, FECHA, TIPOOPER)
    VALUES ("Profesores", 
     SELECT client_net_address
    FROM sys.dm_exec_connections
    WHERE Session_id = @@SPID,
   SELECT HOST_NAME(),
   SELECT session_id
    FROM sys.dm_exec_connections
    WHERE Session_id = @@SPID,  
   SELECT GETDATE(), 
    "Insert")
end
go

-- Trigger de actualizacion de profesor:
create TRIGGER triger_update_profe on PROFESORES for update as
begin
    INSERT INTO BITACORA (TABLA, IP, IDMAQ, IDUSUARIO, FECHA, TIPOOPER)
    VALUES ("Profesores", 
     SELECT client_net_address
    FROM sys.dm_exec_connections
    WHERE Session_id = @@SPID,
   SELECT HOST_NAME(),
   SELECT session_id
    FROM sys.dm_exec_connections
    WHERE Session_id = @@SPID,  
   SELECT GETDATE(), 
    "Update")
end
go

--Trigger de eliminacion de asignatura:
create TRIGGER triger_delete_asi on ASIGNATURAS for delete as
begin
    INSERT INTO BITACORA (TABLA, IP, IDMAQ, IDUSUARIO, FECHA, TIPOOPER)
    VALUES ("Asignaturas", 
     SELECT client_net_address
    FROM sys.dm_exec_connections
    WHERE Session_id = @@SPID,
   SELECT HOST_NAME(),
   SELECT session_id
    FROM sys.dm_exec_connections
    WHERE Session_id = @@SPID,  
   SELECT GETDATE(), 
    "Delete")
end
go

--Trigger de creacion de asignatura:
create TRIGGER triger_insert_asig on ASIGNATURAS for insert as
begin
    INSERT INTO BITACORA (TABLA, IP, IDMAQ, IDUSUARIO, FECHA, TIPOOPER)
    VALUES ("Asignaturas", 
     SELECT client_net_address
    FROM sys.dm_exec_connections
    WHERE Session_id = @@SPID,
   SELECT HOST_NAME(),
   SELECT session_id
    FROM sys.dm_exec_connections
    WHERE Session_id = @@SPID,  
   SELECT GETDATE(), 
    "Insert")
end
go

-- Trigger de actualizacion de estudiante:
create TRIGGER triger_update_asig on ASIGNATURAS for update as
begin
    INSERT INTO BITACORA (TABLA, IP, IDMAQ, IDUSUARIO, FECHA, TIPOOPER)
    VALUES ("Asignaturas", 
     SELECT client_net_address
    FROM sys.dm_exec_connections
    WHERE Session_id = @@SPID,
   SELECT HOST_NAME(),
   SELECT session_id
    FROM sys.dm_exec_connections
    WHERE Session_id = @@SPID,  
   SELECT GETDATE(), 
    "Update")
end



