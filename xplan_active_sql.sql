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

@_save_buffer

set termout on 

select t.* 
from gv$session s, table(dbms_xplan.display_cursor(s.sql_id, s.sql_child_number, format => 'allstats last')) t
where s.sid = &1.
/    

@_read_buffer
@_set_all
