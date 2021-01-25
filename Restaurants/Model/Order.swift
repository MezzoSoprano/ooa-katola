//
//  Order.swift
//  Restaurants
//
//  Created by Святослав Катола on 5/24/19.
//

import Firebase

struct Order {
    
    var date: Date
    
    var personsAmount: Int
    var restaurantName: String
    var customerName: String
    var id: String?
    
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        return dateFormatter.string(from: date)
    }
    
    init(dictionary: [String:Any]) {
        date = (dictionary["date"] as! Timestamp).dateValue()
        personsAmount = dictionary["personsAmount"] as! Int
        restaurantName = dictionary["restaurantName"] as! String
        customerName = dictionary["customerName"] as! String
    }
    
    init(date: Date, personsAmount: Int, restaurantName: String, customerName: String) {
        self.date = date
        self.personsAmount = personsAmount
        self.customerName = customerName
        self.restaurantName = restaurantName
    }
}

extension Order {
    
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case personsAmount = "personsAmount"
        case restaurantName = "restaurantName"
        case customerName = "customerName"
    }
}
