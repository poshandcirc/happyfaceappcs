//
//  AppDelegate.swift
//  happyface
//
//  Created by Cassy Stone on 7/11/16.
//  Copyright © 2016 Cassandra Stone. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Inside your application(application:didFinishLaunchingWithOptions:)
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 5,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 5) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
        })
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
        
        // Now that we've told Realm how to handle the schema change, opening the file
        // will automatically perform the migration
        let realm = try! Realm()
        
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont(name: "Futura-Medium", size: 22)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        UINavigationBar.appearance().barTintColor = UIColor(colorLiteralRed: (84/255), green: (194/255), blue: (251/255), alpha: 1.0)
        
        UINavigationBar.appearance().translucent = false
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Futura-Medium", size: 18)!, NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
        
        
//        UITabBar.appearance().backgroundColor = UIColor.whiteColor()
//        UITabBar.appearance().tintColor = UIColor.whiteColor()
        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Futura-Medium", size: 10)!, NSForegroundColorAttributeName: UIColor(colorLiteralRed: (84/255), green: (194/255), blue: (251/255), alpha: 1.0)], forState: UIControlState.Normal)
        
//        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.blueColor()]
        
        //UINavigationBar.appearance().backgroundColor = UIColor(colorLiteralRed: (84/255), green: (194/255), blue: (251/255), alpha: 1.0)
        
 //       UIBarButtonItem.setTitleTextAttributes([NSFontAttributeName: "Futura"], forState: UIControlState.normal)
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

