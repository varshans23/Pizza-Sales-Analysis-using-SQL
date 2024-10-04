use pizza;

-- Join the necessary tables to find the total quantity of each pizza category ordered.

select sum(order_details.quantity)as total_quantity,pizza_types.category
from pizza_types
JOIN pizzas
ON pizza_types.pizza_type_id=pizzas.pizza_type_id
JOIN order_details
ON pizzas.pizza_id=order_details.pizza_id
group by pizza_types.category
order by total_quantity desc;

-- Determine the distribution of orders by hour of the day.

select HOUR(time)as hour,count(order_id)as total_order_counts from orders
group by hour
order by hour asc;


-- Join relevant tables to find the category-wise distribution of pizzas

select count(name),category from pizza_types
group by category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.

select round(avg(quantity))from  
(select sum(order_details.quantity)as quantity,orders.date
from order_details
join orders
ON order_details.order_id=orders.order_id
group by orders.date)as order_quantity;



-- Determine the top 3 most ordered pizza types based on revenue.
select pizza_types.name,round(sum(order_details.quantity * pizzas.price))as revenue
from order_details
join pizzas
ON order_details.pizza_id=pizzas.pizza_id 
join pizza_types
ON pizza_types.pizza_type_id=pizzas.pizza_type_id
group by pizza_types.name
order by revenue desc
limit 3;






