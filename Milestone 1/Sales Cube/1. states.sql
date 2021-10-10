-- Table: public.states

-- DROP TABLE public.states;

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