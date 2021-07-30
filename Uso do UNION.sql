--EXEMPLO 1 USANDO UNION
    SELECT city
    FROM customers

UNION

    SELECT city
    FROM suppliers
ORDER BY city

--************************--
--EXEMPLO 1 USANDO UNION ALL
    SELECT 'CLI',
        city
    FROM customers

UNION ALL

    SELECT 'FORNEC',
        city
    FROM suppliers
ORDER BY city

--********************--
--EXEMPLO 2 USANDO UNION
    SELECT city,
        country
    FROM customers
    WHERE country = 'Germany'

UNION

    SELECT city,
        country
    FROM suppliers
    WHERE country = 'Germany'
ORDER BY city

--************************--
--EXEMPLO 2 USANDO UNION ALL
    SELECT city,
        country
    FROM customers
    WHERE country = 'Germany'

UNION ALL

    SELECT city,
        country
    FROM suppliers
    WHERE country = 'Germany'
ORDER BY city