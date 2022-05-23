import jwt from "jsonwebtoken";
import connection from "../../database/index.js";

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

const isAdmin = async (req, res, next) => {
  try {
    const { user_id, user_email } = req.user;
    const SQL_script = `
		select * from user where user_id=${user_id};
		`;
    let result = await connection.execute(SQL_script);
    let user = result[0][0];
    if (!user) {
      return res.status(409).json({
        status: "User doesn't Exist. Please Register",
      });
    }

    if (user.user_admin !== 1) {
      return res.status(403).json({
        status: "Forbidden. Access denied.",
      });
    }

    return next();
  } catch (e) {
    console.error(e);
  }
};

// export default verifyToken;
export { verifyToken, isAdmin };
