//
//  Delay.swift
//  ConvenienceKit
//
//  Created by Benjamin Encz on 4/13/15.
//  Copyright (c) 2015 Benjamin Encz. All rights reserved.
//

import Foundation


// Thanks to matt on StackOverflow: http://stackoverflow.com/questions/24034544/dispatch-after-gcd-in-swift
public func delay(_ delay:Double, closure:@escaping ()->()) {
  DispatchQueue.main.asyncAfter(
    deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}
