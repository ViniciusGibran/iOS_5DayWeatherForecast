//
//  AppDelegate.swift
//  5DayWeatherForecast
//
//  Created by Vinicius Gibran on 24/11/17.
//  Copyright © 2017 Vinicius Gibran. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
        window = createMainWindow(homeVC)
        
        UIApplication.shared.statusBarStyle = .lightContent
        return true
    }
    
    /**
     Create an `UIWindow` with initial `UINavigationController` and UIViewController`.
     - returns: `UIWindow` set and up for this app.
     */
    func createMainWindow(_ viewController: UIViewController) -> UIWindow {
        let navigationController = UINavigationController(rootViewController: viewController)
        
        //custom window for this app
        navigationController.navigationBar.tintColor = .white
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navigationController
        window.clipsToBounds = true
        
        window.makeKeyAndVisible()
        
        return window
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {}
    func applicationDidEnterBackground(_ application: UIApplication) {}
    func applicationWillEnterForeground(_ application: UIApplication) {}
    func applicationDidBecomeActive(_ application: UIApplication) {}
    func applicationWillTerminate(_ application: UIApplication) {}


}

