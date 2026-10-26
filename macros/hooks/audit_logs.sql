{% macro audit(event_name, object_name) %}

    INSERT INTO DBT_DEMO.AUDIT.LOG (
        EVENT_NAME,
        OBJECT_NAME,
        EVENT_TIME
    )
    VALUES (
        '{{ event_name }}',
        '{{ object_name }}',
        CURRENT_TIMESTAMP()
    )

{% endmacro %}