-- Table: public.products

-- DROP TABLE public.products;

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