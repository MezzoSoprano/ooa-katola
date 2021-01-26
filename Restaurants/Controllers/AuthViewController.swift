//
//  ViewController.swift
//  Restaurants
//
//  Created by Святослав Катола on 5/19/19.
//

import UIKit
import FirebaseUI

class AuthViewController: UIViewController, Storyboarded {
    
    weak var coordinator: MainCoordinator?
    var userService: UserService!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

// MARK: - Actions

extension AuthViewController {
    
    @IBAction func login(_ sender: Any) {
        let authUI = FUIAuth.defaultAuthUI()
        
        guard authUI != nil else {
            return
        }
        
        authUI?.delegate = self
        authUI?.providers = [FUIEmailAuth()]
        
        let authVC = authUI!.authViewController()
        present(authVC, animated: true)
    }
}

// MARK: - Auth UI Delegate

extension AuthViewController: FUIAuthDelegate {
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if let error = error {
            self.createAlert(title: "Auhtantification error", message: error.localizedDescription)
        } else {
            let authService = assembly.services.service(AuthService.self)
            userService.createUser(id: Auth.auth().currentUser!.uid, email: authService.userEmail!) { _ in self.coordinator?.authDidFinish() }
        }
    }
}

