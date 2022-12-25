const io = require("./../server").io


io.on("connection", (socket) => {
    console.log(socket)
})

module.exports = io
