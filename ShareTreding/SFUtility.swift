//
//  SFUtility.swift
//  SFSoftwiseFinacials
//
//  Created by Softwise  on 08/09/15.

//

import UIKit
import SystemConfiguration




class SFUtility: NSObject {
    
    
    /**
     This is class method which is return sqlite file path
     - Parameters:
     - fileName: sqlite file name
     - returns: return the sqlite DB file's path
     */
    
    class func getPath(fileName: String) -> String {
        
        let dirPaths =
            NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                .userDomainMask, true)
        let docsDir = dirPaths[0]
        let dbPath  = docsDir+"/"+(fileName)
        return dbPath
    }

    /**
     This is class method which is responsible for crating the DB file with proper structure
     - Parameters:
     - fileName: sqlite file name
     - returns: N/A
     */
    
    class func createStructureInDB(fileName: NSString) {
        let dbPath: String = getPath(fileName: fileName as String)
        print(dbPath)
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: dbPath) {
            
            //  let alert: UIAlertView = UIAlertView()
            
            let contactDB = FMDatabase(path: dbPath as String)
            if contactDB.open() {
                var allQueryArray : [ String] = []
                
                allQueryArray.append(TableBank.sharedInstance.createTableForBank())
                
                
                for i in 0  ..< allQueryArray.count
                    {
                        
                        if !contactDB.executeUpdate(allQueryArray[i], withArgumentsIn: allQueryArray) {
                        print(allQueryArray[i])
                        print("Error on subject_codes: \(contactDB.lastErrorMessage())")
                    }
                }
                
                // uncomment these line and insert the hardcoded lookup data
                
                // SFDBManager.getInstance().insertData()
                //  SFDBManager.getInstance().testDBQuery()
                
                contactDB.close()
                
                            }
            
        }
    }

    
    
    /**
     This is class method which is display the alert message.
     - Parameters:
     - strTitle: Title of alert message
     - strBody: body of alert message
     - delegate: calling controller object
     - returns: N/A
     */
    
    class func invokeAlertMethod(_ strTitle: NSString, strBody: NSString, delegate: AnyObject?) {
        DispatchQueue.main.async { () -> Void in
            let alert: UIAlertView = UIAlertView()
            alert.message = strBody as String
            alert.title = strTitle as String
            alert.delegate = delegate
            alert.addButton(withTitle: "OK")
            
            alert.show()
        }
        
    }
    
    
    /**
     This is class method which is display the alert message.
     - Parameters:
     - strTitle: Title of alert message
     - strBody: body of alert message
     - delegate: calling controller object
     - returns: N/A
     */
    
    class func alertContoller(_ title: String, message: String, actionTitle1: String, actionTitle2: String, firstActoin: Selector, controller: UIViewController) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert) // 1
        let firstAction = UIAlertAction(title: actionTitle1, style: .default) { (alert: UIAlertAction!) -> Void in
            NSLog("You pressed button one")
            
            controller.perform(firstActoin)
        }
        
        let secondAction = UIAlertAction(title: actionTitle2, style: .default) { (alert: UIAlertAction!) -> Void in
            NSLog("You pressed button two")
        }
        alert.addAction(firstAction)
        alert.addAction(secondAction)
        controller.present(alert, animated: true, completion:nil)
    }
}
