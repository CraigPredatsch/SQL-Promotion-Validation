Select
    -- Determine what is going to be output
    co.country as country,
    sum(p.amount) as total_revenue,
    avg(p.amount) as average
From sakila.rental r
/* Start with rental table in the sakila database
   Join the information needed from other tables to identify which country a customer is from
   and how much they've spent*/
Left join sakila.payment p on r.customer_id = p.customer_id
Left join sakila.customer cu on r.customer_id = cu.customer_id
Left join sakila.address a on cu.address_id = a.address_id
Left join sakila.city c on a.city_id = c.city_id
Left join sakila.country co on c.country_id = co.country_id
/* Dates of the promotion - Only grab info for customers who purchased during the
   promotion period. Now we can determine how much customers who took advantage of
   the promotion spend compared with all users (all users in another sql tab)*/
Where r.customer_id in (
	Select
		customer_id
	From sakila.rental r
	Where rental_date >= '2005-05-26'
		and rental_date < '2005-05-27')
-- Sort data by country name, order it by average spend high to low
Group by 1
Order by 3 desc