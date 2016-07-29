//
//  ProductInfoViewController.swift
//  happyface
//
//  Created by Cassy Stone on 7/21/16.
//  Copyright © 2016 Cassandra Stone. All rights reserved.
//

import UIKit
import RealmSwift

class ProductInfoViewController: UIViewController, UIPickerViewDelegate {
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var morningLabel: UILabel!
    @IBOutlet weak var middayLabel: UILabel!
    @IBOutlet weak var nightLabel: UILabel!
    @IBOutlet weak var selectLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var iconPicker: UIPickerView!
    var iconNumVar: Int = 0

    var routine: Routine?

    override func viewDidLoad() {
        super.viewDidLoad()
        iconPicker.delegate = self
        // Do any additional setup after loading the view.
    }
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
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
            infoLabel.text = "\(routine.additionalNotes)"
        }
    }
    
    // MARK: UIPickerViewDataSource
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
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
}
/*    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        routine?.iconNum = iconNumVar
        // do something with selected row
    } /*

    /*    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
*/*/
