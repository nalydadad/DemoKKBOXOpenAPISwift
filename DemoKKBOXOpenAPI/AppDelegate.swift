//
//  AppDelegate.swift
//  DemoKKBOXOpenAPI
//
//  Created by DADA on 2018/4/19.
//  Copyright © 2018年 DADA. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: SearchTableViewController())
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        return true
    }

}

