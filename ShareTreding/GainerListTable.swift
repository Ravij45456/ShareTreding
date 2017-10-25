//
//  LogItem.swift
//  MyLog
//
//  Created by Jameson Quave on 2/16/15.
//  Copyright (c) 2015 JQ Software LLC. All rights reserved.
//

import Foundation
import CoreData

class GainerListTable: NSManagedObject {
    
    @NSManaged var gainerNumber: Int32
    @NSManaged var name: String
    @NSManaged var symbolName: String
    @NSManaged var time: String
    
    class func createInManagedObjectContext(_ moc: NSManagedObjectContext, gainerNumber: Int32, name: String, symbolName: String, time: String) -> GainerListTable {
        let gainerListTable = NSEntityDescription.insertNewObject(forEntityName: "GainerListTable", into: moc) as! GainerListTable
        gainerListTable.gainerNumber = 1
        gainerListTable.name = name
        gainerListTable.symbolName = symbolName
        gainerListTable.time = time
        
        return gainerListTable
    }
    
}
