set echo off
set timi off
set pages 0
set head off
set lines 32767
set verify off
set trimspool on
set long 1000000
set longchunksize 10000000
set feedback off
set termout off

@_save_buffer

set termout on

0 explain plan for 
/

select * from table(dbms_xplan.display(format => 'typical'))
/

@_read_buffer
@_set_all
