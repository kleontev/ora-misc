@_save_set
@_set_plain_text_mode
@_save_buffer

set termout on

select t.* 
from table(
    dbms_xplan.display_cursor(
        format => 'all allstats last +predicate +alias -projection +outline'
    )
) t
/

@_read_buffer
@_read_set
