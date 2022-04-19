import { Router } from "express";
import connection from "../../database/index.js";
const router = Router();

router.get("/", async (req, res) => {
  try {
    const [rows, fields] = await connection.execute("select * from product");
    res.json(rows);
    // console.log("send all users", fields);
  } catch (e) {
    console.log(e);
  }
});

router.post("/", async (req, res) => {
  // console.log(req.body);
  const product_name = req.body.product_name;
  const product_price = req.body.product_price;
  const product_type = req.body.product_type;
  const product_img = req.body.product_img;

  const SQL_script = `INSERT INTO mydb.product 
	(
		product_name, 
		product_price, 
		product_type, 
		product_img
	) 
	VALUES(
		'${product_name}', 
		'${product_price}', 
		'${product_type}', 
		'${product_img}'
	);
	`;

  try {
    await connection.query(SQL_script);
    res.sendStatus(200);
  } catch (e) {
    console.log(e);
    res.sendStatus(500);
  }
});

router.put("/product/:product_id", async (req, res) => {
  const itemId = req.params.product_id;

  const product_name = req.body.product_name;
  const product_price = req.body.product_price;
  const product_type = req.body.product_type;
  const product_img = req.body.product_img;

  let SQL_script = `
	UPDATE mydb.product 
	SET 
	product_name='${product_name}', 
	product_price='${product_price}', 
	product_type='${product_type}', 
	product_img='${product_img}' 
	WHERE product_id=${itemId};
	`;

  try {
    await connection.query(SQL_script);
    res.sendStatus(200);
  } catch (e) {
    console.log(e);
    res.sendStatus(500);
  }
});

router.delete("/product/:product_id", async (req, res) => {
  const itemId = req.params.product_id;
  const SQL_script = `
	DELETE FROM mydb.product WHERE product_id=${itemId};
	`;
  console.log("delete product ", itemId);

  try {
    await connection.query(SQL_script);
    res.sendStatus(200);
  } catch (e) {
    console.log(e);
    res.sendStatus(500);
  }
});

export default router;
