import mysql from "mysql2/promise";
const connection = await mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "my-secret-pw",
  database: "mydb",
});

export default connection;
