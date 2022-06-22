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

select t.* 
from table(
    dbms_xplan.display_cursor(
        format => 'all allstats last +predicate +alias -projection'
    )
) t
/

@_read_buffer
@_set_all
