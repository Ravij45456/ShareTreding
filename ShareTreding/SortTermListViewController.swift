//
//  SortTermListViewController.swift
//  ShareTreding
//
//  Created by Ravi Patel on 13/10/16.
//  Copyright © 2016 Chetu. All rights reserved.
//

import UIKit

class SortTermListViewController: UIViewController, DestinationViewControllerDelegate {
    
    var sharePriceModel : [ShareRuningPriceModel] = []
    @IBOutlet weak var sortTermListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            
        
      let runningSharePriceOperation =  RunningSharePriceOperation()
        runningSharePriceOperation.delegate = self
        runningSharePriceOperation.getCompaniesList()
        
        
    }
    
    func doSomethingWithData(_ shareRuningPriceModel: [ShareRuningPriceModel]){
        //sharePriceModel.append(shareRuningPriceModel)
        sharePriceModel = shareRuningPriceModel
       
        DispatchQueue.main.async { () -> Void in
        self.sortTermListTableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
        return 1
           }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sharePriceModel.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        //  let sharePrice = sharePriceModel[indexPath.row]
        cell.textLabel!.text = "\(sharePriceModel[indexPath.row].sharenName)"
        cell.detailTextLabel?.text = "Price=\(sharePriceModel[indexPath.row].sharePrice), 200DMA=\(sharePriceModel[indexPath.row].DMA200)"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        self.performSegue(withIdentifier: "selectedShareDetailOpenInWebView", sender: self)
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "selectedShareDetailOpenInWebView") {
            
            if let selectedShareDetailOnWebViewVC = segue.destination as? SelectedShareDetailOnWebViewViewController{
                selectedShareDetailOnWebViewVC.selectedShareURLInString = sharePriceModel[(sortTermListTableView.indexPathForSelectedRow?.row)!].shareURL
            }
        }
    }
    
}
