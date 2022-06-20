//
//  Notes.swift
//  Aisle
//
//  Created by GVM on 18/06/22.
//

import Foundation
import SwiftyJSON

public final class Notes: NSObject, NSCoding {
    
    private struct SerializationKeys {
        static let invites   = "invites"
        static let likes  = "likes"
    }
    
    public var invites: [String : Any]?
    public var likes: Likes?
    
    // MARK: SwiftyJSON Initializers
    /// Initiates the instance based on the object.
    ///
    /// - parameter object: The object of either Dictionary or Array kind that was passed.
    /// - returns: An initialized instance of the class.
    public convenience init(object: Any) {
        self.init(json: JSON(object))
    }

    /// Initiates the instance based on the JSON that was passed.
    ///
    /// - parameter json: JSON object from SwiftyJSON.
    public required init(json: JSON) {
        likes = Likes(json: json[SerializationKeys.likes])
        invites = json[SerializationKeys.invites].dictionaryObject
    }

    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary[SerializationKeys.likes] = likes
        dictionary[SerializationKeys.invites] = invites
        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.invites = aDecoder.decodeObject(forKey: SerializationKeys.invites) as? [String: Any]
        self.likes = aDecoder.decodeObject(forKey: SerializationKeys.likes) as? Likes
    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(likes, forKey: SerializationKeys.likes)
        aCoder.encode(invites, forKey: SerializationKeys.invites)
    }
}

@objc
public final class Likes: NSObject,NSCoding{

    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let profiles = "profiles"
        static let canSeeProfile = "can_see_profile"
        static let likeReceived = "likes_received_count"
    }

    // MARK: Properties
    public var profiles: [Profiles]?
    public var canSeeProfile: Bool? = false
    public var likeReceived: NSNumber?

    // MARK: SwiftyJSON Initializers
    /// Initiates the instance based on the object.
    ///
    /// - parameter object: The object of either Dictionary or Array kind that was passed.
    /// - returns: An initialized instance of the class.
    public convenience init(object: Any) {
        self.init(json: JSON(object))
    }

    /// Initiates the instance based on the JSON that was passed.
    ///
    /// - parameter json: JSON object from SwiftyJSON.
    public required init(json: JSON) {
        if let items = json[SerializationKeys.profiles].array { profiles = items.map { Profiles(json: $0) } }
        canSeeProfile = json[SerializationKeys.canSeeProfile].boolValue
        if let value = json[SerializationKeys.likeReceived].int {
            likeReceived = NSNumber(value: value)
        }
    }

    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = profiles { dictionary[SerializationKeys.profiles] = value.map { $0.dictionaryRepresentation() } }
        dictionary[SerializationKeys.canSeeProfile] = canSeeProfile
        dictionary[SerializationKeys.likeReceived] = likeReceived
        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.profiles = aDecoder.decodeObject(forKey: SerializationKeys.profiles) as? [Profiles]
        self.canSeeProfile = aDecoder.decodeObject(forKey: SerializationKeys.canSeeProfile) as? Bool
        if let value = aDecoder.decodeObject(forKey: SerializationKeys.likeReceived) as? Int {
            self.likeReceived = NSNumber(value: value)
        }
    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(profiles, forKey: SerializationKeys.profiles)
        aCoder.encode(canSeeProfile, forKey: SerializationKeys.canSeeProfile)
        aCoder.encode(likeReceived, forKey: SerializationKeys.likeReceived)
    }
}

@objc
public final class Profiles: NSObject,NSCoding{

    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let firstName = "first_name"
        static let avatar = "avatar"
    }

    // MARK: Properties
    public var firstName: String?
    public var avatar: String?

    // MARK: SwiftyJSON Initializers
    /// Initiates the instance based on the object.
    ///
    /// - parameter object: The object of either Dictionary or Array kind that was passed.
    /// - returns: An initialized instance of the class.
    public convenience init(object: Any) {
        self.init(json: JSON(object))
    }

    /// Initiates the instance based on the JSON that was passed.
    ///
    /// - parameter json: JSON object from SwiftyJSON.
    public required init(json: JSON) {
        firstName = json[SerializationKeys.firstName].string
        avatar = json[SerializationKeys.avatar].string
    }

    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary[SerializationKeys.firstName] = firstName
        dictionary[SerializationKeys.avatar] = avatar
        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.firstName = aDecoder.decodeObject(forKey: SerializationKeys.firstName) as? String
        self.avatar = aDecoder.decodeObject(forKey: SerializationKeys.avatar) as? String
    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(firstName, forKey: SerializationKeys.firstName)
        aCoder.encode(avatar, forKey: SerializationKeys.avatar)
    }
}
