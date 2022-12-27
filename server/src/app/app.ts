import { app } from "./../server"

import User from "./../models/userModel"
import verifyToken from "./../utilities/verifyToken"

import authRouter from "./routes/authRoutes"
app.use("/", authRouter)

app.get("/", async (req, res, next) => {
    const token = await verifyToken(req.body.token)

    if (!token) {
        return next(new Error("Invalid Token!"))
    }

    const user = await User.findById(token.id)

    res.json({
        status: "Token Verifies",
        user,
    })
})

import { Request, Response, NextFunction, ErrorRequestHandler } from "express"
app.use(
    (
        err: ErrorRequestHandler,
        req: Request,
        res: Response,
        next: NextFunction,
    ) => {
        // TO DO Error handling
        console.error(err)
        res.status(500).json({
            status: "Error",
            err,
        })
    },
)

export default app
