//
//  OrderServiceImpl.swift
//  Restaurants
//
//  Created by Святослав Катола on 5/24/19.
//

import FirebaseFirestore
import FirebaseAuth

final class OrderServiceImpl: OrderService {
    
    let db: Firestore
    
    init(db: Firestore) {
        self.db = db
    }
    
    func makeOrder(_ order: Order, completionHandler: @escaping (Result<Order, Error>) -> Void) {
        
        let docRef = db.collection("order").whereField("restaurantName", isEqualTo: order.restaurantName).whereField("date", isEqualTo: order.date)
        
        docRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                completionHandler(.failure(err))
            } else {
                var models = [Order]()
                for document in querySnapshot!.documents {
                    models.append((Order(dictionary: document.data())))
                }
                if models.count == 0 {
                    self.db.collection("order").addDocument(data: ["date":order.date, "personsAmount":order.personsAmount, "restaurantName":order.restaurantName, "customerName":order.customerName])
                    completionHandler(.success(order))
                } else {
                    completionHandler(.failure(OrderError.OrderConflict))
                }
            }
        }
    }
    
    func cancelOrder(_ order: Order, completionHandler: @escaping (Result<Order, Error>) -> Void) {
        let docRef = db.collection("order").whereField("restaurantName", isEqualTo: order.restaurantName).whereField("date", isEqualTo: order.date)
        docRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                completionHandler(.failure(err))
            } else {
                for document in querySnapshot!.documents {
                    self.db.collection("order").document(document.documentID).delete()
                }
                
                if querySnapshot!.documents.count == 0 {
                    completionHandler(.failure(OrderError.OrderMissing))
                } else { completionHandler(.success(order)) }
            }
        }
    }
    
    func editOrder(from: Order, to: Order, completionHandler: @escaping (Result<Order, Error>) -> Void) {
        
    }
    
    func ordersForCurrentUser(completionHandler: @escaping (Result<[Order], Error>) -> Void) {
        
        let docRef = db.collection("order").whereField("customerName", isEqualTo: (Auth.auth().currentUser?.email)!).order(by: "date", descending: true)
        
        docRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                completionHandler(.failure(err))
            } else {
                var models = [Order]()
                for document in querySnapshot!.documents {
                    models.append((Order(dictionary: document.data())))
                }
                completionHandler(.success(models))
            }
        }
    }
    
    func orders(completionHandler: @escaping (Result<[Order], Error>) -> Void) {
        let docRef = db.collection("order").order(by: "date", descending: true)
        
        docRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                completionHandler(.failure(err))
            } else {
                var models = [Order]()
                for document in querySnapshot!.documents {
                    models.append((Order(dictionary: document.data())))
                }
                completionHandler(.success(models))
            }
        }
    }
}
