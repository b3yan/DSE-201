-- 5. Table: public.activity_types

CREATE TABLE public.activity_types
(
    activity_type_id integer NOT NULL,
    activity_type_name text COLLATE pg_catalog."default" NOT NULL,
    display_name text COLLATE pg_catalog."default" NOT NULL
);

-- PK
ALTER TABLE public.activity_types
    ADD CONSTRAINT pkey_activity_types_activity_type_id PRIMARY KEY (activity_type_id);

-- Check
ALTER TABLE public.activity_types
    ADD CONSTRAINT check_activity_types_activity_type_name CHECK (activity_type_name <> NULL::text);

COMMENT ON CONSTRAINT check_activity_types_activity_type_name ON public.activity_types
    IS 'activity_type_name is not null.';
	
ALTER TABLE public.activity_types
    ADD CONSTRAINT check_activity_types_display_name CHECK (display_name <> NULL::text);

COMMENT ON CONSTRAINT check_activity_types_display_name ON public.activity_types
    IS 'display_name is not null.';

-- Unique
ALTER TABLE public.activity_types
    ADD CONSTRAINT unique_activity_types_activity_type_name UNIQUE (activity_type_name);

COMMENT ON CONSTRAINT unique_activity_types_activity_type_name ON public.activity_types
    IS 'activity_type_name is unique.';
	
ALTER TABLE public.activity_types
    ADD CONSTRAINT unique_activity_types_display_name UNIQUE (display_name);

COMMENT ON CONSTRAINT unique_activity_types_display_name ON public.activity_types
    IS 'display_name is unique.';
