import { publicUserData } from "customSocket"
import { PlayerType, WinnerType } from "gametypes"

export default class Game {
    gameRoom: string
    player1: publicUserData
    player2: publicUserData
    p1Type: PlayerType
    p2Type: PlayerType
    whoseTurn: string
    winner: WinnerType = WinnerType.None
    totalGames: number = 0
    drawCount: number = 0
    player1WinCount: number = 0
    xList: Array<number> = []
    oList: Array<number> = []

    constructor(room: string, p1: publicUserData) {
        this.gameRoom = room
        this.player1 = p1
        this.whoseTurn = p1.publicId
        return this
    }

    checkWinner(currentPlayer: PlayerType): boolean {
        var winnerExists = false
        const winningPossibilities = [
            [1, 2, 3],
            [4, 5, 6],
            [7, 8, 9],
            [1, 4, 7],
            [2, 5, 8],
            [3, 6, 9],
            [1, 5, 9],
            [3, 5, 7],
        ]

        if (this.xList.length < 3 && this.oList.length < 3) return winnerExists

        const currentPlayerList = PlayerType.X ? this.xList : this.oList

        currentPlayerList.forEach((element) => {
            winningPossibilities.forEach((winningCase) => {
                var count = 0
                if (winningCase.includes(element)) {
                    count++
                }
                if (count === 3) {
                    winnerExists = true
                    this.winner =
                        currentPlayer == PlayerType.X
                            ? WinnerType.X
                            : WinnerType.O

                    this.incrementWinnerCount()
                    return winnerExists
                }
            })
        })

        if (this.xList.length + this.oList.length === 9) {
            winnerExists = true
            this.winner = WinnerType.draw
            this.incrementWinnerCount()
        }

        return winnerExists
    }

    incrementWinnerCount() {
        if (this.winner == WinnerType.None) return

        this.totalGames++
        if (this.winner === WinnerType.X) {
            if (this.p1Type === PlayerType.X) {
                this.player1WinCount++
            }
        } else if (this.winner == WinnerType.O) {
            if (this.p1Type === PlayerType.O) {
                this.player1WinCount++
            }
        } else {
            this.drawCount++
        }
        return
    }

    reset() {
        this.winner = WinnerType.None
        this.xList = []
        this.oList = []
    }
}
