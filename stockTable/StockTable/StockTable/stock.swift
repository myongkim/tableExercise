//
//  stock.swift
//  StockTable
//
//  Created by Isaac Kim on 8/29/17.
//  Copyright © 2017 Isaac Kim. All rights reserved.
//

import Foundation

struct Stock {
    
    enum Industry: Int{
        case tech = 0
        case western = 1
        
    }
    let name : String
    let symbol: String
    let price: Int
    let industry: Industry
}
