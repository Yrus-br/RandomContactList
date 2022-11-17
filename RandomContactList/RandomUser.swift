//
//  RandomUser.swift
//  RandomContactList
//
//  Created by Jorgen Shiller on 15.11.2022.
//

import Foundation
import Alamofire

struct User {
    let gender: String
    let name: Name
    let location: Location
    let email: String
    let login: Login
    let dob, registered: String
    let phone, cell: String
    let id: Id
    let picture: Picture
    let nat: String
    
    init(value: [String:Any]) {
        gender = value["gender"] as? String ?? ""
        
        let nameData = value["name"] as? [String: String] ?? [:]
        name = Name(value: nameData)
        
        let locationData = value["location"] as? [String: Any] ?? [:]
        location  = Location(value: locationData)
        
        email = value["email"] as? String ?? ""
        
        let loginData = value["login"] as? [String: String] ?? [:]
        login = Login(value: loginData)
        
        dob = value["dob"] as? String ?? ""
        
        registered = value["registered"] as? String ?? ""
        
        phone = value["phone"] as? String ?? ""
        
        cell = value["cell"] as? String ?? ""
        
        let idData = value["id"] as? [String: String] ?? [:]
        id = Id(value: idData)
        
        let pictureData = value["picture"] as?  [String: String] ?? [:]
        picture = Picture(value: pictureData)
        
        nat = value["nat"] as? String ?? ""
    }
    
    static func getUser(from value: Any) -> [User] {
        guard let userData = value as? [String: Any] else { return [] }
        guard let results = userData["results"] as? [[String: Any]] else { return [] }
        return results.map { User(value: $0)}
    }
}

struct Name {
    var title: String
    var first: String
    var last: String
    
    init(value: [String: String]) {
        title = value["title"] ?? ""
        first = value["first"] ?? ""
        last = value["last"] ?? ""
    }
}

struct Location {
    let street: Street
    let city: String
    let state: String
    let country: String
    let postcode: Int
    let coordinates: Coordinates
    let timezone: Timezone
    
    init(value: [String: Any]) {
        let streetData = value["street"] as? [String: Any] ?? [:]
        street = Street(value: streetData)
        
        city = value["city"] as? String ?? ""
        state = value["state"] as? String ?? ""
        country = value["country"] as? String ?? ""
        postcode = value["city"] as? Int ?? 0
        
        let coordinatesData = value["coordinates"] as? [String: String] ?? [:]
        coordinates = Coordinates(value: coordinatesData)
        
        let timezondeData = value["timezone"] as? [String: String] ?? [:]
        timezone = Timezone(value: timezondeData)
    }
}

struct Street {
    let number: Int
    let name: String
    
    init(value: [String: Any]) {
        number = value["number"] as? Int ?? 0
        name = value["name"] as? String ?? ""
    }
}

struct Coordinates{
    let latitude: String
    let longitude: String
    
    init(value: [String: String]) {
        latitude = value["latitude"] ?? ""
        longitude = value["longitude"] ?? ""
    }
}

struct Timezone {
    let offset: String
    let description: String
    
    init(value: [String: String]) {
        offset = value["offset"] ?? ""
        description = value["description"] ?? ""
    }
}

struct Login {
    let uuid: String
    let username: String
    let password: String
    let salt: String
    let md5: String
    let sha1: String
    let sha256: String
    
    init(value: [String: String]) {
        uuid = value["uuid"] ?? ""
        username = value["username"] ?? ""
        password = value["password"] ?? ""
        salt = value["salt"] ?? ""
        md5 = value["md5"] ?? ""
        sha1 = value["sha1"] ?? ""
        sha256 = value["sha256"] ?? ""
    }
}

struct Id {
    let name, value: String
    
    init(value: [String:String]) {
        name = value["name"] ?? ""
        self.value = value["value"] ?? ""
    }
}

struct Picture {
    let large, medium, thumbnail: String
    
    init(value: [String: String]) {
        large = value["large"] ?? ""
        medium = value["medium"] ?? ""
        thumbnail = value["thumbnail"] ?? ""
    }
}

enum URLLinks: String {
    case randomUserLink = "https://randomuser.me/api/"
}

