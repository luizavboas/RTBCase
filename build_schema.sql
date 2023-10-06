--build using postgreSQL syntax;
create extension if not exists "uuid-ossp";

create table advertiser (
  id uuid primary key,
  name varchar(32) not null
);
create table "user" (
  id uuid primary key
);
create table impressions (
  id uuid primary key default uuid_generate_v4(),
  date timestamp not null,
  advertiser_id uuid not null,
  user_id uuid not null,
  constraint impressions_fk_1 foreign key (advertiser_id) references advertiser (id),
  constraint impressions_fk_2 foreign key (user_id) references "user" (id)
);
create table clicks (
  id uuid primary key default uuid_generate_v4(),
  date timestamp not null,
  advertiser_id uuid not null,
  user_id uuid not null,
  cost numeric not null,
  constraint clicks_fk_1 foreign key (advertiser_id) references advertiser (id),
  constraint clicks_fk_2 foreign key (user_id) references "user" (id)
);
create table tags (
  id uuid primary key default uuid_generate_v4(),
  date timestamp not null,
  advertiser_id uuid not null,
  user_id uuid not null,
  tag_type varchar(32) not null,
  constraint tags_fk_1 foreign key (advertiser_id) references advertiser (id),
  constraint tags_fk_2 foreign key (user_id) references "user" (id)
);
create table conversions (
  id uuid primary key default uuid_generate_v4(),
  date timestamp not null,
  advertiser_id uuid not null,
  user_id uuid not null,
  value numeric not null,
  rtb boolean not null,
  constraint conversions_fk_1 foreign key (advertiser_id) references advertiser (id),
  constraint conversions_fk_2 foreign key (user_id) references "user" (id)
);
insert into advertiser values
('404786b8-c890-4e2f-bc3d-246816e84749' , 'advertiser1'),
('124a2cfb-ae3b-42d4-9653-b59b26a37dab' , 'advertiser2')
;
insert into "user" values (
  '735b5495-5928-49e9-abeb-e631a73bdd4b'),
  ('4e7d7f61-1217-49d2-bf93-eb3023d3f00d')
;
insert into impressions (advertiser_id, user_id, date) values
  ('404786b8-c890-4e2f-bc3d-246816e84749', '4e7d7f61-1217-49d2-bf93-eb3023d3f00d', '2018-11-03'),
  ('404786b8-c890-4e2f-bc3d-246816e84749', '4e7d7f61-1217-49d2-bf93-eb3023d3f00d', '2018-11-07'),
  ('404786b8-c890-4e2f-bc3d-246816e84749', '4e7d7f61-1217-49d2-bf93-eb3023d3f00d', '2018-11-10'),
  ('404786b8-c890-4e2f-bc3d-246816e84749', '4e7d7f61-1217-49d2-bf93-eb3023d3f00d', '2018-11-20'),
  ('404786b8-c890-4e2f-bc3d-246816e84749', '735b5495-5928-49e9-abeb-e631a73bdd4b', '2018-11-15'),
  ('404786b8-c890-4e2f-bc3d-246816e84749', '4e7d7f61-1217-49d2-bf93-eb3023d3f00d', '2018-11-04'),
  ('124a2cfb-ae3b-42d4-9653-b59b26a37dab', '735b5495-5928-49e9-abeb-e631a73bdd4b', '2018-11-08'),
  ('404786b8-c890-4e2f-bc3d-246816e84749', '735b5495-5928-49e9-abeb-e631a73bdd4b', '2018-11-15'),
  ('124a2cfb-ae3b-42d4-9653-b59b26a37dab', '735b5495-5928-49e9-abeb-e631a73bdd4b', '2018-11-23'),
  ('124a2cfb-ae3b-42d4-9653-b59b26a37dab', '735b5495-5928-49e9-abeb-e631a73bdd4b', '2018-11-27'),
  ('124a2cfb-ae3b-42d4-9653-b59b26a37dab', '735b5495-5928-49e9-abeb-e631a73bdd4b', '2018-11-29'),
  ('124a2cfb-ae3b-42d4-9653-b59b26a37dab', '735b5495-5928-49e9-abeb-e631a73bdd4b', '2018-11-30')
;

insert into clicks (date, advertiser_id, user_id, "cost") values
  ('2018-11-03', '404786b8-c890-4e2f-bc3d-246816e84749', '4e7d7f61-1217-49d2-bf93-eb3023d3f00d', 1.36),
  ('2018-11-03', '404786b8-c890-4e2f-bc3d-246816e84749', '735b5495-5928-49e9-abeb-e631a73bdd4b', 4.24),
  ('2018-11-07', '124a2cfb-ae3b-42d4-9653-b59b26a37dab', '4e7d7f61-1217-49d2-bf93-eb3023d3f00d', 2.67),
  ('2018-11-08', '404786b8-c890-4e2f-bc3d-246816e84749', '735b5495-5928-49e9-abeb-e631a73bdd4b', 1.04),
  ('2018-11-10', '404786b8-c890-4e2f-bc3d-246816e84749', '4e7d7f61-1217-49d2-bf93-eb3023d3f00d', 1.64),
  ('2018-11-12', '404786b8-c890-4e2f-bc3d-246816e84749', '735b5495-5928-49e9-abeb-e631a73bdd4b', 1.05),
  ('2018-11-12', '404786b8-c890-4e2f-bc3d-246816e84749', '4e7d7f61-1217-49d2-bf93-eb3023d3f00d', 1.53),
  ('2018-11-20', '404786b8-c890-4e2f-bc3d-246816e84749', '735b5495-5928-49e9-abeb-e631a73bdd4b', 0.87),
  ('2018-11-22', '404786b8-c890-4e2f-bc3d-246816e84749', '4e7d7f61-1217-49d2-bf93-eb3023d3f00d', 0.98),
  ('2018-11-23', '404786b8-c890-4e2f-bc3d-246816e84749', '735b5495-5928-49e9-abeb-e631a73bdd4b', 1.03),
  ('2018-11-23', '404786b8-c890-4e2f-bc3d-246816e84749', '735b5495-5928-49e9-abeb-e631a73bdd4b', 1.04),
  ('2018-11-28', '404786b8-c890-4e2f-bc3d-246816e84749', '4e7d7f61-1217-49d2-bf93-eb3023d3f00d', 1.07)
;

insert into tags (date, advertiser_id, user_id, tag_type) values
  ('2018-11-03', '404786b8-c890-4e2f-bc3d-246816e84749', '4e7d7f61-1217-49d2-bf93-eb3023d3f00d', 'OFFER_PAGE'),
  ('2018-11-04', '124a2cfb-ae3b-42d4-9653-b59b26a37dab', '735b5495-5928-49e9-abeb-e631a73bdd4b', 'OFFER_PAGE'),
  ('2018-11-05', '404786b8-c890-4e2f-bc3d-246816e84749', '4e7d7f61-1217-49d2-bf93-eb3023d3f00d', 'HOME_PAGE'),
  ('2018-11-05', '124a2cfb-ae3b-42d4-9653-b59b26a37dab', '735b5495-5928-49e9-abeb-e631a73bdd4b', 'OFFER_PAGE'),
  ('2018-11-10', '404786b8-c890-4e2f-bc3d-246816e84749', '4e7d7f61-1217-49d2-bf93-eb3023d3f00d', 'HOME_PAGE'),
  ('2018-11-12', '124a2cfb-ae3b-42d4-9653-b59b26a37dab', '735b5495-5928-49e9-abeb-e631a73bdd4b', 'OFFER_PAGE'),
  ('2018-11-13', '404786b8-c890-4e2f-bc3d-246816e84749', '4e7d7f61-1217-49d2-bf93-eb3023d3f00d', 'ORDER'),
  ('2018-11-21', '124a2cfb-ae3b-42d4-9653-b59b26a37dab', '735b5495-5928-49e9-abeb-e631a73bdd4b', 'ORDER'),
  ('2018-11-22', '404786b8-c890-4e2f-bc3d-246816e84749', '4e7d7f61-1217-49d2-bf93-eb3023d3f00d', 'OFFER_PAGE'),
  ('2018-11-23', '124a2cfb-ae3b-42d4-9653-b59b26a37dab', '735b5495-5928-49e9-abeb-e631a73bdd4b', 'ORDER'),
  ('2018-11-23', '404786b8-c890-4e2f-bc3d-246816e84749', '4e7d7f61-1217-49d2-bf93-eb3023d3f00d', 'ORDER'),
  ('2018-11-23', '124a2cfb-ae3b-42d4-9653-b59b26a37dab', '735b5495-5928-49e9-abeb-e631a73bdd4b', 'HOME_PAGE'),
  ('2018-11-27', '404786b8-c890-4e2f-bc3d-246816e84749', '4e7d7f61-1217-49d2-bf93-eb3023d3f00d', 'OFFER_PAGE'),
  ('2018-11-29', '124a2cfb-ae3b-42d4-9653-b59b26a37dab', '735b5495-5928-49e9-abeb-e631a73bdd4b', 'ORDER'),
  ('2018-11-30', '404786b8-c890-4e2f-bc3d-246816e84749', '4e7d7f61-1217-49d2-bf93-eb3023d3f00d', 'ORDER')
;

insert into conversions (date, advertiser_id, user_id, "value", rtb) values
  ('2018-11-03', '404786b8-c890-4e2f-bc3d-246816e84749', '4e7d7f61-1217-49d2-bf93-eb3023d3f00d', 254.36, True),
  ('2018-11-03', '404786b8-c890-4e2f-bc3d-246816e84749', '735b5495-5928-49e9-abeb-e631a73bdd4b', 321.24, True),
  ('2018-11-18', '124a2cfb-ae3b-42d4-9653-b59b26a37dab', '735b5495-5928-49e9-abeb-e631a73bdd4b', 576.67, False),
  ('2018-11-22', '404786b8-c890-4e2f-bc3d-246816e84749', '4e7d7f61-1217-49d2-bf93-eb3023d3f00d', 123.04, True)
;

-- We want the following columns
-- date as Date (UTC)
-- Imps: from groupby of advertisers and date, with count of impressions
-- Clicks: from groupby of advertisers and date, with count of clicks
-- CTR	
-- Cost (BRL): from groupby of advertisers and date, with sum of click costs
-- CPC	
-- RTB Conversions: from groupby of advertisers and date, with count of conversions where rtb=True
-- CR	
-- ROAS	
-- RTB Conversions value (BRL): from groupby of advertisers and date, with sum of conversions values where rtb=True
-- Total number of conversions: from groupby of advertisers and date, with count of conversions
-- Share	
-- Total number of tags: : from groupby of advertisers and date, with count of tags

-- Query 1 - Item 3
WITH df AS(
  SELECT a.date AS date, a.id AS imps, b.id AS clicks, c.id AS convs, d.id AS tags, 
  b."cost" AS cost, c."value" AS c_value, c.rtb AS rtb_conv

  FROM impressions AS a
  LEFT OUTER JOIN clicks AS b
  ON a.date = b.date AND a.user_id = b.user_id
  LEFT OUTER JOIN conversions AS c
  ON a.date = c.date 
  LEFT OUTER JOIN tags AS d
  ON a.date = d.date 
  WHERE a.advertiser_id = '404786b8-c890-4e2f-bc3d-246816e84749')

SELECT d.day,
  COUNT(DISTINCT df.imps) AS Imps, 
  COUNT(DISTINCT df.clicks) AS Clicks, 
  COUNT(DISTINCT df.convs) AS Conversions, 
  COUNT(DISTINCT df.tags) AS Tags, 
  SUM(df.cost) AS Cost, 
  SUM(df.c_value) AS Conversion_Value, 
  df.rtb_conv AS RTB_Conv

FROM
  generate_series(
    (SELECT MIN(date) FROM df),
    (SELECT MAX(date) FROM df),
    interval '1 day'
  ) AS d(day)
LEFT JOIN df ON d.day = df.date

GROUP BY d.day, df.RTB_Conv
ORDER BY d.day;


-- Query 2 - Item 4
SELECT 
  DISTINCT a.id AS conv_id,
  a.date AS conv_date,
  a.user_id AS user_id,
  a.value AS conv_value
FROM conversions AS a
  INNER JOIN clicks b
  ON a.user_id = b.user_id
  WHERE
  a.advertiser_id = '404786b8-c890-4e2f-bc3d-246816e84749'
  AND a.rtb = true
  AND a.date - INTERVAL '24 hours' < b.date;


-- Query 3 - Item 5
SELECT DISTINCT
    a.name AS advertiser_name
FROM advertiser AS a
WHERE EXISTS(
  -- At least one impression
  SELECT 1 FROM impressions AS b 
  WHERE b.advertiser_id = a.id AND b.user_id = '4e7d7f61-1217-49d2-bf93-eb3023d3f00d')
OR EXISTS (
  -- At least one click
  SELECT 1 FROM clicks AS c
  WHERE c.advertiser_id = a.id AND c.user_id = '4e7d7f61-1217-49d2-bf93-eb3023d3f00d')
OR EXISTS (
  -- At least one tags
  SELECT 1 FROM tags d
  WHERE d.advertiser_id = a.id AND d.user_id = '4e7d7f61-1217-49d2-bf93-eb3023d3f00d')
OR EXISTS (
  -- At least one conversion
  SELECT 1 FROM conversions e
  WHERE e.advertiser_id = a.id AND e.user_id = '4e7d7f61-1217-49d2-bf93-eb3023d3f00d');