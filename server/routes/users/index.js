import { Router } from "express";
import connection from "../../database/index.js";
const router = Router();

router.get("/", async (req, res) => {
  try {
    const [rows, fields] = await connection.execute("select * from user");
    res.json(rows);
    // console.log("send all users", fields);
  } catch (e) {
    console.log(e);
  }
});

router.post("/", async (req, res) => {
  // console.log(req.body);
  const user_admin = req.body.user_admin;
  const user_credit = req.body.user_credit;
  const user_email = req.body.user_email;
  const user_name = req.body.user_name;
  const user_phone = req.body.user_phone;
  const user_read = req.body.user_read;
  const user_write = req.body.user_write;

  const user_hash = "dummy_hash";

  let SQL_script = `INSERT INTO mydb.user
  (
    user_name, 
    user_hash, 
    user_credit, 
    user_phone, 
    user_email, 
    user_admin, 
    user_read, 
    user_write
  )
  VALUES(
    '${user_name}', 
    '${user_hash}', 
    ${user_credit},
    '${user_phone}', 
    '${user_email}', 
    ${user_admin}, 
    ${user_read}, 
    ${user_write}
  );
  `;
  SQL_script = SQL_script.replaceAll("\n", "");
  try {
    await connection.query(SQL_script);
    res.sendStatus(200);
  } catch (e) {
    console.log(e);
    res.sendStatus(500);
  }
});

export default router;
