const io = require("./../server").io

const checkAuth = require("./middlewares/checkAuth")
const initSocket = require("./middlewares/initSocket")
io.use(checkAuth)
io.use(initSocket)

io.on("connection", (socket) => {
    console.log(socket.user.username)
    console.log(socket.user.publicId)
    console.log(socket.user.email)

    var myPrivateRoom = io.sockets.adapter.rooms.get(socket.user.publicId)
    console.log(myPrivateRoom.size)
})

module.exports = io
