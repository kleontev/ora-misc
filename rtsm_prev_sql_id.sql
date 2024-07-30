@_save_set
@_set_text_spool_mode
@_save_buffer

set termout on

select 
    dbms_sql_monitor.report_sql_monitor(
        sql_id => s.prev_sql_id,
        sql_exec_start => s.prev_exec_start,
        sql_exec_id => s.prev_exec_id,
        report_level => 'all -sql_text +plan_histogram',
        type => 'text'
    )
from v$session s 
where s.sid = userenv('sid')
/

@_read_buffer
@_read_set
