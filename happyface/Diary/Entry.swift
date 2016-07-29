//
//  Entry.swift
//  happyface
//
//  Created by Cassy Stone on 7/12/16.
//  Copyright © 2016 Cassandra Stone. All rights reserved.
//


import Foundation
import RealmSwift

class Entry: Object {
    dynamic var acneScale = 0
    dynamic var drynessScale = 0
    dynamic var oilinessScale = 0
    dynamic var rednessScale = 0
    dynamic var routineStreak = 0
    dynamic var date = NSDate()
    dynamic var isEmpty = false
}