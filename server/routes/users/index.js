import { Router } from "express";
import connection from "../../database/index.js";
const router = Router();

router.get("/", async (req, res) => {
  try {
    const [rows, fields] = await connection.execute("select * from user");
    res.json(rows);
    console.log("send all users", fields);
  } catch (e) {
    console.log(e);
  }
});

export default router;
