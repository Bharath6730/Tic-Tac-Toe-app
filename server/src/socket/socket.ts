import { server } from "./../server"
import { Server as socketio } from "socket.io"
import { customSocket } from "customSocket"

const io = new socketio(server)

import checkAuth from "./middlewares/checkAuth"
import initSocket from "./middlewares/initSocket"
io.use(checkAuth)
io.use(initSocket)

import createGame from "./controllers/createGame"
import joinGame from "./controllers/joinGame"
import gameController from "./controllers/gameController"
import nextRound from "./controllers/nextRound"
import quitGame from "./controllers/quitGame"
import handleDisconnect from "./controllers/handleDisconnect"

io.on("connection", async (socket: customSocket) => {
    console.log(socket.user)
    // var myPrivateRoom = io.sockets.adapter.rooms.get(socket.user.publicId)
    // console.log(myPrivateRoom.size)
    socket.on("createGame", (data) => createGame(socket, data))
    socket.on("joinGame", (data) => joinGame(socket, io, data))
    socket.on("game", (data) => gameController(socket, data))
    socket.on("nextRound", (_) => nextRound(io,socket))
    socket.on("quit", (_) => quitGame(io, socket))
    socket.on("disconnecting", (_) => handleDisconnect(io, socket))
})

export default io
