//
//  UITextViewPlaceholderText.swift
//  MakeSchoolNotes
//
//  Created by Benjamin Encz on 2/23/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit

open class TextView : UITextView {

  open var placeholderText: String = "Tap to edit"
  
  public required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    initialize()
  }
  
  public override init(frame: CGRect, textContainer: NSTextContainer?) {
    super.init(frame: frame, textContainer: textContainer)
    initialize()
  }
  
  fileprivate func initialize() {
    NotificationCenter.default.addObserver(self,
      selector: #selector(UITextViewDelegate.textViewDidBeginEditing(_:)),
      name: NSNotification.Name.UITextViewTextDidBeginEditing,
      object: self)
    
    NotificationCenter.default.addObserver(self,
      selector: #selector(UITextViewDelegate.textViewDidEndEditing(_:)),
      name: NSNotification.Name.UITextViewTextDidEndEditing,
      object: self)
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  override open var text: String! {
    didSet {
      if let text = text, text == "" {
        if (showsPlaceholderText == nil) {
          showsPlaceholderText = true
        }
      } else {
        if (showsPlaceholderText == nil) {
          showsPlaceholderText = false
        }
      }
    }
  }
  
  open var textValue:String {
    get {
      if let showsPlaceholderText = showsPlaceholderText, showsPlaceholderText == true {
          return ""
      } else {
        return text
      }
    }
  }
  
  open fileprivate (set) var showsPlaceholderText: Bool? {
    didSet {
      if let showsPlaceholderText = showsPlaceholderText {
        if (showsPlaceholderText == true) {
          textColor = placeHolderTextColor
          text = placeholderText
        } else {
          textColor = UIColor.black
        }
      }
    }
  }
  
  @IBInspectable open var placeHolderTextColor: UIColor = UIColor.lightGray
  
  open func textViewDidEndEditing(_ notification: Notification) {
    self.showsPlaceholderText = (self.text.characters.count == 0)
  }
  
  open func textViewDidBeginEditing(_ notification: Notification) {
    if let showsPlaceholderText = showsPlaceholderText, showsPlaceholderText == true {
        self.showsPlaceholderText = false
        text = ""
    }
  }
  
}
