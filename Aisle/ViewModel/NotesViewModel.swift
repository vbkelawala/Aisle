//
//  NotesViewModel.swift
//  Aisle
//
//  Created by GVM on 18/06/22.
//

import Foundation
import SwiftyJSON

struct NoteViewModel {
    func sendOTPRequest(dicParam: [String:Any], completion: @escaping (_ isSuccess: Bool?,_ notes: Notes?) -> Void) {
        APIRoute.sharedInstance.getRequest(parameterDict: dicParam, URL: API.notes.URL) { dicResponse, isSuccess in
            if isSuccess == true {
                if let dic = dicResponse as? [String: Any], !dic.isEmpty {
                    completion(isSuccess,Notes(json: JSON(dic)))
                }
            }
        }
    }
}
