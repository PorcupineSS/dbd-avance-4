/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     15/05/2013 09:07:31 p.m.                     */
/*==============================================================*/


alter table ASIGNATURAS
   drop constraint FK_ASIGNATU_DICTA_PROFESOR;

alter table DIRECTORIO
   drop constraint FK_DIRECTOR_ESTTIENET_ESTUDIAN;

alter table DIRECTORIO
   drop constraint FK_DIRECTOR_PROFETIEN_PROFESOR;

alter table INSCRIPCION
   drop constraint FK_INSCRIPC_INSCRIPCI_ESTUDIAN;

alter table INSCRIPCION
   drop constraint FK_INSCRIPC_INSCRIPCI_ASIGNATU;

drop index DICTA_FK;

drop table ASIGNATURAS cascade constraints;

drop table BITACORA cascade constraints;

drop table CONTROLB cascade constraints;

drop index ESTTIENETELEFONOS_FK;

drop index PROFETIENETELEFONOS_FK;

drop table DIRECTORIO cascade constraints;

drop table ESTUDIANTES cascade constraints;

drop index INSCRIPCION_FK;

drop index INSCRIPCION2_FK;

drop table INSCRIPCION cascade constraints;

drop table PROFESORES cascade constraints;

/*==============================================================*/
/* Table: ASIGNATURAS                                           */
/*==============================================================*/
create table ASIGNATURAS 
(
   CODASIG              INTEGER              not null,
   IDPROFE              VARCHAR2(11),
   NOMBREASIG           VARCHAR2(40)         not null,
   HORASSEMANALASIGPRES INTEGER              not null,
   NUMCREDITOSASIG      INTEGER              not null,
   TIPOASIG             VARCHAR2(18)         not null,
   OFERTADAACTUAL       SMALLINT             not null,
   constraint PK_ASIGNATURAS primary key (CODASIG),
   constraint AK_IDNOMBREASIG_ASIGNATU unique (NOMBREASIG)
);

/*==============================================================*/
/* Index: DICTA_FK                                              */
/*==============================================================*/
create index DICTA_FK on ASIGNATURAS (
   IDPROFE ASC
);

/*==============================================================*/
/* Table: BITACORA                                              */
/*==============================================================*/
create table BITACORA 
(
   IDR                  INTEGER              not null,
   IP                   VARCHAR2(20),
   IDMAQ                VARCHAR2(20),
   IDUSUARIO            VARCHAR2(20),
   TIPOOPER             VARCHAR2(20),
   TABLA                VARCHAR2(20),
   FECHAB               DATE,
   constraint PK_BITACORA primary key (IDR)
);

/*==============================================================*/
/* Table: CONTROLB                                              */
/*==============================================================*/
create table CONTROLB 
(
   IDCONTROL            INTEGER              not null,
   IPC                  VARCHAR2(20),
   IDMAQC               VARCHAR2(20),
   IDUSUARIOC           VARCHAR2(20),
   TIPOOPERC            VARCHAR2(20),
   FECHACB              DATE,
   constraint PK_CONTROLB primary key (IDCONTROL)
);

/*==============================================================*/
/* Table: DIRECTORIO                                            */
/*==============================================================*/
create table DIRECTORIO 
(
   IDTEL                INTEGER              not null,
   IDPROFE              VARCHAR2(11),
   IDESTU               VARCHAR2(11),
   NUMTELEFONO          VARCHAR2(10)         not null,
   NUMCELULAR           VARCHAR2(10)         not null,
   constraint PK_DIRECTORIO primary key (IDTEL)
);

/*==============================================================*/
/* Index: PROFETIENETELEFONOS_FK                                */
/*==============================================================*/
create index PROFETIENETELEFONOS_FK on DIRECTORIO (
   IDPROFE ASC
);

/*==============================================================*/
/* Index: ESTTIENETELEFONOS_FK                                  */
/*==============================================================*/
create index ESTTIENETELEFONOS_FK on DIRECTORIO (
   IDESTU ASC
);

/*==============================================================*/
/* Table: ESTUDIANTES                                           */
/*==============================================================*/
create table ESTUDIANTES 
(
   IDESTU               VARCHAR2(11)         not null,
   NOMBRECOMPLETOESTU   VARCHAR2(40)         not null,
   DIRECCIONESTU        VARCHAR2(25),
   GENEROESTU           CHAR(1)              not null,
   FECHANACIMIENTOESTU  DATE                 not null,
   FECHAINGRESOUESTU    DATE                 not null,
   CODESTU              INTEGER              not null,
   PROGESTU             VARCHAR2(40)         not null,
   ESTADOCIVILESTU      VARCHAR2(11)         not null,
   constraint PK_ESTUDIANTES primary key (IDESTU),
   constraint AK_IDCODESTU_ESTUDIAN unique (CODESTU)
);

/*==============================================================*/
/* Table: INSCRIPCION                                           */
/*==============================================================*/
create table INSCRIPCION 
(
   CODASIG              INTEGER              not null,
   IDESTU               VARCHAR2(11)         not null,
   NOTADEFINITIVA       INTEGER,
   CONCEPTONOTA         VARCHAR2(30),
   constraint PK_INSCRIPCION primary key (CODASIG, IDESTU)
);

/*==============================================================*/
/* Index: INSCRIPCION2_FK                                       */
/*==============================================================*/
create index INSCRIPCION2_FK on INSCRIPCION (
   CODASIG ASC
);

/*==============================================================*/
/* Index: INSCRIPCION_FK                                        */
/*==============================================================*/
create index INSCRIPCION_FK on INSCRIPCION (
   IDESTU ASC
);

/*==============================================================*/
/* Table: PROFESORES                                            */
/*==============================================================*/
create table PROFESORES 
(
   IDPROFE              VARCHAR2(11)         not null,
   NOMBREPROFE          VARCHAR2(40)         not null,
   SUELDOPROFE          NUMBER(8,2),
   DIRECCIONPROFE       VARCHAR2(20),
   GENEROPROFE          CHAR(1)              not null,
   FECHANACIMIENTOPROFE DATE                 not null,
   FECHAGRADOPROFE      DATE                 not null,
   FECHAINGRESOUPROFE   DATE                 not null,
   ESTADOCIVILPROFE     VARCHAR2(11)         not null,
   constraint PK_PROFESORES primary key (IDPROFE)
);

alter table ASIGNATURAS
   add constraint FK_ASIGNATU_DICTA_PROFESOR foreign key (IDPROFE)
      references PROFESORES (IDPROFE);

alter table DIRECTORIO
   add constraint FK_DIRECTOR_ESTTIENET_ESTUDIAN foreign key (IDESTU)
      references ESTUDIANTES (IDESTU);

alter table DIRECTORIO
   add constraint FK_DIRECTOR_PROFETIEN_PROFESOR foreign key (IDPROFE)
      references PROFESORES (IDPROFE);

alter table INSCRIPCION
   add constraint FK_INSCRIPC_INSCRIPCI_ESTUDIAN foreign key (IDESTU)
      references ESTUDIANTES (IDESTU);

alter table INSCRIPCION
   add constraint FK_INSCRIPC_INSCRIPCI_ASIGNATU foreign key (CODASIG)
      references ASIGNATURAS (CODASIG);
