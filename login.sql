def _buffer_path="_sqlplus_buffer.sql"
def _editor="notepad++.exe -notabbar -multiInst -nosession -noPlugin"

def _my_inst_id = ""
def _my_sid = "" 
def _my_serial = ""
def _my_prompt = "SQL> "

col inst_id new_value _my_inst_id
col sid new_value _my_sid
col serial# new_value _my_serial
col my_prompt new_value _my_prompt

set termout off

select 
    sys_context('userenv', 'instance') inst_id, 
    trim(sid) sid,
    trim(serial#) serial#
from v$session s 
where s.sid = sys_context('userenv', 'sid')
/

select
    '&_connect_identifier, &_user, sid=&_my_sid., seiral=&_my_serial.> ' my_prompt
from dual
/


ho title "db=&_connect_identifier., user=&_user., inst_id=&_my_inst_id, sid=&_my_sid., serial=&_my_serial."

set sqlprompt "&_my_prompt."

alter session set nls_date_format='yyyy.mm.dd hh24:mi:ss'
/

alter session set statistics_level = all
/

-- so I can "ed" immediately
select * from dual
.

@_set_all