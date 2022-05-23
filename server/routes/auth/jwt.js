import jwt from "jsonwebtoken";

const config = process.env;

const verifyToken = (req, res, next) => {
  //   console.log(req, res);
  const token = req.headers["x-access-token"];

  if (!token) {
    return res.status(403).json({
      status: "A token is required for authentication",
    });
  }
  try {
    const decoded = jwt.verify(token, config.SECRET_JWT);
    req.user = decoded;
  } catch (err) {
    return res.status(401).json({
      status: "Invalid Token",
    });
  }
  return next();
};

export default verifyToken;
