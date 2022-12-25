const crypto = require("crypto")

const pbkdf2Hash = (pass, salt) => {
    return new Promise((resolve, reject) => {
        crypto.pbkdf2(
            pass,
            salt,
            parseInt(process.env.HASH_ITERATIONS),
            parseInt(process.env.HASH_KEY_LENGTH),
            "sha512",
            (err, derivedKey) => {
                err ? reject(err) : resolve(derivedKey.toString("hex"))
            },
        )
    })
}

module.exports = pbkdf2Hash
