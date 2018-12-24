//
//  AppDelegate.swift
//  RFastLoan
//
//  Created by RPK on 2018/10/30.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NotificationCenter.default.addObserver(self, selector: #selector(setMainController), name: alreadyLogin, object: nil)
        
//        自定义数据库
//        let modesConfig = Realm.Configuration.init(fileURL: modelsRealm, inMemoryIdentifier: nil, syncConfiguration: nil, encryptionKey: nil, readOnly: false, schemaVersion: 0, migrationBlock: nil, deleteRealmIfMigrationNeeded: false, shouldCompactOnLaunch: nil, objectTypes: nil)
//        _ = try! Realm.init(configuration: accountConfig)
//        _ = try! Realm.init(configuration: modesConfig)
//        let path = RLMRealmConfiguration.default()
//        print("数据库路径 \(path)")
        IQKeyboardManager.shared.enable = true
        //控制点击背景是否收起键盘
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        //控制键盘上的工具条文字颜色是否用户自定义
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = true
        //       IQKeyboardManager.sharedManager().shouldToolbarUsesTextFieldTintColor = true
        //将右边Done改成完成
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "完成"
        // 控制是否显示键盘上的工具条
        IQKeyboardManager.shared.enableAutoToolbar = true
        //最新版的设置键盘的returnKey的关键字 ,可以点击键盘上的next键，自动跳转到下一个输入框，最后一个输入框点击完成，自动收起键盘
        IQKeyboardManager.shared.toolbarManageBehaviour = .byPosition
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        if (RAccessToken.userAccessToken().count == 0) {
            window?.rootViewController = RBaseNavViewController.init(rootViewController: RLoginViewController())
        }
        else {
            window?.rootViewController = RMainTabBarViewController()
        }
        // Override point for customization after application launch.
        return true
    }
    
    @objc func setMainController() {
        window?.rootViewController = RMainTabBarViewController()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

