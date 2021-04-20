//
//  AppDelegate.swift
//  Challenge
//
//  Created by Alejandro Jose Ramirez Vergara on 17/04/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var navigationController: UINavigationController? = UINavigationController()
    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let mainView = MainViewSwiftRouter.createModule()
        navigationController = UINavigationController.init(rootViewController: mainView)
        navigationController?.isNavigationBarHidden = true
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navigationController
        return true
    }
}

