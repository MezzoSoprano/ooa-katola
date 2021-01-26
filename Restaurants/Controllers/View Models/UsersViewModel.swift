//
//  UsersViewModel.swift
//  Restaurants
//
//  Created by Svyatoslav Katola on 26.01.2021.
//

import Foundation

final class UsersViewModel {
    
    let usersService: UserService
    var items = [User]()
    
    init(usersService: UserService) {
        self.usersService = usersService
    }
}

// MARK: - API

extension UsersViewModel {
    
    func loadItems(handler: @escaping (Error?) -> Void ) {
        usersService.fetchUsers { (result) in
            switch result {
            case .success(let models):
                self.items = models
                handler(nil)
            case .failure(let error):
                handler(error)
            }
        }
    }
}
