//
//  UserDefaults.swift
//  Tick Tick Done
//
//  Created by CP on 24/12/24.
//

import Foundation

var currentUser: User? {
    set {
        // Whatever useer is going to set, gonna take it dictionary & set it in user default
        USER_DEFAULTS.setValue(newValue?.dictionary, forKey: "currentUser")
    }
    get {
        // Have to get that dictionry(JSON) and have to make user using object mapper
        let userDict = USER_DEFAULTS.value(forKey: "currentUser") as? [String:Any] ?? nil
        if userDict == nil {
            return nil
        }
        let userId = userDict?["userID"] as? String ?? ""
        let email = userDict?["email"] as? String ?? ""
        return User(userID: userId, email: email)
    }
}
