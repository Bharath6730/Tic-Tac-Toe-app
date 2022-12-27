declare global {
    namespace NodeJS {
        interface ProcessEnv {
            NODE_ENV: "development" | "production"
            PORT: string
            DATABASE_URL: string
            DATABASE_PASSWORD: string
            REDIS_HOST_URL: string
            REDIS_PORT: string
            REDIS_PASSWORD: string
        }
    }
}

export {}
