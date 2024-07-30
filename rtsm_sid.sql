@_save_set
@_set_plain_text_mode
@_save_buffer

set termout on

select
  dbms_sql_monitor.report_sql_monitor(
    sql_id => s.sql_id,
    sql_exec_start => s.sql_exec_start,
    sql_exec_id => s.sql_exec_id,
    report_level => 'all -sql_text +plan_histogram',
    type => 'text'
  )
from gv$session s
where 1 = 1
and s.inst_id = &1.
and s.sid = &2.
/

@_read_buffer
@_read_set
