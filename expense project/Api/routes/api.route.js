const { PrismaClient } = require("@prisma/client");
const bcrypt = require("bcrypt");
const router = require("express").Router();
const prisma = new PrismaClient();
const jwtGenerator = require("../utils/jwtGenerator");
const authorization = require("../middleware/authorization");
const { v4: uuidv4 } = require("uuid");
const jwt = require("jsonwebtoken");
const jwt_decode = require("jwt-decode");
require("dotenv").config();
router.post("/signin", async (req, res, next) => {
  try {
    const { u_gmail, u_username, u_password } = req.body;
    // check user valid
    if (
      await prisma.User.findUnique({
        where: {
          u_gmail: u_gmail,
        },
      })
    ) {
      return res.status(401).send("user already exists");
    }
    const saltRound = 10;
    const salt = await bcrypt.genSalt(saltRound);
    const bcryptPassword = await bcrypt.hash(u_password, salt);
    req.body.u_password = bcryptPassword;
    req.body.u_id = uuidv4();
    req.body.u_role = "user";
    console.log(req.body.u_id);
    const insertUser = await prisma.User.create({ data: req.body });
    const token = jwtGenerator(insertUser.u_id);
    res.json({ token });
  } catch (error) {
    next(error);
  }
});
router.post("/login", async (req, res) => {
  try {
    const { u_gmail, u_password } = req.body;
    const user = await prisma.User.findUnique({
      where: {
        u_gmail: u_gmail,
      },
    });
    if ([user].length === 0) {
      return res.status(401).json("Password or Gmail does not incorrect...!!!");
    }
    const validPassword = await bcrypt.compare(
      req.body.u_password,
      user.u_password
    );
    if (!validPassword) {
      return res.status(401).json("Password incorrect");
    }
    const token = jwtGenerator(user.u_id);
    res.json({ token });
  } catch (error) {
    console.error(error.message);
    res.status(500).send("Server error");
  }
});
router.post("/checkUser", async (req, res, next) => {
  try {
    const expense = await prisma.User.findUnique({
      where: {
        u_gmail: req.body.u_gmail,
      },
    });
    if (expense === null) {
      res.json("user no exist");
    } else {
      res.status(200).json("User already exist");
    }
  } catch (error) {
    next(error);
  }
});
router.get("/expense", async (req, res, next) => {
  try {
    const token = req.get("authorization").slice(7);
    const decode = jwt_decode(token);
    var decodedJson = JSON.parse(JSON.stringify(decode));
    const expense = await prisma.Expense.findMany({
      where: {
        userId: decodedJson.users,
      },
    });
    res.status(200).json(expense);
  } catch (error) {
    next(error);
  }
});

router.post("/expense", authorization, async (req, res, next) => {
  try {
    const id = uuidv4();
    req.body.e_id = id;
    const token = req.get("authorization").slice(7);
    const decode = jwt_decode(token);
    var decodedJson = JSON.parse(JSON.stringify(decode));
    req.body.userId = decodedJson.users;
    const expense = await prisma.Expense.create({ data: req.body });
    res.status(200).json({ result: "Expense Inserted Successful" });
  } catch (error) {
    next(error);
  }
});

router.delete("/expense/:id", authorization, async (req, res, next) => {
  try {
    const { id } = req.params;
    const deleteExpense = await prisma.Expense.delete({
      where: {
        e_id: id,
      },
    });
    res.status(200).json({ result: "Expense Deleted Successful" });
  } catch (error) {
    next(error);
  }
});

router.patch("/expense/:id", authorization, async (req, res, next) => {
  try {
    const { id } = req.params;
    const expense = await prisma.Expense.update({
      where: {
        e_id:id,
      },
      data: req.body,
      
    });
    res.status(200).json({ result: "Expense Updated Successful" });
  } catch (error) {
    next(error);
  }
});

router.get("/user", authorization, async (req, res, next) => {
  try {
    const token = req.get("authorization").slice(7);
    const decode = jwt_decode(token);
    var decodedJson = JSON.parse(JSON.stringify(decode));
    const check = await prisma.User.findMany({
      // where:{
      //   u_id:decodedJson.users
      // },

      include: { u_expense: true, u_category: true },
    });

    res.json(check);
  } catch (error) {
    next(error);
  }
});
router.delete("/user/:id", authorization, async (req, res, next) => {
  try {
    const token = req.get("authorization").slice(7);
    const decode = jwt_decode(token);
    var decodedJson = JSON.parse(JSON.stringify(decode));
    const check = await prisma.User.delete({
      where: {
        u_id: decodedJson.users,
      },
    });
    res.json(check);
  } catch (error) {
    next(error);
  }
});

router.post("/category", authorization, async (req, res, next) => {
  try {
    const token = req.get("Authorization").slice(7);
    const decode = jwt_decode(token);
    var decodedJson = JSON.parse(JSON.stringify(decode));
    req.body.userId = decodedJson.users;
    const id = uuidv4();
    req.body.c_id = id;
    const expense = await prisma.Category.create({ data: req.body });
    res.status(200).json({ result: "Category Inserted Successful" });
  } catch (error) {
    next(error);
  }
});

router.delete("/category/:id", authorization, async (req, res, next) => {
  try {
    const { id } = req.params;
    const deleteExpense = await prisma.Category.delete({
      where: {
        c_id: id,
      },
    });
    res.status(200).json({ result: "Category Deleted Successful" });
  } catch (error) {
    next(error);
  }
});
router.get("/category/:id", authorization, async (req, res, next) => {
  try {
    const { id } = req.params;
    const deleteExpense = await prisma.Category.findUnique({
      where: {
        e_id: id,
      },
    });
    res.status(200).json(deleteExpense);
  } catch (error) {
    next(error);
  }
});
router.get("/category", authorization, async (req, res, next) => {
  try {
    const token = req.get("authorization").slice(7);
    const decode = jwt_decode(token);
    var decodedJson = JSON.parse(JSON.stringify(decode));
    const getAllCategory = await prisma.Category.findMany({
      where:{
        userId:decodedJson.users
      }
    });
    res.status(200).json(getAllCategory);
  } catch (error) {
    next(error);
  }
});

router.patch("/category/:id", authorization, async (req, res, next) => {
  try {
    const { id } = req.params;
    const { c_title, c_color } = req.body;
    const expense = await prisma.Category.update({
      where: {
        c_id: id,
      },
      data: {
        c_title,
        c_color,
      },
      include: { user: true },
    });
    res.status(200).json({ result: "Category Updated Successful" });
  } catch (error) {
    next(error);
  }
});
module.exports = router;
