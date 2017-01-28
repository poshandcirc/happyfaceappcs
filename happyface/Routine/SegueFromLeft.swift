//
//  SegueFromLeft.swift
//  happyface
//
//  Created by Cassy Stone on 8/3/16.
//  Copyright © 2016 Cassandra Stone. All rights reserved.
//

import UIKit
import QuartzCore

class SegueFromLeft: UIStoryboardSegue {
    override func perform() {
        let src: UIViewController = self.source
        let dst: UIViewController = self.destination
//        src.navigationController!.view.addSubview(self.destinationViewController.view)
        let transition: CATransition = CATransition()
        let timeFunc : CAMediaTimingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.duration = 1
        transition.timingFunction = timeFunc
        transition.type = kCATransitionReveal
        transition.subtype = kCATransitionFromBottom
        
//        src.navigationController!.view.backgroundColor = (UIColor .clearColor())
//        src.navigationController!.view.tintColor = (UIColor .clearColor())
//        let color = UIColor(colorLiteralRed: (84/255), green: (194/255), blue: (251/255), alpha: 1.0)
        
        
//        blah.layer.addAnimation(transition, forKey: kCATransition)
        src.navigationController!.view.layer.add(transition, forKey: kCATransition)
        src.navigationController!.pushViewController(dst, animated: true)

    }
}
