/*

Cleaning AirBnB listing dataset with MS SQL SERVER. Each of the columns were checked on missplellings, 
  dublicate values, errors, blanks, and updated with appropriate values. 
  
  */


SELECT*
FROM PortfolioProject.dbo.Listings


-- Checking for dublicates in 'id'column 

SELECT id, COUNT(*) duplicate
FROM PortfolioProject.dbo.Listings
GROUP BY id
HAVING COUNT(*) >1

-- Updating "id" field by populating with data from "listing_url" column and changing data type. 

SELECT listing_url, SUBSTRING(listing_url, CHARINDEX('/', listing_url, 29)+1, LEN(listing_url)-CHARINDEX('/', listing_url, 29)) NewID
FROM   PortfolioProject.dbo.Listings

UPDATE PortfolioProject.dbo.Listings
SET    id  = CAST(SUBSTRING(listing_url, CHARINDEX('/', listing_url, 29)+1, LEN(listing_url)-CHARINDEX('/', listing_url, 29)) AS BIGINT)

SELECT id
FROM   PortfolioProject.dbo.Listings


--Checking for blank values in column "host_name"

SELECT host_name, COUNT(*)
FROM  PortfolioProject.dbo.Listings
GROUP BY host_name
ORDER BY  1 

SELECT *
FROM  PortfolioProject.dbo.Listings
WHERE host_name LIKE ''


-- Change blank "host_name" field with "N/A"

SELECT host_name, 
       CASE 
       WHEN host_name LIKE '' THEN 'N/A'
	   END NA
FROM  PortfolioProject.dbo.Listings
WHERE host_name LIKE ''


UPDATE PortfolioProject.dbo.Listings
SET   host_name = CASE 
                  WHEN host_name LIKE '' THEN 'N/A'
	              END 
WHERE host_name LIKE ''


-- Checking "host_since" field 

SELECT host_since, COUNT(*)
FROM  PortfolioProject.dbo.Listings
GROUP BY host_since


SELECT *, LEN(host_since)
FROM   PortfolioProject.dbo.Listings
WHERE  LEN(host_since)> 10

--Update of 26 rows and corresponding "host_name" and "host_since" fields by concatenation, and update of fields with shifted to the next column values. 

SELECT TRIM(' " ' FROM CONCAT(host_name, host_since))
FROM   PortfolioProject.dbo.Listings
WHERE  LEN(host_since)> 10

UPDATE PortfolioProject.dbo.Listings
SET    host_name = TRIM(' " ' FROM CONCAT(host_name, host_since))
WHERE  LEN(host_since)> 10


UPDATE PortfolioProject.dbo.Listings
SET    host_since = host_response_time, host_response_time = host_response_rate
       , host_response_rate = host_acceptance_rate
	   , host_acceptance_rate = host_is_superhost
	   , host_is_superhost = host_total_listings_count
	   , host_total_listings_count = neighbourhoods
	   , neighbourhoods = boroughs
       , boroughs = latitude
	   , latitude = longitude
	   , longitude = property_type
	   , property_type = room_type
	   , room_type = accommodates
	   , accommodates = bathrooms
	   , bathrooms = bathrooms_text
	   , bathrooms_text = bedrooms
	   , bedrooms = beds
	   , beds = price
	   , price = minimum_nights
	   , minimum_nights = maximum_nights
	   , maximum_nights = has_availability
	   , has_availability = availability_365
	   , availability_365 = number_of_reviews
	   , number_of_reviews = number_of_reviews_12m 
	   , number_of_reviews_12m = number_of_reviews_l30d
	   , number_of_reviews_l30d = first_review
	   , first_review = last_review
	   , last_review = review_scores_rating
	   , review_scores_rating = instant_bookable
	   , instant_bookable = calculated_host_listings_count
WHERE LEN(host_since)> 10

SELECT host_name, host_since
FROM   PortfolioProject.dbo.Listings
WHERE  host_since LIKE ''

UPDATE PortfolioProject.dbo.Listings
SET   host_since = CASE 
                   WHEN host_since LIKE '' THEN 'N/A'
	               END 
WHERE host_since LIKE ''

-- Update of the "host_response_time" field

SELECT  host_response_time, COUNT(*)
FROM    PortfolioProject.dbo.Listings
GROUP BY host_response_time

UPDATE PortfolioProject.dbo.Listings
SET   host_response_time = CASE 
                           WHEN host_response_time LIKE '' THEN 'N/A'
	                       END 
WHERE host_response_time LIKE ''

SELECT *
FROM   PortfolioProject.dbo.Listings
WHERE  host_response_time NOT IN ('within a few hours', 'a few days or more', 'within a day', 'within an hour', 'N/A')

-- Update of all fields with id 3716193

UPDATE PortfolioProject.dbo.Listings
SET    host_name = 'Erin, Avi, Kaleb & Shiloh', host_since = '7/27/2014', host_response_time = 'within an hour'
       ,host_response_rate = '100%', host_acceptance_rate = '100%', host_is_superhost = 'f' 
	   ,host_total_listings_count = 1, neighbourhoods = 'Bedford-Stuyvesant', boroughs = 'Brooklyn'
	   ,latitude = '40.68245', longitude = '-73.94407', property_type = 'Entire townhouse'
	   ,room_type = 'Entire home/apt', accommodates = 5, bathrooms = Null
	   ,bathrooms_text = '1 bath', bedrooms = 2, beds = 3
	   ,price = 152, minimum_nights = 5, maximum_nights = 400
	   ,has_availability = 't', availability_365 = 95 
	   ,number_of_reviews = 199, number_of_reviews_12m = 15, number_of_reviews_l30d = 3
	   ,first_review = '8/9/2014', last_review = '5/18/2022', review_scores_rating = 4.62
	   ,instant_bookable = 't', calculated_host_listings_count = 1, reviews_per_month = 0.9
WHERE  host_id = 18970667

--Update of 3 rows and corresponding "host_name" and "host_since" fields by concatenation, and update of fields with shifted to the next column values. 

SELECT TRIM(' " ' FROM CONCAT(host_name, host_since))
FROM  PortfolioProject.dbo.Listings
WHERE  host_response_time NOT IN ('within a few hours', 'a few days or more', 'within a day', 'within an hour', 'N/A')

UPDATE PortfolioProject.dbo.Listings
SET   host_name = TRIM(' " ' FROM CONCAT(host_name, host_since))
WHERE  host_response_time NOT IN ('within a few hours', 'a few days or more', 'within a day', 'within an hour', 'N/A')

UPDATE PortfolioProject.dbo.Listings
SET    host_since = host_response_time, host_response_time = host_response_rate
       , host_response_rate = host_acceptance_rate
	   , host_acceptance_rate = host_is_superhost
	   , host_is_superhost = host_total_listings_count
	   , host_total_listings_count = neighbourhoods
	   , neighbourhoods = boroughs
       , boroughs = latitude
	   , latitude = longitude
	   , longitude = property_type
	   , property_type = room_type
	   , room_type = accommodates
	   , accommodates = bathrooms
	   , bathrooms = bathrooms_text
	   , bathrooms_text = bedrooms
	   , bedrooms = beds
	   , beds = price
	   , price = minimum_nights
	   , minimum_nights = maximum_nights
	   , maximum_nights = has_availability
	   , has_availability = availability_365
	   , availability_365 = number_of_reviews
	   , number_of_reviews = number_of_reviews_12m 
	   , number_of_reviews_12m = number_of_reviews_l30d
	   , number_of_reviews_l30d = first_review
	   , first_review = last_review
	   , last_review = review_scores_rating
	   , review_scores_rating = instant_bookable
	   , instant_bookable = calculated_host_listings_count
WHERE  host_response_time NOT IN ('within a few hours', 'a few days or more', 'within a day', 'within an hour', 'N/A')


-- Change blank "host_response_rate" field with "N/A"
SELECT host_response_rate, COUNT(*)
FROM  PortfolioProject.dbo.Listings
GROUP BY host_response_rate

UPDATE PortfolioProject.dbo.Listings
SET   host_response_rate = CASE 
                   WHEN host_response_rate LIKE '' THEN 'N/A'
	               END 
WHERE host_response_rate LIKE ''

-- Change blank " host_acceptance_rate" field with "N/A"

SELECT  host_acceptance_rate, COUNT( host_acceptance_rate)
FROM  PortfolioProject.dbo.Listings
GROUP BY host_acceptance_rate
ORDER BY 1

UPDATE PortfolioProject.dbo.Listings
SET   host_acceptance_rate = CASE 
                   WHEN host_acceptance_rate LIKE '' THEN 'N/A'
	               END 
WHERE host_acceptance_rate LIKE ''


-- Change t and f to Superhost and NonSuperhost in "host_is_superhost" field

SELECT host_is_superhost, COUNT(*)
FROM  PortfolioProject.dbo.Listings
GROUP BY host_is_superhost

SELECT host_is_superhost
  ,  CASE 
	   WHEN host_is_superhost = 't' THEN 'Superhost'
	   WHEN host_is_superhost = 'f' THEN 'NonSuperhost'
	   ELSE  'N/A'
	   END 
FROM  PortfolioProject.dbo.Listings
GROUP BY host_is_superhost

UPDATE PortfolioProject.dbo.Listings
SET    host_is_superhost = CASE 
	                          WHEN host_is_superhost = 't' THEN 'Superhost'
	                          WHEN host_is_superhost = 'f' THEN 'NonSuperhost'
	                          ELSE  'N/A'
	                          END 


-- Checking for dublicates and misspelling in "boroughs" field

SELECT boroughs, COUNT(*)
FROM  PortfolioProject.dbo.Listings
GROUP BY boroughs
ORDER BY 2 DESC

-- Cleaning data for listings with id = 49268785 and 51804585

SELECT*
FROM PortfolioProject.dbo.Listings
WHERE boroughs = ' Staten Island"'

UPDATE PortfolioProject.dbo.Listings
SET    neighbourhoods = TRIM('"' FROM neighbourhoods)
WHERE  boroughs = ' Staten Island"'


UPDATE PortfolioProject.dbo.Listings
SET    boroughs = latitude
	   , latitude = longitude
	   , longitude = property_type
	   , property_type = room_type
	   , room_type = accommodates
	   , accommodates = bathrooms
	   , bathrooms = bathrooms_text
	   , bathrooms_text = bedrooms
	   , bedrooms = beds
	   , beds = price
	   , price = minimum_nights
	   , minimum_nights = maximum_nights
	   , maximum_nights = has_availability
	   , has_availability = availability_365
	   , availability_365 = number_of_reviews
	   , number_of_reviews = number_of_reviews_12m 
	   , number_of_reviews_12m = number_of_reviews_l30d
	   , number_of_reviews_l30d = first_review
	   , first_review = last_review
	   , last_review = review_scores_rating
	   , review_scores_rating = instant_bookable
	   , instant_bookable = calculated_host_listings_count
WHERE  boroughs = ' Staten Island"'

-- Check for "0" values in "accommodates" field and replace with "N/A"

SELECT  CONVERT(INT, accommodates) accommodates, COUNT(*) 
FROM  PortfolioProject.dbo.Listings
GROUP BY accommodates
ORDER BY 1

SELECT accommodates, CASE
                       WHEN accommodates = 0 THEN 'N/A'
	                   END
FROM   PortfolioProject.dbo.Listings
WHERE  accommodates = 0

UPDATE PortfolioProject.dbo.Listings
SET    accommodates = CASE
                       WHEN accommodates = 0 THEN 'N/A'
	                   END
WHERE  accommodates = 0


-- Change blank "bedrooms" field with "N/A"

SELECT  bedrooms, COUNT(*)
FROM  PortfolioProject.dbo.Listings
GROUP BY bedrooms
ORDER BY 1

UPDATE PortfolioProject.dbo.Listings
SET    bedrooms = CASE 
                   WHEN bedrooms LIKE '' THEN 'N/A'
	               END 
WHERE bedrooms LIKE ''

-- Change blank "beds" field with "N/A"

SELECT  beds, COUNT(*)
FROM  PortfolioProject.dbo.Listings
GROUP BY beds
ORDER BY 1

UPDATE PortfolioProject.dbo.Listings
SET    beds = CASE 
                   WHEN beds LIKE '' THEN 'N/A'
	               END 
WHERE beds LIKE ''


-- Change t and f to Superhost and NonSuperhost in "host_is_superhost" field

SELECT has_availability, COUNT(*)
FROM  PortfolioProject.dbo.Listings
GROUP BY has_availability
ORDER BY 1

SELECT has_availability
,   CASE 
	   WHEN has_availability = 't' THEN 'Available'
	   WHEN has_availability = 'f' THEN 'NotAvailable'
	   ELSE  'N/A'
	   END 
FROM  PortfolioProject.dbo.Listings
GROUP BY has_availability

UPDATE PortfolioProject.dbo.Listings
SET    has_availability = CASE 
	                        WHEN has_availability = 't' THEN 'Available'
	                        WHEN has_availability = 'f' THEN 'NotAvailable'
	                        ELSE  'N/A'
	                        END 

-- Change blank "review_scores_rating" field with "N/A"

UPDATE PortfolioProject.dbo.Listings
SET    review_scores_rating = CASE 
                               WHEN review_scores_rating LIKE '' THEN 'N/A'
	                           END 
WHERE  review_scores_rating LIKE ''


-- Updating "calculated_host_listings_count" field by populating with data from "reviews_per_month" column

SELECT   calculated_host_listings_count
FROM     PortfolioProject.dbo.Listings
GROUP BY calculated_host_listings_count
ORDER BY 1

SELECT calculated_host_listings_count, reviews_per_month 
FROM   PortfolioProject.dbo.Listings
WHERE  calculated_host_listings_count IN ('t', 'f')

SELECT reviews_per_month, LEFT(reviews_per_month, 1),
       Substring(reviews_per_month, Charindex(',', reviews_per_month)+1, LEN(reviews_per_month)-Charindex(',', reviews_per_month))
FROM   PortfolioProject.dbo.Listings
WHERE  calculated_host_listings_count IN ('t', 'f')

UPDATE PortfolioProject.dbo.Listings
SET    calculated_host_listings_count = LEFT(reviews_per_month, 1) 
       , reviews_per_month = Substring(reviews_per_month, Charindex(',', reviews_per_month)+1, LEN(reviews_per_month)-Charindex(',', reviews_per_month))
WHERE  calculated_host_listings_count IN ('t', 'f')


SELECT*
FROM   PortfolioProject.dbo.Listings