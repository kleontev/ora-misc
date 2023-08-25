@_save_set

set head off
set feedback off
set timi off
set pages 0 
set lines 2000

spool &_my_buffer_path. replace

select sql_fulltext 
from gv$sqlarea
where 1 = 1
    and sql_id = '&1.'
    and rownum = 1
/

spool off

@_read_set

set lines 300

col cpu_time_sec for 999,999.999999
col elapsed_time_sec for 999,999.999999

select 
    inst_id,
    sql_id,
    loaded_versions,
    executions,
    fetches,
    rows_processed,
    cpu_time / 1e6 cpu_time_sec,
    elapsed_time / 1e6 elapsed_time_sec,
    last_active_time
from gv$sqlarea 
where sql_id = '&1.'
/

@_read_buffer
@_read_set