//
//  Routine.swift
//  happyface
//
//  Created by Cassy Stone on 7/21/16.
//  Copyright © 2016 Cassandra Stone. All rights reserved.
//

import Foundation
import RealmSwift

class Routine: Object {
    dynamic var itemName = ""
    dynamic var morningUse = false
    dynamic var middayUse = false
    dynamic var nightUse = false
    dynamic var selectiveUse = false
    dynamic var additionalNotes = ""
    dynamic var currentUse = true
    dynamic var isPrescription = false
    dynamic var iconNum = 0
}