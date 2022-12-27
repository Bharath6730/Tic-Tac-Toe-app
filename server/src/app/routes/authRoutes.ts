import { Router } from "express"
import { signInUser, signUpUser } from "./../controllers/authController"
const router = Router({ caseSensitive: true })

router.route("/signup").post(signUpUser)
router.route("/login").post(signInUser)

export default router
