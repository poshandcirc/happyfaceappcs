//
//  AddItemViewController.swift
//  happyface
//
//  Created by Cassy Stone on 7/21/16.
//  Copyright © 2016 Cassandra Stone. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {
    @IBOutlet weak var productNameTextField: UITextField!
    @IBOutlet weak var morningSwitch: UISwitch!
    @IBOutlet weak var middaySwitch: UISwitch!
    @IBOutlet weak var nightSwitch: UISwitch!
    @IBOutlet weak var selectiveSwitch: UISwitch!
    @IBOutlet weak var infoTextField: UITextField!
 

    var morningBool: Bool = false
    var middayBool: Bool = false
    var nightBool: Bool = false
    var selectBool: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    @IBAction func saveProduct(sender: UIButton) {
        let routine = Routine()
        routine.morningUse = morningBool
        routine.middayUse = middayBool
        routine.nightUse = nightBool
        routine.selectiveUse = selectBool
        routine.currentUse = true
        routine.additionalNotes = infoTextField.text!
        routine.itemName = productNameTextField.text!
        RealmHelper.addRoutine(routine)
        print("is this working")
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
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
