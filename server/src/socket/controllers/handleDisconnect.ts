import { customSocket } from "customSocket"
import { getUserStatus, setUserStatus } from "./../../utilities/redisHelpers"
import { userData, userStatus } from "userGameData"
import { Server } from "socket.io"

export default async (io: Server, socket: customSocket) => {
    const userData: userData = await getUserStatus(socket.user.publicId)

    if (userData.status === userStatus.playing) {
        io.to(userData.gameRoom).emit("playerLeft")
    }

    // TODO Set user offline and inform all friends
    await setUserStatus(socket.user.publicId, userStatus.offline)
}
