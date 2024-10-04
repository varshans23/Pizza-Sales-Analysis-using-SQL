create database pizza;
use pizza;

-- Retrieve the total number of orders placed.

select count(*)from orders;

-- Calculate the total revenue generated from pizza sales.

select round(SUM(order_details.quantity * pizzas.price)) as total_revenue
from order_details 
JOIN pizzas
ON order_details.pizza_id= pizzas.pizza_id;

-- Identify the highest-priced pizza.

select pizza_types.name, pizzas.price
from pizza_types
JOIN pizzas
ON pizza_types.pizza_type_id= pizzas.pizza_type_id
order by pizzas.price DESC
LIMIT 1;

-- Identify the most common pizza size ordered.

select COUNT(order_details.quantity)as total_quantity, pizzas.size
from order_details
JOIN pizzas
ON order_details.pizza_id=pizzas.pizza_id
group by pizzas.size
order by total_quantity DESC;

-- List the top 5 most ordered pizza types along with their quantities.

select SUM(order_details.quantity)as quantity, pizza_types.name
from pizza_types
JOIN pizzas
ON pizza_types.pizza_type_id=pizzas.pizza_type_id
JOIN order_details
ON pizzas.pizza_id=order_details.pizza_id
group by pizza_types.name
order by quantity DESC
limit 5;







