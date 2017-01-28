//
//  ParseHelper.swift
//  happyface
//
//  Created by Cassy Stone on 8/5/16.
//  Copyright © 2016 Cassandra Stone. All rights reserved.
//

import Foundation
import Parse
import Bond
import ConvenienceKit

class ParseHelper {
    
//    var entryUploadTask: UIBackgroundTaskIdentifier?
//    var routineUploadTask: UIBackgroundTaskIdentifier?
//    var routineUpdateTask: UIBackgroundTaskIdentifier?
    
    // Entry
    static let ParseEntryClass = "ParEntry"
    static let ParseEntryUser = "user"
    static let ParseEntryAcneScale = "acneScale"
    static let ParseEntryDrynessScale = "drynessScale"
    static let ParseEntryOilinessScale = "oilinessScale"
    static let ParseEntryRednessScale = "rednessScale"
    static let ParseEmptyEntry = "isEmpty"
    static let ParseEntryDateAdded = "date"
    
    // Routine
    static let ParseRoutineClass = "ParRoutine"
    static let ParseRoutineUser = "user"
    static let ParseRoutineItemName = "itemName"
    static let ParseRoutineMorningUse = "morningUse"
    static let ParseRoutineMiddayUse = "middayUse"
    static let ParseRoutineNightUse = "nightUse"
    static let ParseRoutineSelectiveUse = "selectiveUse"
    static let ParseRoutineNotes = "additionalNotes"
    static let ParseRoutineCurrentUse = "currentUse"
    static let ParseRoutinePrescription = "isPrescription"
    static let ParseRoutineDateStartedUsing = "today"
    
    static func addEntry(_ user: PFUser, acneScale: Int, drynessScale: Int, oilinessScale: Int, rednessScale: Int, date: Date, isEmpty: Bool) {
        let entryObject = PFObject(className: ParseEntryClass)
        entryObject.setObject(user, forKey: ParseEntryUser)
        entryObject.setObject(acneScale, forKey: ParseEntryAcneScale)
        entryObject.setObject(drynessScale, forKey: ParseEntryDrynessScale)
        entryObject.setObject(oilinessScale, forKey: ParseEntryOilinessScale)
        entryObject.setObject(rednessScale, forKey: ParseEntryRednessScale)
        entryObject.setObject(isEmpty, forKey: ParseEmptyEntry)
        entryObject.setObject(date, forKey: ParseEntryDateAdded)
        
        entryObject.saveInBackground(block: ErrorHandling.errorHandlingCallback)
    }
    
    static func deleteEntry(_ dateCreated: Date) {
        let query = PFQuery(className: ParseEntryClass)
        query.whereKey(ParseEntryDateAdded, equalTo: dateCreated)
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects {
                    for object in objects {
                        object.deleteInBackground(block: ErrorHandling.errorHandlingCallback)
                        print("successful update")
                    }
                }
            } else {
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    static func addRoutine(_ user: PFUser, itemName: String, morningUse: Bool, middayUse: Bool, nightUse: Bool, selectiveUse: Bool, additionalNotes: String, currentUse: Bool, isPrescription: Bool, today: Date) {
        let routineObject = PFObject(className: ParseRoutineClass)
        routineObject.setObject(user, forKey: ParseRoutineUser)
        routineObject.setObject(itemName, forKey: ParseRoutineItemName)
        routineObject.setObject(morningUse, forKey: ParseRoutineMorningUse)
        routineObject.setObject(middayUse, forKey: ParseRoutineMiddayUse)
        routineObject.setObject(nightUse, forKey: ParseRoutineNightUse)
        routineObject.setObject(selectiveUse, forKey: ParseRoutineSelectiveUse)
        routineObject.setObject(additionalNotes, forKey: ParseRoutineNotes)
        routineObject.setObject(currentUse, forKey: ParseRoutineCurrentUse)
        routineObject.setObject(isPrescription, forKey: ParseRoutinePrescription)
        routineObject.setObject(today, forKey: ParseRoutineDateStartedUsing)
        
        routineObject.saveInBackground(block: ErrorHandling.errorHandlingCallback)
    }
    
    static func updateRoutine(_ originalItemName: String, newItemName: String, morningUse: Bool, middayUse: Bool, nightUse: Bool, selectiveUse: Bool, additionalNotes: String, currentUse: Bool, isPrescription: Bool) {
        let query = PFQuery(className: ParseRoutineClass)
        query.whereKey(ParseRoutineItemName, equalTo: originalItemName)
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects {
                    for object in objects {
                        object.setObject(newItemName, forKey: ParseRoutineItemName)
                        object.setObject(morningUse, forKey: ParseRoutineMorningUse)
                        object.setObject(middayUse, forKey: ParseRoutineMiddayUse)
                        object.setObject(nightUse, forKey: ParseRoutineNightUse)
                        object.setObject(selectiveUse, forKey: ParseRoutineSelectiveUse)
                        object.setObject(additionalNotes, forKey: ParseRoutineNotes)
                        object.setObject(currentUse, forKey: ParseRoutineCurrentUse)
                        object.setObject(isPrescription, forKey: ParseRoutinePrescription)
                        object.saveInBackground(block: ErrorHandling.errorHandlingCallback)
                        print("successful update")
                    }
                }
            } else {
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    static func archiveRoutine(_ originalItemName: String, currentUse: Bool) {
        let query = PFQuery(className: ParseRoutineClass)
        query.whereKey(ParseRoutineItemName, equalTo: originalItemName)
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects {
                    for object in objects {
                        object.setObject(currentUse, forKey: ParseRoutineCurrentUse)
                        object.saveInBackground(block: ErrorHandling.errorHandlingCallback)
                        print("successful update")
                    }
                }
            } else {
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    static func deleteRoutine(_ originalItemName: String) {
        let query = PFQuery(className: ParseRoutineClass)
        query.whereKey(ParseRoutineItemName, equalTo: originalItemName)
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                if let objects = objects {
                    for object in objects {
                        object.deleteInBackground(block: ErrorHandling.errorHandlingCallback)
                        print("successful update")
                    }
                }
            } else {
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }

}
