with

source as (

    select * from {{ source('ecom', 'raw_customers') }}

),

renamed as (

    select
        -- Primary Key
        id as customer_id,

        -- Details
        nullif(trim(name), '') as customer_name

    from source

    union all
 
    select
        null as customer_id,
        null as customer_name

)

select * from renamed