import { Router } from "express";
import connection from "../../database/index.js";
const router = Router();

router.post("/", async (req, res) => {
  try {
    const SQL_script = req.body.SQL_script;
    console.log(SQL_script);
    const [rows, fields] = await connection.execute(SQL_script);
    console.log(rows);
    res.json(rows);
  } catch (e) {
    console.log(e);
    res.sendStatus(500);
  }
});

export default router;
