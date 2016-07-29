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
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentRoutineCount
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            let realm = RLMRealm.defaultRealm()
            realm.beginWriteTransaction()
            routines[indexPath.row].currentUse = false
            routines = RealmHelper.retrieveCurrentRoutine()
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("productCell", forIndexPath: indexPath) as! RoutineTableViewCell
        let row = indexPath.row
        let routine = routines[row]
        cell.productNameLabel.text = routine.itemName
        cell.prodIcon.image = UIImage(named: "heart")
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
