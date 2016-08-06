//
//  ProductInfoViewController.swift
//  happyface
//
//  Created by Cassy Stone on 7/21/16.
//  Copyright © 2016 Cassandra Stone. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class ProductInfoViewController: UIViewController, UIPickerViewDelegate {
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var morningLabel: UILabel!
    @IBOutlet weak var middayLabel: UILabel!
    @IBOutlet weak var nightLabel: UILabel!
    @IBOutlet weak var selectLabel: UILabel!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var rXImage: UIImageView!

    var routine: Routine?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func unwindToContainerVC(segue: UIStoryboardSegue) {
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
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
            let formatter = NSDateFormatter()
            formatter.dateStyle = NSDateFormatterStyle.LongStyle
            let today = formatter.stringFromDate(routine.today)
            let dateString = "Date added: \(today)."
            infoLabel.text = dateString.uppercaseString
            notesTextView.text = "\(routine.additionalNotes)"
        }
    }

    
    // MARK: UIPickerViewDataSource
    
/*    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 13
    }
    
    // MARK: UIPickerViewDelegate
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        
        iconPicker.transform = CGAffineTransformMakeScale(2, 2)
        
//        let myInsets: UIEdgeInsets = UIEdgeInsetsMake(25, 25, 25, 25)
        
        var myImageView = UIImageView()
        
        switch row {
        case 0:
            myImageView = UIImageView(image: UIImage(named:"heartp"))
        case 1:
            myImageView.image = nil
        case 2:
            myImageView = UIImageView(image: UIImage(named:"AMp"))
        case 3:
            myImageView.image = nil
        case 4:
            myImageView = UIImageView(image: UIImage(named:"PMp"))
        case 5:
            myImageView.image = nil
        case 6:
            myImageView = UIImageView(image: UIImage(named:"rXp"))
        case 7:
            myImageView.image = nil
        case 8:
            myImageView = UIImageView(image: UIImage(named:"eyep"))
        case 9:
            myImageView.image = nil
        case 10:
            myImageView = UIImageView(image: UIImage(named:"SOSp"))
        case 11:
            myImageView.image = nil
        case 12:
            myImageView = UIImageView(image: UIImage(named:"lipsp"))
        default:
            myImageView.image = nil
            return myImageView
        }
        return myImageView
    }

   func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    
    let realm = RLMRealm.defaultRealm()
    realm.beginWriteTransaction()
    if row%2 == 0 {
    routine?.iconNum = row
    }

    
        // do something with selected row
    }
} */

    /*    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    */
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            if identifier == "editSegue" {
                let destinatonVC = segue.destinationViewController as! EditItemViewController
                destinatonVC.routine = self.routine
        
    }
 
}
    }}