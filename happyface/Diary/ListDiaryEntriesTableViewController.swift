//
//  ListDiaryEntriesTableViewController.swift
//  happyface
//
//  Created by Cassy Stone on 7/12/16.
//  Copyright © 2016 Cassandra Stone. All rights reserved.
//

import UIKit
import RealmSwift
import Parse

class ListDiaryEntriesTableViewController: UITableViewController {
    var entries: Results<Entry>! {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.layer.cornerRadius = 10
  //      tableView.layer.masksToBounds = true
        entries = RealmHelper.retrieveNonEmptyEntry()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        tableView.layer.cornerRadius = 10
  //      tableView.layer.masksToBounds = true
        entries = RealmHelper.retrieveNonEmptyEntry()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "diaryEntryCell", for: indexPath) as! DiaryEntryCellTableViewCell
        let row = indexPath.row
        let entry = entries[row]
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.long
        let entryDate = entry.date
        cell.entryDateLabel.text = formatter.string(from: entryDate)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
//            let entryDate = entries[indexPath.row].date
//            print("\(entryDate)")
//            ParseHelper.deleteEntry(entries[indexPath.row].date)
            RealmHelper.deleteEntry(entries[indexPath.row])
            entries = RealmHelper.retrieveNonEmptyEntry()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "displayEntry" {
                print("Table view cell tapped")
                let indexPath = tableView.indexPathForSelectedRow!
                let entry = entries[indexPath.row]
                let entryStatsUIViewController = segue.destination as! EntryStatsUIViewController
                entryStatsUIViewController.entry = entry
            }
            else if identifier == "addEntry" {
                print("+ button tapped")
//                let addDiaryEntryViewController = segue.destinationViewController as! AddDiaryEntryViewController
                
            }
        }
    }


    /*
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     if let identifier = segue.identifier {
     if identifier == "displayNote" {
     print("Table view cell tapped")
     } else if identifier == "addNote" {
     print("+ button tapped")
     }
     }
     }
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
