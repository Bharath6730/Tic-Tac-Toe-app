import { customSocket } from "customSocket"
import { userData, userStatus } from "./../../types/userGameData"
import redis from "./../../redis"
import { setUserStatus } from "./../../utilities/redisHelpers"

export default async (socket: customSocket, next: any) => {
    // Set socket as online
    await setUserStatus(socket.user.publicId, userStatus.online)

    // Join publicId room
    socket.join(socket.user.publicId)

    // TODO Inform all friends that socket is online

    next()
}
