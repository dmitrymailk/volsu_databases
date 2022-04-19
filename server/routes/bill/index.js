import { Router } from "express";
import connection from "../../database/index.js";
const router = Router();

router.get("/", async (req, res) => {
  try {
    const [rows, fields] = await connection.execute("select * from bill");
    res.json(rows);
    // console.log("send all users", fields);
  } catch (e) {
    console.log(e);
  }
});

router.post("/", async (req, res) => {
  // console.log(req.body);
  const bill_user = req.body.bill_user;
  const bill_sum = req.body.bill_sum;

  const SQL_script = `INSERT INTO mydb.bill 
  (
    bill_user, 
    bill_sum
	) 
	VALUES(
		'${bill_user}', 
		'${bill_sum}'
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

router.put("/bill/:bill_id", async (req, res) => {
  const itemId = req.params.bill_id;

  const bill_user = req.body.bill_user;
  const bill_sum = req.body.bill_sum;

  let SQL_script = `
	UPDATE mydb.bill 
	SET 
	bill_user='${bill_user}', 
	bill_sum='${bill_sum}'
	WHERE bill_id=${itemId};
	`;

  try {
    await connection.query(SQL_script);
    res.sendStatus(200);
  } catch (e) {
    console.log(e);
    res.sendStatus(500);
  }
});

router.delete("/bill/:bill_id", async (req, res) => {
  const itemId = req.params.bill_id;
  const SQL_script = `
	DELETE FROM mydb.bill WHERE bill_id=${itemId};
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
