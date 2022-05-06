//
//  HTTPURLResponse.swift
//  StockList
//
//  Created by Yansong Wang on 2022/5/5.
//

import Foundation

import Foundation

extension HTTPURLResponse {
    var hasSuccessStatusCode: Bool {
        return 200...299 ~= statusCode
    }
}
