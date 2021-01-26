//
//  ServicesContainer.swift
//  Restaurants
//
//  Created by Svyatoslav Katola on 25.01.2021.
//

import Dip

protocol ServicesContainer {
    
    func service<T>(_ type: T.Type) -> T
}

// swiftlint:disable force_try
extension DependencyContainer: ServicesContainer {
    
    func service<T>(_ type: T.Type) -> T {
        return try! resolve()
    }
}

extension DependencyContainer {
    
    static func services() -> DependencyContainer {
        let container = DependencyContainer()
        
        container.register(.singleton) { () -> AuthService in
            return AuthServiceImpl()
        }
        
        container.register(.singleton) { () -> OrderService in
            return OrderServiceImpl(db: try! container.resolve())
        }
        
        container.register(.singleton) { () -> UserService in
            return UserServiceImpl(db: try! container.resolve())
        }

        return container
    }
}
