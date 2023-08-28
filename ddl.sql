@_save_set

set termout off

@_save_buffer

@_set_plain_text_mode
@_set_def_val

col dbms_metadata_compat_obj_type new_value _obj_type
col owner new_value _obj_owner
col object_name new_value _obj_name

with
parsed_name(owner, name, object_type_mask) as (
    -- keeping things simple, for now
    select 
        -- first token, if it's a qualified name, null otherwise
        substr(unparsed_name, 1, instr(unparsed_name, '.') - 1),        
        -- second token if it's a qualified name, whole name otherwise
        nvl(
            substr(unparsed_name, instr(unparsed_name, '.') + 1), 
            unparsed_name
        ),
        object_type_mask
    from (
        select 
            -- I'll deal with dbms_utility.canonicalize later
            upper('&1') unparsed_name,
            decode(
                upper('&2'),
                null, '%',
                'B', '%BODY',
                upper('%&2.%')
            ) object_type_mask
        from dual
    )
)
select --+leading(pn)
    decode(
        t.object_type,
        'PACKAGE', 'PACKAGE_SPEC',
        'PACKAGE BODY', 'PACKAGE_BODY',
        'TYPE BODY', 'TYPE_BODY',
        t.object_type
    ) dbms_metadata_compat_obj_type,
    t.owner,
    t.object_name
from parsed_name pn 
join all_objects t on 1 = 1 
    and t.owner = nvl(pn.owner, t.owner)
    and t.object_name = pn.name
    and t.object_type like pn.object_type_mask
order by
    -- if we specified a schema, look in that schema first,
    -- otherwise look in current schema first
    decode(
        t.owner, 
        pn.owner, 0,
        user, 1,
        2
    ),
    decode(
        t.object_type,
        'TABLE', 0,
        'PACKAGE', 1,
        'TYPE', 1,
        2
    )
fetch first 1 row only
/

def _last_ddl_path = -
   "&_my_temp_dir.\&_obj_type._&_obj_owner._&_obj_name..sql"

spool &_last_ddl_path

select
    dbms_metadata.get_ddl(
        object_type => '&_obj_type' ,
        name => '&_obj_name',
        schema => '&_obj_owner'
    )
from dual
/

-- TODO get_dependent_ddl for relevant objects

spool off

@_read_buffer
@_read_set

ho start &_last_ddl_path.

@_unset_def_val
undef _obj_type _obj_owner _obj_name _last_ddl_path