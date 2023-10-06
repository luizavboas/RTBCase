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