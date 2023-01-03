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
        return socket.emit("invalidRoom", { message: "Invalid room code!" })
    }
    if (io.sockets.adapter.rooms.get(room) == undefined) {
        return socket.emit("invalidRoom", { message: "Invalid room code!" })
    }
    if (io.sockets.adapter.rooms.get(room).size >= 2) {
        return socket.emit("invalidRoom", { message: "Room Full" })
    }

    let gameData = await getGameData(room)

    if (gameData.player2 === undefined) {
        //Player 2  Joins at start
        let player2 = gameData.player2
        gameData.player2 = socket.user
    } else {
        if (
            !(
                socket.user.publicId === gameData.player1.publicId ||
                socket.user.publicId === gameData.player2.publicId
            )
        )
            return socket.emit("invalidRoom", { message: "Room Reserved!" })
    }

    socket.join(room)
    socket.gameRoom = room

    await Promise.all([
        setUserStatus(socket.user.publicId, userStatus.playing, room),
        setGameData(gameData),
    ])

    io.to(room).emit("startGame", gameData)
}
