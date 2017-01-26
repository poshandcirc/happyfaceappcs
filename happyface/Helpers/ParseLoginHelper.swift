//
//  ParseLoginHelper.swift
//  happyface
//
//  Created by Cassy Stone on 8/6/16.
//  Copyright © 2016 Cassandra Stone. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import Parse
import ParseUI

typealias ParseLoginHelperCallback = (PFUser?, NSError?) -> Void

class ParseLoginHelper: NSObject {
    static let errorDomain = "com.makeschool.parseloginhelpererrordomain"
    static let usernameNotFoundErrorCode = 1
    static let usernameNotFoundLocalizedDescription = "Could not retrieve Facebook username"
    
    let callback: ParseLoginHelperCallback
    
    init(callback: @escaping ParseLoginHelperCallback) {
        self.callback = callback
    }
}

extension ParseLoginHelper : PFLogInViewControllerDelegate {
    
    func log(_ logInController: PFLogInViewController, didLogIn user: PFUser) {
        // Determine if this is a Facebook login
        let isFacebookLogin = FBSDKAccessToken.current() != nil
        
        if !isFacebookLogin {
            // Plain parse login, we can return user immediately
            self.callback(user, nil)
        } else {
            // if this is a Facebook login, fetch the username from Facebook
            FBSDKGraphRequest(graphPath: "me", parameters: nil).start {
                (connection: FBSDKGraphRequestConnection!, result: AnyObject?, error: NSError?) -> Void in
                if let error = error {
                    // Facebook Error? -> hand error to callback
                    self.callback(nil, error)
                }
                
                if let fbUsername = result?["name"] as? String {
                    // assign Facebook name to PFUser
                    user.username = fbUsername
                    // store PFUser
                    user.saveInBackground(block: { (success, error) -> Void in
                        if (success) {
                            // updated username could be stored -> call success
                            self.callback(user, error)
                        } else {
                            // updating username failed -> hand error to callback
                            self.callback(nil, error)
                        }
                    })
                } else {
                    // cannot retrieve username? -> create error and hand it to callback
                    //            let userInfo = [NSLocalizedDescriptionKey : ParseLoginHelper.usernameNotFoundLocalizedDescription]
                    //            let noUsernameError = NSError(
                    //              domain: ParseLoginHelper.errorDomain,
                    //              code: ParseLoginHelper.usernameNotFoundErrorCode,
                    //              userInfo: userInfo
                    //            )
                    self.callback(nil, error)
                }
            }
        }
    }
    
}

extension ParseLoginHelper : PFSignUpViewControllerDelegate {
    
    func signUpViewController(_ signUpController: PFSignUpViewController, didSignUp user: PFUser) {
        self.callback(user, nil)
    }
    
}
