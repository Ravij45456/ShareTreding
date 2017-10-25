//
//  GainerListTableViewController.swift
//  coreDemo
//
//  Created by Ravi Patel on 22/09/16.
//  Copyright © 2016 Chetu. All rights reserved.
//

import UIKit
import CoreData


class GainerListTableViewController: UITableViewController {
    
    
    //********* New ******* //
    // Create an empty array of LogItem's
  //  var gainerListTables = [GainerListTable]()
    
    // Retreive the managedObjectContext from AppDelegate
 //  let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    
    //******//
    
    let runningSharePrice = ShareRuningPriceModel()
    var runningSharesManageObject = [NSManagedObject]()
    
    var objects = [Tutorial]()
   
   // var contributors = [Any]()
    
    func loadTutorials() {
  
        let tutorialsUrl = URL(string: "http://www.bseindia.com/markets/Equity/EQReports/mktwatchR.aspx?filter=Gainer*group$all$A&expandable=2")!
        let tutorialsHtmlData = try? Data(contentsOf: tutorialsUrl)
         let tutorialsParser = TFHpple.init(htmlData: tutorialsHtmlData)
        let tutorialsXpathQueryString = "//tr[@class='TTRow']/td/a"
        let tutorialsNodes =  tutorialsParser?.search(withXPathQuery: tutorialsXpathQueryString)
       
       
        for element in tutorialsNodes! {
                       let elementTwo: TFHppleElement = element as! TFHppleElement
            let tutorial = Tutorial()
            tutorial.title = elementTwo.firstChild.content
            tutorial.url = elementTwo.object(forKey: "href")
         
             self.objects.append(tutorial)
        }
        
        addRunningShareInformationOnLocalDB()
       
        self.tableView.reloadData()
        
        
        
//            if let moc = self.managedObjectContext {
//            
//            // Create some dummy data to work with
////            let items = [
////                ("Best Animal", "Dog"),
////                ("Best Language","Swift"),
////                ("Worst Animal","Cthulu"),
////                ("Worst Language","LOLCODE")
////            ]
//            
//            // Loop through, creating items
//            for (index, share) in objects.enumerate() where index < 11 {
//                // Create an individual item
//                GainerListTable.createInManagedObjectContext(moc, gainerNumber: Int32(index), name: share.title, symbolName: "", time: NSDate().description)
//            }
//            
//        }
        
        
    }
    
    
    
    func getCurrentSharePrice() {
        
        let tutorialsUrl = URL(string: "http://www.moneycontrol.com/india/stockpricequote/diamond-cutting-jewellery-precious-metals/pcjeweller/PJ")!
        let tutorialsHtmlData = try? Data(contentsOf: tutorialsUrl)
        
        let tutorialsParser = TFHpple.init(htmlData: tutorialsHtmlData)
        
       // let tutorialsXpathQueryString = "//tr[@class='TTRow']/td/a"
        
       let tutorialsXpathQueryString =  "//div[@class='FL PR5 rD_30']/span/strong"
        let tutorialsNodes =  tutorialsParser?.search(withXPathQuery: tutorialsXpathQueryString)
        
        
        for element in tutorialsNodes! {
            let elementTwo: TFHppleElement = element as! TFHppleElement
            let tutorial = Tutorial()
            tutorial.title = elementTwo.firstChild.content
            tutorial.url = elementTwo.object(forKey: "href")
            
            self.objects.append(tutorial)
        }
        
        self.tableView.reloadData()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     //   NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: #selector(loadTutorials), userInfo: nil,repeats: true)
        
      //  NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: #selector(loadTutorials()), userInfo: nil, repeats: true)
        
      // loadTutorials()
        
    let runningSharePriceOperation =  RunningSharePriceOperation()
      //  runningSharePriceOperation.getTredingTime()
        
        runningSharePriceOperation.getCompaniesList()
        
       getCurrentSharePrice()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
          }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
      
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return objects.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let thisTutorial = objects[indexPath.row]
        cell.textLabel!.text = thisTutorial.title
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         self.performSegue(withIdentifier: "selectedShareDetailOpenInWebView", sender: self)
    }

 
    
    func addRunningShareInformationOnLocalDB()  {
        
        //1
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let entity =  NSEntityDescription.entity(forEntityName: "GainerListTable", in:managedContext)
        
        
        
        //3
        
        for (index, share) in objects.enumerated() where index < 11 {
            
            let shareRunningPriceTable = NSManagedObject(entity: entity!,
                                                         insertInto: managedContext)
        shareRunningPriceTable.setValue(share.title, forKey: "name")
        shareRunningPriceTable.setValue(index, forKey: "gainerNumber")
       // shareRunningPriceTable.setValue(runningSharePrice.time, forKey: "symbolName")
        shareRunningPriceTable.setValue(Date().description, forKey: "time")
       
        
            if  fetchShares(share.title){
                return
            }
            
        //4
        do {
            try managedContext.save()
            //5
            runningSharesManageObject.append(shareRunningPriceTable)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    }
    
    
    func fetchShares(_ shareName: String) -> Bool{
    var shareExist = false
        //1
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        
        // find all Persons who have a nickname associated with that person
       let predicate = NSPredicate(format: "name = %@", shareName)
      
        
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GainerListTable")
            fetchRequest.predicate = predicate
        
        //3
        do {
            let results =
                try managedContext.fetch(fetchRequest)
            runningSharesManageObject = results as! [NSManagedObject]
            
         if   runningSharesManageObject.count>0{
            shareExist = true
                return shareExist
            }
    
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
return shareExist
    }
    
    
    
    
//    func fetchLog(shareName: String) {
//        
//        
//        //1
//        let appDelegate =
//            UIApplication.sharedApplication().delegate as! AppDelegate
//        
//        let managedContext = appDelegate.managedObjectContext
//        
//        //2
//       // let entity =  NSEntityDescription.entityForName("GainerListTable", inManagedObjectContext:managedContext)
//        
//        let fetchRequest = NSFetchRequest(entityName: "GainerListTable")
//        
//        // Create a sort descriptor object that sorts on the "title"
//        // property of the Core Data object
//        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
//        
//        // Set the list of sort descriptors in the fetch request,
//        // so it includes the sort descriptor
//        fetchRequest.sortDescriptors = [sortDescriptor]
//        
//        // Create a new predicate that filters out any object that
//        // doesn't have a title of "Best Language" exactly.
//        let firstPredicate = NSPredicate(format: "name == %@", "shareName")
//        
//        // Search for only items using the substring "Worst"
//        let thPredicate = NSPredicate(format: "title contains %@", "Worst")
//        
//        // Combine the two predicates above in to one compound predicate
//        let predicate = NSCompoundPredicate(type: NSCompoundPredicateType.OrPredicateType, subpredicates: [firstPredicate, thPredicate])
//        
//        // Set the predicate on the fetch request
//        fetchRequest.predicate = predicate
//        
//        if let fetchResults = (try? managedContext.executeFetchRequest(fetchRequest)) {
//            fetchResults[0].name
//           // logItems = fetchResults
//        }
//    }

   
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "selectedShareDetailOpenInWebView") {
            
            if let selectedShareDetailOnWebViewVC = segue.destination as? SelectedShareDetailOnWebViewViewController{
                selectedShareDetailOnWebViewVC.selectedShareURLInString = objects[(self.tableView.indexPathForSelectedRow?.row)!].url
            }
        }
    }
    
}
