//
//  ShareRuningPriceModel.swift
//  HTMLParsing
//
//  Created by Ravi Patel on 24/09/16.
//  Copyright © 2016 Swipe Stack Ltd. All rights reserved.
//

import UIKit





class ShareRuningPriceModel: NSObject {
    
    //  var delegate: DestinationViewControllerDelegate?
    static let sharedInstance = ShareRuningPriceModel()
    
    var sharenName = ""
    var shareSymbleName = ""
    var gainerNumber = 0
    var sharePrice: Float = 0.0
    var time = ""
    
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
    var shareURL: String  = ""
    
    var rsi: String = ""
    var stoch:  Float = 0.0
    
    var companiesList = [String]()
    
}
