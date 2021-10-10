-- 1. Table: public.states

CREATE TABLE public.states
(
    state_id integer NOT NULL,
    state_name text NOT NULL,
    display_name text NOT NULL
);

COMMENT ON COLUMN public.states.display_name
    IS 'For multi-languages perspective, normally, state_name is used for generating enumerations in code and should not be translated. However, display_name is used for showing on the UI and can be translated.';

-- PK
ALTER TABLE public.states
    ADD CONSTRAINT pkey_states_state_id PRIMARY KEY (state_id);

-- Check
ALTER TABLE public.states
    ADD CONSTRAINT check_state_name CHECK (state_name <> NULL::text);

COMMENT ON CONSTRAINT check_state_name ON public.states
    IS 'state_name is not null.';
	
ALTER TABLE public.states
    ADD CONSTRAINT check_display_name CHECK (display_name <> NULL::text);

COMMENT ON CONSTRAINT check_display_name ON public.states
    IS 'display_name is not null.';
	
-- Unique
ALTER TABLE public.states
    ADD CONSTRAINT unique_state_name UNIQUE (state_name);

COMMENT ON CONSTRAINT unique_state_name ON public.states
    IS 'state_name is unique.';
	
ALTER TABLE public.states
    ADD CONSTRAINT unique_display_name UNIQUE (display_name);

COMMENT ON CONSTRAINT unique_display_name ON public.states
    IS 'display_name is unique.';	

-- 2. Table: public.categories

CREATE TABLE public.categories
(
    category_id integer NOT NULL,
    category_name text NOT NULL,
    display_name text NOT NULL,
    description text
);

COMMENT ON COLUMN public.categories.display_name
    IS 'For multi-languages perspective, normally, category_name is used for generating enumerations in code and should not be translated. However, display_name is used for showing on the UI and can be translated.';

-- PK
ALTER TABLE public.categories
    ADD CONSTRAINT pkey_categories_category_id PRIMARY KEY (category_id);

-- Check
ALTER TABLE public.categories
    ADD CONSTRAINT check_categories_category_name CHECK (category_name <> NULL::text);

COMMENT ON CONSTRAINT check_categories_category_name ON public.categories
    IS 'category_name is not null.';
	
ALTER TABLE public.categories
    ADD CONSTRAINT check_categories_display_name CHECK (display_name <> NULL::text);

COMMENT ON CONSTRAINT check_categories_display_name ON public.categories
    IS 'display_name is not null.';

-- Unique
ALTER TABLE public.categories
    ADD CONSTRAINT unique_categories_category_name UNIQUE (category_name);

COMMENT ON CONSTRAINT unique_categories_category_name ON public.categories
    IS 'category_name is unique.';
	
ALTER TABLE public.categories
    ADD CONSTRAINT unique_categories_display_name UNIQUE (display_name);

COMMENT ON CONSTRAINT unique_categories_display_name ON public.categories
    IS 'display_name is unique.';

-- 3. Table: public.products

CREATE TABLE public.products
(
    product_id integer NOT NULL,
    product_name text COLLATE pg_catalog."default" NOT NULL,
    display_name text COLLATE pg_catalog."default" NOT NULL,
    unit_price money NOT NULL,
    category_id integer NOT NULL
);

COMMENT ON COLUMN public.products.display_name
    IS 'For multi-languages perspective, normally, product_name is used for generating enumerations in code and should not be translated. However, display_name is used for showing on the UI and can be translated.';

-- PK
ALTER TABLE public.products
    ADD CONSTRAINT pkey_products_product_id PRIMARY KEY (product_id);
	
-- FK
ALTER TABLE public.products
    ADD CONSTRAINT fkey_product_category_id FOREIGN KEY (product_id)
    REFERENCES public.categories (category_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

-- Unique
ALTER TABLE public.products
    ADD CONSTRAINT unique_products_product_name UNIQUE (product_name);

COMMENT ON CONSTRAINT unique_products_product_name ON public.products
    IS 'product_name is unique.';
	
ALTER TABLE public.products
    ADD CONSTRAINT unique_products_display_name UNIQUE (display_name);

COMMENT ON CONSTRAINT unique_products_display_name ON public.products
    IS 'display_name is unique.';

-- Check
ALTER TABLE public.products
    ADD CONSTRAINT check_products_product_name CHECK (product_name <> NULL::text);

COMMENT ON CONSTRAINT check_products_product_name ON public.products
    IS 'product_name is not null.';
	
ALTER TABLE public.products
    ADD CONSTRAINT check_products_display_name CHECK (display_name <> NULL::text);

COMMENT ON CONSTRAINT check_products_display_name ON public.products
    IS 'display_name is not null.';

ALTER TABLE public.products
    ADD CONSTRAINT check_products_unit_price CHECK (unit_price >= '$0.00'::money);

COMMENT ON CONSTRAINT check_products_unit_price ON public.products
    IS 'unit_price >= $0';
	
-- 4. Table: public.customers

CREATE TABLE public.customers
(
    customer_id integer NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    display_name text NOT NULL,
    state_id integer NOT NULL,
    nick_name text NOT NULL
);

COMMENT ON COLUMN public.customers.display_name
    IS 'For multi-languages perspective, normally, first_name and last_name are used for generating enumerations in code and should not be translated. However, display_name is used for showing on the UI and can be translated.';

-- PK
ALTER TABLE public.customers
    ADD CONSTRAINT pkey_customers_customer_id PRIMARY KEY (customer_id);
	
-- FK
ALTER TABLE public.customers
    ADD CONSTRAINT fkey_customers_state_id FOREIGN KEY (state_id)
    REFERENCES public.states (state_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

-- Unique
ALTER TABLE public.customers
    ADD CONSTRAINT unique_customers_nick_name UNIQUE (nick_name);

COMMENT ON CONSTRAINT unique_customers_nick_name ON public.customers
    IS 'nick_name is unique in case the following case happens.

If first_name, last_name, display_name, and state_id are all the same, then we will use nick_name to distinguish different customers.';

-- Check
ALTER TABLE public.customers
    ADD CONSTRAINT check_customers_first_name CHECK (first_name <> NULL::text);

COMMENT ON CONSTRAINT check_customers_first_name ON public.customers
    IS 'first_name is not null.';

ALTER TABLE public.customers
    ADD CONSTRAINT check_customers_last_name CHECK (last_name <> NULL::text);

COMMENT ON CONSTRAINT check_customers_last_name ON public.customers
    IS 'last_name is not NULL.';
	
ALTER TABLE public.customers
    ADD CONSTRAINT check_customers_display_name CHECK (display_name <> NULL::text);

COMMENT ON CONSTRAINT check_customers_display_name ON public.customers
    IS 'display_name is not null.';

ALTER TABLE public.customers
    ADD CONSTRAINT check_customers_nick_name CHECK (nick_name <> NULL::text);

COMMENT ON CONSTRAINT check_customers_nick_name ON public.customers
    IS 'nick_name is not null.';

-- 5. Table: public.sales

CREATE TABLE public.sales
(
    sale_id integer NOT NULL,
    customer_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer NOT NULL,
    percent_discount double precision NOT NULL
);

-- PK
ALTER TABLE public.sales
    ADD CONSTRAINT pkey_sales_sale_id PRIMARY KEY (sale_id);

-- FK
ALTER TABLE public.sales
    ADD CONSTRAINT fkey_sales_product_id FOREIGN KEY (product_id)
    REFERENCES public.products (product_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
	
ALTER TABLE public.sales
    ADD CONSTRAINT fkey_sales_customer_id FOREIGN KEY (sale_id)
    REFERENCES public.customers (customer_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
	
-- Check
ALTER TABLE public.sales
    ADD CONSTRAINT check_sales_quantity CHECK (quantity > 0 AND quantity <> NULL::integer);

COMMENT ON CONSTRAINT check_sales_quantity ON public.sales
    IS 'quantity is not null and should > 0.';
	
ALTER TABLE public.sales
    ADD CONSTRAINT check_sales_percent_discount CHECK (percent_discount >= 0::double precision AND percent_discount <= 100::double precision AND percent_discount <> NULL::double precision);

COMMENT ON CONSTRAINT check_sales_percent_discount ON public.sales
    IS 'percent_discount should between 0.0 and 100.0.';

-- In case you need to drop these tables
/*
DROP TABLE public.sales;
DROP TABLE public.customers;
DROP TABLE public.products;
DROP TABLE public.categories;
DROP TABLE public.states;
*/