//
//  OrderListViewModel.swift
//  Restaurants
//
//  Created by Святослав Катола on 5/23/19.
//

import FirebaseAuth

final class OrderListViewModel {
    
    typealias viewModelType = CurrentUserState
    var type: viewModelType {
        return authService.currentUserState()
    }
    
    let orderService: OrderService
    let authService: AuthService
    
    var items = [Order]()
    
    var barTitle: String {
        switch authService.currentUserState() {
        
        case .admin:
            return "Admin"
        case .user:
            return "User"
        case .unAuhtorized:
            return "Login please!"
        case .manager:
            return "Manager"
        }
    }
    
    init(orderService: OrderService, authService: AuthService) {
        self.orderService = orderService
        self.authService = authService
    }
}

// MARK: - API

extension OrderListViewModel {
    
    func loadItems(handler: @escaping (Error?) -> Void ) {
        
        switch type {
        case .admin, .manager:
            orderService.orders { (result) in
                
                switch result {
                case .success(let models):
                    self.items = models
                    handler(nil)
                case .failure(let error):
                    handler(error)
                }
            }
            
        case .user:
            orderService.ordersForCurrentUser { (result) in
                
                switch result {
                case .success(let models):
                    self.items = models
                    handler(nil)
                case .failure(let error):
                    handler(error)
                }
            }
            
        case .unAuhtorized:
            print("Unauthorized")
        }
    }
    
    func remove(index: Int, handler: @escaping (Error?) -> Void ) {
        orderService.cancelOrder(items[index]) { (result) in
            switch result {
            
            case .success(_):
                self.items.remove(at: index)
                handler(nil)
            case .failure(let error):
                handler(error)
            }
        }
    }
}
