-- 3. Table: public.videos

CREATE TABLE public.videos
(
    video_id integer NOT NULL,
    video_name text COLLATE pg_catalog."default" NOT NULL,
    display_name text COLLATE pg_catalog."default" NOT NULL
);

-- PK
ALTER TABLE public.videos
    ADD CONSTRAINT pkey_videos_video_id PRIMARY KEY (video_id);
	
-- Check
ALTER TABLE public.videos
    ADD CONSTRAINT check_videos_video_name CHECK (video_name <> NULL::text);

COMMENT ON CONSTRAINT check_videos_video_name ON public.videos
    IS 'video_name is not null.';
	
ALTER TABLE public.videos
    ADD CONSTRAINT check_videos_display_name CHECK (display_name <> NULL::text);

COMMENT ON CONSTRAINT check_videos_display_name ON public.videos
    IS 'display_name is not null.';

-- Unique
ALTER TABLE public.videos
    ADD CONSTRAINT unique_videos_video_name UNIQUE (video_name);

COMMENT ON CONSTRAINT unique_videos_video_name ON public.videos
    IS 'video_name is unique.';
	
ALTER TABLE public.videos
    ADD CONSTRAINT unique_videos_display_name UNIQUE (display_name);

COMMENT ON CONSTRAINT unique_videos_display_name ON public.videos
    IS 'display_name is unique.';
