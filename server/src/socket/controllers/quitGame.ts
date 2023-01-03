import redis from "./../../redis"
import { customSocket } from "customSocket"
import { Server } from "socket.io"
import { userStatus } from "userGameData"
import {
    getGameData,
    setGameData,
    setUserStatus,
} from "./../../utilities/redisHelpers"

export default async (io: Server, socket: customSocket) => {
    // Leave game Room
    const gameData = await getGameData(socket.gameRoom)
    socket.gameRoom = undefined

    if (gameData.flaggedToDelete) {
        await Promise.all([
            setUserStatus(socket.user.publicId, userStatus.online),
            redis.del(`game:${gameData.gameRoom}`),
        ])
    } else {
        await Promise.all([
            gameData.player1?.publicId !== undefined
                ? setUserStatus(gameData.player1.publicId, userStatus.online)
                : Promise.resolve(),
            gameData.player2?.publicId !== undefined
                ? setUserStatus(gameData.player2.publicId, userStatus.online)
                : Promise.resolve(),
            redis.del(`game:${gameData.gameRoom}`),
        ])
    }

    socket.broadcast.to(gameData.gameRoom).emit("quit")
    io.in(gameData.gameRoom).socketsLeave(gameData.gameRoom)
}
// gameData.flaggedToDelete = gameData.flaggedToDelete ? false : true

// console.log(gameData.flaggedToDelete + "Flag")

// change user status for both the players
// Destroy gameData on Redis
// await Promise.all([
//     setUserStatus(socket.user.publicId, userStatus.online),
//     !gameData.flaggedToDelete
//         ? redis.del(`game:${gameData.gameRoom}`)
//         : setGameData(gameData),
// ])
// if (!gameData.flaggedToDelete) return
// await Promise.all([
//     setUserStatus(socket.user.publicId, userStatus.online),
//     !gameData.flaggedToDelete
//         ? redis.del(`game:${gameData.gameRoom}`)
//         : setGameData(gameData),
// ])
