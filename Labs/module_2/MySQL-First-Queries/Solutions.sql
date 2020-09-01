use ironhack_par;

select * from Appstore;

#1. What are the different genres?
select distinct prime_genre from Appstore;

#2. Which is the genre with the most apps rated?
select prime_genre, count(rating_count_tot) as number_of_apps_rated
from Appstore
where rating_count_tot is not null and rating_count_tot >0
group by prime_genre
order by 2 desc
limit 1;

#3. Which is the genre with most apps? 
select count(id), prime_genre
from Appstore
group by prime_genre
order by count(id) desc
limit 1;

#4. Which is the one with least?
select count(id), prime_genre
from Appstore
group by prime_genre
order by count(id) asc
limit 1;

#5. Find the top 10 apps most rated.
select track_name, rating_count_tot
from Appstore
order by rating_count_tot desc
limit 10;

#6. Find the top 10 apps best rated by users.
select track_name, user_rating
from Appstore
where user_rating = 5
order by user_rating desc
limit 10;

#7. Take a look at the data you retrieved in question 5. Give some insights.
#These are known apps, free apps, well rated (almost 4)

#8. Take a look at the data you retrieved in question 6. Give some insights.
select count(*) from Appstore where user_rating=5;
#These are 492 apps having a rate = 5. They just need 1 vote to be best rated.

#9. Now compare the data from questions 5 and 6. What do you see?
# the top 10 apps most rated is different of the top 10 apps best rated by users (no apps in common)
# They are not correlated 

#10. How could you take the top 3 regarding both user ratings and number of votes?
select track_name, user_rating, rating_count_tot
from Appstore
order by user_rating desc, rating_count_tot desc
limit 3;


#11. Do people care about the price of an app? Do some queries, comment why are you doing them and the results you retrieve. What is your conclusion?

#Looking for price of top 10 apps most rated :
select track_name, rating_count_tot, price
from Appstore
order by rating_count_tot desc
limit 10;

#Looking for price of top 10 apps best rated :
select track_name, user_rating, price
from Appstore
order by user_rating desc, price desc
limit 10;

#conclusion : the top 10 apps most rated are all free, top 10 apps most rated are not.
			#free apps are most rated