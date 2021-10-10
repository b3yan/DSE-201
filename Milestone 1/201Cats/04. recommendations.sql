-- 4. Table: public.recommendations

CREATE TABLE public.recommendations
(
    user_id integer NOT NULL,
    video_id integer NOT NULL,
    user_login_time timestamp with time zone
);

-- PK
ALTER TABLE public.recommendations
    ADD CONSTRAINT pkey_recommendations_user_id_video_id PRIMARY KEY (user_id, video_id);

-- FK
ALTER TABLE public.recommendations
    ADD CONSTRAINT fkey_recommendations_user_id FOREIGN KEY (user_id)
    REFERENCES public.users (user_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

ALTER TABLE public.recommendations
    ADD CONSTRAINT fkey_recommendations_video_id FOREIGN KEY (video_id)
    REFERENCES public.videos (video_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
	
-- Check
ALTER TABLE public.recommendations
    ADD CONSTRAINT check_recommendations_user_login_time CHECK (user_login_time <> NULL::timestamp with time zone);
