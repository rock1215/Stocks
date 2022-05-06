//
//  Result.swift
//  StockList
//
//  Created by Yansong Wang on 2022/5/5.
//

import Foundation

enum Result<T, U: Error> {
    case success(T)
    case failure(U)
}
