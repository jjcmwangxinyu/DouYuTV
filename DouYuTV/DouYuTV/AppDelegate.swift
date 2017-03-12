//
//  AppDelegate.swift
//  DouYuTV
//
//  Created by 王新宇 on 2017/3/12.
//  Copyright © 2017年 王新宇. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UITabBar.appearance().tintColor = UIColor.orange
        return true
    }

}

