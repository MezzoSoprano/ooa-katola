//
//  Date.swift
//  Restaurants
//
//  Created by Святослав Катола on 5/25/19.
//

import Foundation

extension Date {
    
    func stripTime() -> Date {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let date = Calendar.current.date(from: components)
        return date!
    }
}
