with 

source as (

    select * from {{ source('ecom', 'raw_products') }}

),

renamed as (

    select
        -- Primary Key
        sku as product_id,

        -- Details
        nullif(trim(name), '') as product_name,
        nullif(trim(type), '') as product_type,
        nullif(trim(description), '') as product_description, 

        -- Numerics
        coalesce(price::number, 0) as product_price_cents,
        {{ cents_to_dollars('price') }} as product_price,

        -- Boolean
        coalesce(lower(type) = 'jaffle', false) as is_food_item,
        coalesce(lower(type) = 'beverage', false) as is_drink_item

    from source

)

select * from renamed