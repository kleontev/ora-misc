declare 
    e_table_not_exists exception;
    pragma exception_init(e_table_not_exists, -942);
begin 
    execute immediate 'drop table &1. purge';
exception when e_table_not_exists then
    null;
end;
/