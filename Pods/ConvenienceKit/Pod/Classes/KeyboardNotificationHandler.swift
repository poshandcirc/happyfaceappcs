//
//  KeyboardNotificationHandler.swift
//  MakeSchoolNotes
//
//  Created by Benjamin Encz on 2/23/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit

@objc(KeyboardNotificationHandler)
open class KeyboardNotificationHandler: NSObject {
  
  public typealias KeyboardHandlerCallback = (CGFloat) -> ()
  
  open var keyboardWillBeHiddenHandler: KeyboardHandlerCallback?
  open var keyboardWillBeShownHandler:  KeyboardHandlerCallback?
  
  public required override init() {
    super.init()
    
    NotificationCenter.default.addObserver(self,
      selector: #selector(KeyboardNotificationHandler.keyboardWillBeShown(_:)),
      name: NSNotification.Name(rawValue: "UIKeyboardWillShowNotification"),
      object: nil
    )
    
    NotificationCenter.default.addObserver(self,
      selector: #selector(KeyboardNotificationHandler.keyboardWillBeHidden(_:)),
      name: NSNotification.Name(rawValue: "UIKeyboardWillHideNotification"),
      object: nil
    )
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  open func keyboardWillBeShown(_ notification: Notification) {
    invokeHandler(notification, callback: keyboardWillBeShownHandler)
  }
  
  open func keyboardWillBeHidden(_ notification: Notification) {
    invokeHandler(notification, callback: keyboardWillBeHiddenHandler)
  }
  
  fileprivate func invokeHandler(_ notification: Notification, callback: KeyboardHandlerCallback?) {
    if let info = notification.userInfo, let callback = callback {
      let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        callback(keyboardFrame.height)
    }
  }
  
}
