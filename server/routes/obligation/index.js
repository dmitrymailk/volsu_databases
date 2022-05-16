import { Router } from "express";
import connection from "../../database/index.js";
const router = Router();

router.get("/", async (req, res) => {
  try {
    const [rows, fields] = await connection.execute("select * from obligation");
    res.json(rows);
    // console.log("send all users", fields);
  } catch (e) {
    console.log(e);
  }
});

router.get("/bill/:obligation_bill", async (req, res) => {
  try {
    const obligation_bill = req.params.obligation_bill;
    const [rows, fields] = await connection.execute(`select bill from bill;`);
    res.json(rows);
  } catch (e) {
    console.log(e);
  }
});

router.post("/", async (req, res) => {
  // console.log(req.body);
  const obligation_bill = req.body.obligation_bill;
  const obligation_sum = req.body.obligation_sum;

  const SQL_script = `INSERT INTO mydb.obligation 
  (
    obligation_bill,
    obligation_sum
	) 
	VALUES(
		'${obligation_bill}', 
		'${obligation_sum}'
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

router.put("/obligation/:obligation_id", async (req, res) => {
  const itemId = req.params.obligation_id;

  const obligation_bill = req.body.obligation_bill;
  const obligation_sum = req.body.obligation_sum;

  let SQL_script = `
	UPDATE mydb.obligation 
	SET 
	obligation_bill='${obligation_bill}', 
	obligation_sum='${obligation_sum}'
	WHERE obligation_id=${itemId};
	`;

  try {
    await connection.query(SQL_script);
    res.sendStatus(200);
  } catch (e) {
    console.log(e);
    res.sendStatus(500);
  }
});

router.delete("/obligation/:obligation_id", async (req, res) => {
  const itemId = req.params.product_id;
  const SQL_script = `
	DELETE FROM mydb.obligation WHERE obligation_id=${itemId};
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
