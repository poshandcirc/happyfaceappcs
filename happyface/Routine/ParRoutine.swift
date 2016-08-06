//
//  ParRoutine.swift
//  happyface
//
//  Created by Cassy Stone on 8/5/16.
//  Copyright © 2016 Cassandra Stone. All rights reserved.
//

import UIKit
import Foundation
import Parse

class ParRoutine: PFObject, PFSubclassing {
    
    @NSManaged var user: PFUser?
    @NSManaged var itemName: String
    @NSManaged var morningUse: Bool
    @NSManaged var middayUse: Bool
    @NSManaged var nightUse: Bool
    @NSManaged var selectiveUse: Bool
    @NSManaged var additionalNotes: String
    @NSManaged var currentUse: Bool
    @NSManaged var isPrescription: Bool
    @NSManaged var today: NSDate
    
    static func parseClassName() -> String {
        return "ParRoutine"
    }
    
    override init() {
        super.init()
    }
    
    func uploadRoutine() {
        user = PFUser.currentUser()
        ParseHelper.addRoutine(user!, itemName: self.itemName, morningUse: self.morningUse, middayUse: self.middayUse, nightUse: self.nightUse, selectiveUse: self.selectiveUse, additionalNotes: self.additionalNotes, currentUse: self.currentUse, isPrescription: self.isPrescription, today: self.today)
    }
    
    func changeRoutineName(newItem: String) {
        ParseHelper.updateRoutine(itemName, newItemName: newItem, morningUse: self.morningUse, middayUse: self.middayUse, nightUse: self.nightUse, selectiveUse: self.selectiveUse, additionalNotes: self.additionalNotes, currentUse: self.currentUse, isPrescription: self.isPrescription)
    }
    
    func archRoutine() {
        ParseHelper.archiveRoutine(itemName, currentUse: false)
    }
    
    func removeRoutine() {
        ParseHelper.deleteRoutine(itemName)
    }

}
