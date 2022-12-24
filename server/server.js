const express = require("express")
const app = express()

const dotenv = require("dotenv")
dotenv.config({ path: "./config.env" })


const server = app.listen(3000 | process.env.PORT, () => {
    console.log("Server successfully running!")
})

const socketio = require("socket.io")
const io = socketio(server)

module.exports = {
    app,
    io,
}
