-- Table: public.users

CREATE TABLE public.users
(
    user_id integer NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    display_name text NOT NULL,
    facebook_log_in text NOT NULL
);

-- PK
ALTER TABLE public.users
    ADD CONSTRAINT pkey_users_user_id PRIMARY KEY (user_id);
	
-- Unique
ALTER TABLE public.users
    ADD CONSTRAINT unique_users_facebook_log_in UNIQUE (facebook_log_in);

COMMENT ON CONSTRAINT unique_users_facebook_log_in ON public.users
    IS 'facebook_log_in is unique.';
	
-- Check
ALTER TABLE public.users
    ADD CONSTRAINT check_users_first_name CHECK (first_name <> NULL::text);

COMMENT ON CONSTRAINT check_users_first_name ON public.users
    IS 'first_name is not null';
	
ALTER TABLE public.users
    ADD CONSTRAINT check_users_last_name CHECK (last_name <> NULL::text);

COMMENT ON CONSTRAINT check_users_last_name ON public.users
    IS 'last_name is not null.';

ALTER TABLE public.users
    ADD CONSTRAINT check_users_display_name CHECK (display_name <> NULL::text);

COMMENT ON CONSTRAINT check_users_display_name ON public.users
    IS 'display_name is not null.';

ALTER TABLE public.users
    ADD CONSTRAINT check_users_facebook_log_in CHECK (facebook_log_in <> NULL::text);

COMMENT ON CONSTRAINT check_users_facebook_log_in ON public.users
    IS 'facebook_log_in is not null.';