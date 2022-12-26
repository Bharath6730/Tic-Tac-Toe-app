const jwt = require("jsonwebtoken")

module.exports = (token) => {
    const decodedToken = {
        valid: false,
    }
    return new Promise((resolve, reject) => {
        jwt.verify(token, process.env.JWT_SECRET, (err, data) => {
            if (err) return resolve(decodedToken)
            decodedToken.valid = true
            decodedToken.data = data
            resolve(decodedToken)
        })
    })
}
