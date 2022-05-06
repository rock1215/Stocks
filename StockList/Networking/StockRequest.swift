//
//  StockRequest.swift
//  StockList
//
//  Created by Yansong Wang on 2022/5/5.
//

import Foundation

typealias Parameters = [String: String]

struct StockRequest {
    let path: String
  
    let parameters: Parameters = ["apikey": "7ceaa84d2c67ebe0e9ea82766666b212"]
    private init(path: String) {
        self.path = path
    }
}

extension StockRequest {
    static func from(path: String) -> StockRequest {
        return StockRequest(path: path)
    }
    
    static func all() -> StockRequest {
        return StockRequest(path: "stock/list")
    }
}
