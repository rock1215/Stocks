//
//  StockListResponse.swift
//  StockList
//
//  Created by Yansong Wang on 2022/5/5.
//

import Foundation

struct StockListResponse {
    let stocks: [StockItem]
    
    init(with stocks: [StockItem]) {
        self.stocks = stocks
    }
}
