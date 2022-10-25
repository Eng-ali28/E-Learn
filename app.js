//core module

//third-party module
import express, { json, urlencoded } from "express";
import createError from "http-errors";

import morgan from "morgan";
import { config } from "dotenv";
config();

const app = express();
app.use(json());
app.use(urlencoded({ extended: false }));
app.use(morgan("dev"));

// routes section

import routeMount from "./routes/index.js";
routeMount(app);

app.use((req, res, next) => {
  next(createError.NotFound());
});

app.use((err, req, res, next) => {
  res.status(err.status || 500);
  res.json({
    statusCode: err.statusCode || 500,
    status: err.statusCode >= 400 ? "falid" : "success",
    message: err.message,
    stack: err.stack,
  });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`🚀 @ http://localhost:${PORT}`));
