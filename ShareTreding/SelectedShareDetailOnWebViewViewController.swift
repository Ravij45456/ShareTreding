//
//  SelectedShareDetailOnWebViewViewController.swift
//  ShareTreding
//
//  Created by Ravi Patel on 27/09/16.
//  Copyright © 2016 Chetu. All rights reserved.
//

import UIKit

class SelectedShareDetailOnWebViewViewController: UIViewController, MessageDataPassingDelegate {
    
   var selectedShareURLInString = ""
     @IBOutlet weak var webViewLoanDocumentDetail: UIWebView?

        var stocks: [String] {
                get {
                        if let returnValue = UserDefaults.standard.object(forKey: "stock") as? [String] {
                                return returnValue
                        } else {
                                return ["muesli.com", "banana.com"] //Default value
                        }
                }
                set {
                        UserDefaults.standard.set(newValue, forKey: "stock")
                        UserDefaults.standard.synchronize()
                }
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Add navigation bar button
        let favouriteVC = STFavouriteTableViewController()
        favouriteVC.delegate = self

        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFavSotckInPrefe))
       let favList = UIBarButtonItem(title: "Fav List", style: .plain, target: self, action: #selector(moveToFavouriteStockListController))

        navigationItem.rightBarButtonItems = [favList, add]
        sendStockName(stockName: selectedShareURLInString)

           }

        func addFavSotckInPrefe(){
                stocks += [selectedShareURLInString]
                print (stocks)
        }


        func moveToFavouriteStockListController(){
                self.performSegue(withIdentifier: "favouriteVC", sender: self)
        }

//        func openSelectedStockInWebView(){
//
//        }

        func sendStockName(stockName: String){
                //selectedShareURLInString = stockName
                webViewLoanDocumentDetail?.loadRequest(URLRequest(url: URL(string: stockName)!))
                webViewLoanDocumentDetail!.scalesPageToFit = true
        }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
