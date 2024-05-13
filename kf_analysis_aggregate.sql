


SELECT trx.transaction_id, trx.date, trx.branch_id, brc.branch_name, brc.kota, brc.provinsi, brc.rating AS rating_cabang, trx.customer_name, trx.product_id,prd.product_name, trx.price AS actual_price, trx.discount_percentage,
    CASE 
        WHEN trx.price <= 50000 THEN 0.1
        WHEN trx.price > 50000 AND trx.price <= 100000 THEN 0.15
        WHEN trx.price > 100000 AND trx.price <= 300000 THEN 0.2
        WHEN trx.price > 300000 AND trx.price <= 500000 THEN 0.25
        ELSE 0.3
    END AS persentase_gross_laba,
    trx.price * (1 - discount_percentage) AS nett_sales,
    CASE 
        WHEN trx.price <= 50000 THEN trx.price + (1 + 0.1) - trx.price * (1 - discount_percentage)
        WHEN trx.price > 50000 AND trx.price <= 100000 THEN trx.price + (1 + 0.15) - trx.price * (1 - discount_percentage)
        WHEN trx.price > 100000 AND trx.price <= 300000 THEN trx.price + (1 + 0.2) - trx.price * (1 - discount_percentage)
        WHEN trx.price > 300000 AND trx.price <= 500000 THEN trx.price + (1 + 0.25) - trx.price * (1 - discount_percentage)
        ELSE trx.price + (1 + 0.3) - trx.price * (1 - discount_percentage)
    END AS nett_profit,
    trx.rating AS rating_transaksi
FROM `kimia_farma.kf_final_transaction` AS trx
LEFT JOIN `kimia_farma.kf_product` AS prd
  ON trx.product_id = prd.product_id
LEFT JOIN `kimia_farma.kf_kantor_cabang` AS brc
  ON trx.branch_id = brc.branch_id;




