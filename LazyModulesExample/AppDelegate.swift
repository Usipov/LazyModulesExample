//
//  AppDelegate.swift
//  LazyModulesExample
//
//  Created by Тимур Юсипов on 22/04/2019.
//  Copyright © 2019 Avito. All rights reserved.
//

import UIKit
import DI
import Footprints

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let container = DIContainer()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        LazyFeaturesFootprintsRegistry().registerFeatureFootprints(
            in: container
        )
        
        return true
    }
    
    public static var instance: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}

