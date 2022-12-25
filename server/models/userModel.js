const mongoose = require("mongoose")
const Validator = require("validator")

const userSchema = mongoose.Schema(
    {
        username: {
            type: String,
            required: true,
            min: [4, "Name must atleast contain 4 charcaters"],
            max: [20, "Name can only contain 20 charcaters"],
            unique: true,
            trim: true,
            validate: {
                validator: function (name) {
                    // Allow only Alphabets,Numbers,Undersores and space
                    return /^[a-z0-9-_\s]+$/i.test(name)
                },
                message: `Username can contain only alphabets,numbers , whitespace and underscores`,
            },
        },
        email: {
            type: String,
            unique: true,
            trim: true,
            lowercase: true,
            required: true,
            validate: [Validator.isEmail, "Please enter a valide Email!"],
        },
        publicId: {
            type: String,
            unique: true,
            required: true,
        },
        profilePic: {
            type: String,
            default:
                "https://res.cloudinary.com/dciwowqk7/image/upload/v1660972618/user/default-profile-pic.jpg",
        },
        hash: {
            type: String,
            required: true,
        },
        salt: {
            type: String,
            required: true,
        },
    },
    { timestamps: true },
)

userSchema.pre("save", function (next) {
    console.log(this)
    next()
})

const User = mongoose.model("User", userSchema)
module.exports = User
