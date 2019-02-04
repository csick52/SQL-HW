use sakila;

# 1a. 
select first_name, last_name 
	from actor;

# 1b.
select concat(first_name, ' ' ,last_name) 
	as Actor_Name
	from actor;

# 2a. To search on a specific name, use a "where" clause and a "like (%name%)" construction.

# 2b.
select * from actor
	where last_name like "%gen%";
    
# 2c.
select * from actor
	where last_name like "%li%"
    order by last_name, first_name;
    
# 2d.
select country_id, country
	from country
    where country in ("Afghanistan", "Bangladesh", "China");
    
# 3a.
alter table actor
	add description blob(200);
    
# 3b.
alter table actor
	drop column description;
    
# 4a.
select count(*), last_name 
	from actor
	group by last_name;
    
# 4b.
select count(*) as num, last_name
	from actor
    group by last_name
    having num > 1;
    
# 4c.
update actor
	set first_name = "Harpo"
    where last_name = "Williams"
    and first_name = "Groucho";
    
# 4d.
update actor
	set first_name = "Groucho"
    where last_name = "Williams"
    and first_name = "Harpo";
    
# 5a.
show create table address;

# 6a.
select staff.first_name, staff.last_name, address.address
	from staff
	inner join address on staff.address_id = address.address_id;

# 6b.
select staff.first_name, staff.last_name, sum(payment.amount)
	from staff
	inner join payment on staff.staff_id = payment.staff_id
	group by staff.last_name, staff.first_name;

# 6c.
select film.title, count(film_actor.actor_id)
	from film
	inner join film_actor on film.film_id = film_actor.film_id
	group by film.title;

# 6d.
select film.title, count(inventory.inventory_id)
	from film
	inner join inventory on film.film_id = inventory.film_id
	group by film.title
	having film.title = "Hunchback Impossible";

# 6e. 
select customer.first_name, customer.last_name, sum(payment.amount)
	from customer
    inner join payment on customer.customer_id = payment.customer_id
    group by customer.first_name, customer.last_name
    order by customer.last_name;
    
# 7a. 
select title from film
	inner join language on film.language_id = language.language_id
    where language.name = "English"
    and film.title like "K%"
    or film.title like "Q%";
    
# 7b.
select first_name, last_name
	from actor
    where actor_id in (

	select actor_id from film_actor
		where film_id in (
	
			select film_id from film
				where film.title = "Alone Trip"
));

# 7c.
select customer.email, customer.first_name, customer.last_name
	from customer
    inner join address 
		on customer.address_id = address.address_id
    inner join city
		on address.city_id = city.city_id
	inner join country
		on city.country_id = country.country_id
	where country.country = "Canada";

# 7d.
select title from film
	inner join film_category
		on film.film_id = film_category.film_id
	inner join category
		on film_category.category_id = category.category_id
	where category.name = "Family";
    
# 7e.
select film.title, count(rental_id) as num
	from film
	inner join inventory
		on film.film_id = inventory.film_id
	inner join rental
		on inventory.inventory_id = rental.inventory_id
	group by film.title
    order by num desc;
    
# 7f.
select sum(payment.amount), store.store_id 
	from payment
    inner join staff
		on payment.staff_id = staff.staff_id
	inner join store
		on staff.store_id = store.store_id
	group by store.store_id;
    
# 7g.
select store.store_id, city.city, country.country
	from store
    inner join address
		on store.address_id = address.address_id
	inner join city 
		on address.city_id = city.city_id
	inner join country
		on city.country_id = city.country_id;
        
# 7h.
select category.name, sum(payment.amount) as num
	from category
    inner join film_category
		on category.category_id = film_category.category_id
	inner join film
		on film_category.film_id = film.film_id
	inner join inventory
		on film.film_id = inventory.film_id
	inner join rental 
		on inventory.inventory_id = rental.inventory_id
	inner join payment
		on rental.rental_id = payment.rental_id
	group by category.name
	order by num desc
    limit 5;
	
# 8a. 
create view top_genres as
select category.name, sum(payment.amount) as num
	from category
    inner join film_category
		on category.category_id = film_category.category_id
	inner join film
		on film_category.film_id = film.film_id
	inner join inventory
		on film.film_id = inventory.film_id
	inner join rental 
		on inventory.inventory_id = rental.inventory_id
	inner join payment
		on rental.rental_id = payment.rental_id
	group by category.name
	order by num desc
    limit 5;
    
# 8b.
select * from top_genres;

# 8c.
drop view top_genres;
		
	
    

    
	





