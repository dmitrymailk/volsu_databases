import { Router } from "express";
import connection from "../../database/index.js";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
const router = Router();

router.post("/login", async (req, res) => {
  try {
    const { user_email, password } = req.body;
    if (!(user_email && password)) {
      res.status(400).json({
        status: "All input is required",
      });
    }

    const SQL_script = `
	select * from user where user_email='${user_email}';
	`;
    let [rows, fields] = await connection.execute(SQL_script);
    if (rows.length == 0) {
      return res.status(409).json({
        status: "User doesn't Exist. Please Register",
      });
    }
    let user = rows[0];
    const user_hash = user.user_hash;
    const isPasswordEqual = await bcrypt.compare(`${password}`, user_hash);
    if (isPasswordEqual) {
      const token = jwt.sign(
        { user_id: user.user_id, user_email },
        process.env.SECRET_JWT,
        {
          expiresIn: "2h",
        }
      );

      user.token = token;
      res.status(200).json(user);
    }
    res.status(400).json({
      status: "Invalid Credentials",
    });
  } catch (e) {
    console.error(e);
  }
});

export default router;
