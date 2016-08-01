//
//  EntryStatsUIViewController.swift
//  happyface
//
//  Created by Cassy Stone on 7/13/16.
//  Copyright © 2016 Cassandra Stone. All rights reserved.
//

import UIKit

class EntryStatsUIViewController: UIViewController {

    @IBOutlet weak var acneStat: UILabel!
    @IBOutlet weak var drynessStat: UILabel!
    @IBOutlet weak var oilinessStat: UILabel!
    @IBOutlet weak var rednessStat: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    var entry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
 //       self.navigationController?.navigationBar.tintColor = UIColor.whiteColor();
    }
    
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let entry = entry {
            let formatter = NSDateFormatter()
            formatter.dateStyle = NSDateFormatterStyle.LongStyle
            let entryDate = entry.date
            timeLabel.text = formatter.stringFromDate(entryDate).capitalizedString
            acneStat.text = "\(entry.acneScale)"
            drynessStat.text = "\(entry.drynessScale)"
            oilinessStat.text = "\(entry.oilinessScale)"
            rednessStat.text = "\(entry.rednessScale)"
    }
}
}