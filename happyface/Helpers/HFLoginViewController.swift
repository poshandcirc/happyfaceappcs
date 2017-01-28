//
//  HFLoginViewController.swift
//  happyface
//
//  Created by Cassy Stone on 8/6/16.
//  Copyright © 2016 Cassandra Stone. All rights reserved.
//

import Parse
import ParseUI
import UIKit

class HFLoginViewController: PFLogInViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(colorLiteralRed: (84/255), green: (194/255), blue: (251/255), alpha: 1.0)
        
        self.logInView!.logo = UIImageView(image: UIImage(named: "happyface"))
        self.logInView!.passwordForgottenButton?.setTitleColor(UIColor.white, for: UIControlState())
//        self.logInView!.logInButton?.backgroundColor = UIColor(colorLiteralRed: (20/255), green: (46/255), blue: (124/255), alpha: 1.0)
//        self.logInView!.logInButton?.tintColor = UIColor(colorLiteralRed: (20/255), green: (46/255), blue: (124/255), alpha: 1.0)
//        let happyBlue = UIColor(colorLiteralRed: (84/255), green: (194/255), blue: (251/255), alpha: 1.0)     
//        self.logInView!.logInButton?.layer.backgroundColor = happyBlue.CGColor
//        self.logInView!.logInButton?.layer.cornerRadius = 4
        self.logInView?.logInButton?.setTitleColor(UIColor.white, for: UIControlState())
//        self.logInView?.logInButton?.setImage(UIImage(named: "background"), forState: UIControlState.Normal)
        self.signUpController!.signUpView!.backgroundColor = UIColor(colorLiteralRed: (84/255), green: (194/255), blue: (251/255), alpha: 1.0)
                self.signUpController!.signUpView!.logo = UIImageView(image: UIImage(named: "happyface"))

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
//    override func viewDidLayoutSubviews() {
//        self.logInView!.logInButton?.backgroundColor = UIColor(colorLiteralRed: (20/255), green: (46/255), blue: (124/255), alpha: 1.0)
//        self.logInView!.logInButton?.tintColor = UIColor(colorLiteralRed: (20/255), green: (46/255), blue: (124/255), alpha: 1.0)
//    }

}
