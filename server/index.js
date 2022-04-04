import express from "express";
import mysql from "mysql2/promise";

const main = async () => {
  const connection = await mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "my-secret-pw",
    database: "mydb",
  });

  const app = express();
  const port = 5000;

  app.get("/", async (req, res) => {
    res.send("Hello World!");
    try {
      const [rows, fields] = await connection.execute("select * from user");
      console.log(rows);
    } catch (e) {
      console.log(e, "error connect");
    }
  });

  app.post("/", (req, res) => {
    res.send("Got a POST request");
  });

  app.listen(port, () => {
    console.log(`Example app listening on port ${port}`);
  });
};

main();
