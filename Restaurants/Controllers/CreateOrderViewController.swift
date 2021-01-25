//
//  CreateOrderViewController.swift
//  Restaurants
//
//  Created by Святослав Катола on 5/22/19.
//

import UIKit
import FirebaseAuth

var restaurants = [Restaurant(name: "Sunrise", address: "Kharkiv, Sichovih, 1", capacity: 10, pricePerPerson: 40), Restaurant(name: "Sunset", address: "Lviv, Hotceva, 15", capacity: 50, pricePerPerson: 10), Restaurant(name: "Mukola", address: "Odessa, Franka, 8", capacity: 20, pricePerPerson: 30)]

class CreateOrderViewController: UIViewController, Storyboarded {
    
    var coordinator: MainCoordinator?
    let orderService: OrderService = assembly.services.service(OrderService.self)
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var restaurantPicker: UIPickerView!
    @IBOutlet weak var personsAmountTextField: UITextField!
    @IBOutlet weak var totalPriceTextField: UITextField!
    
    var selectedRestaurant = restaurants[0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.minimumDate = Date()
    }
}

// MARK: - Actions

extension CreateOrderViewController {
    
    @IBAction func dateDidChange(_ sender: Any) {
    }
    
    @IBAction func personsAmountDidChange(_ sender: Any) {
        
        if let amount = Int(self.personsAmountTextField.text!) {
             self.totalPriceTextField.text = String(amount * selectedRestaurant.pricePerPerson)
        }
    }
    
    @IBAction func makeOrder(_ sender: Any) {
        guard let field = self.personsAmountTextField.text else { return }
        guard let amount = Int(field) else {
            self.createAlert(title: "Guests amount", message: "Please enter guests amount")
            return
        }
        
        let order = Order(date: datePicker.date.stripTime(), personsAmount: amount, restaurantName: selectedRestaurant.name, customerName: (Auth.auth().currentUser?.email!)!)
        
        if order.personsAmount > selectedRestaurant.capacity {
            createAlert(title: "Error", message: "This restaurant can contain only \(selectedRestaurant.capacity) persons, not \(order.personsAmount)")
            return
        }
        
        orderService.makeOrder(order) { (result) in
            switch result {
            case .success(let order):
                self.createAlert(title: "Successed!", message: "Order for \(order.restaurantName) at \(order.dateString) was created.")
            case .failure(let error):
                self.createAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }
}

extension CreateOrderViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return restaurants.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return restaurants[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRestaurant = restaurants[row]
    }
}

extension CreateOrderViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        personsAmountTextField.resignFirstResponder()
        self.view.endEditing(true)
        return true
    }
}
