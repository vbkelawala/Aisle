//
//  APIRoute.swift
//  Aisle
//
//  Created by GVM on 18/06/22.
//

import Foundation
import Alamofire

enum API: String {
    static let BaseURL = "https://testa2.aisle.co/V1"
    case phoneNumberLogin = "/users/phone_number_login"
    case verifyOTP = "/users/verify_otp"
    case notes = "/users/test_profile_list"
    var URL : String {
        get{
            return API.BaseURL + self.rawValue
        }
    }

    var getURL: String {
        get {
            return API.BaseURL + self.rawValue
        }
    }
}

class APIRoute: NSObject {
    var headers: HTTPHeaders = [:]

    static let sharedInstance : APIRoute = {
        let instance = APIRoute()
        return instance
    }()

    let reachablity = NetworkReachabilityManager()

    var isConnectedToInternet: Bool {
        if let isNetworkReachable = self.reachablity?.isReachable,
            isNetworkReachable == true {
            return true
        } else {
            return false
        }
    }

    func postRequest(parameterDict: [String: Any], URL aUrl: String,
                     block: @escaping (NSDictionary?, NSError?,Int?,String?) -> Void) {
        if !self.isConnectedToInternet {
            SnackBar.show(strMessage: "No Internet Connection", type: .negative)
            return
        }

        let url = URL(string: aUrl)!
        print("url----\(aUrl)")
        print("param---\(parameterDict)" )
        let jsonData = try? JSONSerialization.data(withJSONObject: parameterDict, options: JSONSerialization.WritingOptions())
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        request.headers = headers
        AF.request(request).responseJSON { (response) in
            switch response.result {
            case .success:
                do {
                    if let result = response.data {
                        do {
                            let decoded = try JSONSerialization.jsonObject(with: result, options: [])
                            // here "decoded" is of type `Any`, decoded from JSON data

                            // you can now cast it with the right type
                            if let dictFromJSON = decoded as? NSDictionary {
                                block(dictFromJSON, nil, nil, nil)
                            } else {
                                SnackBar.show(strMessage: ErrorMesssages.wrong, type: .negative)
                            }
                        } catch {
                            SnackBar.show(strMessage: "\(error.localizedDescription)", type: .negative)
                        }
                    }
                }
                break
            case .failure( _):
                if !self.isConnectedToInternet {
                    SnackBar.show(strMessage: "Network connection was lost.Please try again.", type: .negative)
                    return
                }
            }
        }
    }

    func getRequest(parameterDict:[String : Any], URL aUrl: String, block: @escaping (NSDictionary?, Bool?) -> Void) {
        if !self.isConnectedToInternet {
            SnackBar.show(strMessage: "No Internet Connection", type: .negative)
            return
        }
        guard let token = AppPrefsManager.sharedInstance.getAuthToken() else {
            return
        }
        headers = [
            "Content-Type": "application/json",
            "Authorization": token
        ]

        AF.request(aUrl, method: HTTPMethod.get, parameters: parameterDict, encoding: URLEncoding.default, headers: headers, interceptor: nil, requestModifier: nil).responseJSON { (response) in
            switch response.result {
            case .success:
                do {
                    if let result = response.data {
                        do {
                            let decoded = try JSONSerialization.jsonObject(with: result, options: [])
                            if let dictFromJSON = decoded as? NSDictionary {
                                block(dictFromJSON,true)
                            } else {
                                SnackBar.show(strMessage: ErrorMesssages.wrong, type: .negative)
                            }
                        } catch {
                            SnackBar.show(strMessage: "\(error.localizedDescription)", type: .negative)
                        }
                    }
                }
                break
            case .failure(let error):
                print(error)
                if !self.isConnectedToInternet {
                    SnackBar.show(strMessage: "Network connection was lost.Please try again.", type: .negative)
                    return
                } else {

                }
//                SnackBar.show(strMessage: "from api response-- \(error.localizedDescription)", type: .nagative)

            }
        }
    }
}

extension URL {
    /// Creates an NSURL with url-encoded parameters.
    init?(string : String, parameters : [String : String]) {
        guard var components = URLComponents(string: string) else { return nil }

        components.queryItems = parameters.map { return URLQueryItem(name: $0, value: $1) }

        guard let url = components.url else { return nil }

        // Kinda redundant, but we need to call init.
        self.init(string: url.absoluteString)
    }
}

extension Encodable {
    subscript(key: String) -> Any? {
        return dictionary[key]
    }
    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any] ?? [:]
    }
}
