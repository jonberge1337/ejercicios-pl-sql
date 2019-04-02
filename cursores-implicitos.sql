/* 1. Crear un bloque PL/SQL anónimo que muestre por pantalla los 10 primeros múltiplos de un número dado e indique si es par o impar, de la forma: */



/*                         EL MULTIPLO NUMERO 2 DE 75 ES 150 Y ES PAR */

/* EL MULTIPLO NUMERO 3 DE 75 ES 225 Y ES IMPAR */

/*  . . . . */

/* Hacerlo con las diferentes cláusulas iterativas existentes: */

/* v WHILE */
declare
    cont number(4) := 1;
    numero number(2) :=75;
begin
    while cont < 11 loop
        if mod(cont, 2)=0 then
        DBMS_OUTPUT.PUT_LINE('EL MULTIPLO NUMERO '||TO_CHAR(cont)||' DE '||numero||' ES '||TO_CHAR(numero * cont)||' Y ES PAR');
        else
        DBMS_OUTPUT.PUT_LINE('EL MULTIPLO NUMERO '||TO_CHAR(cont)||' DE '||numero||' ES '||TO_CHAR(numero * cont)||' Y ES IMPAR');
        end if;
        cont := cont + 1;
    end loop;
end;
/

/* v LOOP */
declare
    cont number(4) := 1;
    numero number(2) := 75;
begin
    loop
        if mod(cont, 2)=0 then
        DBMS_OUTPUT.PUT_LINE('EL MULTIPLO NUMERO '||TO_CHAR(cont)||' DE '||numero||' ES '||TO_CHAR(numero * cont)||' Y ES PAR');
        else
        DBMS_OUTPUT.PUT_LINE('EL MULTIPLO NUMERO '||TO_CHAR(cont)||' DE '||numero||' ES '||TO_CHAR(numero * cont)||' Y ES IMPAR');
        end if;
        cont := cont + 1;
    exit when cont > 10;
    /* DBMS_OUTPUT.PUT_LINE('PROGRAMA FINALIZADO'); -- preguntar porque esto se ejecuta */
    end loop;
    DBMS_OUTPUT.PUT_LINE('PROGRAMA FINALIZADO');
end;
/

declare
    cont number(4) := 1;
    numero number(2) := 75;
    par varchar2(5);
begin
    loop
        if mod(cont, 2)=0 then
            par := 'PAR'
        else
            par := 'IMPAR'
        end if;
        DBMS_OUTPUT.PUT_LINE('EL MULTIPLO NUMERO ' || TO_CHAR(cont) || ' DE ' || numero || ' ES ' || TO_CHAR(numero * cont) || ' Y ES ' || par);
        cont := cont + 1;
    exit when cont > 10;
    end loop;
    DBMS_OUTPUT.PUT_LINE('PROGRAMA FINALIZADO');
end;
/

/* v FOR */
declare
    numero number(2) :=75;
begin
    for i in 1..10 loop
        if mod(i, 2)=0 then
            DBMS_OUTPUT.PUT_LINE('EL MULTIPLO NUMERO '||TO_CHAR(i)||' DE '||numero||' ES '||TO_CHAR(numero * i)||' Y ES PAR');
        else
            DBMS_OUTPUT.PUT_LINE('EL MULTIPLO NUMERO '||TO_CHAR(i)||' DE '||numero||' ES '||TO_CHAR(numero * i)||' Y ES IMPAR');
        end if;
    end loop;
end;
/

/* 2. Construir un bloque PL/SQL que escriba en pantalla la cadena ‘ORACLE’ al revés. */

/* Utilizando bucles: */

/* v WHILE */
declare
    palabra varchar2(10) := 'oracle';
    invertida varchar2(10);
    contador number(2) := length('oracle');
begin
    while contador > 0 loop
        invertida := invertida || substr(palabra, contador, 1);
        contador := contador - 1;
    end loop;
    DBMS_OUTPUT.PUT_LINE('oracle al reves es ' || invertida);
end;
/

/* v FOR */
declare
    palabra varchar2(10) := 'oracle';
    invertida varchar2(10);
begin
    for i in reverse 1..length(palabra) loop
        invertida := invertida || substr(palabra, i, 1);
    end loop;
    DBMS_OUTPUT.PUT_LINE(invertida);
end;
/

/* 3. Utilizando variables de sustitución: (solo para bloques anónimos) */

/* a) Crear un bloque PL/SQL que muestre el precio de venta de un articulo determinado. */
declare
    artic articulos.articulo%type := &articulo;
    provee articulos.proveedor%type := &proveedor;
    precio articulos.pr_vent%type;
begin
    select pr_vent into precio
    from articulos
    where articulo = artic and proveedor = provee;
    dbms_output.put_line('El precio de venta de dicho articulo es ' || precio);
exception 
    when no_data_found then
        dbms_output.put_line('No hay ningun articulo');
end;
/
/* b) Otro que devuelva el precio de venta y el de compra de un artículo. */
declare
    artic articulos.articulo%type := &articulo;
    provee articulos.proveedor%type := &proveedor;
    precio articulos.pr_vent%type;
    comp articulos.pr_cost%type;
begin
    select pr_vent, pr_cost into precio, comp
    from articulos
    where articulo = artic and proveedor = provee;
    dbms_output.put_line('El precio de venta de dicho articulo es ' || precio ||' y el precio de compra es ' || comp);
exception 
    when no_data_found then
        dbms_output.put_line('No hay ningun articulo');
end;
/
/* c) Conéctate con tu usuario y crea un bloque PL/SQL que permita dar de alta una provincia con
 todos sus datos en la tabla provincias. */
declare
    provi provincias.provincia%type := &provincia;
    descr provincias.descripcion%type := '&descripcion';
    prefi provincias.prefijo%type := &prefijo;
begin
    insert into provincias
    values(provi, descr, prefi);

    exception 
        when DUP_VAL_ON_INDEX then
            dbms_output.put_line('ya los tienes insertados');
end;
/
    provi provincias.provincia%type := &provincia;
    descr provincias.descripcion%type := '&descripcion';
    prefi provincias.prefijo%type := &prefijo;
begin
    insert into provincias
    values(provi, descr, prefi);

    exception 
        when DUP_VAL_ON_INDEX then
            dbms_output.put_line('ya los tienes insertados');
end;
/
/* 4. Escribe un bloque PL/SQL que cuente el número de líneas de las tablas de clientes y proveedores. */

/* Y según lo devuelto muestre por pantalla: */

/* TENGO X PROVEEDORES MÄS QUE CLIENTES */

/* TENGO X CLIENTES MÄS QUE PROVEEDORES */

/* TENGO IGUAL NÜMERO DE CLIENTES Y PROVEEDORES */
declare
    cli number(5);
    pro number(5);
begin
    select count(*) into cli
    from clientes;

    select count(*) into pro
    from proveedores;
    
    if cli > pro then
        dbms_output.put_line('tengo ' || to_char(cli - pro) || ' proveedores mas que clientes');
    elsif cli < pro then
        dbms_output.put_line('tengo ' || to_char(pro -cli) || ' clientes mas que proveedores');
    else
        dbms_output.put_line('tengo igual numero de clientes y proveedores');
    end if;
end;
/

/* 5. Crear un procedimiento almacenado de nombre VER_CLIENTE para consultar los datos relevantes de 
un cliente (empresa, dirección, población). */
create or replace procedure ver_cliente(cli in clientes.cliente%type, emp out clientes.empresa%type, dir out clientes.direccion1%type, pob out clientes.poblacion%type)
is

begin
    select empresa, direccion1, poblacion into emp, dir, pob
    from clientes
    where cliente = cli;
exception
    when no_data_found then
        emp := 'no existe';

end;
/
/* Una vez creado y almacenado: */

/* a) Realizar una llamada al procedimiento directamente desde SQL*Plus. */

/* b) Realizar la llamada desde un bloque PL/SQL anónimo. */
declare
    x clientes.empresa%type;
    y clientes.direccion1%type;
    z clientes.poblacion%type;
    cli number(3) := &client;
begin
    ver_cliente(cli, x, y, z);
    dbms_output.put_line('Los datos del cliente '||to_char(cli)||' son EMPRESA: '||x||' DIRECCION: '||Y||' POBLACION: '||z);
end;
/
/* c) Insertar la excepción NO_DATA_FOUND para poder tratar el caso en que no
exista tal código de cliente. */


/* 6. Crear desde vuestro usuario una tabla de nombre Mis_clientes a imagen de la tabla Clientes
del usuario almacén. */
CREATE TABLE MIS_CLIENTES
AS SELECT *
FROM CLIENTES
/

/* 7. Crear un procedimiento almacenado de nombre ACTU_TOTAL que dado un código de cliente
actualice el campo Total_factura de la tabla Mis_clientes con el importe de las compras que ha realizado. */

/* a) Comprobando primero que el cliente existe, sino ésta en la tabla Mis_clientes saque
un mensaje.(EXCEPTION NO_DATA_FOUND) */

/* EL CLIENTE X NO EXISTE */

/* b) En el caso en que exista, pero no tiene compras, sacar un mensaje. */

/* EL CLIENTE X NO TIENE COMPRAS */

/* c) En otro caso, actualizarlo y sacar un mensaje diciendo: */

/* EL CLIENTE X HA SIDO ACTUALIZADO CON XXXXX EUROS */
CREATE OR REPLACE PROCEDURE ACTU_TOTAL(COD IN NUMBER)
IS
    TOTAL MIS_CLIENTES.TOTAL_FACTURA%TYPE;
    EXISTE MIS_CLIENTES.CLIENTE%TYPE;
    COMPRAS NUMBER(11,2);
BEGIN
    SELECT COUNT(*) INTO EXISTE
    FROM MIS_CLIENTES
    WHERE CLIENTE = COD;

    SELECT COUNT(*) INTO COMPRAS
    FROM ALBARANES
    WHERE CLIENTE = COD;

    IF EXISTE = 0 THEN
        DBMS_OUTPUT.PUT_LINE('EL CLIENTE ' || TO_CHAR(COD) || 'NO EXISTE');
    ELSIF COMPRAS = 0 THEN
        DBMS_OUTPUT.PUT_LINE('EL CLIENTE ' || TO_CHAR(COD) || 'NO TIENE COMPRAS');
    ELSE
        SELECT SUM(NVL(CANTIDAD * PRECIO * (1 - DESCUENTO / 100))) INTO TOTAL
        FROM LINEAS, ALBARANES
        WHERE ALBARANES.ALBARAN = LINEAS.ALBARAN
        AND CLIENTE = COD;

        UPDATE MIS_CLIENTES
        SET TOTAL_FACTURA = TOTAL
        WHERE CLIENTE = COD;

        DBMS_OUTPUT.PUT_LINE('EL CLIENTE' || TO_CHAR(COD) || 'HA SIDO ACTUALIZADO');
    END IF;

END ACTU_TOTAL;
/

CREATE OR REPLACE PROCEDURE NUEVA_PROV(CLI IN NUMBER)
IS
    X MIS_CLIENTES.CLIENTES%TYPE;
    COMPRAS MIS_CLIENTES.TOTAL_FACTURA%TYPE := NULL;
BEGIN
    SELECT CLIENTE INTO X
    FROM CLIENTES
    WHERE CLIENTE = CLI;

    SELECT SUM(NVL(CANTIDAD * PRECIO * (1 - DESCUENTO / 100))) INTO TOTAL
    FROM LINEAS, ALBARANES
    WHERE LINEAS.ALBARAN = ALBARANES.ALBARAN
    AND ALBARANES = CLI;

    IF COMPRAS IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('EL CLIENTE '|| CLI || ' NO TIENE COMPRAS');
    ELSE
        UPDATE MIS_CLIENTES
        SET TOTAL_FACTURA = COMPRAS
        WHERE CLIENTE = CLI;
        DBMS_OUTPUT.PUT_LINE('EL CLIENTE '|| CLI ||' HA SIDO ACTUALIZADO CON '|| COMPRAS ||' EUROS');
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('EL CLIENTE ' || CLI || ' NO EXISTE');
END;


/* 8. Crear un procedimiento almacenado de nombre NUEVA_PROV que dados un código,
descripción y prefijo, inserte con ellos una provincia nueva. */

/* (Tratar la excepción DUP_VAL_ON_INDEX) */
CREATE OR REPLACE PROCEDURE NUEVA_PROV(PROVINCIA IN NUMBER, DESCRIPCION IN VARCHAR2, PREFIJO IN NUMBER)
IS 
BEGIN
    INSERT INTO PROVINCIAS
    VALUES (PROVINCIA, DESCRIPCION, PREFIJO);

    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('ESA PROVINCIA YA EXISTE METE ALGO VALIDO');
END NUEVA_PROV;
/

CREATE OR REPLACE PROCEDURE NUEVA_PROV
IS
    PROV PROVINICAS.PROVINCIA%TYPE;
    DESCR PROVINICAS.DESCRIPCION%TYPE;
    PREF PROVINCIAS.PREFIJO%TYPE;
    EXISTE BOOLEAN := TRUE;
BEGIN
    LOOP
        PROV := &PROVINCIA
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                DBMS_OUTPUT.PUT_LINE('ESA PROVINCIA YA EXISTE METE ALGO VALIDO');
                EXISTE := FALSE;
        EXIT WHEN EXISTE = FALSE;
    END LOOP;

    DESCR := '&DESCRIPCION'
    PREFIJO := &PREFIJO

    INSERT INTO PROVINCIAS
    VALUES(PROV, DESCR, PREFIJO)

END NUEVA_PROV;
/

CREATE OR REPLACE PROCEDURE NUEVA_PROV(COD PROVINCIAS.PROVINCIA%TYPE,
                                        DES PROVINCIAS.DESCRIPCION%TYPE,
                                        PRE PROVINCIAS.PREFIJO%TYPE,
                                        RES OUT BOOLEAN)
IS
BEGIN
    INSERT INTO PROVINCIAS(PROVINCIA, DESCRIPCION, PREFIJO) VALUES (COD, DES, PRE);
    RES := TRUE;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        RES := FALSE;
END;
/

DECLARE
    PROV PROVINCIAS.PROVINCIA%TYPE := &P;
    DES PROVINCIAS.DESCRIPCION%TYPE := '&D';
    PRE PROVINCIAS.PREFIJO%TYPE := &PR;
    RESULTADO BOOLEAN := NULL;
BEGIN
    NUEVA_PROV(PROV, DES, PRE, RESULTADO)
    IF RESULTADO THEN
        DBMS_OUTPUT.PUT_LINE('LA PROVINCIA '|| PROV || ' HA SIDO INSERTADA CON EXITO');
    ELSE
        DBMS_OUTPUT.PUT_LINE('LA PROVINCIA' || PROV || ' NO HA SIDO INSERTADA');
    END IF;
END;
/

/* 9. Desarrollar una función de nombre DIF_FECHAS que devuelva el número de años completos que hay
entre dos fechas que se pasan como parámetro. */ 
CREATE OR REPLACE FUNCTION DIF_FECHAS(FECHA1 IN DATE, FECHA2 IN DATE)
RETURN NUMBER
IS
    DIF NUMBER(5);
BEGIN
    DIF := ABS(TO_NUMBER(TO_CHAR(FECHA1, 'YYYY')) - TO_NUMBER(TO_CHAR(FECHA2, 'YYYY')));
    RETURN DIF;
END DIF_FECHAS;
/

-- ERROR AL PROBAR
DECLARE
    DIF NUMBER(11);
BEGIN
    DIF := DIF_FECHAS(TO_DATE('01/01/1999', 'DD/MM/YYYY'), TO_DATE('01/01/2007', 'DD/MM/YYYY'))
    DBMS_OUTPUT.PUT_LINE(DIF);
END;
/

CREATE OR REPLACE FUNCTION DIF_FECHAS(FECH1 DATE, FECH2 DATE)
RETURN NUMBER
IS
    DIF NUMBER := NULL;
    F1 NUMBER := NULL;
    F2 NUMBER := NULL;
BEGIN
    F1 := TO_NUMBER(TO_CHAR(FECH1, 'YYYY'));
    F2 := TO_NUMBER(TO_CHAR(FECH2, 'YYYY'));
    DIF := ABS(F1-F2);
    RETURN DIF;
END DIF_FECHAS;
/

DECLARE
    F1 DATE := TO_DATE('1/1/2005', 'DD/MM/YYYY');
    F2 DATE := TO_DATE('1/1/2035', 'DD/MM/YYYY');
    RESUL NUMBER := NULL;
BEGIN
    RESUL := DIF_FECHAS(F1. F2);
    DBMS_OUTPUT.PUT_LINE('LA DIFERENCIA DE AÑOS ENTRE LAS DOS FECHAS ES: '||RESUL);
END;
/


/*  10. Implementar un procedimiento de nombre CAMBIO_DIVISA que reciba un importe y visualice el desglose del cambio en unidades monetarias de 1,2,5,10,20,50 ctms de € y 1, 2, 5,10,20,50,100 € en orden inverso al que aquí aparecen enumeradas. */



/* 11. Crear un procedimiento de nombre BORRAR_CLIENTE que permita borrar de la tabla Mis_clientes un cliente, cuyo número se pasará en la llamada. */

/* (Tratar excepción NO_DATA_FOUND) */
CREATE OR REPLACE PROCEDURE BORRAR_CLIENTE(COD IN NUMBER)
IS
BEGIN
    DELETE FROM CLIENTES
    WHERE CLIENTE = COD;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('EL CLIENTE '||COD||' NO SE ENCUENTRA EN LA BASE DE DATOS');
END BORRAR_CLIENTE;
/

CREATE OR REPLACE PROCEDURE BORRAR_CLIENTE(CLI CLIENTES.CLIENTE%TYPE)
IS
BEGIN
    DELETE FROM CLIENTES
    WHERE CLIENTE = CLI;
    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('CLIENTE ' || CLI || ' BORRADO CON EXITO');
    ELSE
        DBMS_OUTPUT.PUT_LINE('CLIENTE ' || CLI || ' NO BORRADO');
    END IF;

END BORRAR_CLIENTE;
/

CREATE OR REPLACE PROCEDURE BORRAR_CLIENTE2(CLI CLIENTES.CLIENTE%TYPE)
IS
    CODIGO CLIENTES.CLIENTE%TYPE;
BEGIN
    SELECT CLIENTE INTO CODIGO
    FROM CLIENTES
    WHERE CLIENTE = CLI;

    DELETE FROM CLIENTES
    WHERE CLIENTE = CLI;

    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('CLIENTE ' || CLI || ' BORRADO CON EXITO');
    ELSE
        DBMS_OUTPUT.PUT_LINE('CLIENTE ' || CLI || ' NO BORRADO');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('CLIENTE '|| CLI || ' NO EXISTE');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLCODE||' '||SQLERRM);
END BORRAR_CLIENTE2;

/* 12. Escribir un procedimiento de nombre DOS_PROVI que dados dos códigos de provincia devuelva lo facturado por cada una de ellas y
su diferencia. En el caso en que no hayan facturado o no existan las provincias obtengamos el mensaje correspondiente. */
CREATE OR REPLACE PROCEDURE DOS_PROVI(PRO1 IN NUMBER, PRO2 IN NUMBER, DIF OUT NUMBER, FAC1 OUT NUMBER, FAC2 OUT NUMBER)
IS
BEGIN
    FAC1 := UN_PROVI(PRO1);
    FAC2 := UN_PROVI(PRO2);
    DIF := FAC2 - FAC1;  


/* Realizar la llamada a una función de nombre UN_PROVI que calcule lo facturado para una provincia. */
CREATE OR REPLACE FUNCTION UN_PROVI(PRO IN NUMBER)
RETURN NUMBER
IS 
    TOT MIS_CLIENTES.TOTAL_FACTURA%TYPE;
    EXISTE NUMBER(5);
BEGIN
    SELECT SUM(TOTAL_FACTURA) INTO TOT
    FROM CLIENTES
    WHERE PRO = PROVINCIA;

    SELECT COUNT(*) INTO EXISTE
    FROM CLIENTES
    WHERE PRO = PROVINCIAS;

    IF EXISTE = 0 THEN
        DBMS_OUTPUT.PUT_LINE('NO HAY CLIENTES ASIGNADA A LA PROVINCIA' || TO_CHAR(PRO));
    ELSE
        RETURN TOT;
    END IF;
END UN_PROVI;
/

CREATE OR REPLACE FUNCTION UN_PROVI(PRO IN PROVINCIAS.PROVINCIA%TYPE)
RETURN NUMBER
IS
    TOTAL_FACTURADO NUMBER(12, 2) := NULL;
BEGIN

    SELECT SUM(CANTIDAD * PRECIO) INTO TOTAL_FACTURADO
    FROM LINEAS L, ALBARANES A, CLIENTES C
    WHERE L.ALBARAN = A.ALBARAN
    AND A.CLIENTE = C.CLIENTE
    AND C.PROVINCIA = PROVI;

RETURN NVL(TOTAL_FACTURADO, -1);

END UN_PROVI;
/

CREATE OR REPLACE FUNCTION EXISTE(COD IN PROVINCIAS.PROVINCIA%TYPE)
RETURN BOOLEAN
IS
    CODIGO NUMBER(3) := NULL;
BEGIN
    SELECT PROVINCIA INTO CODIGO
    FROM PROVINCIAS
    WHERE PROVINCIA = COD;
    RETURN TRUE;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN FALSE;
END EXISTE;
/

CREATE OR REPLACE PROCEDURE DOS_PROVI(PROV1 PROVINCIAS.PROVINCIA%TYPE,
                                        PROV2 PROVINCIAS.PROVINCIA%TYPE,
                                        TOTALPROV1 OUT NUMBER,
                                        TOTALPROV2 OUT NUMBER,
                                        DIF OUT NUMBER)
IS
BEGIN
    IF !EXISTE(PROV1) THEN
        DBMS_OUTPUT.PUT_LINE('LA PROVINCIA '|| PROV1 ||' NO EXISTE');
    ELSIF !EXISTE(PROV2) THEN
        DBMS_OUTPUT.PUT_LINE('LA PROVINCIA '|| PROV2 ||' NO EXISTE');
    ELSE
        TOTALPROV1 := UN_PROVI(PROV1);
        TOTALPROV2 := UN_PROVI(PROV2);
        IF TOTALPROV1 = -1 OR TOTALPROV2 = -1 THEN
            DBMS_OUTPUT.PUT_LINE('UNA DE LAS PROVINCIAS NO TIENE COMPRAS');
        ELSE
            DIF := ABS(TOTALPROV1 - TOTALPROV2);
            DBMS_OUTPUT.PUT_LINE('TOTAL FACTURADO' || PROV1 || ' ES: '|| TOTALPROV1);
            DBMS_OUTPUT.PUT_LINE('TOTAL FACTURADO' || PROV2 || ' ES: '|| TOTALPROV2);
            DBMS_OUTPUT.PUT_LINE('DIFERENCIA ES:' || DIF);
        END IF;
    END IF;
END DOS_PROVI;



/* 13. Crear una función de nombre CALCULA_FACT que dada una fecha devuelva el total facturado hasta la misma entre los albaranes (según fecha de albarán). */
CREATE OR REPLACE FUNCTION CALCULA_FACT(FECHA IN DATE)
RETURN NUMBER
IS
    TOTAL NUMBER(12, 2) := NULL;
BEGIN
    SELECT SUM(NVL(PRECIO * CANTIDAD * (1 - DESCUENTO / 100)), 0) INTO TOTAL
    FROM LINEAS, ALBARANES
    WHERE FECHA_ALBARAN < FECHA;
    RETURN TOTAL;
END CALCULA_FACT;
/

CREATE OR REPLACE FUNCTION CALCULA_FACT(FECHA DATE)
RETURN NUMBER
IS
TOTAL_FACT NUMBER(12, 2) := NULL;
BEGIN
	SELECT SUM(I.PRECIO * I.CANTIDAD) INTO TOTAL_FACT
	FROM LINEAS L, ALBARANES A
	WHERE L.ALBARAN = A.ALBARAN
	AND FECHA_ALBARAN <= FECHA;

	RETURN TOTAL_FACT
EXCEPTION
	WHEN OTHERS THEN
	DBMS_OUTPUT.PUT_LINE(SQLCODE ||'-'||SQLERRM);
	RETURN -1;
END CALCULA_FACT;
/

/* 14. Crear una función de nombre CUANTAS_EXIS que devuelva el total de existencias existentes en nuestro almacén. */
CREATE OR REPLACE FUNCTION CUANTAS_EXIS
RETURN NUMBER
IS
    TOTAL NUMBER(12, 2) := NULL;
BEGIN
    SELECT SUM(NVL(EXISTENCIAS), 0) INTO TOTAL
    FROM ARTICULOS;
    RETURN TOTAL;
END CUANTAS_EXIS;
/

CREATE OR REPLACE FUNCTION CUANTAS_EXIS
RETURN NUMBER
IS
	TOTAL NUMBER(12) := NULL;
BEGIN
	SELECT SUM(NVL(EXISTENCIAS, 0)) INTO TOTAL
	FROM ARTICULOS;

	RETURN TOTAL;

EXCEPTION
	WHEN OTHERS THEN
		 RETURN -1;

END CUATNTAS_EXIS;
/

/* 15. Modificar la función anterior para que calcule el total de existencias pero para los artículos de un tipo de unidad de medida específico, que se pasará como parámetro. */
CREATE OR REPLACE FUNCTION CUANTAS_EXIS(TIPO IN VARCHAR2)
RETURN NUMBER
IS
    TOTAL NUMBER(12, 2) := NULL;
BEGIN
    SELECT SUM(NVL(EXISTENCIAS), 0) INTO TOTAL
    FROM ARTICULOS, UNIDADES
    WHERE UNIDADES.UNIDAD = ARTICULOS.UNIDAD
    AND UNIDADES.DESCRIPCION = TIPO;
    RETURN TOTAL;
END CUANTAS_EXIS;
/

CREATE OR REPLACE FUNCTION CUANTAS_EXIS (UNI ARTICULOS.UNIDAD%TYPE)
RETURN NUMBER
IS
	TOTAL NUMBER(12) := NULL;
BEGIN
	SELECT SUM(EXISTENCIAS) INTO TOTAL
	FROM ARTICULOS
	WHERE UNIDAD = UNI;
	RETURN TOTAL;

EXCEPTION
	WHEN OTHERS THEN
		 RETURN -1;

END CUANTAS_EXIS;
/
