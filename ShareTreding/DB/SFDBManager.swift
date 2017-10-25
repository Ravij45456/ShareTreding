//
//  SFDBManager.swift
//  DataBaseDemo
//
//  Created by Krupa-iMac on 05/08/14.


import UIKit



let sharedInstance = SFDBManager()

class SFDBManager: NSObject {
    
    var database: FMDatabase? = nil
    
    class func getInstance() -> SFDBManager
    {
        if(sharedInstance.database == nil)
        {
            
            sharedInstance.database = FMDatabase(path: SFUtility.getPath(fileName: "SFSoftwiseFinancial.sqlite"))
            
        }
        
        return sharedInstance
    }
    
    // MARK: - Test Method
    
    /**
     This is test method which is used for hardcode data inset in local DB
     - Parameters: N/A
     - returns: N/A
     */
    
 
    
    
    
    //MARK: - Bank Table
    
    /**
     check that bank record alredy exist or not
     - Parameters:
     - returns: return bool value this is indicate that record exitst or not    */
    func checkBankAlreadyRegister(stockDetail : SFBankInfo)-> Bool{
        
        var isRecoredExist = false
        
        let queue : FMDatabaseQueue = FMDatabaseQueue(path: SFUtility.getPath(fileName: "SFSoftwiseFinancial.sqlite"))
        
        if !sharedInstance.database!.open() {
            print("Unable to open database")
            return false
        }
        
        queue.inDatabase { (db) -> Void in
            let resultSet: FMResultSet? = db.executeQuery("SELECT * FROM \(TableBank.sharedInstance.kTableName) WHERE \(TableBank.sharedInstance.kSharenName)==? ", withArgumentsIn:[stockDetail.sharenName])
            // check that record exist or not
            if (resultSet != nil) {
                if (!resultSet!.next()) {
                    
                    return
                    
                }else{
                    
                    isRecoredExist = true
                }
                
                resultSet?.close()
            }
        }
        return isRecoredExist
    }
    
    
    func checkBankRecordAlreadyExist(stockName : String)-> Bool{
        
        var isRecoredExist = false
        
        let queue : FMDatabaseQueue = FMDatabaseQueue(path: SFUtility.getPath(fileName: "SFSoftwiseFinancial.sqlite"))
        if !sharedInstance.database!.open() {
            print("Unable to open database")
            return false
        }
        
        queue.inDatabase { (db) -> Void in
            let resultSet: FMResultSet? = db.executeQuery("SELECT * FROM \(TableBank.sharedInstance.kTableName) WHERE \(TableBank.sharedInstance.kTableName)==? ", withArgumentsIn:[stockName])
            // check that record exist or not
            if (resultSet != nil) {
                if (!resultSet!.next()) {
                    
                    return
                    
                }else{
                    
                    isRecoredExist = true
                }
                
                resultSet?.close()
            }
        }
        return isRecoredExist
        
    }
    
    
    //*****************************************//
    /**
     Delete the data from Bank table in local DB
     - Parameters:
     - userInfo: N/A
     - returns: N/A   */
    
    func deleteBankRecord(bankInfo: SFBankInfo?, isDeletedFromServer:Bool) -> Bool {
        
        sharedInstance.database!.open()
        var isDeleted : Bool = false
        
        if( bankInfo!.sharenName.isEmpty){
            isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM \(TableBank.sharedInstance.kTableName) WHERE \(TableBank.sharedInstance.kId)==?", withArgumentsIn:[NSNumber.init(value:bankInfo!.id)])
            
        }
        
        sharedInstance.database!.close()
        return isDeleted
    }
    
    
    /**
     Delete the data from Bank table in local DB by sync api
     - Parameters:
     - userInfo: N/A
     - returns: N/A   */
    
    func deleteBankRecordbySyncAPI(stockName:String)  {
        
        sharedInstance.database!.open()
        if checkBankRecordAlreadyExist(stockName: stockName){
            
            sharedInstance.database!.executeUpdate("DELETE FROM \(TableBank.sharedInstance.kTableName) WHERE \(TableBank.sharedInstance.kSharenName)==?", withArgumentsIn:[stockName])
        }
        sharedInstance.database!.close()
        
    }
    
    
   
    
    
    
    //*****************************************//
    /**
     Fetch the data from Bank table in local DB
     - Parameters:
     - userInfo: N/A
     - returns: N/A   */
    
    func getBankDetailsList() -> [SFBankInfo]? {
        
        var bankInfoModelArray : [SFBankInfo] = []
        let queue : FMDatabaseQueue = FMDatabaseQueue(path: SFUtility.getPath(fileName: "SFSoftwiseFinancial.sqlite"))
        
        if !sharedInstance.database!.open() {
            print("Unable to open database")
            return nil
        }
        queue.inDatabase { (db) -> Void in
            
            let resultSet: FMResultSet? = sharedInstance.database!.executeQuery("SELECT * FROM \(TableBank.sharedInstance.kTableName) ", withArgumentsIn:[])
            
            if (resultSet == nil){
                print("errore message =\(db.lastErrorMessage())")
                return
            }
            
            let hasAnyRows:Bool = resultSet!.next()
            if (!hasAnyRows) {
                //Util.invokeAlertMethod("", strBody: failed_login_password, delegate: nil)
                print("No Record Found on getLoanDetails List in Loans Table")        }
            else{
                
                repeat{
                    
                    bankInfoModelArray.append(self.setBankInfoModelData(resultSet: resultSet!) )
                } while resultSet!.next()
            }
            
            resultSet?.close()
        }
        return bankInfoModelArray
        
    }
    
    
    // Get the Bank details by a single loan object
    
    /**
     Fetch the single record from Bank table in local DB
     - Parameters:
     - loanTypeid: getting the value according to this feild value
     - returns: SFLoansInfo model object    */
    
    func getBankDetails(stockName: String ) -> SFBankInfo? {
        
        if !sharedInstance.database!.open() {
            print("Unable to open database")
            return nil
        }
        
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM \(TableBank.sharedInstance.kTableName) WHERE \(TableBank.sharedInstance.kSharenName)==? ", withArgumentsIn:[stockName])
        
        let hasAnyRows:Bool = resultSet.next()
        if (!hasAnyRows) {
            print("No Record Found on getLoanDetails in Loans Table")
        }
        else{
            
            return setBankInfoModelData(resultSet: resultSet)
        }
        return nil
    }
    
    
    // set the LoansInfoModelData
    
    /**
     Set the single record on Loans table in local DB
     - Parameters:
     - resultSet: all record set which is retrun by query
     - returns: SFLoansInfo model object    */
    var  id : Int32 = Int32()
    var sharenName = ""
    var shareSymbleName = ""
    var sharePrice: Float = 0.0
    var time = ""
    var shareURL: String  = ""
    var type = stockType.allBreakDown

    
    func setBankInfoModelData(resultSet:FMResultSet) -> SFBankInfo{
        
        let bankInfo: SFBankInfo? = SFBankInfo()
        
        bankInfo!.id = resultSet.int(forColumn: TableBank.sharedInstance.kId)
        
        bankInfo!.sharenName = resultSet.string(forColumn: TableBank.sharedInstance.kSharenName)!
        
        bankInfo!.shareSymbleName = resultSet.string(forColumn: TableBank.sharedInstance.kShareSymbleName)!
        
        bankInfo!.sharePrice = Float(resultSet.double(forColumn: TableBank.sharedInstance.kSharePrice))
        
        bankInfo!.time = resultSet.string(forColumn: TableBank.sharedInstance.kTime)!
        
        bankInfo!.shareURL = resultSet.string(forColumn: TableBank.sharedInstance.kShareURL)!
        
        bankInfo!.type = stockType(rawValue: Int(resultSet.int(forColumn: TableBank.sharedInstance.kType)))!
        
       
        
        // Log Message //
        
        print("Bank Table \n",bankInfo!.id, bankInfo!.sharenName, bankInfo!.shareSymbleName, bankInfo!.sharePrice, bankInfo!.time, bankInfo!.shareURL,bankInfo!.type )
        //***//
        return bankInfo!
        
    }
    
    
    // Insert Bank detail
    /**
     Insert Bank detail in Local DB
     - Parameters:
     - userInfo: take the SFBankInfo model class object
     - returns: return bool value this is indicate the value inserted or not
     */
    
    func insertBankDetails(bankInfo: SFBankInfo) -> Bool {
        sharedInstance.database!.open()
        
        let isInserted = sharedInstance.database!.executeUpdate("INSERT INTO \(TableBank.sharedInstance.kTableName) (\(TableBank.sharedInstance.kSharenName),\(TableBank.sharedInstance.kShareSymbleName),\(TableBank.sharedInstance.kSharePrice), \(TableBank.sharedInstance.kTime), \(TableBank.sharedInstance.kShareURL), \(TableBank.sharedInstance.kType)) VALUES (?, ?, ?, ?, ?, ?)", withArgumentsIn: [bankInfo.sharenName ,bankInfo.shareSymbleName , NSNumber.init(value:bankInfo.sharePrice), bankInfo.time, bankInfo.shareURL,  NSNumber.init(integerLiteral: bankInfo.type.rawValue)])
        
        return isInserted
        
    }
    
    
    // Insert bank details List Data
    
    
    /**
     Insert list of bankInfo details in database
     - Parameters:
     - loanInfoArray: take the array of Slo model class object
     - returns: return bool value this is indicate the value inserted or not
     */
    
    func insertBankDetailsList(bankInfoArray: [SFBankInfo]) -> Bool{
        
        var isInsertedData : Bool = false
        
        if(!bankInfoArray.isEmpty){
            
            for  bankInfo: SFBankInfo in bankInfoArray{
                
                if (checkBankRecordAlreadyExist(stockName: bankInfo.sharenName)){
                    
                    isInsertedData = (getBankDetails(stockName: bankInfo.sharenName) != nil)
                    
                }else{
                    isInsertedData = insertBankDetails(bankInfo: bankInfo)
                }
                
                
                if (!isInsertedData){
                    break
                    // return isInsertedData
                }
            }
        }
        return isInsertedData
    }
    
    
    
    
    
    
//    /**
//     update the Bank detail in local Db
//     - Parameters:
//     - userInfo: take the SFBankInfo model class object
//     - returns: return bool value this is indicate the value inserted or not    */
//    
//    func updateBankDetails(bankInfo: SFBankInfo) -> Bool {
//        
//        sharedInstance.database!.open()
//        
//        var isUpdated = false
//        // uncommented these line for update the online mode
//        
//        if (!bankInfo.bankAccountId.isEmpty){
//            
//            isUpdated = sharedInstance.database!.executeUpdate("UPDATE \(TableBank.sharedInstance.kTableName) SET \(TableBank.sharedInstance.kBankAccountId) = ?, \(TableBank.sharedInstance.kBankRoutingNumber) = ?, \(TableBank.sharedInstance.kAccountNumber) = ?, \(TableBank.sharedInstance.kAccountType) = ?, \(TableBank.sharedInstance.kIsSync) = ? , \(TableBank.sharedInstance.kTimeStamp) = ?,  \(TableBank.sharedInstance.kIsStatus) = ? ,  \(TableBank.sharedInstance.kIsActive) = ? WHERE \(TableBank.sharedInstance.kBankAccountId) = ?", withArgumentsIn: [bankInfo.bankAccountId ,bankInfo.bankRoutingNumber, bankInfo.accountNumber, bankInfo.accountType,  NSNumber.init(value:bankInfo.isSync!), bankInfo.timeStamp!, UPDATE, NSNumber.init(value:bankInfo.isActive!),  bankInfo.bankAccountId])
//            
//        }else{
//            
//            isUpdated = sharedInstance.database!.executeUpdate("UPDATE \(TableBank.sharedInstance.kTableName) SET \(TableBank.sharedInstance.kBankAccountId) = ?, \(TableBank.sharedInstance.kBankRoutingNumber) = ?, \(TableBank.sharedInstance.kAccountNumber) = ?, \(TableBank.sharedInstance.kAccountType) = ? , \(TableBank.sharedInstance.kIsSync) = ? , \(TableBank.sharedInstance.kTimeStamp) = ?,  \(TableBank.sharedInstance.kIsStatus) = ? ,  \(TableBank.sharedInstance.kIsActive) = ? WHERE \(TableBank.sharedInstance.k_Id) = ?", withArgumentsIn: [bankInfo.bankAccountId ,bankInfo.bankRoutingNumber, bankInfo.accountNumber, bankInfo.accountType,  NSNumber.init(value:bankInfo.isSync!), bankInfo.timeStamp!, UPDATE, NSNumber.init(value:bankInfo.isActive!),  NSNumber.init(value:bankInfo._id)])
//        }
//        
//        
//        
//        
//        //   sharedInstance.database!.close()
//        return isUpdated
//        
//    }
//    
//    
//    
//    
//    
//    func isAccountNumberExists(accountNumber : String) -> Bool {
//        sharedInstance.database!.open()
//        
//        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM \(TableBank.sharedInstance.kTableName) WHERE \(TableBank.sharedInstance.kAccountNumber)==?  AND \(TableBank.sharedInstance.kCustomerId)==?", withArgumentsIn:[accountNumber, SHARED_CUSTOMER_ID])
//        
//        let hasAnyRows:Bool = resultSet.next()
//        return hasAnyRows
//        
//    }
    
}

       
