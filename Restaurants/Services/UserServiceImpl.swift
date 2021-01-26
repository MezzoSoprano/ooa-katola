//
//  UserServiceImpl.swift
//  Restaurants
//
//  Created by Svyatoslav Katola on 26.01.2021.
//

import Foundation
import FirebaseFirestore

class UserServiceImpl {
    let db: Firestore
    
    init(db: Firestore) {
        self.db = db
    }
}

extension UserServiceImpl: UserService {
    
    func updateUser(id: String, with: [String], handler: @escaping ResultHandler<Void>) {
        let query = db.collection("users").whereField("id", isEqualTo: id)
        query.getDocuments { snap, _ in
            snap?.documents.first?.reference.updateData([
                "restaurants": with
            ])
            
            handler(.success(()))
        }
    }

    func createUser(id: String, email: String, handler: @escaping (Result<Void, Error>) -> Void) {
        fetchUsers { result in
            switch result {
            case .failure(_):
                return
            case .success(let models):
                let exists = models.first { $0.id == id }
                guard !adminsID.contains(exists?.id ?? "nope") else {
                    handler(.success(()))
                    return
                }
                var service = assembly.services.service(AuthService.self)
                cache.set(exists?.restaurants, forKey: "restiki")
                if exists == nil { self.db.collection("users").addDocument(data: User(id: id, email: email).asDictionary()) }
                handler(.success(()))
            }
        }
    }
    
    func fetchUsers(handler: @escaping (Result<[User], Error>) -> Void) {
        db.collection("users").getDocuments { snap, error in
            guard error == nil else {
                handler(.failure(error!))
                return
            }
            var models = [User]()
            for document in snap!.documents {
                models.append((User(from: document.data())))
            }
            handler(.success(models))
        }
    }
}
