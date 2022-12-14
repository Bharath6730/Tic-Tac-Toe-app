import { customSocket } from "customSocket"
import { PlayerType } from "./../../types/gametypes"
import io from "../socket"
import { getGameData, setGameData } from "./../../utilities/redisHelpers"

export default async (socket: customSocket, data: any) => {
    const move: number = data.move
    if (!(move >= 1 && move <= 9)) {
        return socket.emit("invalidMove")
    }
    const gameData = await getGameData(socket.gameRoom)
    if (gameData.whoseTurn != socket.user.publicId) {
        return socket.emit("invalidMove", gameData)
    }

    // Change Game Data
    const amIPlayer1 = gameData.player1.publicId === socket.user.publicId
    const myType = amIPlayer1 ? gameData.p1Type : gameData.p2Type

    if (gameData.xList.length === 0 && gameData.oList.length === 0) {
        gameData.whoStartedFirst = gameData.whoseTurn
    }
    if (myType == PlayerType.X) {
        gameData.xList.push(move)
    } else {
        gameData.oList.push(move)
    }
    // Check Winner
    const winner = gameData.checkWinner(myType)

    // Change whoseTurn and save gameData
    if (winner) {
        gameData.whoseTurn = "none"
    } else {
        gameData.whoseTurn = amIPlayer1
            ? gameData.player2.publicId
            : gameData.player1.publicId
    }
    await setGameData(gameData)

    if (winner) {
        let gameCopy: any = { ...gameData }
        gameCopy.move = move
        io.to(gameData.gameRoom).emit("winner", gameCopy)
    } else {
        const newMove = {
            move,
        }
        socket.broadcast.to(gameData.gameRoom).emit("game", newMove)
    }
}
