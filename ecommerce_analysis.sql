SELECT COUNT(*) FROM ecomm.`user`;
SELECT COUNT(*) FROM ecomm.product;
SELECT COUNT(*) FROM ecomm.purchASe;
-- The highest selling products

SELECT 
	c.`name` AS category_name,
    COUNT(*) AS qty
FROM ecomm.purchASe p
	LEFT JOIN ecomm.product pr ON p.product_id = pr.id
    LEFT JOIN ecomm.category c ON pr.category_id = c.id
        GROUP BY category_name
        ORDER BY qty DESC
;

-- The highest income generating product

SELECT 
	c.`name` AS category_name,
    COUNT(*) AS qty,
    SUM(price) AS revenue
FROM ecomm.product pr
	LEFT JOIN ecomm.purchASe p ON pr.id = p.product_id
    LEFT JOIN ecomm.category c ON pr.category_id = c.id
        GROUP BY category_name
        ORDER BY revenue DESC
;

-- The channel with the highest traffic

SELECT
	ch.`name` AS channel_name,
    COUNT(*) AS user_COUNT
FROM ecomm.`user` u 
	LEFT JOIN ecomm.`channel` ch ON u.channel_id = ch.id
    LEFT JOIN ecomm.purchASe p ON u.id = p.user_id
GROUP BY channel_name
ORDER BY user_COUNT DESC
;

-- The channel with the highest income

SELECT
	ch.`name` AS channel_name,
    COUNT(*) AS user_COUNT,
    SUM(price) AS revenue
FROM ecomm.`user` u 
	LEFT JOIN ecomm.`channel` ch ON u.channel_id = ch.id
    LEFT JOIN ecomm.purchASe p ON u.id = p.user_id
    LEFT JOIN ecomm.product pr ON p.product_id = pr.id
        GROUP BY channel_id
        ORDER BY revenue DESC
;

WITH temp AS
(SELECT
	u.id AS user_id,
    CONCAT(u.first_name,' ',u.lASt_name) AS full_name,
    ch.`name` AS channel_name,
    COUNT(*) AS qty,
    SUM(price) AS revenue
FROM ecomm.`user` u
	inner join ecomm.purchASe p ON u.id = p.user_id
    LEFT JOIN ecomm.product pr ON p.product_id = pr.id
    LEFT JOIN ecomm.category c ON pr.category_id = c.id
    LEFT JOIN ecomm.`channel` ch ON u.channel_id = ch.id
		GROUP BY 1,2
		ORDER BY revenue DESC
)
SELECT
	channel_name,
	SUM(revenue)
FROM temp
	GROUP BY channel_name
;