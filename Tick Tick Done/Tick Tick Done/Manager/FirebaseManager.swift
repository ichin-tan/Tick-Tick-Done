//
//  FirebaseManager.swift
//  Tick Tick Done
//
//  Created by CP on 04/01/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreInternal

class FirebaseManager {
    
    static let shared = FirebaseManager()
    let DB = Firestore.firestore()
    
    // MARK: - Authentication methods -
    
    func signIn(email: String, password: String, success: @escaping (String) -> (), failure: @escaping (String) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if (authResult == nil) {
                if (error?.localizedDescription == FirebaseErrors.invalidCred) {
                    failure(FirebaseErrors.invalidCred)
                } else {
                    failure(AppMessages.somethingWentWrong)
                }
            } else {
                success(authResult?.user.uid ?? "")
            }
        }
    }
    
    func signUp(email: String, password: String, success: @escaping () -> (), failure: @escaping (String) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if(authResult == nil) {
                if(error?.localizedDescription == FirebaseErrors.emailAlreadyInUse) {
                    failure(FirebaseErrors.emailAlreadyInUse)
                } else {
                    failure(AppMessages.somethingWentWrong)
                }
            } else {
                success()
            }
        }
    }
    
    func resetPassword(email: String, success: @escaping () -> (), failure: @escaping (String) -> ()) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if(error != nil) {
                failure(error?.localizedDescription ?? AppMessages.somethingWentWrong)
            } else {
                success()
            }
        }
    }
    
    func addUser(user: User, success: @escaping () -> (), failure: @escaping (String) -> ()) {
        DB.collection("users").document(user.userID).setData(user.dictionary) { error in
            if (error == nil) {
                success()
            } else {
                failure(error?.localizedDescription ?? "")
            }
        }
    }
    
    func checkIfUserExist(collection: String, valueToCheck: String, completion: @escaping ((Bool) -> ())) {
        DB.collection(collection).whereField("email", isEqualTo: valueToCheck).getDocuments { snapshot, error in
            if error != nil {
                completion(false)
                return
            }
            let isExist = snapshot?.documents.isEmpty == false
            completion(isExist)
        }
    }
    
    func getUser(docId: String, completion:@escaping (User) -> ()) {
        DB.collection("users").document(docId).getDocument { document, error in
            let email = document?.data()?["email"] as? String ?? ""
            let user = User(userID: docId, email: email)
            completion(user)
        }
    }
}
