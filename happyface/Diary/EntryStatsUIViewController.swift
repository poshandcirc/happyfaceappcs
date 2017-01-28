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
    
    @IBAction func backAction(_ sender: AnyObject) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let entry = entry {
            let formatter = DateFormatter()
            formatter.dateStyle = DateFormatter.Style.long
            let entryDate = entry.date
            let dateString = formatter.string(from: entryDate as Date)
            timeLabel.text = dateString.uppercased()
            acneStat.text = "\(entry.acneScale)"
            drynessStat.text = "\(entry.drynessScale)"
            oilinessStat.text = "\(entry.oilinessScale)"
            rednessStat.text = "\(entry.rednessScale)"
    }
}
}
