# SQL Join exercise
#

#
# 1: Get the cities with a name starting with ping sorted by their population with the least populated cities first
SELECT * FROM city WHERE Name LIKE 'ping%' ORDER BY Population;
#
# 2: Get the cities with a name starting with ran sorted by their population with the most populated cities first
SELECT * FROM city WHERE Name LIKE 'ran%' ORDER BY Population DESC;
#
# 3: Count all cities
SELECT count(*) FROM city;
#
# 4: Get the average population of all cities
SELECT AVG(Population) FROM city;
#
# 5: Get the biggest population found in any of the cities
SELECT max(Population) FROM city;
#
# 6: Get the smallest population found in any of the cities
SELECT min(Population) FROM city;
#
# 7: Sum the population of all cities with a population below 10000
SELECT sum(Population) FROM city WHERE Population < 10000;
#
# 8: Count the cities with the countrycodes MOZ and VNM
SELECT count(*) FROM city WHERE CountryCode IN ('MOZ', 'VNM');
#
# 9: Get individual count of cities for the countrycodes MOZ and VNM
SELECT sum(Population) FROM city WHERE CountryCode IN ('MOZ', 'VNM');
#
# 10: Get average population of cities in MOZ and VNM
SELECT AVG(Population) FROM city WHERE CountryCode IN ('MOZ', 'VNM');
#
# 11: Get the countrycodes with more than 200 cities
SELECT CountryCode 
FROM city
GROUP BY CountryCode
HAVING count(Name) > 200;
#
# 12: Get the countrycodes with more than 200 cities ordered by city count
SELECT CountryCode 
FROM city
GROUP BY CountryCode
HAVING count(Name) > 200
ORDER BY count(Name);

#
# 13: What language(s) is spoken in the city with a population between 400 and 500 ?
SELECT Language
FROM countrylanguage cl
LEFT JOIN country c
	 ON cl.CountryCode = c.Code
WHERE c.Population BETWEEN 400 AND 500; 
#
# 14: What are the name(s) of the cities with a population between 500 and 600 people and the language(s) spoken in them
SELECT city.Name, cl.language 
FROM city, countrylanguage cl, country c 
WHERE (city.Population BETWEEN 500 AND 600)
	AND city.CountryCode = c.Code
    AND c.Code = cl.CountryCode;
#
# 15: What names of the cities are in the same country as the city with a population of 122199 (including the that city itself)
SELECT Name
FROM city 
WHERE CountryCode = (SELECT CountryCode FROM city WHERE population = 122199);
#
# 16: What names of the cities are in the same country as the city with a population of 122199 (excluding the that city itself)
SELECT Name
FROM city 
WHERE CountryCode = (SELECT CountryCode FROM city WHERE population = 122199)
AND Name != (SELECT Name FROM city WHERE population = 122199);
#
# 17: What are the city names in the country where Luanda is capital?
SELECT Name 
FROM city 
WHERE CountryCode = (SELECT CountryCode FROM city WHERE Name = 'Luanda');
#
# 18: What are the names of the capital cities in countries in the same region as the city named Yaren
SELECT ci.Name
FROM city ci LEFT JOIN country co ON ci.CountryCode = co.Code
WHERE co.Region = (
	SELECT Region 
	FROM country co LEFT JOIN city ci ON co.Code = ci.CountryCode 
	WHERE ci.Name = 'Yaren')
AND ci.ID = co.Capital; 
#
# 19: What unique languages are spoken in the countries in the same region as the city named Riga
SELECT DISTINCT language
FROM countrylanguage cl 
LEFT JOIN country co ON cl.CountryCode = co.Code
LEFT JOIN city ci ON co.Code = ci.CountryCode
WHERE co.Region = (SELECT Region FROM country WHERE (Code = (SELECT CountryCode FROM city WHERE Name = 'Riga'))
);
#
# 20: Get the name of the most populous city
SELECT Name FROM city WHERE Population = (SELECT max(Population) FROM city);
#
