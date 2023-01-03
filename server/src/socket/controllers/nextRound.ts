import { customSocket } from "customSocket"
import { Server } from "socket.io"
import { WinnerType } from "./../../types/gametypes"
import { getGameData, setGameData } from "./../../utilities/redisHelpers"

export default async (io: Server, socket: customSocket) => {
    const gameData = await getGameData(socket.gameRoom)

    if (gameData.winner == WinnerType.None) {
        return socket.emit("InvalidMove", gameData)
    }

    console.log(socket.user.username)
    console.log("WhoseTurn : " + gameData.whoseTurn)
    console.log("nextRound : " + gameData.nextRoundOffer)
    if (gameData.nextRoundOffer === socket.user.publicId) return
    if (gameData.nextRoundOffer === "none") {
        gameData.nextRoundOffer = socket.user.publicId
    } else {
        gameData.nextRoundOffer = "none"
        gameData.reset()
        gameData.whoseTurn =
            gameData.whoStartedFirst == gameData.player1.publicId
                ? gameData.player2.publicId
                : gameData.player1.publicId
    }
    await setGameData(gameData)

    if (gameData.nextRoundOffer === "none") {
        console.log("Sending to room")
        io.to(gameData.gameRoom).emit("startNextRound", {
            whoseTurn: gameData.whoseTurn,
        })
    } else {
        console.log("Broadcasting to room")
        socket.broadcast.to(gameData.gameRoom).emit("nextRound")
    }
}
