//
//  AppDelegate.swift
//  PFC
//
//  Created by Cyril on 07/08/2017.
//  Copyright © 2017 Cyril. All rights reserved.
//

import UIKit

let appDelegate = UIApplication.shared.delegate as! AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appFlow: AppFlow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        initAppFlow()
        BasicAppearance.styleTheApp()
        return true
    }
    
    func initAppFlow() {
        self.appFlow = AppFlow()
        self.window = UIWindow()
        self.window?.rootViewController = appFlow?.navigation
        self.window?.makeKeyAndVisible()
    }
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        let dispachAfter = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: dispachAfter) {
            closure()
        }
    }

}

