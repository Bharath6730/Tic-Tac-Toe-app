const cryto = require("crypto")
const { v4: uuidv4 } = require("uuid")
const User = require("./../../models/userModel")
const pbkdf2Hash = require("../../utilities/hashPassword")
const catchAsync = require("./../../utilities/catchAsync")
const jwt = require("jsonwebtoken")

const createAndSendToken = (user, res, message) => {
    const token = jwt.sign(
        {
            id: user._id,
        },
        process.env.JWT_SECRET,
    )

    res.status(200).json({
        status: "success",
        message: message,
        data: {
            username: user.username,
            publicId: user.pubId,
            email: user.email,
            profilePic: user.profilePic,
            token,
        },
    })
}

exports.signUpUser = catchAsync(async (req, res, next) => {
    const password = req.body.password
    if (password === undefined || password.trim().length === 0) {
        //Need to do some password check
        return next(Error("Enter a Password"))
    }

    const salt = cryto.randomBytes(128).toString("hex")
    const hashedPassword = await pbkdf2Hash(password, salt)

    const user = await User.create({
        username: req.body.username,
        email: req.body.email,
        salt: salt,
        hash: hashedPassword,
        publicId: uuidv4(),
    })

    // Create and send Jwt token
    createAndSendToken(user, res, "Successfully registered user")
})
exports.signInUser = catchAsync(async (req, res, next) => {
    const emailOrUsername = req.body.emailOrUsername
    const user = await User.findOne({
        $or: [{ email: emailOrUsername }, { username: emailOrUsername }],
    })

    if (user === null) {
        return next(new Error("Invalid Email or Username"))
    }

    var hashedPassword = await pbkdf2Hash(req.body.password, user.salt)
    console.log(hashedPassword)
    console.log(user.hash)
    if (hashedPassword != user.hash) {
        return next(new Error("Incorrect Password"))
    }

    createAndSendToken(user, res, "Successfully logged in")
})
