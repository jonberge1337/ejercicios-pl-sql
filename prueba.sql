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
        SELECT SUM(NVL(CANTIDAD * PRECIO * (1 - DESCUENTO / 100),0)) INTO TOTAL
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