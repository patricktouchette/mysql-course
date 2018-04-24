-- 1. - Find the 5 oldest users
SELECT * FROM users
ORDER BY created_at
LIMIT 5;

-- 2. What day of the week do most users register on?
SELECT DATE_FORMAT(created_at, '%W') AS day,
    COUNT(*) AS registration_day
FROM users
GROUP BY day
ORDER BY registration_day DESC;

--3. Find the users who have never posted a photo
SELECT 
    users.id,
    username, 
    image_url,
    COUNT(image_url) AS image_posts
FROM users
LEFT JOIN photos
ON users.id = photos.user_id
WHERE image_url IS NULL
GROUP BY users.id
;

--4. Identify the most popular photo and user who created it
SELECT
    photos.user_id,
    users.username,
    photos.id,
    photos.image_url,
    COUNT(*) As total
FROM photos
INNER JOIN likes
    ON photos.id = likes.photo_id
INNER JOIN users
    ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC
LIMIT 1;
;

--5. HOW many times does the average user post;
SELECT
    (SELECT count(*) FROM photos) / (SELECT count(*) FROM users);
    
--6. What are the 5 most commonly used hashtags
SELECT
    tags.tag_name,
    count(*) as total
FROM tags
INNER JOIN photo_tags
    ON photo_tags.tag_id = tags.id
GROUP BY tags.id
ORDER BY total DESC
LIMIT 5
;

--7. Find users (bots) who have liked every single 
--photo on the site
SELECT
    users.username
    photos