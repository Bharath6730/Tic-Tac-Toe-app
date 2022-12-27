import Redis from "ioredis"

const redis = new Redis({
    host: process.env.REDIS_HOST_URL,
    password: process.env.REDIS_PASSWORD,
    connectTimeout: 10000,
    port: Number(process.env.REDIS_PORT),
})

export default redis
