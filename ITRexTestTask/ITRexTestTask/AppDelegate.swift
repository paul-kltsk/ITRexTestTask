//
//  AppDelegate.swift
//  ITRexTestTask
//
//  Created by Павел Кулицкий on 11.02.22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)

        let navController = UINavigationController(rootViewController: FirstViewController())
        
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        return true
    }



}

