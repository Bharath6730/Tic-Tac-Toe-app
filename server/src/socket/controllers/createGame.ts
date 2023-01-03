import { v4 as uuidv4 } from "uuid"
import randomString from "random-string-generator"

import { userStatus } from "userGameData"
import { customSocket } from "customSocket"
import { setGameData, setUserStatus } from "./../../utilities/redisHelpers"
import Game from "../../models/gameModel"

export default async (socket: customSocket, data: any) => {
    let room: string
    if (data.shortLink) {
        room = randomString(6)
    } else {
        room = uuidv4()
    }
    // TODO Check if room already exists
    // const already = io.sockets.adapter.rooms.get(room)
    socket.join(room)
    socket.gameRoom = room

    const game = new Game(room, socket.user)

    await Promise.all([
        setUserStatus(socket.user.publicId, userStatus.playing, room),
        setGameData(game),
    ])
    socket.emit("gameCreated", { room: room })
}
