-- Cross Join
/*1. Suppose every vendor in the `vendor_inventory` table had 5 of each of their products to sell to **every** 
customer on record. How much money would each vendor make per product? 
Show this by vendor_name and product name, rather than using the IDs.

HINT: Be sure you select only relevant columns and rows. 
Remember, CROSS JOIN will explode your table rows, so CROSS JOIN should likely be a subquery. 
Think a bit about the row counts: how many distinct vendors, product names are there (x)?
How many customers are there (y). 
Before your final group by you should have the product of those two queries (x*y).  */

select vendor_name, product_name, amount
from (
	select  vendor_id, product_id, original_price *5 * count( distinct customer_id) as amount
	from vendor_inventory
	cross join customer
	group by vendor_id, product_id, original_price
	order by 1,2,3 limit 100) a
inner join vendor v
on a.vendor_id = v.vendor_id
inner join product p 
on a.product_id = p.product_id;


-- INSERT
/*1.  Create a new table "product_units". 
This table will contain only products where the `product_qty_type = 'unit'`. 
It should use all of the columns from the product table, as well as a new column for the `CURRENT_TIMESTAMP`.  
Name the timestamp column `snapshot_timestamp`. */

create table product_units as 
	select *, CURRENT_TIMESTAMP as snapshot_timestamp
	from product
	where product_qty_type = 'unit';

/*2. Using `INSERT`, add a new row to the product_units table (with an updated timestamp). 
This can be any product you desire (e.g. add another record for Apple Pie). */
insert into product_units 
VALUES ('24', 'Maple Syrup - Barrel', '42  gallons', 2, 'unit', CURRENT_TIMESTAMP)


-- DELETE
/* 1. Delete the older record for the whatever product you added. 

HINT: If you don't specify a WHERE clause, you are going to have a bad time.*/

create table product_units_bkp as select * from product_units;

delete from product_units
where product_id = '24';


drop table product_units_bkp;

-- UPDATE
/* 1.We want to add the current_quantity to the product_units table. 
First, add a new column, current_quantity to the table using the following syntax.

ALTER TABLE product_units
ADD current_quantity INT;

Then, using UPDATE, change the current_quantity equal to the last quantity value from the vendor_inventory details.

HINT: This one is pretty hard. 
First, determine how to get the "last" quantity per product. 
Second, coalesce null values to 0 (if you don't have null values, figure out how to rearrange your query so you do.) 
Third, SET current_quantity = (...your select statement...), remembering that WHERE can only accommodate one column. 
Finally, make sure you have a WHERE statement to update the right row, 
	you'll need to use product_units.product_id to refer to the correct row within the product_units table. 
When you have all of these components, you can run the update statement. */


create view last_quantity_by_prod as 
select product_id, quantity as last_quantity from (
select product_id, quantity,
row_number() over( partition by product_id order by market_date desc ) date_rank
from vendor_inventory)a
where date_rank =  1;

--select * from last_quantity_by_prod;

UPDATE product_units
SET current_quantity = (
    SELECT l.last_quantity
    FROM last_quantity_by_prod l
    WHERE product_units.product_id = l.product_id
)
WHERE EXISTS (
    SELECT 1
    FROM last_quantity_by_prod l
    WHERE product_units.product_id = l.product_id
);



