//
//  User.swift
//  Tick Tick Done
//
//  Created by CP on 04/01/25.
//

import Foundation

class User {
    var userID: String
    var email: String
    var dictionary: [String: Any] = [:]
    
    init(userID: String, email: String) {
        self.userID = userID
        self.email = email
        self.dictionary = ["userID": self.userID, "email": self.email]
    }
}
