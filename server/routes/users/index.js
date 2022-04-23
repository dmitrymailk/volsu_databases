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
  ) VALUES(
    '${user_name}', 
    '${user_hash}', 
    '${user_credit}',
    '${user_phone}', 
    '${user_email}', 
    '${user_admin}', 
    '${user_read}', 
    '${user_write}'
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

router.post("/search/", async (req, res) => {
  try {
    console.log(req.body);
    const searchFields = req.body.searchFields;
    const searchPhrase = req.body.searchPhrase;
    const likeSearch = (field, phrase) => `${field} LIKE '%${phrase}%'`;
    let SQL_script = "SELECT * from user WHERE ";
    let searchFieldsKeys = [];
    for (let item of Object.keys(searchFields))
      if (searchFields[item]) searchFieldsKeys.push(item);
    if (searchFieldsKeys.length > 0) {
      searchFieldsKeys.forEach((item, index) => {
        if (index < searchFieldsKeys.length - 1) {
          SQL_script += `${likeSearch(item, searchPhrase)} OR `;
        } else {
          SQL_script += `${likeSearch(item, searchPhrase)};`;
        }
      });
    } else {
      SQL_script = "select * from user;";
    }
    // console.log(SQL_script);
    const [rows, fields] = await connection.execute(SQL_script);
    res.json(rows);
  } catch (e) {
    console.log(e);
    res.sendStatus(500);
  }
});

router.put("/user/:user_id", async (req, res) => {
  const userId = req.params.user_id;

  const user_admin = req.body.user_admin;
  const user_credit = req.body.user_credit;
  const user_email = req.body.user_email;
  const user_name = req.body.user_name;
  const user_phone = req.body.user_phone;
  const user_read = req.body.user_read;
  const user_write = req.body.user_write;
  const user_hash = "dumb_hash";

  let SQL_script = `
  UPDATE mydb.user 
  SET 
  user_name='${user_name}', 
  user_hash='${user_hash}', 
  user_credit='${user_credit}', 
  user_phone='${user_phone}', 
  user_email='${user_email}', 
  user_admin='${user_admin}', 
  user_read='${user_read}', 
  user_write='${user_write}'
  
  WHERE user_id=${userId};
  `;

  try {
    await connection.query(SQL_script);
    res.sendStatus(200);
  } catch (e) {
    res.sendStatus(500);
  }
});

router.delete("/user/:user_id", async (req, res) => {
  const userId = req.params.user_id;
  const SQL_script = `
  DELETE FROM mydb.user WHERE user_id=${userId};
  `;
  console.log("delete user ", userId);

  try {
    await connection.query(SQL_script);
    res.sendStatus(200);
  } catch (e) {
    res.sendStatus(500);
  }
});

export default router;
