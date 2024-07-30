@_save_buffer 
@_save_set 

set lines 2000

col object_type for a20
col object_owner for a15
col object_name for a30
col subobject_name for a30
col status for a20

break on object_type page

select 
    object_type,
    owner object_owner,
    object_name,
    subobject_name,
    created,
    last_ddl_time,
    status
from dba_objects 
where 1 = 1
    and owner || '.' || object_name like upper('&1.')
order by 
    object_Type, 
    owner,
    object_name
fetch first 500 rows only
/

@_read_buffer
@_read_set