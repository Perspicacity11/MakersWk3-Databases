TRUNCATE TABLE users, posts RESTART IDENTITY;

INSERT INTO users ("username", "email_address") VALUES
('Cass Naylor', 'cassius@makers.com'),
('Ed Thomas', 'edward@makers.com'),
('Luke Lai', 'luke@makers.com'),
('Ryan Lai', 'ryan@makers.com'),
('Max Allen-Smith', 'max@makers.com');

INSERT INTO posts ("title", "contents", "view_count", "user_id") VALUES
('Cass post 1', 'My first comment in this fictional social network', 1000, 1),
('Cass post 2', 'I really hope this works', 5000, 1),
('Cass post 3', 'Also I hope that this recording comes in at under an hour', 2000, 1),
('Ed post 1', 'Cass is being very loud and he is messing up my recording', 1000, 2),
('Ed post 2', 'I think I can hear him on my process feedback challenge', 1000, 2),
('Luke post 1', 'Thank god I am paired with Terry today', 1000, 3);