//
//  Error.swift
//  Restaurants
//
//  Created by Святослав Катола on 5/25/19.
//

import Foundation

enum OrderError: Error {
    case OrderConflict
    case OrderMissing
}

extension OrderError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .OrderConflict:
            return NSLocalizedString("Sorry, this date is already reserved.", comment: "Order error")
        case .OrderMissing:
            return NSLocalizedString("Order doesnt exist.", comment: "Order error")
        }
    }
    
}
