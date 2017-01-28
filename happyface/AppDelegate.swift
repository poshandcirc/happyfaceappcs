//
//  AppDelegate.swift
//  happyface
//
//  Created by Cassy Stone on 7/11/16.
//  Copyright © 2016 Cassandra Stone. All rights reserved.
//

import UIKit
import RealmSwift
import Parse
import FBSDKCoreKit
import ParseUI
import ParseFacebookUtilsV4

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var parseLoginHelper: ParseLoginHelper!
    
    override init() {
        super.init()
        
        parseLoginHelper = ParseLoginHelper {[unowned self] user, error in
            if let error = error {
                ErrorHandling.defaultErrorHandler(error)
            } else if let _ = user {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController")
                self.window?.rootViewController!.present(tabBarController, animated:true, completion: nil)
            }
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
// MARK: Realm configuration
        // Inside your application(application:didFinishLaunchingWithOptions:)
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 10,
            migrationBlock: { migration, oldSchemaVersion in
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migration.enumerate(Routine.className()) { oldObject, newObject in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 10) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                    newObject!["today"] = Date()
                }
                }})
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
        // Now that we've told Realm how to handle the schema change, opening the file
        // will automatically perform the migration
        let realm = try! Realm()

// MARK: Parse SDK
        let configuration = ParseClientConfiguration {
            $0.applicationId = "HappyFaceApp"
            $0.server = "https://happyfaceapp.herokuapp.com/parse"
        }
        
        Parse.initialize(with: configuration)
        
        /*
        // asynchronous try
        PFUser.logInWithUsernameInBackground("testytest", password: "testytest") { (user:PFUser?, error:NSError?) in
            if error == nil {
                print("woot we did it")
            } else {
                print("total disaster")
            }
        } */

    
// MARK: AppDelegate appearance features
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont(name: "Futura-Medium", size: 22)!, NSForegroundColorAttributeName: UIColor.white]
        UINavigationBar.appearance().barTintColor = UIColor(colorLiteralRed: (84/255), green: (194/255), blue: (251/255), alpha: 1.0)
        UINavigationBar.appearance().isTranslucent = false
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Futura-Medium", size: 18)!, NSForegroundColorAttributeName: UIColor.white], for: UIControlState())
        window?.backgroundColor = (UIColor.white)
        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Futura-Medium", size: 10)!, NSForegroundColorAttributeName: UIColor(colorLiteralRed: (84/255), green: (194/255), blue: (251/255), alpha: 1.0)], for: UIControlState())

// MARK: Initialize Facebook
        PFFacebookUtils.initializeFacebook(applicationLaunchOptions: launchOptions)
        
        let user = PFUser.current()
        let startViewController: UIViewController
        
        if (user != nil) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            startViewController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        } else {
            let loginViewController = HFLoginViewController()
            loginViewController.fields = [.usernameAndPassword, .logInButton, .signUpButton, .passwordForgotten, .facebook]
            loginViewController.delegate = parseLoginHelper
            loginViewController.signUpController?.delegate = parseLoginHelper
            
            startViewController = loginViewController
        }
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = startViewController;
        self.window?.makeKeyAndVisible()
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

//    func applicationDidBecomeActive(application: UIApplication) {
//        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
// MARK: Facebook Integration
    func applicationDidBecomeActive(_ application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }

}

