import "dotenv/config";

import express from "express";
import cors from "cors";
import bodyParser from "body-parser";

import usersRouter from "./routes/users/index.js";
import productsRouter from "./routes/products/index.js";
import obligationsRouter from "./routes/obligation/index.js";
import billsRouter from "./routes/bill/index.js";
import experimentRouter from "./routes/experiment/index.js";

import login from "./routes/auth/login.js";
import register from "./routes/auth/register.js";

import { verifyToken, isAdmin } from "./routes/auth/jwt.js";

const main = async () => {
  const app = express();
  const port = 5000;

  app.use(cors());
  app.use(bodyParser.json());
  // app.use(verifyToken);
  // api part
  app.use("/api/v1/users", verifyToken, isAdmin, usersRouter);
  app.use("/api/v1/products", verifyToken, productsRouter);
  app.use("/api/v1/obligations", verifyToken, obligationsRouter);
  app.use("/api/v1/bills", verifyToken, billsRouter);
  app.use("/api/v1/experiment", verifyToken, experimentRouter);

  app.use("/api/v1/", login);
  app.use("/api/v1/", register);

  app.listen(port, () => {
    console.log(`Example app listening on port ${port}`);
  });
};

main();
