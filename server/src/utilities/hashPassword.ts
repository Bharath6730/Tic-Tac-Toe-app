import crypto from "crypto"

const pbkdf2Hash = (pass: string, salt: string) => {
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

export default pbkdf2Hash
