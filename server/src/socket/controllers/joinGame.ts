import { customSocket } from "customSocket"
import { Server } from "socket.io"
import {
    getGameData,
    setGameData,
    setUserStatus,
} from "./../../utilities/redisHelpers"
import { userStatus } from "userGameData"

export default async function joinGame(
    socket: customSocket,
    io: Server,
    data: any,
) {
    const room = data.room
    if (!room) {
        return socket.emit("gameError", { data: "Invalid room code!" })
    }
    if (io.sockets.adapter.rooms.get(room) == undefined) {
        return socket.emit("gameError", { data: "Invalid room code!" })
    }
    if (io.sockets.adapter.rooms.get(room).size >= 2) {
        return socket.emit("gameError", { data: "Room Full" })
    }
    socket.join(room)
    socket.gameRoom = room

    const [_, gameData] = await Promise.all([
        setUserStatus(socket.user.publicId, userStatus.playing, room),
        getGameData(room),
    ])

    console.log("Player1Data" + gameData.player1.username)
    gameData.player2 = socket.user
    await setGameData(gameData)

    io.to(room).emit("startGame", gameData)
}
