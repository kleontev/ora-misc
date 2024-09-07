@_save_set
@_set_plain_text_mode
@_save_buffer

@_set_def_val

set termout off

column d new_value _rtsm_date
select to_char(sysdate, 'yyyymmdd_hh24miss') as d from dual
/

def rtsm_dir = &_my_temp_dir.\rtsm\&_connect_identifier.\

ho mkdir &rtsm_dir. 2> nul

def rtsm_path = &rtsm_dir.\&_rtsm_date._&1..html

select
    dbms_sql_monitor.report_sql_monitor(
        sql_id => '&1.',
        sql_exec_id => '&2.',
        sql_exec_start => '&3.',
        report_level => 'all +sql_text +plan_histogram +metrics',
        type => 'active'
    )
from dual
.

spool &rtsm_path.
/
spool off
set termout on
pro Saved RTSM report to &rtsm_path.

undef rtsm_path
undef rtsm_dir

@_unset_def_val
@_read_buffer
@_read_set