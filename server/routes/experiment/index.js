import { Router } from "express";
import connection from "../../database/index.js";
const router = Router();

router.get("/", async (req, res) => {
  try {
    const SQL_script = req.body.SQL_script;
    const [rows, fields] = await connection.execute(SQL_script);
    res.json(rows);
  } catch (e) {
    console.log(e);
    res.sendStatus(500);
  }
});

export default router;
