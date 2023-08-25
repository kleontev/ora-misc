set echo off
set head on 
set time on
set timi on
set feedback on
set verify off
set termout on 
set trimspool on 
set trimout on 
set pages 50
set lines 80
set long 200000000
set longchunksize 200000000
set tab off

clear columns 

col inst_id for 99
col sid for 99999
col serial# for 99999
col schemaname for a20
col osuser for a10
col seconds_in_wait for 999,999

col "LINE/COL" for a10
col "ERROR" for a65 wrap