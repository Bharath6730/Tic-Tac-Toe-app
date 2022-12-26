const User = require("../../models/userModel")
const verifyToken = require("../../utilities/verifyToken")

module.exports = async (socket, next) => {
    var token = socket.handshake.auth.token
    if (token === undefined) {
        const err = new Error("Not Authorized")
        err.data = {
            message: "No Token Available",
        }
        return next(err)
    }

    token = await verifyToken(token)
    if (!token.valid) {
        const err = new Error("Not Authorized")
        err.data = {
            message: "Invalid Token",
        }
        return next(err)
    }
    const user = await User.findById(token.data.id)
    socket.user = user
    next()
}
