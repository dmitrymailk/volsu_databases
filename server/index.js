import express from "express";
import usersRouter from "./routes/users/index.js";

const main = async () => {
  const app = express();
  const port = 5000;

  app.get("/", async (req, res) => {
    res.send("Hello World!");
  });

  app.listen(port, () => {
    console.log(`Example app listening on port ${port}`);
  });

  // api part
  app.use("/api/v1/users", usersRouter);
};

main();
