export declare const enum userStatus {
    online = "online",
    playing = "playing",
    offline = "offline",
}
export interface userData {
    status: userStatus
    gameRoom?: string
}
