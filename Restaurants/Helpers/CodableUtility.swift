//
//  CodableUtility.swift
//  Restaurants
//
//  Created by Svyatoslav Katola on 26.01.2021.
//

import Foundation

var dateformatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    return formatter
}

extension Decodable {
    
  init(from: Any) {
    let data = try! JSONSerialization.data(withJSONObject: from, options: .prettyPrinted)
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .formatted(dateformatter)
    self = try! decoder.decode(Self.self, from: data)
  }
}

extension Encodable {
    
  func asDictionary() -> [String: Any] {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .formatted(dateformatter)
    let data = try! encoder.encode(self)
    let dictionary = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
    return dictionary
  }
}
