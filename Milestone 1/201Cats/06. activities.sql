-- 6. Table: public.activities

CREATE TABLE public.activities
(
    activity_id integer NOT NULL,
    user_id integer NOT NULL,
    video_id integer NOT NULL,
    activity_type_id integer NOT NULL,
    activity_time timestamp with time zone NOT NULL,
    is_video_recommended boolean NOT NULL
);

-- PK
ALTER TABLE public.activities
    ADD CONSTRAINT pkey_activities_activity_id PRIMARY KEY (activity_id);

-- FK
ALTER TABLE public.activities
    ADD CONSTRAINT fkey_activities_user_id FOREIGN KEY (user_id)
    REFERENCES public.users (user_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
	
ALTER TABLE public.activities
    ADD CONSTRAINT fkey_activities_video_id FOREIGN KEY (video_id)
    REFERENCES public.videos (video_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
	
ALTER TABLE public.activities
    ADD CONSTRAINT fkey_activities_activity_type_id FOREIGN KEY (activity_type_id)
    REFERENCES public.activity_types (activity_type_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

-- Check
ALTER TABLE public.activities
    ADD CONSTRAINT check_activities_is_video_recommended CHECK (is_video_recommended <> NULL::boolean);

COMMENT ON CONSTRAINT check_activities_is_video_recommended ON public.activities
    IS 'is_video_recommended is not null.';
	
ALTER TABLE public.activities
    ADD CONSTRAINT check_activities_activity_time CHECK (activity_time <> NULL::timestamp with time zone);

COMMENT ON CONSTRAINT check_activities_activity_time ON public.activities
    IS 'activity_time is not null.';