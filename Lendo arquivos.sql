-- PL/SQL CHALLANGE - ARQUIVOS

-- CREATE OR REPLACE DIRECTORY TEST_DIR AS 'C:\app\oracle\product\12.1.0\dbhome_1\Tests';
SET SERVEROUTPUT ON;

DECLARE
   l_file   UTL_FILE.file_type;
   l_mode VARCHAR2(1) := 'R';
   line   VARCHAR2(50);
BEGIN
   l_file := UTL_FILE.FOPEN ('TEST_DIR', 'test_data.txt', l_mode);
   SYS.UTL_FILE.GET_LINE(l_file, line);
   SYS.UTL_FILE.FCLOSE(l_file);
   DBMS_OUTPUT.PUT_LINE(line);
END;
