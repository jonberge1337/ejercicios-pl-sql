-- 1.    Crear un procedimiento de nombre PROM_PRECIO que por cada proveedor muestre el promedio del precio al que nos vende sus artÍculos

--  Proveedor:  FAGOR

-- Promedio Venta:  360€

--             Proveedor:  EROSKI

--                         Promedio Venta:  52€

-- 
CREATE OR REPLACE PROCEDURE PROM_PRECIO
IS
	CURSOR CONSULTA IS
		   SELECT PROVEEDOR, EMPRESA
		   FROM PROVEEDORES;
	CANTIDAD NUMBER(12);
BEGIN
	FOR I IN CONSULTA LOOP
		SELECT NVL(AVG(PR_VENT), 0) INTO CANTIDAD
		FROM ARTICULOS
		WHERE PROVEEDOR = I.PROVEEDOR;

		DBMS_OUTPUT.PUT_LINE('EL PROVEEDOR '||I.PROVEEDOR);
		DBMS_OUTPUT.PUT_LINE('PROMEDIO VENTA '||CANTIDAD||' €');

	END LOOP;
END PROM_PRECIO;
/

--          While
CREATE OR REPLACE PROCEDURE PROM_PRECIO
IS
	CURSOR CONSULTA IS
		SELECT PROVEEDOR, EMPRESA
		FROM PROVEEDORES;
	CANTIDAD NUMBER(12);
FILA CONSULTA%ROWTYPE;
BEGIN
	OPEN CONSULTA;
	FETCH CONSULTA INTO FILA;
	WHILE SQL%FOUND LOOP
		SELECT NVL(AVG(PR_VENT), 0) INTO CANTIDAD
		FROM ARTICULOS
		WHERE PROVEEDOR = FILA.PROVEEDOR;

		DBMS_OUTPUT.PUT_LINE('EL PROVEEDOR '||FILA.PROVEEDOR);
		DBMS_OUTPUT.PUT_LINE('PROMEDIO VENTA '||CANTIDAD||' €');

		FETCH CONSULTA INTO FILA;
	END LOOP;
	CLOSE CONSULTA;
END PROM_PRECIO;
/
--         Loop
CREATE OR REPLACE PROCEDURE PROM_PRECIO
IS
	CURSOR CONSULTA IS
		SELECT PROVEEDOR, EMPRESA
		FROM PROVEEDORES;
	CANTIDAD NUMBER(12);
FILA CONSULTA%ROWTYPE;
BEGIN
	OPEN CONSULTA;
	FETCH CONSULTA INTO FILA;
	LOOP
		EXIT WHEN SQL%NOTFOUND;
		SELECT AVG(PR_VENT) INTO CANTIDAD
		FROM ARTICULOS
		WHERE PROVEEDOR = FILA.PROVEEDOR;

		DBMS_OUTPUT.PUT_LINE('EL PROVEEDOR '||FILA.PROVEEDOR);
		DBMS_OUTPUT.PUT_LINE('PROMEDIO VENTA '||CANTIDAD||' €');

		FETCH CONSULTA INTO FILA;
	END LOOP;
	CLOSE CONSULTA;
END PROM_PRECIO;
/

BEGIN
	PROM_PRECIO;
END;
/

-- 2.    Crear un procedimiento de nombre PROVCLI que devuelva las provincias (por pantalla) con más de un número de  clientes dado como parámetro.

-- Lista de las provincias con más de X clientes (Por ejemplo: 4)

-- Provincia: BARCELONA

-- Nº de Clientes: 43

--           Provincia: GIPUZKOA

-- Nº de Clientes: 5

--             …

-- a.    For …loop
CREATE OR REPLACE PROCEDURE PROVCLI(NUM IN NUMBER)
IS
	CURSOR CONSULTA IS
		SELECT PROVINCIA, DESCRIPCION
		FROM PROVINCIAS;
CANTIDAD NUMBER(5);
BEGIN
	FOR FILA IN CONSULTA LOOP
		SELECT COUNT(*) INTO CANTIDAD
		FROM CLIENTES
		WHERE PROVINCIA = FILA.PROVINCIA;

		IF CANTIDAD >= FILA.PROVINCIA THEN
		    DBMS_OUTPUT.PUT_LINE('PROVINCIA: '|| FILA.DESCRIPCION);
			DBMS_OUTPUT.PUT_LINE('Nº DE CLIENTES: '|| CANTIDAD);
		END IF;
	END LOOP;
END PROVCLI;
/

-- b.    While
CREATE OR REPLACE PROCEDURE PROVCLI(NUM IN NUMBER)
IS
	CURSOR CONSULTA IS
		SELECT PROVINCIA, DESCRIPCION
		FROM PROVINCIAS;
CANTIDAD NUMBER(5);
FILA CONSULTA%ROWTYPE;
BEGIN
	OPEN CONSULTA;
	FETCH CONSULTA INTO FILA;
	WHILE SQL%FOUND THEN
		SELECT COUNT(*) INTO CANTIDAD
		FROM CLIENTES
		WHERE PROVINCIA = FILA.PROVINCIA;

		IF CANTIDAD >= FILA.PROVINCIA THEN
		    DBMS_OUTPUT.PUT_LINE('PROVINCIA: '|| FILA.DESCRIPCION);
			DBMS_OUTPUT.PUT_LINE('Nº DE CLIENTES: '|| CANTIDAD);
		END IF;
		FETCH CONSULTA INTO FILA;
	END LOOP;
	CLOSE CONSULTA;
END PROVCLI;
/

BEGIN
	PROVCLI(5);	
END;
/

-- 3.    Crear una tabla MASCLI con la provincia y el número de clientes. Modificar el ejercicio anterior y crear un procedimiento PROVCL2, que además de sacar por pantalla la información anterior, inserte en la tabla MASCLI cada provincia y su número de clientes que cumplen la condición (parámetro de entrada).

CREATE TABLE MASCLI(
	PROVINCIA NUMBER(5),
	CLIENTES NUMBER(5),
);

CREATE OR REPLACE PROCEDURE PROVCL2(NUMCLI IN NUMBER)
IS
	CURSOR CONSULTA IS
		SELECT DISTINCT PROVINCIA, DESCRIPCION
		FROM PROVINCIAS, CLIENTES
		WHERE PROVINCIAS.PROVINCIA = CLIENTES.PROVINCIA;
	CANTIDAD NUMBER(5);
BEGIN
	FOR FILA IN CONSULTA LOOP
		SELECT COUNT(*) INTO CANTIDAD
		FROM CLIENTES
		WHERE PROVINCIA = FILA.PROVINCIA;

		IF CANTIDAD >= NUMCLI THEN
		    DBMS_OUTPUT.PUT_CLI('PROVINCIA: '|| FILA.DESCRIPCION);
			DBMS_OUTPUT.PUT_CLI('Nº DE CLIENTES: '|| CANTIDAD);
			
			INSERT INTO MASCLI
			VALUES(FILA.DESCRIPCION, CANTIDAD);
		END IF;
	END LOOP;
END PROVCL2;

-- 4.     

-- a.     Crear una tabla de nombre AUDITAR_CLIENTES, que contenga cuatro campos (Codigo, empresa, total_facturado, fecha_ultimo_albaran), con sus tipos de datos adecuados y la clave primaria que precise.
CREATE TABLE AUDITAR_CLIENTES(
	CODIGO NUMBER(10);
	EMPRESA VARCHAR2(30);
	TOTAL_FACTURADO NUMBER(12, 2);
	FECHA_ULTIMO_ALBARAN DATE;
	PRIMARY KEY(CODIGO);
)
   

-- b.    Dada de alta la tabla de auditación. Crear un procedimiento almacenado de nombre AUDITAR_CLIENTES_PROC, tal que para cada uno de los clientes existentes en nuestra base de datos (tabla CLIENTES) realice lo siguiente:
CREATE OR REPLACE PROCEDURE AUDITAR_CLIENTES_PROC
 

 

-- ü Lo dé de alta en nuestra tabla AUDITAR_CLIENTES si no aparece en dicha tabla. Adjuntar todos los datos requeridos.

 

 

-- ü Si el cliente ya está dado de alta. Comprobar si su total facturado coincide con el almacenado. Si es así no hacer nada. En otro caso actualizarlo con el valor correspondiente, así como con la fecha de su último albarán en el campo correspondiente.

 

 

-- ü Dar de baja de la tabla AUDITAR_CLIENTES aquellos clientes que ya no aparezcan en la tabla CLIENTES. ( Cuando los campos código y empresa no coincidan)

 

 

-- ü Este procedimiento debe devolver el número de clientes dados de alta, actualizados y borrados, en sendos parámetros de salida creados para tal efecto.

  

-- q Cursor FOR..LOOP 



 

-- 5.     

-- a.     Crear la tabla AUDITAR_PROVINCIAS, que guarde el código de provincia, número de clientes, número de proveedores, número de albaranes y total facturado por provincia. 

  

-- b.    Crear un procedimiento almacenado de nombre AUDITAR_PROVINCIAS_PROC, que para cada una de la provincias existentes en la base de datos ( Tabla PROVINCIAS ) realice lo siguiente:

  

-- Ø Darla de alta sino existe en la tabla AUDITAR_PROVINCIAS.

 

-- Ø Actualizar los demás campos con el valor correspondiente.

 

-- Ø Crear una función para cada cálculo:

-- o Función NUMERO_CLIENTES.

-- o Función NUMERO_PROVEEDORES.

-- o Función NÚMERO_ALBARANES.

-- o Función TOTAL_FACT_PROVINCIA.

 

--             q WHILE

