//
//  ListRoutineItemsTableViewController.swift
//  happyface
//
//  Created by Cassy Stone on 7/21/16.
//  Copyright © 2016 Cassandra Stone. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import Foundation

class ListRoutineItemsTableViewController: UITableViewController {
    var currentRoutineCount: Int = 0
    var routines: Results<Routine>! {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 //       tableView.layer.cornerRadius = 10
   //     tableView.layer.masksToBounds = true
        self.tableView.backgroundColor = UIColor(colorLiteralRed: (84/255), green: (194/255), blue: (251/255), alpha: 1.0)
        routines = RealmHelper.retrieveCurrentRoutine()
        currentRoutineCount = routines.count
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
 //       tableView.layer.cornerRadius = 10
   //     tableView.layer.masksToBounds = true
        self.tableView.backgroundColor = UIColor(colorLiteralRed: (84/255), green: (194/255), blue: (251/255), alpha: 1.0)
        routines = RealmHelper.retrieveCurrentRoutine()
        currentRoutineCount = routines.count
    }
    
    
    @IBAction func unwindToContainerVC(segue: UIStoryboardSegue) {

        let dst: UIViewController = segue.destinationViewController
        let transition: CATransition = CATransition()
        let timeFunc : CAMediaTimingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.duration = 0.35
        transition.timingFunction = timeFunc
        transition.type = kCATransitionFade
        transition.subtype = kCATransitionFromTop
        dst.navigationController!.view.layer.addAnimation(transition, forKey: kCATransition)
        

        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routines.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
/*    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            if RealmHelper.retrieveRoutine().count != 0 {
            RealmHelper.deleteRoutine(routines[indexPath.row])
            routines = RealmHelper.retrieveRoutine()
            }
        }
    } */
    
override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
           let realm = RLMRealm.defaultRealm()
        realm.beginWriteTransaction()
        routines[indexPath.row].currentUse = false
            routines = RealmHelper.retrieveCurrentRoutine()
        try! realm.commitWriteTransaction()
        }
    }
    
/*    @IBAction func historyButton(sender: AnyObject) {
        sender.navigationController!(UINavigationController, animationControllerForOperation: UINavigationControllerOperation, fromViewController: ListRoutineItemsTableViewController, toViewController: ListHistoryTableViewController)
    } */
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("productCell", forIndexPath: indexPath) as! RoutineTableViewCell
        let row = indexPath.row
        let routine = routines[row]
        cell.productNameLabel.text = routine.itemName
        if routine.isPrescription == true {
            cell.prodIcon.image = UIImage(named: "rX")
        }
        else if cell.productNameLabel.text!.uppercaseString.containsString("EYE") || cell.productNameLabel.text!.uppercaseString.containsString("LASH") {
            cell.prodIcon.image = UIImage(named: "eye")
        }
        else if cell.productNameLabel.text!.uppercaseString.containsString("LIP") || cell.productNameLabel.text!.uppercaseString.containsString("MOUTH") || cell.productNameLabel.text!.uppercaseString.containsString("BALM") {
            cell.prodIcon.image = UIImage(named: "lips")
        }
        else if (routine.morningUse == true) && (routine.nightUse == false) {
            cell.prodIcon.image = UIImage(named: "AM")
        }
        else if (routine.nightUse == true) && (routine.morningUse == false) {
            cell.prodIcon.image = UIImage(named: "PM")
        }
        else if routine.selectiveUse == true {
            cell.prodIcon.image = UIImage(named: "SOS")
        }
        else {
            cell.prodIcon.image = UIImage(named: "heart")
        }
        
        /*
        if routine.iconNum == 2 {
        cell.prodIcon.image = UIImage(named: "AM")
        }
        else if routine.iconNum == 4 {
            cell.prodIcon.image = UIImage(named: "PM")
        }
        else if routine.iconNum == 6 {
            cell.prodIcon.image = UIImage(named: "rX")
        }
        else if routine.iconNum == 8 {
            cell.prodIcon.image = UIImage(named: "eye")
        }
        else if routine.iconNum == 10 {
            cell.prodIcon.image = UIImage(named: "SOS")
        }
        else if routine.iconNum == 12 {
            cell.prodIcon.image = UIImage(named: "lips")
        }
        else {
            cell.prodIcon.image = UIImage(named: "heart")
        } */
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if identifier == "displayRoutine" {
                print("Table view cell tapped")
                let indexPath = tableView.indexPathForSelectedRow!
                let routine = routines[indexPath.row]
                let productInfoViewController = segue.destinationViewController as! ProductInfoViewController
                productInfoViewController.routine = routine
            }
            else if identifier == "addRoutine" {
                print("+ button tapped")
                //                let addDiaryEntryViewController = segue.destinationViewController as! AddDiaryEntryViewController
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
