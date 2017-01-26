//
//  SplashViewController.swift
//  happyface
//
//  Created by Cassy Stone on 7/27/16.
//  Copyright © 2016 Cassandra Stone. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let xScale = UITraitCollection(displayScale: 3.0)   //could be 1.0, 2.0 or 3.0
        let image = UIImage(named: "invertedSmile" )?.imageAsset!.image(with: xScale)
        UIPasteboard.general.image = image;

        // Do any additional setup after loading the view.
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

}
