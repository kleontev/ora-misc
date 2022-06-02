set lines 100
col trace_file for a100

select value as trace_file 
from v$diag_info 
where name = 'Default Trace File'
/

@_set_all
