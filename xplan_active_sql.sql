@_save_set
@_set_plain_text_mode
@_save_buffer

set termout on 

select t.* 
from gv$session s, table(dbms_xplan.display_cursor(s.sql_id, s.sql_child_number, format => 'allstats last')) t
where s.sid = &1.
/    

@_read_buffer
@_read_set
