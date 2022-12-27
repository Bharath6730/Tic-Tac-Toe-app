import express from "express"
const app = express()
app.use(express.json())

import dotenv from "dotenv"
dotenv.config({ path: "./config.env" })

// Connect Database
import mongoose from "mongoose"
const DB = process.env.DATABASE_URL.replace(
    "<password>",
    process.env.DATABASE_PASSWORD,
)
mongoose.connect(DB).then(() => {
    console.log("Database connection Established")
})

const server = app.listen(process.env.PORT, () => {
    console.log("Server successfully running!")
})

export { app, server }
