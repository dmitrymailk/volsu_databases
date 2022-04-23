import express from "express";
import cors from "cors";
import bodyParser from "body-parser";

import usersRouter from "./routes/users/index.js";
import productsRouter from "./routes/products/index.js";
import obligationsRouter from "./routes/obligation/index.js";
import billsRouter from "./routes/bill/index.js";
import experimentRouter from "./routes/experiment/index.js";

const main = async () => {
  const app = express();
  const port = 5000;

  app.use(cors());
  app.use(bodyParser.json());

  // api part
  app.use("/api/v1/users", usersRouter);
  app.use("/api/v1/products", productsRouter);
  app.use("/api/v1/obligations", obligationsRouter);
  app.use("/api/v1/bills", billsRouter);
  app.use("/api/experiment", experimentRouter);

  app.listen(port, () => {
    console.log(`Example app listening on port ${port}`);
  });
};

main();
