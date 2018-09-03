//
//  AppDelegate.swift
//  Todoey
//
//  Created by Sittha Sukkasi on 8/29/18.
//  Copyright © 2018 Sittha Sukkasi. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        do {
            _ = try Realm()
        } catch {
            print("Error initializing Realm: \(error)")
        }

        return true
    }

}

