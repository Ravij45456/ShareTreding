//
//  SFBankInfo.swift
//  SFSoftwiseFinacials
//
//  Created by Softwise  on 13/10/15.

//

import UIKit


// Create the model class for Bank which hold all filed name of Bank Table

protocol ParseBankResponce : class {
    
    func getBankDataAfterParsing()
}

enum stockType:Int{
    case DMA200
    case DMA150
    case DMA50
    case DMA30
    case allBreakDown
    
}

class SFBankInfo: NSObject {
    
    var  id : Int32 = Int32()
    var sharenName = ""
    var shareSymbleName = ""
    var sharePrice: Float = 0.0
    var time = ""
    var shareURL: String  = ""
    var type = stockType.allBreakDown
    
    var gainerNumber = 0
    
    var lastQuaterPromoter: Float = 0.0
    var secondLastQuaterPromoter: Float = 0.0
    var thirdLastQuaterPromoter: Float = 0.0
    var fourthLastQuaterPromoter: Float = 0.0
    
    var DMA200: Float = 0.0
    var DMA150: Float = 0.0
    var DMA50: Float = 0.0
    var DMA30: Float = 0.0
    
    var low52Weak: Float = 0.0
    var high52Weak: Float = 0.0
    var basePrice: Float = 0.0
    
    var highToday: Float = 0.0
    var lowToday: Float = 0.0
    

    
    
    
    
    /**
     insertBanksInLocalDB class method which parse the  bank  API data and fired the notification with bank info model
     - Parameters:
     - responceDic:  This is NSDictionary which is hold the bank record.
     - returns:
     */
    
    func insertBanksInLocalDB(responceDic :NSDictionary){
        
        let banksInfo = SFBankInfo()
        
//        if let bankAccount_Id = (responceDic.objectForKey(kBankAccount_Id) as? String){
//            banksInfo.bankAccountId = bankAccount_Id
//            
//        }; if let customerId = (responceDic.objectForKey(kCustomer_Id) as? String){
//            banksInfo.customerId = customerId
//            
//        }; if let accountNumber = (responceDic.objectForKey(kAccountNumber) as? String){
//            banksInfo.accountNumber  = accountNumber
//            
//        }; if let name = (responceDic.objectForKey(kName) as? String){
//            banksInfo.bankName  = name
//            
//        }; if let phone = (responceDic.objectForKey(kPhone)as? String){
//            banksInfo.bankPhoneNumber  = phone
//            
//        }; if let routingNumber = (responceDic.objectForKey(kRoutingNumber)){
//            banksInfo.bankRoutingNumber  = routingNumber as! String
//            
//        }; if let type = (responceDic.objectForKey(kType) as? String ){
//            banksInfo.accountType  = type
//        }
//        banksInfo.isSync = 1
//        NSNotificationCenter.defaultCenter().postNotificationName("NotificationIdentifier", object: nil, userInfo:["bankData":banksInfo])
    }
    
    
    /**
     insertBankListInLocalDB class method which parse the  bank list API data and insert the bank record on bank table.
     - Parameters:
     - responceDic:  This is NSMutableArray which is hold the bank list record.
     - returns: return the bool
     */
    
    class func insertBankListInLocalDB(responceDic :NSMutableArray) -> Bool{
        
        var bankInfoArray: [SFBankInfo] = []
        
        for tempBankInfo in responceDic{
            let banksInfo = SFBankInfo()
            
//            if let bankAccount_Id = (tempBankInfo.objectForKey(kBankAccount_Id) as? String){
//                banksInfo.bankAccountId = bankAccount_Id
//                
//            }; if let customerId = (tempBankInfo.objectForKey(kCustomer_Id) as? String){
//                banksInfo.customerId = customerId
//                
//            }; if let accountNumber = (tempBankInfo.objectForKey(kAccountNumber) as? String){
//                banksInfo.accountNumber  = accountNumber
//                
//            }; if let name = (tempBankInfo.objectForKey(kName) as? String){
//                banksInfo.bankName  = name
//                
//            }; if let phone = (tempBankInfo.objectForKey(kPhone)as? String){
//                banksInfo.bankPhoneNumber  = phone
//                
//            }; if let routingNumber = (tempBankInfo.objectForKey(kRoutingNumber) as? String){
//                banksInfo.bankRoutingNumber  = routingNumber
//                
//            }; if let type = (tempBankInfo.objectForKey(kType) as? String ){
//                banksInfo.accountType  = type
//                
//            }; if let action = (tempBankInfo.objectForKey(Action) as? String ){
//                banksInfo.action  = action
//                
//            }; if let actionDate = (tempBankInfo.objectForKey(ActionDate) as? String ){
//                banksInfo.actionDate  = actionDate
//            }
//            
//            banksInfo.isSync = 1
//            banksInfo.timeStamp = SFUtility.getCurrentTimeInMilliSeconds()
//            
  
                
                if   SFDBManager.getInstance().checkBankRecordAlreadyExist(stockName: banksInfo.sharenName){
                    SFDBManager.getInstance().deleteBankRecord(bankInfo: banksInfo, isDeletedFromServer: true)
                }
                
        
            }
  
        
        
        
        // insert the bank record on local DB.
        
             let isInserted = SFDBManager.getInstance().insertBankDetailsList(bankInfoArray: bankInfoArray)
        return isInserted
        
        //  return isInserted
        
    }
    
    
    /**
     insertBanksInLocalDBbySyncAPI class method which parse the  bank  API data and fired the notification with bank info model
     - Parameters:
     - responceDic:  This is NSDictionary which is hold the bank record.
     - returns:
     */
    
    class  func insertBanksInLocalDBbySyncAPI(responceDic :NSDictionary) -> Bool{
        
        // test notification
        //  var notificationTestData = SFNotificationInfo()
        //  notificationTestData = notificationTestData.initWithTestData()
        //****//
        let banksInfo = SFBankInfo()
        
                
        
        if   SFDBManager.getInstance().checkBankRecordAlreadyExist(stockName: banksInfo.sharenName){
            
            return true
          //  return  SFDBManager.getInstance().updateBankDetails(bankInfo: banksInfo)
        }else{
            
            return SFDBManager.getInstance().insertBankDetails(bankInfo: banksInfo)
            
        }
    }
}
