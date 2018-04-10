select * from PORC_ASESORIAS;

set serveroutput on;


select * from REMUNERACION_MENSUAL;
SELECT * FROM PROFESIONAL;

DECLARE 
  VAR_NRO_PROFESIONALES NUMBER := 0;
  VAR_RUT_PROF PROFESIONAL.RUTPROF%TYPE := 0;
  VAR_MES_REMUNERACION NUMBER := 0;
  VAR_ANO_REMUNERACION NUMBER := 0;
  VAR_SUELDO_BASE PROFESIONAL.SUELDO_BASE%TYPE := 0;
  VAR_BONO_IMAGEN NUMBER := 0;
  VAR_BONO_ASESORIAS NUMBER := 0;
  VAR_NRO_ASESORIAS NUMBER := 0;
  VAR_PORCENTAJE_ASESORIAS NUMBER := 0;
  VAR_BONO_COLACION NUMBER := 0;
  VAR_BONO_MOVILIZACION NUMBER := 0;
BEGIN
  -- CUENTA CUANTOS PROFESIONALES HAY EN LA TABLA
  SELECT COUNT(IDPROFESIONAL) INTO VAR_NRO_PROFESIONALES FROM PROFESIONAL;
  
  --RECORREMOS LOS ID DE PROFEIONALES DESDE EL 1 HASTA EL NUMERO MAXIMO DE PROFESIONALES
  FOR I IN 1 ..VAR_NRO_PROFESIONALES LOOP
  
  
       SELECT RUTPROF INTO VAR_RUT_PROF FROM PROFESIONAL WHERE IDPROFESIONAL = I;   
       DBMS_OUTPUT.PUT(VAR_RUT_PROF||' ');
       
       VAR_MES_REMUNERACION := :Mes;
       DBMS_OUTPUT.PUT(VAR_MES_REMUNERACION||' ');
       
       
       VAR_ANO_REMUNERACION := :Anio;
       DBMS_OUTPUT.PUT(VAR_ANO_REMUNERACION||' ');
       
       
       SELECT SUELDO_BASE INTO VAR_SUELDO_BASE FROM PROFESIONAL WHERE IDPROFESIONAL = I;   
       DBMS_OUTPUT.PUT(VAR_SUELDO_BASE||' ');
       
       
       VAR_BONO_IMAGEN := :Bono_imagen;
       DBMS_OUTPUT.PUT(VAR_BONO_IMAGEN||' ');
       
       
       /*â€¢	El monto de bono asesorÃ­as corresponde a un porcentaje (2%, 3%, 5% y 7%)
       del sueldo base del profesional de acuerdo con la cantidad de
       asesorÃ­as prestadas en el mes de cÃ¡lculo y en base a los tramos existentes en la tabla porc_asesorias:*/
     --  VAR_BONO_ASESORIAS :=

       SELECT COUNT(A.RUTPROF) 
       INTO VAR_NRO_ASESORIAS
       FROM PROFESIONAL P 
       JOIN ASESORIA A ON P.RUTPROF = A.RUTPROF
       GROUP BY A.RUTPROF,P.IDPROFESIONAL
       HAVING P.IDPROFESIONAL = I;
       
       IF VAR_NRO_ASESORIAS > 0  AND VAR_NRO_ASESORIAS <= 10 THEN
        VAR_PORCENTAJE_ASESORIAS := 2;
       ELSIF VAR_NRO_ASESORIAS > 10  AND VAR_NRO_ASESORIAS <= 20 THEN
        VAR_PORCENTAJE_ASESORIAS := 3;
       ELSE
        VAR_PORCENTAJE_ASESORIAS := 0;
       END IF;
       VAR_BONO_ASESORIAS := ((VAR_PORCENTAJE_ASESORIAS/100)* VAR_SUELDO_BASE);
       DBMS_OUTPUT.PUT(VAR_BONO_ASESORIAS||' ');
      
      
       VAR_BONO_COLACION := :Bono_Colacion;
       DBMS_OUTPUT.PUT(VAR_BONO_COLACION||' ');
       
        VAR_BONO_MOVILIZACION := :Bono_Movilizacion;
       DBMS_OUTPUT.PUT(VAR_BONO_MOVILIZACION||' ');
      
       DBMS_OUTPUT.PUT_LINE(' ');
       --INSERT INTO REMUNERACION_MENSUAL VALUES(RUTPROF,ETC,ETC);
  END LOOP;

END;
/

 /*â€¢	El monto de bono asesorÃ­as corresponde a un porcentaje (2%, 3%, 5% y 7%)
       del sueldo base del profesional de acuerdo con la cantidad de
       asesorÃ­as prestadas en el mes de cÃ¡lculo y en base a los tramos existentes en la tabla porc_asesorias:*/
       SELECT * FROM PORC_ASESORIAS;
       
      
        SELECT A.RUTPROF,COUNT(A.RUTPROF) 
       FROM PROFESIONAL P 
       JOIN ASESORIA A ON P.RUTPROF = A.RUTPROF
       GROUP BY A.RUTPROF,P.IDPROFESIONAL;
       HAVING P.IDPROFESIONAL = 1;
       
      
