//
//  AddDiaryEntryViewController.swift
//  happyface
//
//  Created by Cassy Stone on 7/12/16.
//  Copyright © 2016 Cassandra Stone. All rights reserved.
//

import UIKit
import Foundation

class AddDiaryEntryViewController: UIViewController {
    @IBOutlet weak var acneSlider: UISlider!
    @IBOutlet weak var drynessSlider: UISlider!
    @IBOutlet weak var oilinessSlider: UISlider!
    @IBOutlet weak var rednessSlider: UISlider!
    @IBOutlet weak var routineController: UISegmentedControl!
    @IBOutlet weak var titleLabel: UILabel!
    var lastStreak: Int = 0
    var routineStreakCounter: Int = 0
    var acneSliderValue: Int = 0
    var drynessSliderValue: Int = 0
    var oilinessSliderValue: Int = 0
    var rednessSliderValue: Int = 0
    var routineStick: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cancelAction(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func acneValueChanged(sender: UISlider) {
        acneSliderValue = Int(acneSlider.value)
    }
    @IBAction func drynessValueChanged(sender: UISlider) {
        drynessSliderValue = Int(drynessSlider.value)
    }
    @IBAction func oilinessValueChanged(sender: UISlider) {
        oilinessSliderValue = Int(oilinessSlider.value)
    }
    @IBAction func rednessValueChanged(sender: UISlider) {
        rednessSliderValue = Int(rednessSlider.value)
    }
    @IBAction func routineCheck(sender: UISegmentedControl) {
        switch routineController.selectedSegmentIndex
        {
        case 0:
            routineStick = true
            routineStreakCounter = 1
        case 1:
            routineStreakCounter = 0
        default:
            break
        }
    }
    
    func daysBetweenDates(startDate: NSDate, endDate: NSDate) -> Int
    {
        let calendar = NSCalendar.currentCalendar()
        
        let components = calendar.components([.Day], fromDate: startDate, toDate: endDate, options: [])
        
        return components.day
    }
    
    @IBAction func saveEntry(sender: UIButton) {
        let entries = RealmHelper.retrieveEntry()
        
        // Make sure entries exist (not the first entry)
        if entries.count != 0 {
         lastStreak = entries.last!.routineStreak
         let dateA = entries.last!.date
         let dateB = NSDate()
         let formatter = NSDateFormatter()
         formatter.dateStyle = NSDateFormatterStyle.LongStyle
         let dateAString = formatter.stringFromDate(dateA)
         let dateBString = formatter.stringFromDate(dateB)
         //   }
 //       if ((daysBetweenDates(dateA, endDate: dateB) == 0) && (dateA.isEqualToDate(dateB) == false)) {
        if dateAString == dateBString {
            let alert = UIAlertController(title: "Sorry!", message: "For the best results, you can only add one diary entry per day. Please delete the initial entry if you would like to update today's stats.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else if ((daysBetweenDates(dateA, endDate: dateB) == 0) && (dateAString != dateBString)) {
             let entry = Entry()
             entry.acneScale = acneSliderValue
             entry.drynessScale = drynessSliderValue
             entry.oilinessScale = oilinessSliderValue
             entry.rednessScale = rednessSliderValue
             entry.date = NSDate()
             entry.routineStreak = lastStreak + routineStreakCounter
             entry.isEmpty = false
             print("save tapped")
             RealmHelper.addEntry(entry)
             self.navigationController?.popToRootViewControllerAnimated(true)
         }
        // If days no consecutive:
        else if daysBetweenDates(dateA, endDate: dateB) >= 1 {
        var x = 0
        // Create entry objects with "0" values for each day to fill in all consecutive days
            // new entry is added for every day in between dates
        var prevDate = dateA
        while x < daysBetweenDates(dateA, endDate: dateB) {
         let entry = Entry()
         entry.isEmpty = true
         entry.acneScale = 0
         entry.drynessScale = 0
         entry.oilinessScale = 0
         entry.rednessScale = 0
            // set your previous day to the next day so you can keep building day by day
            prevDate = prevDate.dateByAddingTimeInterval(86400)
         entry.date = prevDate // make this the date after
         entry.routineStreak = 0
         x += 1
         print("save tapped")
         RealmHelper.addEntry(entry)
         }
        let entry = Entry()
            entry.acneScale = acneSliderValue
            entry.drynessScale = drynessSliderValue
            entry.oilinessScale = oilinessSliderValue
            entry.rednessScale = rednessSliderValue
            entry.date = NSDate()
            entry.routineStreak = routineStreakCounter
            entry.isEmpty = false
            print("save tapped")
            RealmHelper.addEntry(entry)
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
      }
        else if entries.count == 0 {
            let entry = Entry()
            entry.isEmpty = false
            entry.acneScale = acneSliderValue
            entry.drynessScale = drynessSliderValue
            entry.oilinessScale = oilinessSliderValue
            entry.rednessScale = rednessSliderValue
            entry.date = NSDate()
            entry.routineStreak = routineStreakCounter
            print("save tapped")
            RealmHelper.addEntry(entry)
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
    }
  }
        
 /*


    let entry = Entry()
    entry.acneScale = acneSliderValue
    entry.drynessScale = drynessSliderValue
    entry.oilinessScale = oilinessSliderValue
    entry.rednessScale = rednessSliderValue
    entry.date = NSDate()
    entry.routineStreak = routineStreakCounter
    print("save tapped")
    RealmHelper.addEntry(entry)
    self.navigationController?.popToRootViewControllerAnimated(true)
}
 */
 /*   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let listDiaryEntriesTableViewController = segue.destinationViewController as! ListDiaryEntriesTableViewController
        if segue.identifier == "SAVE YOUR ENTRY" {
            let entry = Entry()
            entry.acneScale = "\(acneSliderValue)"
            entry.drynessScale = "\(drynessSliderValue)"
            entry.oilinessScale = "\(oilinessSliderValue)"
            entry.rednessScale = "\(rednessSliderValue)"
            entry.date = NSDate()
            RealmHelper.addEntry(entry)
        }
        ListDiaryEntriesTableViewController.entries = RealmHelper.retrieveEntry()
    } */
    
/* NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
dayComponent.day = 1;

NSCalendar *theCalendar = [NSCalendar currentCalendar];
NSDate *nextDate = [theCalendar dateByAddingComponents:dayComponent toDate:[NSDate date] options:0]; */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
