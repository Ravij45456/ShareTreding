//
//  SFQueryModel.swift
//  SFSoftwiseFinacials
//
//  Created by Softwise  on 01/10/15.

//

import UIKit


//****************** User ******************//


//****************** Bank ******************//

/**
 * Create the model class for Bank which hold all filed name of Bank Table
 */

class TableBank : NSObject {
    static let sharedInstance = TableBank()
    
    let kId  : String = "id"
    let kTableName : String  = "StockDetail"
    
    let kSharenName: String = "SharenName"
    let kShareSymbleName : String = "ShareSymbleName"
    let kSharePrice : String = "SharePrice"
    let kTime : String = "Time"
    let kShareURL: String  = "ShareURL"
    let kType : String = "Type"
    
    
    /**
     Create the Bank Table structure query
     - Parameters:
     - loanInfoArray: N/A
     - returns: create table query
     */
    
    func createTableForBank () -> String {
        
        
        
        let  createTableQueryStatement : String = "CREATE TABLE IF NOT EXISTS \(kTableName) (\(kId) INTEGER PRIMARY KEY AUTOINCREMENT,\(kSharenName) text,\(kShareSymbleName) text,\(kSharePrice) INTEGER,\(kTime) text,\(kShareURL) text,\(kType) INTEGER)"
        
        return createTableQueryStatement
    }
    
    
}

