//
//  RecoverProductViewController.swift
//  happyface
//
//  Created by Cassy Stone on 7/21/16.
//  Copyright © 2016 Cassandra Stone. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class RecoverProductViewController: UIViewController {
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var morningLabel: UILabel!
    @IBOutlet weak var middayLabel: UILabel!
    @IBOutlet weak var nightLabel: UILabel!
    @IBOutlet weak var selectLabel: UILabel!
    @IBOutlet weak var infoLabel: UITextView!
    @IBOutlet weak var recoverButton: UIButton!
    var routine: Routine?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
/*    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    } */
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if routine?.currentUse == true {
            recoverButton.isHidden = true
        }
        if let routine = routine {
            productNameLabel.text = "\(routine.itemName)"
            if routine.morningUse == true {
                morningLabel.textColor = UIColor.black
            }
            if routine.middayUse == true {
                middayLabel.textColor = UIColor.black
            }
            if routine.nightUse == true {
                nightLabel.textColor = UIColor.black
            }
            if routine.selectiveUse == true {
                selectLabel.textColor = UIColor.black
            }
            infoLabel.text = "\(routine.additionalNotes)"
        }
    }
    

    @IBAction func recoverItem(_ sender: UIButton) {
        let realm = RLMRealm.default()
        realm.beginWriteTransaction()
        routine?.currentUse = true
        try! realm.commitWriteTransaction()
        self.navigationController?.popToRootViewController(animated: true)
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
