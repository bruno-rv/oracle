-- COMPARAÇÃO CURSOR IMPLÍCITO COM BULK COLLECT

-- exec dbms_monitor.session_trace_enable;
exec dbms_monitor.session_trace_enable;
set timi on;

-- SEM BULK
DECLARE
startTime number;
sqlCount  number;
lastName  hr.employees.last_name%TYPE;
BEGIN
  startTime := dbms_utility.get_time;
  FOR REC IN(SELECT COUNT(1), LAST_NAME INTO sqlCount, lastName FROM HR.EMPLOYEES EMP GROUP BY LAST_NAME ORDER BY LAST_NAME DESC) LOOP
    DBMS_OUTPUT.PUT_LINE(TO_CHAR(sqlCount));
    DBMS_OUTPUT.PUT_LINE(REC.LAST_NAME);
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('Tempo de execução CURSOR IMPLÍCITO: ' || (dbms_utility.get_time - startTime));
END;
/

-- COM BULK
DECLARE
TYPE employees_aat IS TABLE OF HR.EMPLOYEES%ROWTYPE;
l_employees employees_aat;
startTime number;
BEGIN
  startTime := dbms_utility.get_time;
  SELECT * BULK COLLECT INTO l_employees FROM HR.EMPLOYEES EMP ORDER BY LAST_NAME DESC;
  
  DBMS_OUTPUT.PUT_LINE(l_employees.COUNT);
  
  FOR indx IN 1 .. l_employees.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE(l_employees(indx).last_name);
  END LOOP;
  
  DBMS_OUTPUT.PUT_LINE('Tempo de execução BULK: ' || (dbms_utility.get_time - startTime));
  
END;
/