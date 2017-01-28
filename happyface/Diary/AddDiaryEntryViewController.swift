//
//  AddDiaryEntryViewController.swift
//  happyface
//
//  Created by Cassy Stone on 7/12/16.
//  Copyright © 2016 Cassandra Stone. All rights reserved.
//

import UIKit
import Foundation
import Realm
import Parse

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
    

    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func acneValueChanged(_ sender: UISlider) {
        acneSliderValue = Int(acneSlider.value)
    }
    @IBAction func drynessValueChanged(_ sender: UISlider) {
        drynessSliderValue = Int(drynessSlider.value)
    }
    @IBAction func oilinessValueChanged(_ sender: UISlider) {
        oilinessSliderValue = Int(oilinessSlider.value)
    }
    @IBAction func rednessValueChanged(_ sender: UISlider) {
        rednessSliderValue = Int(rednessSlider.value)
    }
    @IBAction func routineCheck(_ sender: UISegmentedControl) {
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
    
    func daysBetweenDates(_ startDate: Date, endDate: Date) -> Int
    {
        let calendar = Calendar.current
        
        let components = (calendar as NSCalendar).components([.day], from: startDate, to: endDate, options: [])
        
        return components.day!
    }
    
    
    @IBAction func saveEntry(_ sender: UIButton) {
        let entries = RealmHelper.retrieveEntry()
        
        // Make sure entries exist (not the first entry)
        if entries.count != 0 {
         lastStreak = entries.last!.routineStreak
         let dateA = entries.last!.date
         let dateB = Date()
         let calendar = Calendar.current
         let startDateA = calendar.startOfDay(for: dateA)
         let formatter = DateFormatter()
         formatter.dateStyle = DateFormatter.Style.long
         let dateAString = formatter.string(from: dateA)
         let dateBString = formatter.string(from: dateB)
         //   }
 //       if ((daysBetweenDates(dateA, endDate: dateB) == 0) && (dateA.isEqualToDate(dateB) == false)) {
        if dateAString == dateBString {
            let alert = UIAlertController(title: "Sorry!", message: "For the best results, you should only add one diary entry per day. Please delete the initial entry if you would like to update today's stats.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
//            RealmHelper.deleteEntry(entries.last!)
            print("\(daysBetweenDates(dateA, endDate: dateB))")
            
        }
//        else if ((daysBetweenDates(dateA, endDate: dateB) == 0) && (dateAString != dateBString)) {
        //TEST THIS LATER LOL
        else if ((startDateA.timeIntervalSince(dateB) > TimeInterval(-172800)) && (dateAString != dateBString)) {
            print(dateB)
             let entry = Entry()
             entry.acneScale = acneSliderValue
             entry.drynessScale = drynessSliderValue
             entry.oilinessScale = oilinessSliderValue
             entry.rednessScale = rednessSliderValue
             entry.date = Date()
             entry.routineStreak = lastStreak + routineStreakCounter
             entry.isEmpty = false
             entry.name = entries.last!.name
             print("save tapped")
             RealmHelper.addEntry(entry)
             self.navigationController?.popToRootViewController(animated: true)
            
            // adding Parse version Entry
            
            let pEntry = ParEntry()
            pEntry.acneScale = acneSliderValue
            pEntry.drynessScale = drynessSliderValue
            pEntry.oilinessScale = oilinessSliderValue
            pEntry.rednessScale = rednessSliderValue
            pEntry.isEmpty = false
            pEntry.date = Date()
            pEntry.uploadEntry()
            
         }
        // If days no consecutive:
        else if daysBetweenDates(startDateA, endDate: dateB) >= 1 {
        print("\(daysBetweenDates(startDateA, endDate: dateB)), not consec")
        var x = 0
        // Create entry objects with "0" values for each day to fill in all consecutive days
            // new entry is added for every day in between dates
        var prevDate = startDateA
        while x < daysBetweenDates(dateA, endDate: dateB) {
         let entry = Entry()
         entry.isEmpty = true
         entry.name = entries.last!.name
         entry.acneScale = 0
         entry.drynessScale = 0
         entry.oilinessScale = 0
         entry.rednessScale = 0
            // set your previous day to the next day so you can keep building day by day
            prevDate = prevDate.addingTimeInterval(86400)
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
            entry.date = Date()
            entry.routineStreak = routineStreakCounter
            entry.isEmpty = false
            entry.name = entries.last!.name
            print("save tapped")
            RealmHelper.addEntry(entry)
            
        // adding Parse version Entry
        let pEntry = ParEntry()
            pEntry.acneScale = acneSliderValue
            pEntry.drynessScale = drynessSliderValue
            pEntry.oilinessScale = oilinessSliderValue
            pEntry.rednessScale = rednessSliderValue
            pEntry.isEmpty = false
            pEntry.date = Date()
            pEntry.uploadEntry()
            
            self.navigationController?.popToRootViewController(animated: true)
        }
      }
        else if entries.count == 0 {
            let entry = Entry()
            entry.isEmpty = false
            entry.acneScale = acneSliderValue
            entry.drynessScale = drynessSliderValue
            entry.oilinessScale = oilinessSliderValue
            entry.rednessScale = rednessSliderValue
            entry.date = Date()
            entry.routineStreak = routineStreakCounter
            let realm = RLMRealm.default()
            realm.beginWriteTransaction()
            entry.name = ""
            try! realm.commitWriteTransaction()
            print("save tapped")
            RealmHelper.addEntry(entry)
            
            // adding Parse version Entry
            let pEntry = ParEntry()
            pEntry.acneScale = acneSliderValue
            pEntry.drynessScale = drynessSliderValue
            pEntry.oilinessScale = oilinessSliderValue
            pEntry.rednessScale = rednessSliderValue
            pEntry.isEmpty = false
            pEntry.date = Date()
            pEntry.uploadEntry()
            
            
            self.navigationController?.popToRootViewController(animated: true)
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
