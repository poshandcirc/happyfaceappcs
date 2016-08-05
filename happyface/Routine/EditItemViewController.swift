//
//  EditItemViewController.swift
//  happyface
//
//  Created by Cassy Stone on 8/4/16.
//  Copyright © 2016 Cassandra Stone. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class EditItemViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var productNameTextField: UITextView!
    @IBOutlet weak var morningSwitch: UISwitch!
    @IBOutlet weak var middaySwitch: UISwitch!
    @IBOutlet weak var nightSwitch: UISwitch!
    @IBOutlet weak var selectiveSwitch: UISwitch!
    @IBOutlet weak var productInfoTextField: UITextView!
    @IBOutlet weak var prescriptControl: UISegmentedControl!
    
    var routine: Routine?
    
    var morningBool: Bool = false
    var middayBool: Bool = false
    var nightBool: Bool = false
    var selectBool: Bool = false
    var prescriptBool: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: self.view.window)
        
        productInfoTextField!.delegate = self
        productNameTextField!.delegate = self
        if let routine = routine {
            productNameTextField.text = "\(routine.itemName)"
            func textViewDidChange(textView: UITextView) { //Handle the text changes here
                print(textView.text); //the textView parameter is the textView where text was changed
            }
            if routine.morningUse == true {
                self.morningSwitch.setOn(true, animated: false)
            }
            if routine.middayUse == true {
                self.middaySwitch.setOn(true, animated: false)
            }
            if routine.nightUse == true {
                self.nightSwitch.setOn(true, animated: false)
            }
            if routine.selectiveUse == true {
                self.selectiveSwitch.setOn(true, animated: false)
            }
            productInfoTextField.text = "\(routine.additionalNotes)"
            if routine.isPrescription == true {
                self.prescriptControl.selectedSegmentIndex = 0
            }
            else if routine.isPrescription == false {
                self.prescriptControl.selectedSegmentIndex = 1
            }
        }
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: self.view.window)
        
        productInfoTextField!.delegate = self
        productNameTextField!.delegate = self
        if let routine = routine {
            productNameTextField.text = "\(routine.itemName)"
            func textViewDidChange(textView: UITextView) { //Handle the text changes here
                print(textView.text); //the textView parameter is the textView where text was changed
            }
            if routine.morningUse == true {
                self.morningSwitch.setOn(true, animated: false)
                morningBool = true
            }
            if routine.middayUse == true {
                self.middaySwitch.setOn(true, animated: false)
                middayBool = true
            }
            if routine.nightUse == true {
                self.nightSwitch.setOn(true, animated: false)
                nightBool = true
            }
            if routine.selectiveUse == true {
                self.selectiveSwitch.setOn(true, animated: false)
                selectBool = true
            }
            productInfoTextField.text = "\(routine.additionalNotes)"
            if routine.isPrescription == true {
                self.prescriptControl.selectedSegmentIndex = 0
                prescriptBool = true
            }
            else if routine.isPrescription == false {
                self.prescriptControl.selectedSegmentIndex = 1
                prescriptBool = false
            }
        }
    }
    
    func keyboardWillHide(sender: NSNotification) {
        let userInfo: [NSObject : AnyObject] = sender.userInfo!
        let keyboardSize: CGSize = userInfo[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue.size
        if productInfoTextField.isFirstResponder() == true {
// YO WHY DO WE HAVE TO DIVIDE BY TWO FOR THIS FRAME FIND OUT K
            self.view.frame.origin.y += keyboardSize.height/2
        }
    }
    
    func keyboardWillShow(sender: NSNotification) {
        let userInfo: [NSObject : AnyObject] = sender.userInfo!
        let keyboardSize: CGSize = userInfo[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue.size
        let offset: CGSize = userInfo[UIKeyboardFrameEndUserInfoKey]!.CGRectValue.size
        
        if productInfoTextField.isFirstResponder() == true {
            if keyboardSize.height == offset.height {
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.view.frame.origin.y -= keyboardSize.height/2
                })
            } else {
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
    
/*    @IBAction func cancelAction(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    } */
    
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
        let realm = RLMRealm.defaultRealm()
        realm.beginWriteTransaction()
        routine!.morningUse = morningBool
        routine!.middayUse = middayBool
        routine!.nightUse = nightBool
        routine!.selectiveUse = selectBool
        routine!.currentUse = true
        routine!.additionalNotes = productInfoTextField.text!
        routine!.itemName = productNameTextField.text!
        routine!.isPrescription = prescriptBool
        try! realm.commitWriteTransaction()
        print("edit test")
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: self.view.window)
    }

}

