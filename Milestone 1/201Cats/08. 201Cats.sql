-- 1. Table: public.users

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
	
-- 2. Table: public.friends

CREATE TABLE public.friends
(
    friend_id integer NOT NULL,
    friend_of_id integer NOT NULL,
    created_time timestamp with time zone NOT NULL
);

-- PK
ALTER TABLE public.friends
    ADD CONSTRAINT pkey_friends_friend_id_friend_of_id PRIMARY KEY (friend_id, friend_of_id);
	
-- FK
ALTER TABLE public.friends
    ADD CONSTRAINT fkey_friends_friend_id FOREIGN KEY (friend_id)
    REFERENCES public.users (user_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
	
ALTER TABLE public.friends
    ADD CONSTRAINT fkey_friends_friend_of_id FOREIGN KEY (friend_id)
    REFERENCES public.users (user_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
	
-- Check
ALTER TABLE public.friends
    ADD CONSTRAINT check_friends_friend_id_friend_of_id CHECK (friend_id <> friend_of_id);

COMMENT ON CONSTRAINT check_friends_friend_id_friend_of_id ON public.friends
    IS 'friend_id does not equal to friend_of_id.';

ALTER TABLE public.friends
    ADD CONSTRAINT check_friends_created_time CHECK (created_time <> NULL::timestamp with time zone);

COMMENT ON CONSTRAINT check_friends_created_time ON public.friends
    IS 'created_time is not null.';
	
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

-- In case you need to drop these tables
/* 
DROP TABLE public.activities;
DROP TABLE public.activity_types;
DROP TABLE public.recommendations;
DROP TABLE public.videos;
DROP TABLE public.friends;
DROP TABLE public.users;
*/