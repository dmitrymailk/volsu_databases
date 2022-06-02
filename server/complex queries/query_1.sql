-- 1) найти покупателей которые купили больше всех товаров(сумма);
SELECT * from bill inner join `user` on bill.bill_user = `user`.user_id ORDER by bill_sum DESC limit 3;