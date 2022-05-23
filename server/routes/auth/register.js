import { Router } from "express";
import connection from "../../database/index.js";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
const router = Router();

router.post("/register", async (req, res) => {
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
    if (rows.length != 0) {
      return res.status(409).json({
        status: "User Already Exist. Please Login",
      });
    }

    const encryptedPassword = await bcrypt.hash(password, 10);
    const SQL_script_2 = `
	INSERT INTO user
	(
		user_name, 
		user_hash, 
		user_credit, 
		user_phone, 
		user_email, 
		user_admin, 
		user_read, 
		user_write)
	VALUES(
		'test', 
		'${encryptedPassword}', 
		0, 
		'123', 
		'${user_email}', 
		0, 
		1, 
		0 
	);
	`;
    console.log(SQL_script_2);
    let result = await connection.execute(SQL_script_2);
    console.log(result);
    const { insertId } = result[0];
    const token = jwt.sign(
      { user_id: insertId, user_email },
      process.env.SECRET_JWT,
      {
        expiresIn: "2h",
      }
    );

    const user = {
      token,
      user_email,
    };
    res.status(201).json(user);
  } catch (e) {
    console.error(e);
  }
});

export default router;
