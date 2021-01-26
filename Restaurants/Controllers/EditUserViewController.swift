//
//  EditUserViewController.swift
//  Restaurants
//
//  Created by Svyatoslav Katola on 26.01.2021.
//

import UIKit

class EditUserViewController: UIViewController, Storyboarded {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var isManagerTextField: UITextField!
    @IBOutlet weak var RestaurantsTextField: UITextField!

    var user: User!
    var userService: UserService!
    
    override func viewWillAppear(_ animated: Bool) {
        self.emailTextField.text = user.email
        self.isManagerTextField.text = user.isManager ? "This User is a Manager": "This User is not a Manager"
        self.RestaurantsTextField.text = user.restaurants.joined(separator: ", ")
    }
    
    @IBAction func update(_ sender: Any) {
        if let rests = RestaurantsTextField.text?.components(separatedBy: ", ") {
            let filtered = rests.filter { !$0.isEmpty }
            userService.updateUser(id: user.id, with: filtered, handler: { result in
                switch result {
                case .success(let order):
                    self.createAlert(title: "Successed!", message: "User Was Updated.")
                case .failure(let error):
                    self.createAlert(title: "Error", message: error.localizedDescription)
                }
            })
        }
    }
}

extension EditUserViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text?.isEmpty == true {
            isManagerTextField.text = "This User is not a Manager"
        } else {
            isManagerTextField.text = "This User is a Manager"
        }
        
        return true
    }
}
