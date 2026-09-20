-- Verify that all Vestiaire listings were imported
SELECT COUNT(*) AS total_listings
FROM VESTIAIRE_LISTINGS;

-- ============================================================
-- 1. DATA QUALITY & EXPLORATION
-- ============================================================

-- Preview the dataset
SELECT *
FROM VESTIAIRE_LISTINGS
FETCH FIRST 10 ROWS ONLY;


-- Check the date range
SELECT
    MIN(online_date) AS earliest_listing,
    MAX(online_date) AS latest_listing
FROM VESTIAIRE_LISTINGS;


-- Check price range
SELECT
    MIN(price) AS minimum_price,
    MAX(price) AS maximum_price,
    ROUND(AVG(price), 2) AS average_price
FROM VESTIAIRE_LISTINGS;


-- See available product categories
SELECT
    category,
    COUNT(*) AS listing_count
FROM VESTIAIRE_LISTINGS
GROUP BY category
ORDER BY listing_count DESC;


-- See available designers
SELECT
    designer,
    COUNT(*) AS listing_count
FROM VESTIAIRE_LISTINGS
GROUP BY designer
ORDER BY listing_count DESC;


-- ============================================================
-- 2. BUSINESS ANALYSIS
-- ============================================================

-- Question 1:
-- Which designers have the highest average listing prices?
-- Only include designers with at least 50 listings to avoid
-- drawing conclusions from very small samples.

SELECT
    designer,
    COUNT(*) AS listing_count,
    ROUND(AVG(price), 2) AS avg_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price
FROM VESTIAIRE_LISTINGS
GROUP BY designer
HAVING COUNT(*) >= 50
ORDER BY avg_price DESC;


-- Question 2:
-- How does item condition relate to listing price?

SELECT
    condition,
    COUNT(*) AS listing_count,
    ROUND(AVG(price), 2) AS avg_price,
    ROUND(MEDIAN(price), 2) AS median_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price
FROM VESTIAIRE_LISTINGS
GROUP BY condition
ORDER BY median_price DESC;


-- Question 3:
-- How do listing prices differ across product categories?

SELECT
    category,
    COUNT(*) AS listing_count,
    ROUND(AVG(price), 2) AS avg_price,
    ROUND(MEDIAN(price), 2) AS median_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price
FROM VESTIAIRE_LISTINGS
GROUP BY category
ORDER BY median_price DESC;


-- Question 4:
-- Which designers have the highest listing prices within the bags category?
-- Require at least 20 bag listings per designer.

SELECT
    designer,
    COUNT(*) AS bag_count,
    ROUND(AVG(price), 2) AS avg_bag_price,
    ROUND(MEDIAN(price), 2) AS median_bag_price,
    MIN(price) AS min_bag_price,
    MAX(price) AS max_bag_price
FROM VESTIAIRE_LISTINGS
WHERE category = 'bags'
GROUP BY designer
HAVING COUNT(*) >= 20
ORDER BY median_bag_price DESC;


-- Question 5:
-- How does condition relate to listing price specifically for bags?

SELECT
    condition,
    COUNT(*) AS bag_count,
    ROUND(AVG(price), 2) AS avg_bag_price,
    ROUND(MEDIAN(price), 2) AS median_bag_price
FROM VESTIAIRE_LISTINGS
WHERE category = 'bags'
GROUP BY condition
ORDER BY median_bag_price DESC;


-- Question 6:
-- How do listing prices differ by customer engagement level?

SELECT
    CASE
        WHEN num_likes = 0 THEN '0 likes'
        WHEN num_likes BETWEEN 1 AND 5 THEN '1-5 likes'
        WHEN num_likes BETWEEN 6 AND 10 THEN '6-10 likes'
        WHEN num_likes BETWEEN 11 AND 25 THEN '11-25 likes'
        ELSE '26+ likes'
    END AS engagement_level,
    COUNT(*) AS listing_count,
    ROUND(AVG(price), 2) AS avg_price,
    ROUND(MEDIAN(price), 2) AS median_price
FROM VESTIAIRE_LISTINGS
GROUP BY
    CASE
        WHEN num_likes = 0 THEN '0 likes'
        WHEN num_likes BETWEEN 1 AND 5 THEN '1-5 likes'
        WHEN num_likes BETWEEN 6 AND 10 THEN '6-10 likes'
        WHEN num_likes BETWEEN 11 AND 25 THEN '11-25 likes'
        ELSE '26+ likes'
    END
ORDER BY
    MIN(num_likes);
    
    
-- Question 7:
-- Do "We Love" listings differ in price and customer engagement?

SELECT
    we_love_tag,
    COUNT(*) AS listing_count,
    ROUND(AVG(price), 2) AS avg_price,
    ROUND(MEDIAN(price), 2) AS median_price,
    ROUND(AVG(num_likes), 2) AS avg_likes,
    ROUND(MEDIAN(num_likes), 2) AS median_likes
FROM VESTIAIRE_LISTINGS
GROUP BY we_love_tag
ORDER BY median_price DESC;

-- Question 8:
-- Which seller locations have the highest median listing prices?
-- Require at least 50 listings per location.

SELECT
    location,
    COUNT(*) AS listing_count,
    ROUND(AVG(price), 2) AS avg_price,
    ROUND(MEDIAN(price), 2) AS median_price
FROM VESTIAIRE_LISTINGS
GROUP BY location
HAVING COUNT(*) >= 50
ORDER BY median_price DESC;


-- ============================================================
-- ANALYSIS NOTES
-- ============================================================

-- Dataset: 10,409 Vestiaire Collective listings
--
-- Key findings:
-- 1. Bags had a median listing price of $380, making them one
--    of the strongest high-value categories in the dataset.
--
-- 2. Within bags, Chanel had the highest median listing price
--    ($3,012.50), followed by Hermes ($2,400), among designers
--    with at least 20 bag listings.
--
-- 3. Bag prices generally declined as item condition worsened.
--    Never-worn bags had a median price of $445 compared with
--    $209 for bags in fair condition.
--
-- 4. Listing price was positively associated with engagement.
--    Listings with 26+ likes had a median price of $392.74,
--    compared with $190 for listings with zero likes.
--
-- 5. "We Love" listings generated substantially more engagement:
--    17.57 average likes versus 4.66 for non-tagged listings,
--    despite having a lower median listing price.
--
-- Note: These results describe associations within this dataset
-- and should not be interpreted as causal relationships.