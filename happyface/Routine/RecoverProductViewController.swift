//
//  RecoverProductViewController.swift
//  happyface
//
//  Created by Cassy Stone on 7/21/16.
//  Copyright © 2016 Cassandra Stone. All rights reserved.
//

import UIKit

class RecoverProductViewController: UIViewController {
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var morningLabel: UILabel!
    @IBOutlet weak var middayLabel: UILabel!
    @IBOutlet weak var nightLabel: UILabel!
    @IBOutlet weak var selectLabel: UILabel!
    @IBOutlet weak var infoLabel: UITextView!
    @IBOutlet weak var rXImage: UIImageView!
    @IBOutlet weak var recoverButton: UIButton!
    var routine: Routine?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
/*    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    } */
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if routine?.currentUse == true {
            recoverButton.hidden = true
        }
        if let routine = routine {
            productNameLabel.text = "\(routine.itemName)"
            if routine.morningUse == true {
                morningLabel.textColor = UIColor.blackColor()
            }
            if routine.middayUse == true {
                middayLabel.textColor = UIColor.blackColor()
            }
            if routine.nightUse == true {
                nightLabel.textColor = UIColor.blackColor()
            }
            if routine.selectiveUse == true {
                selectLabel.textColor = UIColor.blackColor()
            }
            if routine.isPrescription == true {
                rXImage.image = UIImage(named: "rX")
            }
            else if productNameLabel.text!.uppercaseString.containsString("EYE") || productNameLabel.text!.uppercaseString.containsString("LASH") {
                rXImage.image = UIImage(named: "eye")
            }
            else if productNameLabel.text!.uppercaseString.containsString("LIP") || productNameLabel.text!.uppercaseString.containsString("MOUTH") {
                rXImage.image = UIImage(named: "lips")
            }
            else if (routine.morningUse == true) && (routine.nightUse == false) {
                rXImage.image = UIImage(named: "AM")
            }
            else if (routine.nightUse == true) && (routine.morningUse == false) {
                rXImage.image = UIImage(named: "PM")
            }
            else if routine.selectiveUse == true {
                rXImage.image = UIImage(named: "SOS")
            }
            else {
                rXImage.image = UIImage(named: "heart")
            }

            infoLabel.text = "\(routine.additionalNotes)"
        }
    }
    

    @IBAction func recoverItem(sender: UIButton) {
        routine?.currentUse = true
        self.navigationController?.popToRootViewControllerAnimated(true)
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
