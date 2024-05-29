@_save_set
@_set_plain_text_mode
@_save_buffer

set termout on

0 explain plan for
/

select * from table(dbms_xplan.display(format => 'all +alias -projection +note -outline'))
/

@_read_buffer
@_read_set
