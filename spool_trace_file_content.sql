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
from V$DIAG_TRACE_FILE_CONTENTS
where trace_filename = '&1'
/
spool off

col payload clear

@_set_all.sql