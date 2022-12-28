import { customSocket } from "customSocket"
import { WinnerType } from "./../../types/gametypes"
import { getGameData, setGameData } from "./../../utilities/redisHelpers"

export default async (socket: customSocket) => {
    const gameData = await getGameData(socket.gameRoom)

    if (gameData.winner == WinnerType.None) {
        return socket.emit("InvalidMove", gameData)
    }

    gameData.reset()

    await setGameData(gameData)
    socket.broadcast.to(gameData.gameRoom).emit("nextRound")
}
