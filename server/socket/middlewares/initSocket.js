const redis = require("../../redis")

module.exports = async (socket, next) => {
    // Set socket as online
    const userData = {
        connected: "online",
    }
    await redis.hmset(`user:${socket.user.publicId}`, userData)
    
    // Join publicId room
    socket.join(socket.user.publicId)

    // TODO Inform all friends that socket is online

    next()
}
