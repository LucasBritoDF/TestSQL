
/*
Listar todos Clientes que não tenham realizado uma compra;
*/
select	distinct
		c.* 
from 	dbo.customers c
left 
join 	dbo.orders o 
on 		o.customer_id = c.customer_id 
where 	o.customer_id is null;


/*
Listar os Produtos que não tenham sido comprados
*/
select 
		p.* 
from 	dbo.products p
where 	not exists (select 1 from dbo.order_items oi where oi.product_id = o.product_id)


/*
Listar os Produtos sem Estoque;
*/
select 
		p.* 
from 	dbo.products p
left
join	dbo.stocks s 
on 		s.product_id = p.product_id
where 	isnull(s.quantity,0) < 1


/*
Agrupar a quantidade de vendas que uma determinada Marca por Loja
*/
-- Não ficou claro se era para somar ou contar :) 
select
		s.brand_name,
		s.store_name,
		quantityTotal = sum(oi.quantity)
from	dbo.orders o 
inner
join 	dbo.order_items oi
on 		oi.order_id = o.order_id
inner
join 	dbo.products p
on  	p.product_id = oi.product_id
inner
join 	dbo.brands b 
on		b.brand_id = p.brand_id
inner
join 	dbo.stores s 
on 		s.store_id = o.store_id
group BY
		s.brand_name,
		s.store_name
		
		
		
/*
Listar os Funcionarios que não estejam relacionados a um Pedido
*/
select
*
from 	dbo.staffs s 
where 	not exists (select 1 from dbo.orders o where o.staff_id = s.staff_id)