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
import Parse

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
    var currentBool: Bool = true
    var originalName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(EditItemViewController.keyboardWillShow(_:)), name:NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.addObserver(self, selector: #selector(EditItemViewController.keyboardWillHide(_:)), name:NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
        
        productInfoTextField!.delegate = self
        productNameTextField!.delegate = self
        if let routine = routine {
            originalName = routine.itemName
            productNameTextField.text = "\(routine.itemName)"
            func textViewDidChange(_ textView: UITextView) { //Handle the text changes here
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
            if routine.currentUse == false {
                self.currentBool == false
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NotificationCenter.default.addObserver(self, selector: #selector(EditItemViewController.keyboardWillShow(_:)), name:NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.addObserver(self, selector: #selector(EditItemViewController.keyboardWillHide(_:)), name:NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
        
        productInfoTextField!.delegate = self
        productNameTextField!.delegate = self
        if let routine = routine {
            productNameTextField.text = "\(routine.itemName)"
            func textViewDidChange(_ textView: UITextView) { //Handle the text changes here
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
    
    func keyboardWillHide(_ sender: Foundation.Notification) {
        let userInfo: [AnyHashable: Any] = sender.userInfo!
        let keyboardSize: CGSize = (userInfo[UIKeyboardFrameBeginUserInfoKey]! as AnyObject).cgRectValue.size
        if productInfoTextField.isFirstResponder == true {
// YO WHY DO WE HAVE TO DIVIDE BY TWO FOR THIS FRAME FIND OUT K
            self.view.frame.origin.y += keyboardSize.height/2
        }
    }
    
    func keyboardWillShow(_ sender: Foundation.Notification) {
        let userInfo: [AnyHashable: Any] = sender.userInfo!
        let keyboardSize: CGSize = (userInfo[UIKeyboardFrameBeginUserInfoKey]! as AnyObject).cgRectValue.size
        let offset: CGSize = (userInfo[UIKeyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue.size
        
        if productInfoTextField.isFirstResponder == true {
            if keyboardSize.height == offset.height {
                UIView.animate(withDuration: 0.1, animations: { () -> Void in
                    self.view.frame.origin.y -= keyboardSize.height/2
                })
            } else {
                UIView.animate(withDuration: 0.1, animations: { () -> Void in
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
    
    @IBAction func morningUse(_ sender: UISwitch) {
        if morningSwitch.isOn == true {
            morningBool = true
        }
        else {
            morningBool = false
        }
    }
    @IBAction func middayUse(_ sender: UISwitch) {
        if middaySwitch.isOn == true  {
            middayBool = true
        }
        else {
            middayBool = false
        }
    }
    @IBAction func nightUse(_ sender: UISwitch) {
        if nightSwitch.isOn == true  {
            nightBool = true
        }
        else {
            nightBool = false
        }
    }
    @IBAction func selectUse(_ sender: UISwitch) {
        if selectiveSwitch.isOn == true  {
            selectBool = true
            print("something man")
        }
        else {
            selectBool = false
        }
    }
    
    @IBAction func isPrescript(_ sender: UISegmentedControl) {
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
    
    @IBAction func saveProduct(_ sender: UIButton) {
        let realm = RLMRealm.default()
        realm.beginWriteTransaction()
        routine!.morningUse = morningBool
        routine!.middayUse = middayBool
        routine!.nightUse = nightBool
        routine!.selectiveUse = selectBool
        routine!.currentUse = currentBool
        routine!.additionalNotes = productInfoTextField.text!
        routine!.itemName = productNameTextField.text!
        routine!.isPrescription = prescriptBool
        try! realm.commitWriteTransaction()
        print("edit test")
        
        ParseHelper.updateRoutine(originalName, newItemName: productNameTextField.text!, morningUse: morningBool, middayUse: middayBool, nightUse: nightBool, selectiveUse: selectBool, additionalNotes: productInfoTextField.text!, currentUse: currentBool, isPrescription: prescriptBool)
        
    self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
    }

}

