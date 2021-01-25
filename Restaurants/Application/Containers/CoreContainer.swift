//
//  CoreContainer.swift
//  Restaurants
//
//  Created by Svyatoslav Katola on 25.01.2021.
//

import FirebaseFirestore
import Dip
import FirebaseAuth

protocol CoreContainer {
    
    func database() -> Firestore
}

extension DependencyContainer: CoreContainer {
    
    func database() -> Firestore {
        return try! resolve() as Firestore
    }
}

extension DependencyContainer {
    
    static func core() -> DependencyContainer {
        let container = DependencyContainer()
        container.register(.singleton) { _ in
            return Firestore.firestore()
        }
        
        return container
    }
}
