SELECT *
FROM sales_agents
WHERE agency_fee >
(SELECT AVG(agency_fee)
 FROM sales_agents);






SELECT name AS painting,
     price,
     (SELECT AVG(price)
  FROM paintings) AS avg_price
FROM paintings;


Multiple-Row Subqueries
If your subquery returns more than one row, it can be referred to as a multiple-row
operators like IN, NOT IN, ANY, ALL, EXISTS, or NOT EXISTS that allow users to
SELECT AVG(agency_fee)
FROM sales_agents
WHERE id NOT IN (SELECT id
                 FROM managers);
                 The inner query will return a list of all manager IDs. Then the outer query filters only those
                 sales agents who are not in the managers
                 list and calculates an average agency fee paid to these agents. 

For example, the following query returns all of the models and producers of bikes that 
have a price greater than the most expensive headphones.
SELECT producer, model
FROM product
WHERE product_category = 'bike'
  AND price > ALL (
    SELECT price
    FROM product
    WHERE product_category = 'headphones'
  );
  
  The following query returns all of the models and producers of bikes 
  that have a price greater than at least one of the headphones.


  SELECT producer, model
FROM product
WHERE product_category = 'bike'
  AND price > ANY (
    SELECT price
    FROM product
    WHERE product_category = 'headphones'
  );


SELECT producer, model
FROM product
WHERE product_category = 'bike'
  AND id IN (
    SELECT distinct product_id
    FROM provider_offer
    WHERE provider_id IN (
      SELECT id
      FROM provider
      WHERE country = 'USA'
    )
  );
  using joins
  
  SELECT product.producer, product.model
FROM product, provider_offer, provider
WHERE provider_offer.product_id = product.id
  AND provider_offer.provider_id = provider.id
  AND product_category = 'bike'
  AND provider.country = 'USA';
  
  SELECT id, company_name
FROM client
WHERE EXISTS(
  SELECT *
  FROM purchase
  WHERE client.id = purchase.client_id
  WHERE date > '2013-07-10'
);


