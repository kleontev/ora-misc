with
all_space as (
    select            
        owner ||'.' || segment_name || nullif('.' || partition_name, '.') full_segment_name,
        tablespace_name,
        extent_id,
        owner,
        segment_name,
        partition_name,
        segment_type,
        file_id,
        block_id,
        blocks
    from dba_extents e
    union all
    select    
        null,
        tablespace_name,
        null,
        null,
        null,
        null,
        null,
        file_id,
        block_id,
        blocks
    from dba_free_space    
),
contiguous_space as (
    select
        s.tablespace_name,
        s.owner,
        s.segment_name,
        s.partition_name,
        s.segment_type,
        s.file_id,
        count(s.extent_id) allocated_extents,
        min(s.block_id) first_block,
        sum(s.blocks) total_blocks
    from (                
        select
            s.*,
            sum(s.sog) over (
                partition by s.tablespace_name, s.file_id
                order by s.block_id
            ) group_id
        from (    
            select
                s.*,
                decode(
                    full_segment_name,            
                    lag(full_segment_name, 1, null)
                    over (
                        partition by s.tablespace_name, s.file_id
                        order by s.block_id
                    ),
                    0,
                    1
                ) sog
            from all_space s
        ) s    
    ) s    
    group by
        s.group_id,
        s.tablespace_name,
        s.owner,
        s.segment_name,
        s.partition_name,
        s.segment_type,
        s.file_id
)
select *
from contiguous_space
where tablespace_name = 'USERS'
order by
    tablespace_name,
    file_id,
    first_block