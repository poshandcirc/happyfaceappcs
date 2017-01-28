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
        NotificationCenter.default.addObserver(self, selector: #selector(AddItemViewController.keyboardWillShow(_:)), name:NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.addObserver(self, selector: #selector(AddItemViewController.keyboardWillHide(_:)), name:NSNotification.Name.UIKeyboardWillHide, object: self.view.window)

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    func keyboardWillHide(_ sender: Notification) {
        let userInfo: [AnyHashable: Any] = sender.userInfo!
        let keyboardSize: CGSize = (userInfo[UIKeyboardFrameBeginUserInfoKey]! as AnyObject).cgRectValue.size
        if infoTextField.isEditing == true {
        self.view.frame.origin.y += keyboardSize.height
    }
    }
    
    func keyboardWillShow(_ sender: Notification) {
        let userInfo: [AnyHashable: Any] = sender.userInfo!
        let keyboardSize: CGSize = (userInfo[UIKeyboardFrameBeginUserInfoKey]! as AnyObject).cgRectValue.size
        let offset: CGSize = (userInfo[UIKeyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue.size
        
        if infoTextField.isEditing == true {
        if keyboardSize.height == offset.height {
            print("offset")
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.view.frame.origin.y -= keyboardSize.height
            })
        } else {
            print("not")
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
    
    @IBAction func cancelAction(_ sender: AnyObject) {
        self.navigationController?.popToRootViewController(animated: true)
        }
    
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
        if productNameTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Wait a second!", message: "Looks like you forgot a name! Are you sure you want to add this?", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
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
            
        let pRoutine = ParRoutine()
        pRoutine.itemName = productNameTextField.text!
        pRoutine.morningUse = morningBool
        pRoutine.middayUse = middayBool
        pRoutine.nightUse = nightBool
        pRoutine.selectiveUse = selectBool
        pRoutine.additionalNotes = infoTextField.text!
        pRoutine.currentUse = true
        pRoutine.isPrescription = prescriptBool
        pRoutine.today = Date()
        pRoutine.uploadRoutine()
            
    self.navigationController?.popToRootViewController(animated: true)
    }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
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

