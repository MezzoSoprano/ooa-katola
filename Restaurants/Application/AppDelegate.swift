//
//  AppDelegate.swift
//  Restaurants
//
//  Created by Святослав Катола on 5/19/19.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // firebaase setup
        FirebaseApp.configure()
        
        // coordinator setup
        let navController = UINavigationController()
        navController.navigationBar.isHidden = true
        coordinator = MainCoordinator(navigationController: navController,
                                      authService: assembly.services.service(AuthService.self))
        coordinator?.start()

        // create a basic UIWindow and activate it
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
}

