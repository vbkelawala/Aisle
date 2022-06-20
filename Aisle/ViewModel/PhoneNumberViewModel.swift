//
//  PhoneNumberViewModel.swift
//  Aisle
//
//  Created by GVM on 18/06/22.
//

import Foundation

struct PhoneNumberViewModel {
    func sendOTPRequest(dicParam: [String:Any], completion: @escaping (_ isSuccess: Bool?) -> Void) {
        APIRoute.sharedInstance.postRequest(parameterDict: dicParam, URL: API.phoneNumberLogin.URL) { (dicResponse, error, code, message) in
            if dicResponse != nil, let dic = dicResponse {
                if let flag = dic["status"] as? Bool {
                    completion(flag)
                }
            }
        }
    }
}
