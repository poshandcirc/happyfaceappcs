//
//  ErrorHandling.swift
//  happyface
//
//  Created by Cassy Stone on 8/5/16.
//  Copyright © 2016 Cassandra Stone. All rights reserved.
//

import Foundation
import UIKit
import ConvenienceKit

struct ErrorHandling {
    
    static let ErrorTitle = "SadFace"
    static let ErrorOKButtonTitle = "OK"
    static let ErrorDefaultMessage = "Something unexpected happened, sorry for that!"
    
    static func defaultErrorHandler(error: NSError) {
        let alert = UIAlertController(title: ErrorTitle, message: ErrorDefaultMessage, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: ErrorOKButtonTitle, style: UIAlertActionStyle.Default, handler: nil))
        
        let window = UIApplication.sharedApplication().windows[0] as! UIWindow
        window.rootViewController?.presentViewControllerFromTopViewController(alert, animated: true, completion: nil)
    }
    
    static func errorHandlingCallback(success: Bool, error: NSError?) -> Void {
        if let error = error {
            ErrorHandling.defaultErrorHandler(error)
        }
    }
}