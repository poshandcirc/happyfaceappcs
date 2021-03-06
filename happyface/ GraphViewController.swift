//
//   GraphViewController.swift
//  happyface
//
//  Created by Cassy Stone on 7/16/16.
//  Copyright © 2016 Cassandra Stone. All rights reserved.
//

//
//  ProfileViewController.swift
//  happyface
//
//  Created by Cassy Stone on 7/15/16.
//  Copyright © 2016 Cassandra Stone. All rights reserved.
//

import UIKit
import RealmSwift
import Realm
import Charts

class GraphViewController: UIViewController {

    @IBOutlet weak var nameButton: UIButton!
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var routineControlSeg: UISegmentedControl!
    var viewSeg: Int = 0
    var datesUse: [String] = []
    var statsUse: [Double] = []
    var datesArray: [String]!
    var nameString: String = "CLICK HERE"
    @IBOutlet weak var routineStreakLabel: UILabel!
    @IBAction func routineControl(_ sender: UISegmentedControl) {
        switch routineControlSeg.selectedSegmentIndex {
        case 0:
            viewSeg = 0
            setChart(datesUse, values: statsUse)
            viewWillAppear(true)
        case 1:
            viewSeg = 1
            setChart(datesUse, values: statsUse)
            viewWillAppear(true)
        case 2:
            viewSeg = 2
            setChart(datesUse, values: statsUse)
            viewWillAppear(true)
        case 3:
            viewSeg = 3
            setChart(datesUse, values: statsUse)
            viewWillAppear(true)
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().barTintColor = UIColor.white
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(colorLiteralRed: (21/255), green: (50/255), blue: (137/255), alpha: 1.0)], for:UIControlState())
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(colorLiteralRed: (21/255), green: (50/255), blue: (137/255), alpha: 1.0)], for:.selected)
        
        barChartView.noDataText = "You're so close. Get it together Cassandra."
        
        var dates: [String] = []
        var stats: [Double] = []
        
        let allEntries = RealmHelper.retrieveEntry()
        if allEntries.count == 0 {
            routineStreakLabel.text = "Routine Streak: 0"
            nameButton.setTitle(nameString, for: UIControlState())
        }
        else if allEntries.count != 0 {
            if allEntries.last!.name.isEmpty == true {
                routineStreakLabel.text = "Routine Streak: \(allEntries.last!.routineStreak)"
                nameButton.setTitle(nameString, for: UIControlState())
            }
            else {
            routineStreakLabel.text = "Routine Streak: \(allEntries.last!.routineStreak)"
            nameString = allEntries.last!.name
            nameButton.setTitle(nameString, for: UIControlState())
            }
        }
        for entry in allEntries {
            let formatter = DateFormatter()
            formatter.dateStyle = DateFormatter.Style.long
            dates.append(formatter.string(from: entry.date))
            if viewSeg == 0 {
            stats.append(Double(entry.acneScale))

            }
            else if viewSeg == 1 {
                stats.append(Double(entry.drynessScale))
            }
            else if viewSeg == 2 {
                stats.append(Double(entry.oilinessScale))
            }
            else if viewSeg == 3 {
                stats.append(Double(entry.rednessScale))
            }
        }
        
        
        datesArray = dates
        datesUse = dates
        statsUse = stats
        setChart(dates, values: stats)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        barChartView.reloadInputViews()
        barChartView.noDataText = "You're so close. Get it together Cassandra."
        
        var dates: [String] = []
        var stats: [Double] = []
        
        let allEntries = RealmHelper.retrieveEntry()
        if allEntries.count == 0 {
            routineStreakLabel.text = "Routine Streak: 0"
            nameButton.setTitle(nameString, for: UIControlState())
        }
        else if allEntries.count != 0 {
            if allEntries.last!.name.isEmpty == true {
                routineStreakLabel.text = "Routine Streak: \(allEntries.last!.routineStreak)"
                nameButton.setTitle(nameString, for: UIControlState())
            }
            else {
                routineStreakLabel.text = "Routine Streak: \(allEntries.last!.routineStreak)"
                nameString = allEntries.last!.name
                nameButton.setTitle(nameString, for: UIControlState())
            }
        }
        for entry in allEntries {
            let formatter = DateFormatter()
            formatter.dateStyle = DateFormatter.Style.long
            dates.append(formatter.string(from: entry.date))
            if viewSeg == 0 {
                stats.append(Double(entry.acneScale))
            }
            else if viewSeg == 1 {
                stats.append(Double(entry.drynessScale))
            }
            else if viewSeg == 2 {
                stats.append(Double(entry.oilinessScale))
            }
            else if viewSeg == 3 {
                stats.append(Double(entry.rednessScale))
            }
        }
        
        datesArray = dates
        datesUse = dates
        statsUse = stats
        setChart(dates, values: stats)
        
    }
    
    func changeButton(_ string: String) {
        nameString = string
    }
    
    @IBAction func setName(_ sender: AnyObject) {
        let alertController = UIAlertController(title: "Hey, gorgeous!", message: "What's your name?", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            let field = alertController.textFields![0] as? UITextField
                // store your data
        let entries = RealmHelper.retrieveEntry()
            if entries.count != 0 {
        let realm = RLMRealm.default()
            realm.beginWriteTransaction()
        entries.last!.name = (field?.text)!
//            self.changeButton((field?.text)!)
            self.nameButton.setTitle(entries.last!.name, for: UIControlState())
            try! realm.commitWriteTransaction()
            } else {
            self.nameString = (field?.text)!
            self.nameButton.setTitle(self.nameString, for: UIControlState())
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func setChart(_ dataPoints: [String], values: [Double]) {
        barChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
        barChartView.noDataText = "You're so close. Get it together Cassandra."
        barChartView.descriptionText = ""
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<RealmHelper.retrieveEntry().count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Your Percent Happy!")
        let chartData = BarChartData(xVals: datesArray, dataSet: chartDataSet)
        barChartView.data = chartData
    
       chartDataSet.colors = [UIColor(red: 84/255, green: 194/255, blue: 251/255, alpha: 1)]
        
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
