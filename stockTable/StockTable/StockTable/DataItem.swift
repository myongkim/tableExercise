//
//  DataItem.swift
//  StockTable
//
//  Created by Isaac Kim on 8/29/17.
//  Copyright © 2017 Isaac Kim. All rights reserved.
//

import UIKit

class StockList {
    
    var stockName: String
    var rating: Int
    var randomStock: [String] = ["Apple", "SNAP", "Google", "Facebook", "At&T", "Verizon", "Tesla", "Amazon", "Lending Tree", "Bank of America"]
    
    init() {
        let ratingRandom = Int(arc4random_uniform(5) + 1)
        let stockRandom = Int(arc4random_uniform(10))
        self.stockName = randomStock[stockRandom]
        self.rating = ratingRandom * 5
    }
    
}
