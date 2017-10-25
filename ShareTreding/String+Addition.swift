//
//  String+Addition.swift
//  SFSoftwiseFinacials
//
//  Created by Softwise  on 17/11/15.

//

import Foundation


extension String {
    
    /**
     insert() method insert the new string for given index and return the new string.
     - Parameters:
     - string: string which is inserted
     -ind : index number where string inserted
     - returns: new string
     */
    
    
    func insert(_ string:String,ind:Int) -> String {
        return  String(self.characters.prefix(ind)) + string + String(self.characters.suffix(self.characters.count-ind))
    }
    
        /** toDouble() method return the double value from string if sting contatin emply string then retrun the 0.0 value
     - Parameters:
     - returns:
     */
    
    func toFloat() -> Float {
        if let unwrappedNum = Float(self) {
            return unwrappedNum
        } else {
            // Handle a bad number
            print("Error converting \"" + self + "\" to Double")
            return 0.0
        }
    }
    
    
    /** oDoubleWithTwoDecimal() method return the double value from string if sting contatin emply string then retrun the 0.00 value
     - Parameters:
     - returns:
     */
    func toDoubleWithTwoDecimal() -> Double {
        if let unwrappedNum = Double(self) {
            return unwrappedNum
        } else {
            // Handle a bad number
            print("Error converting \"" + self + "\" to Double")
            return 0.00
        }
    }
    
    
}

