import { server } from "./../server"
import { Server as socketio } from "socket.io"
import { customSocket } from "customSocket"

import checkAuth from "./middlewares/checkAuth"
import initSocket from "./middlewares/initSocket"

const io = new socketio(server)

io.use(checkAuth)
io.use(initSocket)

io.on("connection", (socket: customSocket) => {
    // socket.data.user =
    console.log(socket.user)
    // console.log(socket.user.publicId)
    // console.log(socket.user.email)
    // var myPrivateRoom = io.sockets.adapter.rooms.get(socket.user.publicId)
    // console.log(myPrivateRoom.size)
})

export default io
