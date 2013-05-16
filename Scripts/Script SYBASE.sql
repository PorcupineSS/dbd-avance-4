/*==============================================================*/
/* DBMS name:      Sybase AS Enterprise 15.0                    */
/* Created on:     15/05/2013 09:07:43 p.m.                     */
/*==============================================================*/


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
   FECHANACIMIENTOESTU  date                           not null,
   FECHAINGRESOUESTU    date                           not null,
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
   FECHANACIMIENTOPROFE date                           not null,
   FECHAGRADOPROFE      date                           not null,
   FECHAINGRESOUPROFE   date                           not null,
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

