//
//  OrderService.swift
//  Restaurants
//
//  Created by Святослав Катола on 5/24/19.
//

typealias ResultHandler<T> = (Result<T, Error>) -> Void

protocol OrderService {
    
    func makeOrder(_ order: Order, completionHandler: @escaping (Result<Order, Error>) -> Void)
    func cancelOrder(_ order: Order, completionHandler: @escaping (Result<Order, Error>) -> Void)
    func editOrder(from: Order, to: Order, completionHandler: @escaping (Result<Order, Error>) -> Void)
    
    func ordersForCurrentUser(completionHandler: @escaping (Result<[Order], Error>) -> Void)
    func orders(completionHandler: @escaping (Result<[Order], Error>) -> Void)
}
