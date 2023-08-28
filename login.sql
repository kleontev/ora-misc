-- most likely I don't want to see what's going on in there 
set termout off


-- obtain and store session metadata somewher
def _my_inst_id = ""
def _my_sid = "" 
def _my_serial = ""
def _my_prompt = "SQL> "

col inst_id new_value _my_inst_id
col sid new_value _my_sid
col serial# new_value _my_serial
col my_prompt new_value _my_prompt

select 
    sys_context('userenv', 'instance') inst_id, 
    trim(sid) sid,
    trim(serial#) serial#
from v$session s 
where s.sid = sys_context('userenv', 'sid')
/

-- init sqlplus prompt, if connected
-- will default to "SQL> " if not
select
       '&_connect_identifier, ' 
    || '&_user, '
    || 'sid=&_my_sid., ' 
    || 'serial=&_my_serial.> ' my_prompt
from dual
/

set sqlprompt "&_my_prompt."
undef _my_prompt


-- change sqlplus window header in win
ho title -
db=&_connect_identifier.,-
user=&_user.,-
inst_id=&_my_inst_id,-
sid=&_my_sid.,-
serial=&_my_serial.


-- some session params
alter session set nls_date_format = 'yyyy.mm.dd hh24:mi:ss';
alter session set nls_timestamp_format = 'yyyy.mm.dd HH24.MI.SSXFF';
alter session set nls_timestamp_tz_format = 'yyyy.mm.dd HH24.MI.SSXFF TZR';

alter session set statistics_level = all;
alter session set plsql_warnings = 'enable:all';


-- init common paths for buffers and spools
def _my_temp_dir = "c:\users\kir-leontev\oracle\tmp"     
def _my_ed_path = "&_my_temp_dir.\&_my_sid._edit.sql"
def _my_buffer_path = "&_my_temp_dir.\&_my_sid._buffer.sql" 
def _my_set_path = "&_my_temp_dir.\&_my_sid._set.sql"


-- buffer editor
def _editor="notepad++.exe -notabbar -multiInst -nosession -noPlugin"
set editfile &_my_ed_path


-- transform params for ddl
exec dbms_metadata.set_transform_param(dbms_metadata.session_transform, 'BODY', false);
exec dbms_metadata.set_transform_param(dbms_metadata.session_transform, 'PRETTY', true);
exec dbms_metadata.set_transform_param(dbms_metadata.session_transform, 'SQLTERMINATOR', true);
exec dbms_metadata.set_transform_param(dbms_metadata.session_transform, 'CONSTRAINTS_AS_ALTER', false);
exec dbms_metadata.set_transform_param(dbms_metadata.session_transform, 'SEGMENT_ATTRIBUTES', false);


-- set my default sqlplus parameters 
set echo off
set feedback on
set head on 
set lines 80
set long 200000000
set longchunksize 200000000
set pages 50
set tab off
set termout on 
set time on
set timi on
set trimspool on 
set trimout on 
set verify off


-- done. make sure I can "ed" immediately after
select * from dual
.

