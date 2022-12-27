import jwt, { JwtPayload } from "jsonwebtoken"


function Promisify(token: string) {
    return new Promise((resolve, reject) => {
        jwt.verify(token, process.env.JWT_SECRET, (err, data) => {
            if (err) return reject()
            resolve(data)
        })
    })
}

export default async  (token: string) =>{
    let decodedToken: string | JwtPayload
    try {
        decodedToken = await Promisify(token)
    } catch (err) {
        return null
    }
    return decodedToken
}