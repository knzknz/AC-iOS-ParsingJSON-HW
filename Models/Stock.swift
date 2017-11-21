//
//  Stock.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/18/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class Stocks {
    
    let date: String?
    let openingAmount: Double
    let closingAmount: Double
    
    var HeaderNames: String {
        var dateAsArr = date?.split(separator: "-")
        let year = dateAsArr![0]
        let month = String(dateAsArr![1])
        return "\(monthsAsDict[month]!)-\(year)"
    }
    
    let monthsAsDict = ["01": "January", "02": "February", "03": "March", "04": "April", "05": "May", "06": "June", "07": "July", "08": "August", "09": "September", "10": "October", "11": "November", "12": "December"]
    
    
    init(date: String?, openingAmount: Double, closingAmount: Double) {
        self.date = date
        self.openingAmount = openingAmount
        self.closingAmount = closingAmount
    }
    
    //failable convenience initialzer
    convenience init?(from jsonDict: [String:Any]) {
        guard
            let openingAmount = jsonDict["open"] as? Double,
            let closingAmount = jsonDict["close"] as? Double
            else{
                return nil
        }
        let date = jsonDict["date"] as? String
        
        self.init(date: date, openingAmount: openingAmount, closingAmount: closingAmount)
    }
    
    //Returns an optional just incase an array cannot be created
    //Data is converted into an object
    static func createArrayOfStock(from data: Data) -> [Stocks]? {
        var stockDetails: [Stocks] = []
        do {
            guard let stockJSONArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]] else {return nil}
            
            for stockDict in stockJSONArray{
                if let thisStock = Stocks(from: stockDict){
                    stockDetails.append(thisStock)
                }
            }
        } catch {
            print("Error: Could not convert data to JSON")
        }
        return stockDetails
    }
}
