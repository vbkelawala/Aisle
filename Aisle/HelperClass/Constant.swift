//
//  Constant.swift
//  Aisle
//
//  Created by GVM on 20/06/22.
//

import Foundation
import MaterialComponents.MaterialSnackbar

struct ErrorMesssages {
    static let emptyPhoneNumber = "Please Enter Phone Number"
    static let wrong = "Something Went Wrong!"
    static let emptyOTP = "Please Enter OTP"
}

class SnackBar {
    static func show(strMessage: String, type: snackBarType) {
        let message = MDCSnackbarMessage()
        message.text = strMessage
        var color: UIColor = UIColor()
        if type == .positive {
            color = UIColor.init(red: 52/255.0, green: 147/255.0, blue: 129/255.0, alpha: 1.0)
        } else {
            color = UIColor.red
        }
        message.duration = 2.55
        MDCSnackbarManager.default.snackbarMessageViewBackgroundColor = color
        MDCSnackbarManager.default.show(message)
    }
}

