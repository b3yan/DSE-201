-- Table: public.sales

-- DROP TABLE public.sales;

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
