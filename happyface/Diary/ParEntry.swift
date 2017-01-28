//
//  ParEntry.swift
//  happyface
//
//  Created by Cassy Stone on 8/5/16.
//  Copyright © 2016 Cassandra Stone. All rights reserved.
//

import Foundation
import UIKit
import Parse

class ParEntry: PFObject, PFSubclassing {
    
    @NSManaged var user: PFUser?
    @NSManaged var acneScale: Int
    @NSManaged var drynessScale: Int
    @NSManaged var oilinessScale: Int
    @NSManaged var rednessScale: Int
    @NSManaged var isEmpty: Bool
    @NSManaged var date: Date

    static func parseClassName() -> String {
        return "ParEntry"
    }
    
    override init() {
        super.init()
    }
    
    func uploadEntry() {
        user = PFUser.current()
        ParseHelper.addEntry(user!, acneScale: self.acneScale, drynessScale: self.drynessScale, oilinessScale: self.oilinessScale, rednessScale: self.rednessScale, date: self.date, isEmpty: self.isEmpty)
    }
    
    func removeEntry() {
        ParseHelper.deleteEntry(date)
    }
    
}
