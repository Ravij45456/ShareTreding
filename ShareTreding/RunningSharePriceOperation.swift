//
//  RunningSharePriceOperation.swift
//  HTMLParsing
//
//  Created by Ravi Patel on 24/09/16.
//  Copyright © 2016 Swipe Stack Ltd. All rights reserved.
//

import UIKit
import CoreData
//
import Alamofire
import SwiftyJSON

protocol DestinationViewControllerDelegate {
    func doSomethingWithData(_ shareRuningPriceModel: [ShareRuningPriceModel])
}



class RunningSharePriceOperation: NSObject {
    
 
    var delegate: DestinationViewControllerDelegate?
    
     var sharePriceModelTemp = [ShareRuningPriceModel]()

    var sharenName = ""
    var shareSymbleName = ""
    var gainerNumber = 0
    var sharePrice: Double = 0.0
    var time = ""
   
     var runningSharePriceTemp = ShareRuningPriceModel()
    
    var runningSharesManageObject = [NSManagedObject]()
    
    var fillterShareCount = 0
    
    func getCurrentSharePrice() {
        
        let tutorialsUrl = URL(string: "http://www.moneycontrol.com/india/stockpricequote/diamond-cutting-jewellery-precious-metals/pcjeweller/PJ")!
        let tutorialsHtmlData = try? Data(contentsOf: tutorialsUrl)
        
        let tutorialsParser = TFHpple.init(htmlData: tutorialsHtmlData)
        
        // let tutorialsXpathQueryString = "//tr[@class='TTRow']/td/a"
        
        let tutorialsXpathQueryString =  "//div[@class='FL PR5 rD_30']/span/strong"
        
        let tutorialsNodes =  tutorialsParser?.search(withXPathQuery: tutorialsXpathQueryString)
        
        for element in tutorialsNodes! {
            let elementTwo: TFHppleElement = element as! TFHppleElement
            runningSharePriceTemp.sharePrice  = (elementTwo.firstChild.content as String).floatValue
            //self.objects.append(tutorial)
        }
        
        // self.tableView.reloadData()
        
    }
    func getCompaniesList() {
        var i = 0
       let companyNameStatedLetter = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
   //let companyNameStatedLetter = ["D"]
       DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async {
        
        for startLetter in companyNameStatedLetter {
            
            let companiesListUrl = URL(string: "http://www.moneycontrol.com/india/stock-market/stock-quotes/\(startLetter)")!
            
            let companiesListHtmlData = try? Data(contentsOf: companiesListUrl)
            
            let companiesListParser = TFHpple.init(htmlData: companiesListHtmlData)
            
            
            // Getting companies list
            let companiesListXpathQueryString =  "//table[@class='pcq_tbl MT10']/tr/td/a/@href"
            
            
            let companiesListNodes =  companiesListParser?.search(withXPathQuery: companiesListXpathQueryString)
            
            for element in companiesListNodes! {
                let elementTwo: TFHppleElement = element as! TFHppleElement
                i = 1+i
                               print("\(i) = \(elementTwo.firstChild.content)")
                
                  self.runningSharePriceTemp.shareURL = elementTwo.firstChild.content
               
                
               if self.verifyUrl(self.runningSharePriceTemp.shareURL){
                
                                   self.getTredingTime(self.runningSharePriceTemp.shareURL)
                }
                 //runningSharePrice.companiesList.append(elementTwo.firstChild.content)
              
            }

        }
        }
       // delegate?.doSomethingWithData(sharePriceModelTemp)
    }
    
    
    //check url is valid or not
    func verifyUrl (_ urlString: String?) -> Bool {
        //Check for nil
        if let urlString = urlString {
            // create NSURL instance
            if let url = URL(string: urlString) {
                // check if your application can open the NSURL instance
                return UIApplication.shared.canOpenURL(url)
            }
        }
        return false
    }
    
    
    func getTredingTime(_ companyURL:String) {
        
        var runningSharePrice = ShareRuningPriceModel()
        
        runningSharePrice.sharePrice = runningSharePriceTemp.sharePrice
        runningSharePrice.shareURL = runningSharePriceTemp.shareURL
        
      // let tutorialsUrl = NSURL(string: "http://www.moneycontrol.com/india/stockpricequote/tyres/mrf/MRF")!
        
//        if !verifyUrl(companyURL){
//            
//            return
//        }
        
        
        let tutorialsUrl = URL(string: companyURL)!
        
        
        
        let tutorialsHtmlData = try? Data(contentsOf: tutorialsUrl)
        
        let tutorialsParser = TFHpple.init(htmlData: tutorialsHtmlData)
        
        
        // Getting Share Running Time
        let tredingTimeXpathQueryString =  "//div/div/div/div[@ id='bse_upd_time']"
        
        let tredingTimeNodes =  tutorialsParser?.search(withXPathQuery: tredingTimeXpathQueryString)
        
        for element in tredingTimeNodes! {
            let elementTwo: TFHppleElement = element as! TFHppleElement
            runningSharePrice.time  = elementTwo.firstChild.content
        }
        
        
        // Getting Share Running Price
        let tredingSharePriceXpathQueryString =  "//div[@class='FL PR5 rD_30']/span/strong"
        
        let tredingSharePriceNodes =  tutorialsParser?.search(withXPathQuery: tredingSharePriceXpathQueryString)
        
        for element in tredingSharePriceNodes! {
            let elementTwo: TFHppleElement = element as! TFHppleElement
            runningSharePrice.sharePrice  = (elementTwo.firstChild.content as String).toFloat()
            //self.objects.append(tutorial)
            print("Current Price=\(  runningSharePrice.sharePrice)")
            // becase we getting only BSE current Price
            break
        }
        
     //   addRunningShareInformationOnLocalDB()
        
        
        
        // Getting Promotor share holding 
        
        let shareHoldingPaternLastQuaterXpathQueryString = "//tr/td[@class='thc04 w90 gD_12 tar']/span[@class='PR5']"
        
        let shareHoldingPaternLastQuaterNodes =  tutorialsParser?.search(withXPathQuery: shareHoldingPaternLastQuaterXpathQueryString)
        
        for (index, element)in (shareHoldingPaternLastQuaterNodes?.enumerated())! {
            
        
            if index == 0{
                let elementTwo: TFHppleElement = element as! TFHppleElement
                if elementTwo.children.count>0{
                    runningSharePrice.lastQuaterPromoter  = (elementTwo.firstChild.content as String).toFloat()
                    print("1st Quater Promoter=\(  runningSharePrice.lastQuaterPromoter)")
                    
                }
            }
            if index == 1{
                let elementTwo: TFHppleElement = element as! TFHppleElement
                if elementTwo.children.count>0{
                    runningSharePrice.secondLastQuaterPromoter  = (elementTwo.firstChild.content as String).toFloat()
                    print("2nd Quater Promoter=\(  runningSharePrice.secondLastQuaterPromoter)")
                    
                }
            }

            if index == 2{
                let elementTwo: TFHppleElement = element as! TFHppleElement
                if elementTwo.children.count>0{
                    runningSharePrice.thirdLastQuaterPromoter  = (elementTwo.firstChild.content as String).toFloat()
                    print("3rd Quater Promoter=\(  runningSharePrice.thirdLastQuaterPromoter)")
                    
                }
            }

            if index == 3{
                let elementTwo: TFHppleElement = element as! TFHppleElement
                if elementTwo.children.count>0{
                    runningSharePrice.fourthLastQuaterPromoter  = (elementTwo.firstChild.content as String).toFloat()
                    print("4th Quater Promoter =\(  runningSharePrice.fourthLastQuaterPromoter)")
                    break
                }
            }

        }
        
        
        //Getting 200 DMA
        let dMA200XpathQueryString = "//div[@class='FR w252']/table/tr/td"
        
        let dMA200SharePriceNodes =  tutorialsParser?.search(withXPathQuery: dMA200XpathQueryString)
        
        for (index, element)in (dMA200SharePriceNodes?.enumerated())! {
            
            if index == 13{
                let elementTwo: TFHppleElement = element as! TFHppleElement
               if elementTwo.children.count>0{
                runningSharePrice.DMA200  = (elementTwo.firstChild.content as String).toFloat()
                   print("200DMA=\(  runningSharePrice.DMA200)")
                
                break
                }
            }
            if index == 10{
                                let elementTwo: TFHppleElement = element as! TFHppleElement
                if elementTwo.children.count>0{
                    runningSharePrice.DMA150  = (elementTwo.firstChild.content as String).toFloat()
                    print("150DMA=\(  runningSharePrice.DMA150)")
                    
                }
            }
            if index == 7{
                let elementTwo: TFHppleElement = element as! TFHppleElement
                if elementTwo.children.count>0{
                    runningSharePrice.DMA50  = (elementTwo.firstChild.content as String).toFloat()
                    print("50DMA=\(  runningSharePrice.DMA50)")
                    
                }
            }
            if index == 4{
                let elementTwo: TFHppleElement = element as! TFHppleElement
                if elementTwo.children.count>0{
                    runningSharePrice.DMA50  = (elementTwo.firstChild.content as String).toFloat()
                    print("50DMA=\(  runningSharePrice.DMA50)")
                    
                }
            }

        }
        
        
        //Getting Share Name
        let shareNameXpathQueryString = "//h1[@ class='b_42']"
        
        let shareNameNodes =  tutorialsParser?.search(withXPathQuery: shareNameXpathQueryString)
        
        for (index, element)in (shareNameNodes?.enumerated())! {
            
            let elementTwo: TFHppleElement = element as! TFHppleElement
            if elementTwo.children.count>0{
                if elementTwo.firstChild.attributes.count>0{
                    runningSharePrice.sharenName  = (elementTwo.firstChild.firstChild.content as String)
                }else{
                    runningSharePrice.sharenName  = (elementTwo.firstChild.content as String)
                }
                print("Share Name=\( runningSharePrice.sharenName)")
            }
        }
        
        //Getting Share symbol Name
        
        let shareSymbolXpathQueryString = "//div[@ class='FL gry10']"
        
        let shareSymbolNameNodes =  tutorialsParser?.search(withXPathQuery: shareSymbolXpathQueryString)
        
        for (index, element)in (shareSymbolNameNodes?.enumerated())! {
            
            let elementTwo: TFHppleElement = element as! TFHppleElement
            if elementTwo.children.count>0{
                if elementTwo.firstChild.attributes.count>0{
                    runningSharePrice.shareSymbleName  = (elementTwo.firstChild.firstChild.content as String)
                }else{
                    runningSharePrice.shareSymbleName  = (elementTwo.firstChild.content as String)
                }
               // let tempStringArray = runningSharePrice.shareSymbleName.split(separator:" ")
                
                
                var fullNameArr = runningSharePrice.shareSymbleName.characters.split{$0 == " "}.map(String.init)
               
                runningSharePrice.shareSymbleName = fullNameArr.count > 1 ? fullNameArr[1] : ""
                
                print("Share symbol name=\(runningSharePrice.shareSymbleName )")
                
            }
        }
        
        //Getting 52 Week Low
        let low52WeekXpathQueryString = "//span[@id='b_52low']"
        
        let low52WeekSharePriceNodes =  tutorialsParser?.search(withXPathQuery: low52WeekXpathQueryString)
        
        for (index, element)in (low52WeekSharePriceNodes?.enumerated())! {
            
            let elementTwo: TFHppleElement = element as! TFHppleElement
            if elementTwo.children.count>0{
                   if elementTwo.firstChild.attributes.count>0{
                    runningSharePrice.low52Weak  = (elementTwo.firstChild.firstChild.content as String).toFloat()
                   }else{
                    runningSharePrice.low52Weak  = (elementTwo.firstChild.content as String).toFloat()
                }
                                print("52 Low=\( runningSharePrice.low52Weak)")
            }

            // Getting 52 Week High
            let high52WeekXpathQueryString = "//span[@id='b_52high']"
                        let high52WeekSharePriceNodes =  tutorialsParser?.search(withXPathQuery: high52WeekXpathQueryString)
            for (index, element)in (high52WeekSharePriceNodes?.enumerated())! {
            let elementTwo: TFHppleElement = element as! TFHppleElement
            if elementTwo.children.count>0{
                if elementTwo.firstChild.attributes.count>0{
                runningSharePrice.high52Weak  = (elementTwo.firstChild.firstChild.content as String).toFloat()
                }else{
                    runningSharePrice.high52Weak  = (elementTwo.firstChild.content as String).toFloat()
                }
                print("52 High=\(runningSharePrice.high52Weak)")
            }
            }
            
            
//            if index == 1{
//                let elementTwo: TFHppleElement = element as! TFHppleElement
//                 if elementTwo.children.count>0{
//                runningSharePrice.lowToday  = (elementTwo.firstChild.content as String).toFloat()
//                }
//            }
//            if index == 3{
//                
//                let elementTwo: TFHppleElement = element as! TFHppleElement
//                 if elementTwo.children.count>0{
//                runningSharePrice.highToday  = (elementTwo.firstChild.content as String).toFloat()
//                }
//            }
//            
//            if index == 5{
//                let elementTwo: TFHppleElement = element as! TFHppleElement
//                 if elementTwo.children.count>0{
//                runningSharePrice.low52Weak  = (elementTwo.firstChild.content as String).toFloat()
//                }
//            }
//            
//            if index == 7{
//                
//                let elementTwo: TFHppleElement = element as! TFHppleElement
//                 if elementTwo.children.count>0{
//                runningSharePrice.high52Weak  = (elementTwo.firstChild.content as String).toFloat()
//                }
//            }
        }
        
        
        
       //  print("DMA200=\(runningSharePrice.DMA200)\n")
        if  (runningSharePrice.high52Weak/runningSharePrice.low52Weak<=2) &&  (runningSharePrice.DMA200 < runningSharePrice.sharePrice) &&  (runningSharePrice.DMA150 < runningSharePrice.sharePrice) &&  (runningSharePrice.DMA50 < runningSharePrice.sharePrice) &&  (runningSharePrice.DMA30 < runningSharePrice.sharePrice) && (checkPromotorHolding(runningSharePrice.lastQuaterPromoter, secondQuater: runningSharePrice.secondLastQuaterPromoter, thirdQuater: runningSharePrice.thirdLastQuaterPromoter, fourthQuater: runningSharePrice.fourthLastQuaterPromoter)){
            fillterShareCount = fillterShareCount+1
       print("\(fillterShareCount) selected=\(companyURL)")
            
         //    print("DMA200=\(runningSharePrice.DMA200)\n")
            
                   // sharePriceModelTemp.append(self.runningSharePrice)
            var runningSharePriceTemp = ShareRuningPriceModel()
            
            runningSharePriceTemp = runningSharePrice
            sharePriceModelTemp.append(runningSharePriceTemp)
            
            let stockDetail = SFBankInfo()
            stockDetail.sharenName = runningSharePriceTemp.sharenName
            stockDetail.shareSymbleName = runningSharePriceTemp.shareSymbleName
            stockDetail.sharePrice = runningSharePriceTemp.sharePrice
            stockDetail.time = runningSharePriceTemp.time
            stockDetail.type = .allBreakDown
            stockDetail.shareURL = runningSharePriceTemp.shareURL
            SFDBManager.getInstance().insertBankDetails(bankInfo: stockDetail)
            
            getRSIData(stockSymbol: stockDetail.shareSymbleName)
            
//            DispatchQueue.main.async {
//                 self.delegate?.doSomethingWithData(self.sharePriceModelTemp)
//            }
           
        }
        
        print("\n")
    }
    
    func getRSIData(stockSymbol:String){
        Alamofire.request("https://www.alphavantage.co/query?function=RSI&symbol=\(stockSymbol)&interval=60min&time_period=10&series_type=close&apikey=AR2WEKVFCR1F386G").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
                let firstKey : String = (JSON(json)["Technical Analysis: RSI"].dictionaryObject?.keys.first)!
               //runningSharePriceTemp.rsi = JSON(json)["Technical Analysis: RSI"].dictionaryValue[firstKey]
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
    }
    
    
    // check share holding patern
    func checkPromotorHolding(_ firstQuater:Float, secondQuater:Float, thirdQuater: Float, fourthQuater:Float) -> Bool {
        if (firstQuater>=secondQuater) && (secondQuater>=thirdQuater) && (thirdQuater>=fourthQuater) {
            return true
        }else{
            return false
        }
    }
    
    
    func addRunningShareInformationOnLocalDB()  {
        
        //1
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let entity =  NSEntityDescription.entity(forEntityName: "ShareRuningPriceTable", in:managedContext)
        let shareRunningPriceTable = NSManagedObject(entity: entity!,
                                                     insertInto: managedContext)
        
        //3
        shareRunningPriceTable.setValue(runningSharePriceTemp.sharenName, forKey: "shareName")
        shareRunningPriceTable.setValue(runningSharePriceTemp.sharePrice as Float, forKey: "sharePrice")
        shareRunningPriceTable.setValue(runningSharePriceTemp.time, forKey: "time")
        shareRunningPriceTable.setValue(runningSharePriceTemp.gainerNumber, forKey: "gainerNumber")
        shareRunningPriceTable.setValue(runningSharePriceTemp.shareSymbleName, forKey: "shareSymbleName")
        
        
        //4
        do {
            try managedContext.save()
            //5
            runningSharesManageObject.append(shareRunningPriceTable)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    
    
//    func verifyUrl (urlString: String?) -> Bool {
//        //Check for nil
//        if let urlString = urlString {
//            // create NSURL instance
//            if let url = NSURL(string: urlString) {
//                // check if your application can open the NSURL instance
//                return UIApplication.sharedApplication().canOpenURL(url)
//            }
//        }
//        return false
//    }
    
}
