//
//  Double+Extension.swift
//  StockList
//
//  Created by Yansong Wang on 2022/5/6.
//

import Foundation

extension Double {
    func toDecimal() -> String {
        return String(format: "%.2f", self)
    }
}
