import crypto from "crypto"
import jwt from "jsonwebtoken"
import { v4 as uuidv4 } from "uuid"
import { Request, Response, NextFunction } from "express"

import User from "./../../models/userModel"
import pbkdf2Hash from "./../../utilities/hashPassword"
import catchAsync from "./../../utilities/catchAsync"

const signJWT = (id: string) =>
    new Promise((resolve, reject) => {
        jwt.sign(
            {
                id: id,
            },
            process.env.JWT_SECRET,
            (err: Error, token: string) => {
                if (err) reject(err)
                resolve(token)
            },
        )
    })

export const signUpUser = catchAsync(
    async (req: Request, res: Response, next: NextFunction) => {
        const password = req.body.password
        if (password === undefined || password.trim().length === 0) {
            //Need to do some password check
            return next(Error("Enter a Password"))
        }

        const salt = crypto.randomBytes(128).toString("hex")
        const hashedPassword = await pbkdf2Hash(password, salt)

        const user = await User.create({
            username: req.body.username,
            email: req.body.email,
            salt: salt,
            hash: hashedPassword,
            publicId: uuidv4(),
        })

        // Create and send Jwt token
        const token = await signJWT(user._id.toString())
        res.status(200).json({
            status: "success",
            message: "Successfully registered user",
            data: {
                username: user.username,
                publicId: user.publicId,
                email: user.email,
                profilePic: user.profilePic,
                token,
            },
        })
    },
)

export const signInUser = catchAsync(
    async (req: Request, res: Response, next: NextFunction) => {
        const emailOrUsername = req.body.emailOrUsername
        const user = await User.findOne({
            $or: [{ email: emailOrUsername }, { username: emailOrUsername }],
        })

        if (user === null) {
            return next(new Error("Invalid Email or Username"))
        }

        var hashedPassword = await pbkdf2Hash(req.body.password, user.salt)
        if (hashedPassword != user.hash) {
            return next(new Error("Incorrect Password"))
        }

        const token = await signJWT(user._id.toString())
        res.status(200).json({
            status: "success",
            message: "Successfully logged user",
            data: {
                username: user.username,
                publicId: user.publicId,
                email: user.email,
                profilePic: user.profilePic,
                token,
            },
        })
    },
)
