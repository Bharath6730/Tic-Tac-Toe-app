const app = require("./../server").app

const User = require("../models/userModel")
const verifyToken = require("../utilities/verifyToken")
const authRouter = require("./routes/authRoutes")
app.use("/", authRouter)

app.get("/", async (req, res, next) => {
    const token = await verifyToken(req.body.token)

    if (!token.valid) {
        return next(new Error("Invalid Token!"))
    }

    const user = await User.findById(token.data.id)

    res.json({
        status: "Token Verifies",
        user,
    })
})

app.use((err, req, res, next) => {
    // TO DO Error handling
    console.error(err)
    res.status(500).json({
        status: "Error",
        err,
    })
})

module.exports = app
