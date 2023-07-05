--soru 1. çıkış 2006 olan rental duration 3 7 ve arasında olan filmelerin sayısı 

--  kategori_ismi, language, tolma film adedi

select c.name as category_name, l.name as language_name, count(f.film_id) as total from category c
left join film_category fc
using(category_id)
left join film f
using(film_id)
left join language l
using(language_id)
where f.release_year = '2006' and f.rental_duration between 3 and 7
group by c.name, l.name



--soru2:hangi store da hangi filmeler kaç. adet stokta var 

-- store_id, film_adi, inventorydeki adedi


select s.store_id, f.title, count(i.inventory_id) from store s
left join staff sf
using(store_id)
left join rental r
using(staff_id)
left join inventory i
using(inventory_id)
left join film f
using(film_id)
group by s.store_id, f.title
order by s.store_id


--soru 3: film kategorisi animayosn olan  ve ülkeleri Anguilla
--Argentina
--Armenia
--Australia
--Austria
--Azerbaijan
--Bahrain
--Bangladesh
--Belarus
--Bolivia
--Brazil
--Brunei
--Bulgaria
--Cambodia
--Cameroon
--Canada
--bu  ülkerler olan müşteriler kimdir?


select cg.name, ct.country, c.customer_id from country ct
left join city ci
using(country_id)
left join address a
using(city_id)
left join customer c
using(address_id)
left join rental r
using(customer_id)
left join inventory i
using(inventory_id)
left join film f
using(film_id)
left join film_category fc
using(film_id)
left join category cg
using(category_id)
where cg.name = 'Animation' and ct.country in ('Anguilla','Argentina','Armenia','Australia','Austria','Azerbaijan','Bahrain','Bangladesh','Belarus','Bolivia','Brazil','Brunei','Bulgaria','Cambodia','Cameroon','Canada')
group by ct.country, cg.name, c.customer_id


--Soru 4: şu an aktif olan müşterilerin kiraladıkların filmlerin isimleri ve  adetleri


select f.title, count(f.title) as total_movie from film f
left join inventory i
using(film_id)
left join rental r
using(inventory_id)
left join customer c
using(customer_id)
where c.activebool = 'true'
group by f.title
order by count(f.title) desc



--Soru5: Animasyon ve Childer kategorilerinde stafflar toplam kaç film kiralamış ve toplam ne kadarlık kiralamış.


select c.name as category_name, count(r.rental_id) as total_rental, sum(p.amount) as total_amount from staff s
left join payment p
using(staff_id)
left join rental r
using(rental_id)
left join inventory i
using(inventory_id)
left join film f
using(film_id)
left join film_category fc
using(film_id)
left join category c
using(category_id)
where c.name in ('Animation', 'Children')
group by c.name