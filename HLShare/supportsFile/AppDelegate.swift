//
//  AppDelegate.swift
//  HLShare
//
//  Created by HLApple on 2017/12/21.
//  Copyright © 2017年 HLApple. All rights reserved.
//

import UIKit
import CoreData
#if DEVELOPMENT
    // 测试环境
let BASEURL = "http://192.168.1.113:8080/"
let BMK_SERVICES_API_KEY = "测试"
let HYPHENATELITE_API_KEY = "aa1c2e092bdd44cfc02b1d80d52869ac"
#else
    // 开发环境
let BASEURL = "http://192.168.1.113:8080/"
let BMK_SERVICES_API_KEY = "开发"
let HYPHENATELITE_API_KEY = "aa1c2e092bdd44cfc02b1d80d52869ac"

#endif
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,BMKGeneralDelegate {

    var window: UIWindow?
    var mapManager = BMKMapManager()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let emOptions = EMOptions(appkey: HYPHENATELITE_API_KEY)
        emOptions?.apnsCertName = "istore_dev"
        EMClient.shared().initializeSDK(with: emOptions)
        
        let ret = mapManager.start(BMK_SERVICES_API_KEY, generalDelegate: self)
        if !ret {print("---------百度地图初始化失败--------------")}
        
        print("BMK_SERVICES_API_KEY: \(BMK_SERVICES_API_KEY)")
                
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    
    /// APP 进入后台
    func applicationDidEnterBackground(_ application: UIApplication) {
       EMClient.shared().applicationDidEnterBackground(application)
    }

    /// APP 将要从后台返回
    func applicationWillEnterForeground(_ application: UIApplication) {
        EMClient.shared().applicationWillEnterForeground(application)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "HLShare")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

