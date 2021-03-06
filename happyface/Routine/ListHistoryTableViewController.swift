//
//  ListHistoryTableViewController.swift
//  happyface
//
//  Created by Cassy Stone on 7/21/16.
//  Copyright © 2016 Cassandra Stone. All rights reserved.
//

import UIKit
import RealmSwift

class ListHistoryTableViewController: UITableViewController {
    
    var routines: Results<Routine>! {
        didSet {
            tableView.reloadData()
        }
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        routines = RealmHelper.retrieveRoutine()
        self.navigationItem.hidesBackButton = true
//        let backItem = UIBarButtonItem(title: "Back", style: .Bordered, target: nil, action: nil)
//        self.navigationItem.setRightBarButtonItem(backItem, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        routines = RealmHelper.retrieveRoutine()
        self.navigationItem.hidesBackButton = true
//        let backItem = UIBarButtonItem(title: "Back", style: .Bordered, target: nil, action: nil)
//        self.navigationItem.setRightBarButtonItem(backItem, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routines.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "archiveProductCell", for: indexPath) as! ArchiveProductTableViewCell
        let row = indexPath.row
        let routine = routines[row]
        cell.archiveProductLabel.text = routine.itemName
        if routine.isPrescription == true {
            cell.archiveProdIcon.image = UIImage(named: "rX")
        }
        else if cell.archiveProductLabel.text!.uppercased().contains("EYE") || cell.archiveProductLabel.text!.uppercased().contains("LASH") {
            cell.archiveProdIcon.image = UIImage(named: "eye")
        }
        else if cell.archiveProductLabel.text!.uppercased().contains("LIP") || cell.archiveProductLabel.text!.uppercased().contains("MOUTH") {
            cell.archiveProdIcon.image = UIImage(named: "lips")
        }
        else if (routine.morningUse == true) && (routine.nightUse == false) {
            cell.archiveProdIcon.image = UIImage(named: "AM")
        }
        else if (routine.nightUse == true) && (routine.morningUse == false) {
            cell.archiveProdIcon.image = UIImage(named: "PM")
        }
        else if routine.selectiveUse == true {
            cell.archiveProdIcon.image = UIImage(named: "SOS")
        }
        else {
            cell.archiveProdIcon.image = UIImage(named: "heart")
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "recoverProduct" {
                let indexPath = tableView.indexPathForSelectedRow!
                let routine = routines[indexPath.row]
                let recoverProductViewController = segue.destination as! RecoverProductViewController
                recoverProductViewController.routine = routine
            }
        }
    }
    
    @IBAction func unwindToContainerVC(_ segue: UIStoryboardSegue){
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

/*    @IBAction func backAction(sender: AnyObject) {
//        dismissViewControllerAnimated(true, completion: nil)
//        print("dismissed")
    performSegueWithIdentifier("returnToCurrent", sender: nil)
    } */
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            ParseHelper.deleteRoutine(routines[indexPath.row].itemName)
            RealmHelper.deleteRoutine(routines[indexPath.row])
            routines = RealmHelper.retrieveRoutine()
        }
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
