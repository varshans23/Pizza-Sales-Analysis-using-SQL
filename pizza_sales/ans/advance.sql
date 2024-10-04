use pizza;

-- Calculate the percentage contribution of each pizza type to total revenue.

select pizza_types.category,round(SUM(order_details.quantity * pizzas.price)/ 
(select round(SUM(order_details.quantity * pizzas.price),2)as total_sale  
from order_details
join pizzas
ON pizzas.pizza_id=order_details.pizza_id) * 100,2) as revenue
from pizza_types
join pizzas
ON pizza_types.pizza_type_id=pizzas.pizza_type_id
join order_details
ON order_details.pizza_id=pizzas.pizza_id
group by pizza_types.category
order by revenue desc;

-- Analyze the cumulative revenue generated over time.
select date,round(sum(revenue)over(order by date))as cum_revenue
from  
(select orders.date,SUM(order_details.quantity * pizzas.price)as revenue
from orders
join order_details
on orders.order_id=order_details.order_id
join pizzas
on order_details.pizza_id=pizzas.pizza_id
group by orders.date)as sales;


-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.

select pizza_types.name,pizza_types.category,sum(order_details.quantity * pizzas.price)as revenue
from pizza_types
join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join order_details
ON order_details.pizza_id=pizzas.pizza_id
group by pizza_types.name,pizza_types.category 
order by revenue desc
limit 3;
