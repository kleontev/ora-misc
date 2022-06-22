create or replace procedure assert(
    p_condition boolean,
    p_error_message varchar2 := 'Assertion error!',
    p_error_code int := -20100
) as
begin
    if p_condition then
        return;
    end if;

    raise_application_error(p_error_code, p_error_message, true);
end assert;
/