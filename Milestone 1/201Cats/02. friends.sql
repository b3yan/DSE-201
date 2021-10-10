-- Table: public.friends

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