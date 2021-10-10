-- Table: public.customers

-- DROP TABLE public.customers;

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
