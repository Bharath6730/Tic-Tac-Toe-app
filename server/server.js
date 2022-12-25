const express = require("express")
const app = express()
app.use(express.json())

const dotenv = require("dotenv")
dotenv.config({ path: "./config.env" })

// Connect Database
const mongoose = require("mongoose")
const DB = process.env.DATABASE.replace(
    "<password>",
    process.env.DATABASE_PASSWORD,
)
mongoose.connect(DB, { useNewUrlParser: true }).then(() => {
    console.log("Database connection Established")
})

const server = app.listen(3000 | process.env.PORT, () => {
    console.log("Server successfully running!")
})

const socketio = require("socket.io")
const io = socketio(server)

module.exports = {
    app,
    io,
}
