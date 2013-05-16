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
go
