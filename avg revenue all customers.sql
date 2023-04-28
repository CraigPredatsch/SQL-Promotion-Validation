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
/* Begin grabbing data for all customers at the beginning of the promotion
   date. This lets us compare data for all customers after the promotion to
   those who took advantage of the promotion*/
Where rental_date >= '2005-05-26'
-- Sort data by country name, order it by average spend high to low
Group by 1
Order by 3 desc