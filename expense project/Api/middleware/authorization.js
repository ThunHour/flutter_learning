const jwt = require("jsonwebtoken");
require("dotenv").config();

module.exports = async (req, res, next) => {
  try {
    const jwtToken = req.get("Authorization");
    console.log(req.headers);
    if (!jwtToken) {
      return res.status().json({
        success: 0,
        message: "Invalid Token..."
      });
    }
    const payload = jwt.verify(jwtToken.slice(7), process.env.jwtSecret);
    req.users = payload.users;
    next();
  } catch (err) {
    return res.status(401).json({
      success: 0,
      message: "Access Denied! Unauthorized User",
    });
  }
};
