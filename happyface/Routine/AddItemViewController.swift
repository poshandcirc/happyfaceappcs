//
//  AddItemViewController.swift
//  happyface
//
//  Created by Cassy Stone on 7/21/16.
//  Copyright © 2016 Cassandra Stone. All rights reserved.
//

import Foundation
import UIKit

class AddItemViewController: UIViewController {
    @IBOutlet weak var productNameTextField: UITextField!
    @IBOutlet weak var morningSwitch: UISwitch!
    @IBOutlet weak var middaySwitch: UISwitch!
    @IBOutlet weak var nightSwitch: UISwitch!
    @IBOutlet weak var selectiveSwitch: UISwitch!
    @IBOutlet weak var infoTextField: UITextField!
    @IBOutlet weak var prescriptControl: UISegmentedControl!
 

    var morningBool: Bool = false
    var middayBool: Bool = false
    var nightBool: Bool = false
    var selectBool: Bool = false
    var prescriptBool: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: self.view.window)
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
    }
    
    func keyboardWillHide(sender: NSNotification) {
        let userInfo: [NSObject : AnyObject] = sender.userInfo!
        let keyboardSize: CGSize = userInfo[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue.size
        if infoTextField.editing == true {
        self.view.frame.origin.y += keyboardSize.height
    }
    }
    
    func keyboardWillShow(sender: NSNotification) {
        let userInfo: [NSObject : AnyObject] = sender.userInfo!
        let keyboardSize: CGSize = userInfo[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue.size
        let offset: CGSize = userInfo[UIKeyboardFrameEndUserInfoKey]!.CGRectValue.size
        
        if infoTextField.editing == true {
        if keyboardSize.height == offset.height {
            print("offset")
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.view.frame.origin.y -= keyboardSize.height
            })
        } else {
            print("not")
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.view.frame.origin.y += keyboardSize.height - offset.height
            })
        }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelAction(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
        }
    
    @IBAction func morningUse(sender: UISwitch) {
        if morningSwitch.on == true {
            morningBool = true
        }
        else {
            morningBool = false
        }
    }
    @IBAction func middayUse(sender: UISwitch) {
        if middaySwitch.on == true  {
            middayBool = true
        }
        else {
            middayBool = false
        }
    }
    @IBAction func nightUse(sender: UISwitch) {
        if nightSwitch.on == true  {
            nightBool = true
        }
        else {
            nightBool = false
        }
    }
    @IBAction func selectUse(sender: UISwitch) {
        if selectiveSwitch.on == true  {
            selectBool = true
            print("something man")
        }
        else {
            selectBool = false
        }
    }
    
    @IBAction func isPrescript(sender: UISegmentedControl) {
        switch prescriptControl.selectedSegmentIndex
        {
        case 0:
            prescriptBool = true
        case 1:
            prescriptBool = false
        default:
            break
        }
    }
    
    @IBAction func saveProduct(sender: UIButton) {
        if productNameTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Wait a second!", message: "Looks like you forgot a name! Are you sure you want to add this?", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else {
        let routine = Routine()
        routine.morningUse = morningBool
        routine.middayUse = middayBool
        routine.nightUse = nightBool
        routine.selectiveUse = selectBool
        routine.currentUse = true
        routine.additionalNotes = infoTextField.text!
        routine.itemName = productNameTextField.text!
        routine.isPrescription = prescriptBool
        RealmHelper.addRoutine(routine)
        print("is this working")
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: self.view.window)
    }

// http://stackoverflow.com/questions/26070242/move-view-with-keyboard-using-swift
// http://stackoverflow.com/questions/28813339/move-a-view-up-only-when-the-keyboard-covers-an-input-field

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
