//
//  UserService.swift
//  Restaurants
//
//  Created by Svyatoslav Katola on 26.01.2021.
//

import Foundation

protocol UserService {
    
    func updateUser(id: String, with: [String], handler: @escaping ResultHandler<Void>)
    func createUser(id: String, email: String, handler: @escaping ResultHandler<Void>)
    func fetchUsers(handler: @escaping ResultHandler<[User]>)
}
