//
//  AuthService.swift
//  Restaurants
//
//  Created by Svyatoslav Katola on 25.01.2021.
//

import Foundation

protocol AuthService {
    
    var manages: [String] { get }
    var isSignedIn: Bool { get }
    var userEmail: String? { get }
    
    func currentUserState () -> CurrentUserState
}
