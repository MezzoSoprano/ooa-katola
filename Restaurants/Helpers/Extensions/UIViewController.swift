//
//  UIViewController.swift
//  Restaurants
//
//  Created by Святослав Катола on 5/19/19.
//

import UIKit

extension UIViewController {
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
