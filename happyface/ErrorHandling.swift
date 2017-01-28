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
    
    static func defaultErrorHandler(_ error: NSError) {
        let alert = UIAlertController(title: ErrorTitle, message: ErrorDefaultMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: ErrorOKButtonTitle, style: UIAlertActionStyle.default, handler: nil))
        
        let window = UIApplication.shared.windows[0] 
        window.rootViewController?.presentViewControllerFromTopViewController(alert, animated: true, completion: nil)
    }
    
    static func errorHandlingCallback(_ success: Bool, error: NSError?) -> Void {
        if let error = error {
            ErrorHandling.defaultErrorHandler(error)
        }
    }
}
