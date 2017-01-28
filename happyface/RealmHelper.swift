//
//  RealmHelper.swift
//  happyface
//
//  Created by Cassy Stone on 7/13/16.
//  Copyright © 2016 Cassandra Stone. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHelper {
    
    static func addEntry(_ entry: Entry) {
        let realm = try! Realm()
        try! realm.write() {
            realm.add(entry)
        }
    }
    
    static func deleteEntry(_ entry: Entry) {
        let realm = try! Realm()
        try! realm.write() {
            realm.delete(entry)
        }
    }
    
    static func retrieveEntry() -> Results<Entry> {
            let realm = try! Realm()
            return realm.objects(Entry).sorted("date", ascending: true)
        }
    
    static func retrieveNonEmptyEntry() -> Results<Entry> {
        let realm = try! Realm()
        return realm.objects(Entry.self).filter("isEmpty == false").sorted("date", ascending: false)
       // https://realm.io/docs/swift/latest/
    }
    
    static func addRoutine(_ routine: Routine) {
        let realm = try! Realm()
        try! realm.write() {
            realm.add(routine)
        }
    }
    
    
    static func deleteRoutine(_ routine: Routine) {
        let realm = try! Realm()
        try! realm.write() {
            realm.delete(routine)
        }
    }
    
    static func retrieveRoutine() -> Results<Routine> {
        let realm = try! Realm()
        return realm.objects(Routine).sorted("itemName", ascending: true)
    }
    
    static func retrieveCurrentRoutine() -> Results<Routine> {
        let realm = try! Realm()
        return realm.objects(Routine.self).filter("currentUse == true").sorted("itemName", ascending: true)
    }
}
