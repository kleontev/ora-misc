@_save_set
set echo off
set feedback off
set lines 2000
set pages 0
set termout off
set timi off
set trimspool on
set verify off

col payload for a2000

spool &1 replace

select payload
from v$diag_trace_file_contents
where trace_filename = '&1'
/
spool off

col payload clear

@_read_set