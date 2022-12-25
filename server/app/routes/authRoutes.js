const express = require("express")
const authController = require("../controllers/authController")
const router = express.Router({ caseSensitive: true })

router.route("/signup").post(authController.signUpUser)
router.route("/login").post(authController.signInUser)

module.exports = router
