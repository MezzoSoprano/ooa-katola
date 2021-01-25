//
//  MainCoordinator.swift
//  Restaurants
//
//  Created by Svyatoslav Katola on 5/22/19.
//

import UIKit
import FirebaseAuth

class MainCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let authService: AuthService
    
    init(navigationController: UINavigationController, authService: AuthService) {
        self.navigationController = navigationController
        self.authService = authService
    }
    
    func start() {
        
        if !authService.isSignedIn {
            let vc = AuthViewController.instantiate()
            vc.coordinator = self
            navigationController.pushViewController(vc, animated: true)
        } else {
            authDidFinish()
        }
    }
    
    func signOut() {
        let vc = AuthViewController.instantiate()
        vc.coordinator = self
        navigationController.viewControllers.removeAll()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func authDidFinish() {
        let vc = MainViewController.instantiate()
        vc.coordinator = self
        navigationController.navigationBar.isHidden = false
        navigationController.viewControllers.removeAll()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func createOrder() {
        let vc = CreateOrderViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
