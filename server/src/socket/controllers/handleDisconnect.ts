import { customSocket } from "customSocket"
import {
    getGameData,
    getUserStatus,
    setUserStatus,
} from "./../../utilities/redisHelpers"
import { userData, userStatus } from "userGameData"
import { Server } from "socket.io"
import redis from "./../../redis"

export default async (io: Server, socket: customSocket) => {
    const userData: userData = await getUserStatus(socket.user.publicId)
    
    
    if (userData.status === userStatus.playing) {
        let gameData = await getGameData(userData.gameRoom)
        if (!gameData.flaggedToDelete) {
            gameData.flaggedToDelete = true

            io.to(userData.gameRoom).emit("playerLeft")
        } else {
            await redis.del(`game:${gameData.gameRoom}`)
        }
    }

    // TODO Set user offline and inform all friends
    await setUserStatus(socket.user.publicId, userStatus.offline)
    console.log(socket.user.username + "  Disconnected")
}
