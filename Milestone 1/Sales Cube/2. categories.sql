-- Table: public.categories

-- DROP TABLE public.categories;

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