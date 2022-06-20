//
//  AppPrefsManager.swift
//  Aisle
//
//  Created by GVM on 18/06/22.
//

import Foundation

import CoreLocation
// swiftlint:disable all
//MARK:- Used for storing some data in UserDefaults.
class AppPrefsManager: NSObject {

    static let sharedInstance = AppPrefsManager()
    let AUTHTOKEN = "AUTHTOKEN"
    func setDataToPreference(data: AnyObject, forKey key: String) {
        do {
            var archivedData = Data()
            if #available(iOS 11.0, *) {
                archivedData = try NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: true)
            } else {
                archivedData = NSKeyedArchiver.archivedData(withRootObject: data)
            }
            UserDefaults.standard.set(archivedData, forKey: key)
            UserDefaults.standard.synchronize()
        }
        catch {
            print("Unexpected error: \(error).")
        }
    }
    
    func getDataFromPreference(key: String) -> AnyObject? {
        let archivedData = UserDefaults.standard.object(forKey: key)
        if(archivedData != nil) {
            do {
                var unArchivedData: Any?
                if #available(iOS 11.0, *) {
                    unArchivedData =  try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(archivedData as! Data) as AnyObject
                } else {
                    unArchivedData = NSKeyedUnarchiver.unarchiveObject(with: archivedData as! Data) as AnyObject
                }
                return unArchivedData as AnyObject
            } catch {
                print("Unexpected error: \(error).")
            }
        }
        return nil
    }
    
    func removeDataFromPreference(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    func isKeyExistInPreference(key: String) -> Bool {
        if(UserDefaults.standard.object(forKey: key) == nil) {
            return false
        }
        return true
    }

    func setAuthToken(obj: String) {
        setDataToPreference(data: obj as AnyObject, forKey: AUTHTOKEN)
    }

    func getAuthToken() -> String? {
        let strToken = getDataFromPreference(key: AUTHTOKEN)
        return strToken as? String
    }
}
