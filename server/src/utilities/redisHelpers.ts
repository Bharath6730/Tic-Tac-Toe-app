import redis from "./../redis"
import { userData, userStatus } from "userGameData"
import Game from "../models/gameModel"

export async function setUserStatus(
    publicId: string,
    userStatus: userStatus,
    gameRoom?: string,
) {
    const userData: userData = {
        status: userStatus,
        gameRoom: gameRoom,
    }
    const userDataString = JSON.stringify(userData)
    await redis.set(`user:${publicId}`, userDataString)
    return
}

export async function getUserStatus(publicId: string) {
    const userDataString = await redis.get(`user:${publicId}`)
    const userData: userData = JSON.parse(userDataString)
    return userData
}

export async function getGameData(room: string) {
    const gameString = await redis.get(`game:${room}`)
    const game: Game = Game.fromJson(JSON.parse(gameString))
    return game
}

export async function setGameData(game: Game) {
    const gameString = JSON.stringify(game)
    await redis.set(`game:${game.gameRoom}`, gameString)
    return
}
