const jwt = require("jsonwebtoken")

module.exports = (token) => {
    try {
        const data = jwt.verify(token, process.env.JWT_SECRET)
        return {
            valid: true,
            data,
        }
    } catch (err) {
        return {
            valid: false,
        }
    }
}
