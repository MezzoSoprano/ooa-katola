//
//  AuthServiceImpl.swift
//  Restaurants
//
//  Created by Svyatoslav Katola on 25.01.2021.
//

import Foundation
import FirebaseAuth

class AuthServiceImpl: AuthService {
    
    var isSignedIn: Bool {
        guard Auth.auth().currentUser != nil else {
            return false
        }
        
        return true
    }

    var userEmail: String? {
        return Auth.auth().currentUser?.email
    }
    
    func currentUserState() -> CurrentUserState {
        guard let userID = Auth.auth().currentUser?.uid else { return .unAuhtorized }

        if adminsID.contains(userID) {
            return .admin
        } else { return .user }
    }
}
