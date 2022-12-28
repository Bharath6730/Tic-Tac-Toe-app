import redis from "./../../redis"
import { customSocket } from "customSocket"
import { Server } from "socket.io"
import { userStatus } from "userGameData"
import { getGameData, setUserStatus } from "./../../utilities/redisHelpers"

export default async (io: Server, socket: customSocket) => {
    // Leave game Room
    const gameData = await getGameData(socket.gameRoom)

    // change user status for both the players
    // Destroy gameData on Redis
    await Promise.all([
        setUserStatus(gameData.player1.publicId, userStatus.online),
        setUserStatus(gameData.player2.publicId, userStatus.online),
        redis.del(gameData.gameRoom),
    ])

    socket.broadcast.to(gameData.gameRoom).emit("quit")
    io.in(gameData.gameRoom).socketsLeave(gameData.gameRoom)
    console.log(gameData)
}
