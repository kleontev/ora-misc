@_save_set
set lines 300

col first_load_time for a30 wrap
col sql_text_first_100 for a100

@_save_buffer

select /*+find.sql*/
    inst_id,
    sql_id, 
    first_load_time,
    substr(sql_text, 1, 100) sql_text_first_100
from gv$sqlarea t 
where 1 = 1 
    and dbms_lob.instr(sql_fulltext, '&1.') > 0
    and sql_text not like '%find.sql%'
order by first_load_time desc
/

@_read_buffer
@_read_set