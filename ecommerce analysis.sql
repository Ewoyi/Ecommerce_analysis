SELECT COUNT(*) FROM ecomm.user;
SELECT COUNT(*) FROM ecomm.product;
SELECT COUNT(*) FROM ecomm.purchase;
-- The highest selling products
/*
SELECT 
	c.`name` as category_name,
    count(*) as qty
FROM ecomm.purchase p
	left join ecomm.product pr on p.product_id = pr.id
    left join ecomm.category c on pr.category_id = c.id
group by category_name
order by qty desc
;
*/
-- The highest income generating product
/*
select 
	c.`name` as category_name,
    count(*) as qty,
    sum(price) as revenue
from ecomm.product pr
	left join ecomm.purchase p on pr.id = p.product_id
    left join ecomm.category c on pr.category_id = c.id
group by category_name
order by revenue desc
;
*/
-- The channel with the highest traffic
/*
select
	ch.`name` as channel_name,
    count(*) as user_count
from ecomm.`user` u 
	left join ecomm.`channel` ch on u.channel_id = ch.id
    left join ecomm.purchase p on u.id = p.user_id
group by channel_name
order by user_count desc
;
*/
-- The channel with the highest income
/*
select
	ch.`name` as channel_name,
    count(*) as user_count,
    sum(price) as revenue
from ecomm.`user` u 
	left join ecomm.`channel` ch on u.channel_id = ch.id
    left join ecomm.purchase p on u.id = p.user_id
    left join ecomm.product pr on p.product_id = pr.id
group by channel_id
order by revenue desc
;
*/
(select
	u.id as user_id,
    concat(u.first_name,' ',u.last_name) as full_name,
    ch.`name` as channel_name,
    count(*) as qty,
    sum(price) as revenue
from ecomm.`user` u
	inner join ecomm.purchase p on u.id = p.user_id
    left join ecomm.product pr on p.product_id = pr.id
    left join ecomm.category c on pr.category_id = c.id
    left join ecomm.`channel` ch on u.channel_id = ch.id
group by 1,2
order by revenue desc
)
select
	channel_name,
	sum(revenue)
from temp
	group by channel_name
;