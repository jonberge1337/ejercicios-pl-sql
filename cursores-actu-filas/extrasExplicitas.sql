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

