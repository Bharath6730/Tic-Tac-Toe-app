import { Socket } from "socket.io"

interface publicUserData {
    username: String
    profilePic: string
    publicId: string
}

interface customSocket extends Socket {
    user: publicUserData
    gameRoom?: string
}

export { customSocket, publicUserData }
