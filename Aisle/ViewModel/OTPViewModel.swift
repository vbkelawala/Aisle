//
//  OTPViewModel.swift
//  Aisle
//
//  Created by GVM on 18/06/22.
//

import Foundation

struct OTPViewModel {
    func verifyOTPRequest(dicParam: [String:Any], completion: @escaping (_ isSuccess: Bool?) -> Void) {
        APIRoute.sharedInstance.postRequest(parameterDict: dicParam, URL: API.verifyOTP.URL) { (dicResponse, error, code, message) in
            if dicResponse != nil, let dic = dicResponse {
                if let flag = dic["token"] as? String {
                    AppPrefsManager.sharedInstance.setAuthToken(obj: flag)
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
}
