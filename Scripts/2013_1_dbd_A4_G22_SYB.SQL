-- *************************************************************************
--                                                     2013_1_A4_Gn_SYB.SQL
-- *************************************************************************
-- Versión para Sybase 15
-- *************************************************************************
--  Sustentación Avance 4 - Mayo 15 / 2013
--  Curso de Diseño de Bases de Datos - Grupo de trabajo No. 22 
-- *************************************************************************
-- Participantes:              <- Escritos en orden alfabético por apellido
--    CORTÉS HERNÁNDEZ SERGIO ANDRÉS, 258006
--    LANCHEROS PINTO CARLOS DUVAN, 258021
--    RODRÍGUEZ PORTELA JOHAN DAVID, 258145
--    ROZO BAUTISTA JEISSON DAVID, 257974
--    VERGARA VARGAS JEISSON ANDRÉS, 258064
-- *************************************************************************
-- Historial de las actualizaciones:
--     Autor, fecha, hora, breve descripción
--     Autor, fecha, hora, breve descripción
--     Autor, fecha, hora, breve descripción
--     Autor, fecha, hora, breve descripción
-- *************************************************************************
--  Descripción del objetivo de este script 
-- *************************************************************************
--  Comandos sql:
--      Bien presentados, 
--      Legibles y
--      Documentados apropiadamente

/*==============================================================*/
/* DBMS name:      Sybase AS Enterprise 15.0                    */
/* Created on:     15/05/2013 10:34:54 p.m.                     */
/*==============================================================*/


if exists (select 1
            from  sysobjects
            where id = object_id('TRIGER_DELETE_ASIG')
            and   type = 'TR')
   drop trigger TRIGER_DELETE_ASIG
go

if exists (select 1
            from  sysobjects
            where id = object_id('TRIGER_INSERT_ASIG')
            and   type = 'TR')
   drop trigger TRIGER_INSERT_ASIG
go

if exists (select 1
            from  sysobjects
            where id = object_id('TRIGER_UPDATE_ASIG')
            and   type = 'TR')
   drop trigger TRIGER_UPDATE_ASIG
go

if exists (select 1
            from  sysobjects
            where id = object_id('TRIGER_DELETE_CTRL')
            and   type = 'TR')
   drop trigger TRIGER_DELETE_CTRL
go

if exists (select 1
            from  sysobjects
            where id = object_id('TRIGER_INSERT_CTRL')
            and   type = 'TR')
   drop trigger TRIGER_INSERT_CTRL
go

if exists (select 1
            from  sysobjects
            where id = object_id('TRIGER_UPDATE_CTRL')
            and   type = 'TR')
   drop trigger TRIGER_UPDATE_CTRL
go

if exists (select 1
            from  sysobjects
            where id = object_id('TRIGER_DELETE_DIRC')
            and   type = 'TR')
   drop trigger TRIGER_DELETE_DIRC
go

if exists (select 1
            from  sysobjects
            where id = object_id('TRIGER_INSERT_DIRC')
            and   type = 'TR')
   drop trigger TRIGER_INSERT_DIRC
go

if exists (select 1
            from  sysobjects
            where id = object_id('TRIGER_UPDATE_DIRC')
            and   type = 'TR')
   drop trigger TRIGER_UPDATE_DIRC
go

if exists (select 1
            from  sysobjects
            where id = object_id('TRIGER_DELETE_ESTU')
            and   type = 'TR')
   drop trigger TRIGER_DELETE_ESTU
go

if exists (select 1
            from  sysobjects
            where id = object_id('TRIGER_INSERT_ESTU')
            and   type = 'TR')
   drop trigger TRIGER_INSERT_ESTU
go

if exists (select 1
            from  sysobjects
            where id = object_id('TRIGER_UPDATE_ESTU')
            and   type = 'TR')
   drop trigger TRIGER_UPDATE_ESTU
go

if exists (select 1
            from  sysobjects
            where id = object_id('TRIGER_DELETE_INSC')
            and   type = 'TR')
   drop trigger TRIGER_DELETE_INSC
go

if exists (select 1
            from  sysobjects
            where id = object_id('TRIGER_INSERT_INSC')
            and   type = 'TR')
   drop trigger TRIGER_INSERT_INSC
go

if exists (select 1
            from  sysobjects
            where id = object_id('TRIGER_UPDATE_INSC')
            and   type = 'TR')
   drop trigger TRIGER_UPDATE_INSC
go

if exists (select 1
            from  sysobjects
            where id = object_id('TRIGER_DELETE_PROFE')
            and   type = 'TR')
   drop trigger TRIGER_DELETE_PROFE
go

if exists (select 1
            from  sysobjects
            where id = object_id('TRIGER_INSERT_PROFE')
            and   type = 'TR')
   drop trigger TRIGER_INSERT_PROFE
go

if exists (select 1
            from  sysobjects
            where id = object_id('TRIGER_UPDATE_PROFE')
            and   type = 'TR')
   drop trigger TRIGER_UPDATE_PROFE
go

if exists (select 1 
            from  sysobjects c 
            join  sysconstraints s on (s.constrid = c.id and s.tableid = object_id('ASIGNATURAS'))
            where name = 'FK_ASIGNATU_DICTA_PROFESOR' and type = 'RI')
   alter table ASIGNATURAS
      drop constraint FK_ASIGNATU_DICTA_PROFESOR
go

if exists (select 1 
            from  sysobjects c 
            join  sysconstraints s on (s.constrid = c.id and s.tableid = object_id('DIRECTORIO'))
            where name = 'FK_DIRECTOR_ESTTIENET_ESTUDIAN' and type = 'RI')
   alter table DIRECTORIO
      drop constraint FK_DIRECTOR_ESTTIENET_ESTUDIAN
go

if exists (select 1 
            from  sysobjects c 
            join  sysconstraints s on (s.constrid = c.id and s.tableid = object_id('DIRECTORIO'))
            where name = 'FK_DIRECTOR_PROFETIEN_PROFESOR' and type = 'RI')
   alter table DIRECTORIO
      drop constraint FK_DIRECTOR_PROFETIEN_PROFESOR
go

if exists (select 1 
            from  sysobjects c 
            join  sysconstraints s on (s.constrid = c.id and s.tableid = object_id('INSCRIPCION'))
            where name = 'FK_INSCRIPC_INSCRIPCI_ESTUDIAN' and type = 'RI')
   alter table INSCRIPCION
      drop constraint FK_INSCRIPC_INSCRIPCI_ESTUDIAN
go

if exists (select 1 
            from  sysobjects c 
            join  sysconstraints s on (s.constrid = c.id and s.tableid = object_id('INSCRIPCION'))
            where name = 'FK_INSCRIPC_INSCRIPCI_ASIGNATU' and type = 'RI')
   alter table INSCRIPCION
      drop constraint FK_INSCRIPC_INSCRIPCI_ASIGNATU
go

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
            where id = object_id('ASIGNATURAS')
            and   type = 'U')
   drop table ASIGNATURAS
go

if exists (select 1
            from  sysobjects
            where id = object_id('BITACORA')
            and   type = 'U')
   drop table BITACORA
go

if exists (select 1
            from  sysobjects
            where id = object_id('CONTROLB')
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
            where id = object_id('DIRECTORIO')
            and   type = 'U')
   drop table DIRECTORIO
go

if exists (select 1
            from  sysobjects
            where id = object_id('ESTUDIANTES')
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
            where id = object_id('INSCRIPCION')
            and   type = 'U')
   drop table INSCRIPCION
go

if exists (select 1
            from  sysobjects
            where id = object_id('PROFESORES')
            and   type = 'U')
   drop table PROFESORES
go

/*==============================================================*/
/* Table: ASIGNATURAS                                           */
/*==============================================================*/
create table ASIGNATURAS (
   CODASIG              int                            not null,
   IDPROFE              varchar(11)                    null,
   NOMBREASIG           varchar(40)                    not null,
   HORASSEMANALASIGPRES int                            not null,
   NUMCREDITOSASIG      int                            not null,
   TIPOASIG             varchar(18)                    not null,
   OFERTADAACTUAL       bit                            not null,
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
   IDR                  int                            not null,
   IP                   varchar(20)                    null,
   IDMAQ                varchar(20)                    null,
   IDUSUARIO            varchar(20)                    null,
   TIPOOPER             varchar(20)                    null,
   TABLA                varchar(20)                    null,
   FECHAB               datetime                       null,
   constraint PK_BITACORA primary key nonclustered (IDR)
)
go

/*==============================================================*/
/* Table: CONTROLB                                              */
/*==============================================================*/
create table CONTROLB (
   IDCONTROL            int                            not null,
   IPC                  varchar(20)                    null,
   IDMAQC               varchar(20)                    null,
   IDUSUARIOC           varchar(20)                    null,
   TIPOOPERC            varchar(20)                    null,
   FECHACB              datetime                       null,
   constraint PK_CONTROLB primary key nonclustered (IDCONTROL)
)
go

/*==============================================================*/
/* Table: DIRECTORIO                                            */
/*==============================================================*/
create table DIRECTORIO (
   IDTEL                int                            not null,
   IDPROFE              varchar(11)                    null,
   IDESTU               varchar(11)                    null,
   NUMTELEFONO          varchar(10)                    not null,
   NUMCELULAR           varchar(10)                    not null,
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
   IDESTU               varchar(11)                    not null,
   NOMBRECOMPLETOESTU   varchar(40)                    not null,
   DIRECCIONESTU        varchar(25)                    null,
   GENEROESTU           char(1)                        not null,
   FECHABBNACIMIENTOESTU  date                           not null,
   FECHABBINGRESOUESTU    date                           not null,
   CODESTU              int                            not null,
   PROGESTU             varchar(40)                    not null,
   ESTADOCIVILESTU      varchar(11)                    not null,
   constraint PK_ESTUDIANTES primary key nonclustered (IDESTU),
   constraint AK_IDCODESTU_ESTUDIAN unique (CODESTU)
)
go

/*==============================================================*/
/* Table: INSCRIPCION                                           */
/*==============================================================*/
create table INSCRIPCION (
   CODASIG              int                            not null,
   IDESTU               varchar(11)                    not null,
   NOTADEFINITIVA       int                            null,
   CONCEPTONOTA         varchar(30)                    null,
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
   IDPROFE              varchar(11)                    not null,
   NOMBREPROFE          varchar(40)                    not null,
   SUELDOPROFE          money                          null,
   DIRECCIONPROFE       varchar(20)                    null,
   GENEROPROFE          char(1)                        not null,
   FECHABBNACIMIENTOPROFE date                           not null,
   FECHABBGRADOPROFE      date                           not null,
   FECHABBINGRESOUPROFE   date                           not null,
   ESTADOCIVILPROFE     varchar(11)                    not null,
   constraint PK_PROFESORES primary key nonclustered (IDPROFE)
)
go

alter table ASIGNATURAS
   add constraint FK_ASIGNATU_DICTA_PROFESOR foreign key (IDPROFE)
      references PROFESORES (IDPROFE)
go

alter table DIRECTORIO
   add constraint FK_DIRECTOR_ESTTIENET_ESTUDIAN foreign key (IDESTU)
      references ESTUDIANTES (IDESTU)
go

alter table DIRECTORIO
   add constraint FK_DIRECTOR_PROFETIEN_PROFESOR foreign key (IDPROFE)
      references PROFESORES (IDPROFE)
go

alter table INSCRIPCION
   add constraint FK_INSCRIPC_INSCRIPCI_ESTUDIAN foreign key (IDESTU)
      references ESTUDIANTES (IDESTU)
go

alter table INSCRIPCION
   add constraint FK_INSCRIPC_INSCRIPCI_ASIGNATU foreign key (CODASIG)
      references ASIGNATURAS (CODASIG)
go


create TRIGGER triger_delete_asig on ASIGNATURAS for delete as
begin
    INSERT INTO BITACORA (TABLA, IP, IDMAQ, IDUSUARIO, FECHAB, TIPOOPER)
    VALUES ("Asignaturas", 
    host_id(), 
    host_name(),
    user_name(),  
    getdate(), 
    "Delete")
end
go


create TRIGGER triger_insert_asig on ASIGNATURAS for insert as
begin
    INSERT INTO BITACORA (TABLA, IP, IDMAQ, IDUSUARIO, FECHAB, TIPOOPER)
    VALUES ("Asignaturas", 
    host_id(), 
    host_name(),
    user_name(),  
    getdate(), 
    "Insert")
end
go


create TRIGGER triger_update_asig on ASIGNATURAS for update as
begin
    INSERT INTO BITACORA (TABLA, IP, IDMAQ, IDUSUARIO, FECHAB, TIPOOPER)
    VALUES ("Asignaturas", 
    host_id(), 
    host_name(),
    user_name(),  
    getdate(), 
    "Update")
end
go


create TRIGGER triger_delete_ctrl on BITACORA for delete as
begin
    INSERT INTO CONTROLB (IPC, IDMAQC, IDUSUARIOC, TIPOOPERC, FECHACB)
    VALUES ( 
    host_id(), 
    host_name(),
    user_name(),  
    "Delete",    
    getdate())
end
go


create TRIGGER triger_insert_ctrl on BITACORA for insert as
begin
    INSERT INTO CONTROLB (IPC, IDMAQC, IDUSUARIOC, TIPOOPERC, FECHACB)
    VALUES ( 
    host_id(), 
    host_name(),
    user_name(),  
    "Insert",    
    getdate())
end
go


create TRIGGER triger_update_ctrl on BITACORA for update as
begin
    INSERT INTO CONTROLB (IPC, IDMAQC, IDUSUARIOC, TIPOOPERC, FECHACB)
    VALUES ( 
    host_id(), 
    host_name(),
    user_name(),  
    "Update",    
    getdate())
end
go


create TRIGGER triger_delete_dirc on DIRECTORIO for delete as
begin
    INSERT INTO BITACORA (TABLA, IP, IDMAQ, IDUSUARIO, FECHAB, TIPOOPER)
    VALUES ("Directorio", 
    host_id(), 
    host_name(),
    user_name(),  
    getdate(), 
    "Delete")
end
go


create TRIGGER triger_insert_dirc on DIRECTORIO for insert as
begin
    INSERT INTO BITACORA (TABLA, IP, IDMAQ, IDUSUARIO, FECHAB, TIPOOPER)
    VALUES ("Directorio", 
    host_id(), 
    host_name(),
    user_name(),  
    getdate(), 
    "Insert")
    end
go


create TRIGGER triger_update_dirc on DIRECTORIO for update as
begin
    INSERT INTO BITACORA (TABLA, IP, IDMAQ, IDUSUARIO, FECHAB, TIPOOPER)
    VALUES ("Directorio", 
    host_id(), 
    host_name(),
    user_name(),  
    getdate(), 
    "Update")
    end
go


create TRIGGER triger_delete_estu on ESTUDIANTES for delete as
begin
    INSERT INTO BITACORA (TABLA, IP, IDMAQ, IDUSUARIO, FECHAB, TIPOOPER)
    VALUES ("Estudiantes", 
    host_id(), 
    host_name(),
    user_name(),  
    getdate(), 
    "Delete")
end
go


create TRIGGER triger_insert_estu on ESTUDIANTES for insert as
begin
    INSERT INTO BITACORA (TABLA, IP, IDMAQ, IDUSUARIO, FECHAB, TIPOOPER)
    VALUES ("Estudiantes", 
    host_id(), 
    host_name(),
    user_name(),  
    getdate(), 
    "Insert")
end
go


create TRIGGER triger_update_estu on ESTUDIANTES for update as
begin
    INSERT INTO BITACORA (TABLA, IP, IDMAQ, IDUSUARIO, FECHAB, TIPOOPER)
    VALUES ("Estudiantes", 
    host_id(), 
    host_name(),
    user_name(),  
    getdate(), 
    "Update")
end
go


create TRIGGER triger_delete_insc on INSCRIPCION for delete as
begin
    INSERT INTO BITACORA (TABLA, IP, IDMAQ, IDUSUARIO, FECHAB, TIPOOPER)
    VALUES ("inscripcion", 
    host_id(), 
    host_name(),
    user_name(),  
    getdate(), 
    "Delete")
end
go


create TRIGGER triger_insert_insc on INSCRIPCION for insert as
begin
    INSERT INTO BITACORA (TABLA, IP, IDMAQ, IDUSUARIO, FECHAB, TIPOOPER)
    VALUES ("inscripcion", 
    host_id(), 
    host_name(),
    user_name(),  
    getdate(), 
    "Insert")
end
go


create TRIGGER triger_update_insc on INSCRIPCION for update as
begin
    INSERT INTO BITACORA (TABLA, IP, IDMAQ, IDUSUARIO, FECHAB, TIPOOPER)
    VALUES ("inscripcion", 
    host_id(), 
    host_name(),
    user_name(),  
    getdate(), 
    "Update")
end
go


create TRIGGER triger_delete_profe on PROFESORES for delete as
begin
    INSERT INTO BITACORA (TABLA, IP, IDMAQ, IDUSUARIO, FECHAB, TIPOOPER)
    VALUES ("Profesores", 
    host_id(), 
    host_name(),
    user_name(),  
    getdate(), 
    "Delete")
    end
go


create TRIGGER triger_insert_profe on PROFESORES for insert as
begin
    INSERT INTO BITACORA (TABLA, IP, IDMAQ, IDUSUARIO, FECHAB, TIPOOPER)
    VALUES ("Profesores", 
    host_id(), 
    host_name(),
    user_name(),  
    getdate(), 
    "Insert")
    end
go


create TRIGGER triger_update_profe on PROFESORES for update as
begin
    INSERT INTO BITACORA (TABLA, IP, IDMAQ, IDUSUARIO, FECHAB, TIPOOPER)
    VALUES ("Profesores", 
    host_id(), 
    host_name(),
    user_name(),  
    getdate(), 
    "Update")
    end

/*==============================================================*/
/* REGLAS - SYBASE                                         */
/*==============================================================*/

CREATE RULE regla1 AS @IDESTU <= 11 AND @IDESTU LIKE '[0-9]%';
sp_bindrule regla1, "ESTUDIANTES.IDEST";
go

CREATE RULE regla2 AS @IDPROFE <= 11 AND @IDPROFE LIKE '[0-9]%';
sp_bindrule regla2, "PROFESORES.IDPROFE";
go

CREATE RULE regla3 AS @NUMTELEFONO LIKE '[5][7][1245678]%';
sp_bindrule regla3, "DIRECTORIO.NUMTELEFONO";
go

CREATE RULE regla4 AS @NUMCELULAR LIKE '[3][01][01256]%';
sp_bindrule regla4, "DIRECTORIO.NUMCELULAR";
go

CREATE RULE regla9 AS @GENEROESTU IN ('M', 'm', 'F', 'f');
sp_bindrule regla9, "ESTUDIANTES.GENEROESTU";
go

CREATE RULE regla10 AS @GENEROPROFE IN ('M', 'm', 'F', 'f');
sp_bindrule regla10, "PROFESORES.GENEROPROFE";
go

CREATE RULE regla11 AS @ESTADOCIVILESTU IN ('Soltero', 'Casado', 'Viudo', 'Divorciado');
sp_bindrule regla11, "ESTUDIANTES.ESTADOCIVILESTU";
go

CREATE RULE regla12 AS @ESTADOCIVILPROFE IN ('Soltero', 'Casado', 'Viudo', 'Divorciado');
sp_bindrule regla12, "PROFESORES.ESTADOCIVILPROFE";



