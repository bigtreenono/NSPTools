//
//  AppDelegate.swift
//  SwiftTextKitNotepad
//
//  Created by Gabriel Hauber on 18/07/2014.
//  Copyright (c) 2014 Gabriel Hauber. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        // style the navigation bar
        let navColor = UIColor(red: 0.175, green: 0.458, blue: 0.831, alpha: 1.0)
        UINavigationBar.appearance().barTintColor = navColor
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        // make the status bar white
        application.statusBarStyle = .LightContent
        
        return true
    }
}