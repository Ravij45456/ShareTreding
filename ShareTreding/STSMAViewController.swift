//
//  STSMAViewController.swift
//  ShareTreding
//
//  Created by Truelogicmac on 24/11/16.
//  Copyright © 2016 Chetu. All rights reserved.
//

import UIKit
import CoreData

//protocol DestinationViewControllerDelegate {
//    func doSomethingWithData(shareRuningPriceModel: [ShareRuningPriceModel])
//}
class STSMAViewController: UITableViewController, DestinationViewControllerDelegate {
    
    var sharePriceModel : [ShareRuningPriceModel] = []
     let runningSharePriceOperation =  RunningSharePriceOperation()
    
       // var delegate: DestinationViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        runningSharePriceOperation.delegate = self
        //runningSharePriceOperation.getCompaniesList()

        
        getCompaniesList()
       // NSTimer.scheduledTimerWithTimeInterval(15, target: self, selector: #selector(getCompaniesList), userInfo: nil,repeats: true)
        
        
    }
    
    func doSomethingWithData(_ shareRuningPriceModel: [ShareRuningPriceModel]){
        //sharePriceModel.append(shareRuningPriceModel)
        sharePriceModel = shareRuningPriceModel
        
        DispatchQueue.main.async { () -> Void in
            self.tableView.reloadData()
        }
    }
    
        
        var sharePriceModelTemp = [ShareRuningPriceModel]()
    
    var DMA50SharesList = [String]()
        
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
    
    func  openShareURL() {
        
         UIApplication.shared.openURL(URL(string:"http://www.moneycontrol.com/"+self.runningSharePriceTemp.shareURL)!)
        
       
        
      //  self.performSegueWithIdentifier("selectedShareDetailOpenInWebView", sender: self)
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "selectedShareDetailOpenInWebView") {
            
            if let selectedShareDetailOnWebViewVC = segue.destination as? SelectedShareDetailOnWebViewViewController{
                selectedShareDetailOnWebViewVC.selectedShareURLInString = "http://www.moneycontrol.com/"+self.runningSharePriceTemp.shareURL
            }
        }
    }
//http://www.moneycontrol.com/india/stockpricequote/paper/dadrawalapapers/DP
 
    
    
        func getCompaniesList() {
            var i = 0
            //let companyNameStatedLetter = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
     //       let companyNameStatedLetter = ["D"]
            DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async {
                
               // for startLetter in companyNameStatedLetter {
                    
                    let companiesListUrl = URL(string: "http://www.moneycontrol.com/technicals/breakout/positive/avg200/index.html")!
                    
                    let companiesListHtmlData = try? Data(contentsOf: companiesListUrl)
                    
                    let companiesListParser = TFHpple.init(htmlData: companiesListHtmlData)
                    
                    
                    // Getting companies list 
                //div class="tbldata13"
               
                    let companiesListXpathQueryString = "//div[@class='tbldata13']/table/tr/td/a"
                
                //"//table[@class='pcq_tbl MT10']/tr/td/a/@href"
                
               // "//tr[@class='bggryrbl']/td/"
                    
                    
                    let companiesListNodes =  companiesListParser?.search(withXPathQuery: companiesListXpathQueryString)
                
                let arrayCount = self.DMA50SharesList.count
                    for element in companiesListNodes! {
                        let elementTwo: TFHppleElement = element as! TFHppleElement
                        i = i+1
                        print("\(i) = \(elementTwo.firstChild.firstChild.content),  -->\(elementTwo.attributes["href"]!)")
                        
                        self.runningSharePriceTemp.sharenName = elementTwo.firstChild.firstChild.content
                        
                        var tempURL =  elementTwo.attributes["href"]! as! String
                        self.runningSharePriceTemp.shareURL = "http://www.moneycontrol.com/india/stock-market/stock-quotes/\(tempURL)"
                    
                        
                        elementTwo.attributes["href"]!
                        
                        if (!self.DMA50SharesList.contains(self.runningSharePriceTemp.sharenName)){
                            self.DMA50SharesList.append(self.runningSharePriceTemp.sharenName)
                           
                            if self.verifyUrl(self.runningSharePriceTemp.shareURL){
                            self.runningSharePriceOperation.getTredingTime(self.runningSharePriceTemp.shareURL)
                            }
                            
                            
//                            dispatch_async(dispatch_get_main_queue()) { () -> Void in
//                                self.tableView.reloadData()
//                            }
                            
                          //  if arrayCount != 0{
                          //  SFUtility.invokeAlertMethod("50 DMA Breakout", strBody: self.runningSharePriceTemp.sharenName, delegate: self)
                                
                                SFUtility.alertContoller("50 DMA Breakout", message: self.runningSharePriceTemp.sharenName, actionTitle1: "Open", actionTitle2: "Ok", firstActoin: #selector(self.openShareURL), controller: self)
                            
                           
                           
                            let stockDetail = SFBankInfo()
                                stockDetail.sharenName = self.runningSharePriceTemp.sharenName
                                stockDetail.shareSymbleName = self.runningSharePriceTemp.shareSymbleName
                                stockDetail.sharePrice = self.runningSharePriceTemp.sharePrice
                                stockDetail.time = self.runningSharePriceTemp.time
                                stockDetail.type = .DMA50
                                stockDetail.shareURL = self.runningSharePriceTemp.shareURL
                                
                                
                            
                            SFDBManager.getInstance().insertBankDetails(bankInfo: stockDetail)
                            
                            
                           // }
                        }
                        
                        
                        
//                        if self.verifyUrl(self.runningSharePriceTemp.shareURL){
//                            
//                            self.getTredingTime(self.runningSharePriceTemp.shareURL)
//                        }else{
//                            return
//                        }
                        //runningSharePrice.companiesList.append(elementTwo.firstChild.content)
                        
                    }
                    
                }
            }
            // delegate?.doSomethingWithData(sharePriceModelTemp)
    
        
        
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
    
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sharePriceModelTemp.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        //  let sharePrice = sharePriceModel[indexPath.row]
        cell.textLabel!.text = "\(sharePriceModelTemp[indexPath.row].sharenName)"
        return cell
    }
    
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        self.performSegueWithIdentifier("selectedShareDetailOpenInWebView", sender: self)
//    }
    
    
    // MARK: - Navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if (segue.identifier == "selectedShareDetailOpenInWebView") {
//            
//            if let selectedShareDetailOnWebViewVC = segue.destinationViewController as? SelectedShareDetailOnWebViewViewController{
//               // selectedShareDetailOnWebViewVC.selectedShareURLInString = sharePriceModel[(self.indexPathForSelectedRow?.row)!].shareURL
//            }
//        }
//    }

    
}

        
//        func getTredingTime(companyURL:String) {
//            
//            var runningSharePrice = ShareRuningPriceModel()
//            
//            runningSharePrice.sharePrice = runningSharePriceTemp.sharePrice
//            runningSharePrice.shareURL = runningSharePriceTemp.shareURL
//            
//            // let tutorialsUrl = NSURL(string: "http://www.moneycontrol.com/india/stockpricequote/tyres/mrf/MRF")!
//            
//            if !verifyUrl(companyURL){
//                
//                return
//            }
//            
//            
//            let tutorialsUrl = NSURL(string: companyURL)!
//            
//            
//            
//            let tutorialsHtmlData = NSData(contentsOfURL: tutorialsUrl)
//            
//            let tutorialsParser = TFHpple.init(HTMLData: tutorialsHtmlData)
//            
//            
//            // Getting Share Running Time
//            let tredingTimeXpathQueryString =  "//div/div/div/div[@ id='bse_upd_time']"
//            
//            let tredingTimeNodes =  tutorialsParser.searchWithXPathQuery(tredingTimeXpathQueryString)
//            
//            for element in tredingTimeNodes {
//                let elementTwo: TFHppleElement = element as! TFHppleElement
//                runningSharePrice.time  = elementTwo.firstChild.content
//            }
//            
//            
//            // Getting Share Running Price
//            let tredingSharePriceXpathQueryString =  "//div[@class='FL PR5 rD_30']/span/strong"
//            
//            let tredingSharePriceNodes =  tutorialsParser.searchWithXPathQuery(tredingSharePriceXpathQueryString)
//            
//            for element in tredingSharePriceNodes {
//                let elementTwo: TFHppleElement = element as! TFHppleElement
//                runningSharePrice.sharePrice  = (elementTwo.firstChild.content as String).toFloat()
//                //self.objects.append(tutorial)
//                print("Current Price=\(  runningSharePrice.sharePrice)")
//                // becase we getting only BSE current Price
//                break
//            }
//            
//            //   addRunningShareInformationOnLocalDB()
//            
//            
//            
//            // Getting Promotor share holding
//            
//            let shareHoldingPaternLastQuaterXpathQueryString = "//tr/td[@class='thc04 w90 gD_12 tar']/span[@class='PR5']"
//            
//            let shareHoldingPaternLastQuaterNodes =  tutorialsParser.searchWithXPathQuery(shareHoldingPaternLastQuaterXpathQueryString)
//            
//            for (index, element)in shareHoldingPaternLastQuaterNodes.enumerate() {
//                
//                
//                if index == 0{
//                    let elementTwo: TFHppleElement = element as! TFHppleElement
//                    if elementTwo.children.count>0{
//                        runningSharePrice.lastQuaterPromoter  = (elementTwo.firstChild.content as String).toFloat()
//                        print("1st Quater Promoter=\(  runningSharePrice.lastQuaterPromoter)")
//                        
//                    }
//                }
//                if index == 1{
//                    let elementTwo: TFHppleElement = element as! TFHppleElement
//                    if elementTwo.children.count>0{
//                        runningSharePrice.secondLastQuaterPromoter  = (elementTwo.firstChild.content as String).toFloat()
//                        print("2nd Quater Promoter=\(  runningSharePrice.secondLastQuaterPromoter)")
//                        
//                    }
//                }
//                
//                if index == 2{
//                    let elementTwo: TFHppleElement = element as! TFHppleElement
//                    if elementTwo.children.count>0{
//                        runningSharePrice.thirdLastQuaterPromoter  = (elementTwo.firstChild.content as String).toFloat()
//                        print("3rd Quater Promoter=\(  runningSharePrice.thirdLastQuaterPromoter)")
//                        
//                    }
//                }
//                
//                if index == 3{
//                    let elementTwo: TFHppleElement = element as! TFHppleElement
//                    if elementTwo.children.count>0{
//                        runningSharePrice.fourthLastQuaterPromoter  = (elementTwo.firstChild.content as String).toFloat()
//                        print("4th Quater Promoter =\(  runningSharePrice.fourthLastQuaterPromoter)")
//                        break
//                    }
//                }
//                
//            }
//            
//            
//            //Getting 200 DMA
//            let dMA200XpathQueryString = "//div[@class='FR w252']/table/tr/td"
//            
//            let dMA200SharePriceNodes =  tutorialsParser.searchWithXPathQuery(dMA200XpathQueryString)
//            
//            for (index, element)in dMA200SharePriceNodes.enumerate() {
//                
//                if index == 13{
//                    let elementTwo: TFHppleElement = element as! TFHppleElement
//                    if elementTwo.children.count>0{
//                        runningSharePrice.DMA200  = (elementTwo.firstChild.content as String).toFloat()
//                        print("200DMA=\(  runningSharePrice.DMA200)")
//                        
//                        break
//                    }
//                }
//                if index == 10{
//                    let elementTwo: TFHppleElement = element as! TFHppleElement
//                    if elementTwo.children.count>0{
//                        runningSharePrice.DMA150  = (elementTwo.firstChild.content as String).toFloat()
//                        print("150DMA=\(  runningSharePrice.DMA150)")
//                        
//                    }
//                }
//                if index == 7{
//                    let elementTwo: TFHppleElement = element as! TFHppleElement
//                    if elementTwo.children.count>0{
//                        runningSharePrice.DMA50  = (elementTwo.firstChild.content as String).toFloat()
//                        print("50DMA=\(  runningSharePrice.DMA50)")
//                        
//                    }
//                }
//                if index == 4{
//                    let elementTwo: TFHppleElement = element as! TFHppleElement
//                    if elementTwo.children.count>0{
//                        runningSharePrice.DMA50  = (elementTwo.firstChild.content as String).toFloat()
//                        print("50DMA=\(  runningSharePrice.DMA50)")
//                        
//                    }
//                }
//                
//            }
//            
//            
//            //Getting Share Name
//            let shareNameXpathQueryString = "//h1[@ class='b_42']"
//            
//            let shareNameNodes =  tutorialsParser.searchWithXPathQuery(shareNameXpathQueryString)
//            
//            for (index, element)in shareNameNodes.enumerate() {
//                
//                let elementTwo: TFHppleElement = element as! TFHppleElement
//                if elementTwo.children.count>0{
//                    if elementTwo.firstChild.attributes.count>0{
//                        runningSharePrice.sharenName  = (elementTwo.firstChild.firstChild.content as String)
//                    }else{
//                        runningSharePrice.sharenName  = (elementTwo.firstChild.content as String)
//                    }
//                    print("Share Name=\( runningSharePrice.sharenName)")
//                }
//            }
//            
//            //Getting 52 Week Low
//            let low52WeekXpathQueryString = "//span[@id='b_52low']"
//            
//            let low52WeekSharePriceNodes =  tutorialsParser.searchWithXPathQuery(low52WeekXpathQueryString)
//            
//            for (index, element)in low52WeekSharePriceNodes.enumerate() {
//                
//                let elementTwo: TFHppleElement = element as! TFHppleElement
//                if elementTwo.children.count>0{
//                    if elementTwo.firstChild.attributes.count>0{
//                        runningSharePrice.low52Weak  = (elementTwo.firstChild.firstChild.content as String).toFloat()
//                    }else{
//                        runningSharePrice.low52Weak  = (elementTwo.firstChild.content as String).toFloat()
//                    }
//                    print("52 Low=\( runningSharePrice.low52Weak)")
//                }
//                
//                // Getting 52 Week High
//                let high52WeekXpathQueryString = "//span[@id='b_52high']"
//                let high52WeekSharePriceNodes =  tutorialsParser.searchWithXPathQuery(high52WeekXpathQueryString)
//                for (index, element)in high52WeekSharePriceNodes.enumerate() {
//                    let elementTwo: TFHppleElement = element as! TFHppleElement
//                    if elementTwo.children.count>0{
//                        if elementTwo.firstChild.attributes.count>0{
//                            runningSharePrice.high52Weak  = (elementTwo.firstChild.firstChild.content as String).toFloat()
//                        }else{
//                            runningSharePrice.high52Weak  = (elementTwo.firstChild.content as String).toFloat()
//                        }
//                        print("52 High=\(runningSharePrice.high52Weak)")
//                    }
//                }
//                
//                
//                //            if index == 1{
//                //                let elementTwo: TFHppleElement = element as! TFHppleElement
//                //                 if elementTwo.children.count>0{
//                //                runningSharePrice.lowToday  = (elementTwo.firstChild.content as String).toFloat()
//                //                }
//                //            }
//                //            if index == 3{
//                //
//                //                let elementTwo: TFHppleElement = element as! TFHppleElement
//                //                 if elementTwo.children.count>0{
//                //                runningSharePrice.highToday  = (elementTwo.firstChild.content as String).toFloat()
//                //                }
//                //            }
//                //
//                //            if index == 5{
//                //                let elementTwo: TFHppleElement = element as! TFHppleElement
//                //                 if elementTwo.children.count>0{
//                //                runningSharePrice.low52Weak  = (elementTwo.firstChild.content as String).toFloat()
//                //                }
//                //            }
//                //
//                //            if index == 7{
//                //
//                //                let elementTwo: TFHppleElement = element as! TFHppleElement
//                //                 if elementTwo.children.count>0{
//                //                runningSharePrice.high52Weak  = (elementTwo.firstChild.content as String).toFloat()
//                //                }
//                //            }
//            }
//            
//            //  print("DMA200=\(runningSharePrice.DMA200)\n")
//            if  (runningSharePrice.high52Weak/runningSharePrice.low52Weak<=2) &&  (runningSharePrice.DMA200 < runningSharePrice.sharePrice) &&  (runningSharePrice.DMA150 < runningSharePrice.sharePrice) &&  (runningSharePrice.DMA50 < runningSharePrice.sharePrice) &&  (runningSharePrice.DMA30 < runningSharePrice.sharePrice) && (checkPromotorHolding(runningSharePrice.lastQuaterPromoter, secondQuater: runningSharePrice.secondLastQuaterPromoter, thirdQuater: runningSharePrice.thirdLastQuaterPromoter, fourthQuater: runningSharePrice.fourthLastQuaterPromoter)){
//                
//                print("\(fillterShareCount++) selected=\(companyURL)")
//                
//                //    print("DMA200=\(runningSharePrice.DMA200)\n")
//                
//                // sharePriceModelTemp.append(self.runningSharePrice)
//                var runningSharePriceTemp = ShareRuningPriceModel()
//                
//                runningSharePriceTemp = runningSharePrice
//                sharePriceModelTemp.append(runningSharePriceTemp)
//                dispatch_async(dispatch_get_main_queue()) {
//                    self.delegate?.doSomethingWithData(self.sharePriceModelTemp)
//                }
//                
//                
//            }
//            
//            print("\n")
//        }
//        
//        // check share holding patern
//        func checkPromotorHolding(firstQuater:Float, secondQuater:Float, thirdQuater: Float, fourthQuater:Float) -> Bool {
//            if (firstQuater>=secondQuater) && (secondQuater>=thirdQuater) && (thirdQuater>=fourthQuater) {
//                return true
//            }else{
//                return false
//            }
//        }
//        
//        
//        func addRunningShareInformationOnLocalDB()  {
//            
//            //1
//            let appDelegate =
//                UIApplication.sharedApplication().delegate as! AppDelegate
//            let managedContext = appDelegate.managedObjectContext
//            
//            //2
//            let entity =  NSEntityDescription.entityForName("ShareRuningPriceTable", inManagedObjectContext:managedContext)
//            let shareRunningPriceTable = NSManagedObject(entity: entity!,
//                                                         insertIntoManagedObjectContext: managedContext)
//            
//            //3
//            shareRunningPriceTable.setValue(runningSharePriceTemp.sharenName, forKey: "shareName")
//            shareRunningPriceTable.setValue(runningSharePriceTemp.sharePrice as Float, forKey: "sharePrice")
//            shareRunningPriceTable.setValue(runningSharePriceTemp.time, forKey: "time")
//            shareRunningPriceTable.setValue(runningSharePriceTemp.gainerNumber, forKey: "gainerNumber")
//            shareRunningPriceTable.setValue(runningSharePriceTemp.shareSymbleName, forKey: "shareSymbleName")
//            
//            
//            //4
//            do {
//                try managedContext.save()
//                //5
//                runningSharesManageObject.append(shareRunningPriceTable)
//            } catch let error as NSError  {
//                print("Could not save \(error), \(error.userInfo)")
//            }
//        }
//        
//        
//        
//        //    func verifyUrl (urlString: String?) -> Bool {
//        //        //Check for nil
//        //        if let urlString = urlString {
//        //            // create NSURL instance
//        //            if let url = NSURL(string: urlString) {
//        //                // check if your application can open the NSURL instance
//        //                return UIApplication.sharedApplication().canOpenURL(url)
//        //            }
//        //        }
//        //        return false
//        //    }
//        
    

