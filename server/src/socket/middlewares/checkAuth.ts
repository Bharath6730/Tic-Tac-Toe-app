import { customSocket, publicUserData } from "customSocket"

import User from "./../../models/userModel"
import verifyToken from "./../../utilities/verifyToken"

function convertToPublicUserData(json: any): publicUserData {
    return {
        username: json.username,
        publicId: json.publicId,
        profilePic: json.profilePic,
    }
}

export default async (socket: customSocket, next: any) => {
    var token = socket.handshake.auth.token
    if (token === undefined) {
        const err = new Error("Not Authorized")
        // err.data = "asd"
        // err.showToUser = true
        return next(err)
    }

    token = await verifyToken(token)
    if (!token) {
        const err = new Error("Not Authorized")
        // err.data = {
        //     message: "Invalid Token",
        // }
        return next(err)
    }
    const user = await User.findById(token.id)
    socket.user = convertToPublicUserData(user)
    next()
}
