//
//  User.swift
//  Restaurants
//
//  Created by Svyatoslav Katola on 26.01.2021.
//

import Foundation

struct User: Codable {
    
    var isManager: Bool {
        return !restaurants.isEmpty
    }
    
    var id: String
    var restaurants: [String]
    var email: String
    
    init(id: String, email: String) {
        self.email = email
        self.id = id
        self.restaurants = []
    }
}
