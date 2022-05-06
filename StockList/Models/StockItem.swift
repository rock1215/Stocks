//
//  StockItem.swift
//  StockList
//
//  Created by Yansong Wang on 2022/5/5.
//

import Foundation

struct StockItem: Decodable {
    let symbol: String
    let name: String
    let price: Double
    let exchange: String
    let exchangeShortName: String
    let type: String
    
    enum CodingKeys: String, CodingKey {
      case symbol, name, price, exchange, exchangeShortName, type
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.symbol = try container.decode(String.self, forKey: .symbol)
        self.name = try container.decode(String.self, forKey: .name)
        self.price = try container.decode(Double.self, forKey: .price)
        self.exchange = try container.decode(String.self, forKey: .exchange)
        self.exchangeShortName = try container.decode(String.self, forKey: .exchangeShortName)
        self.type = try container.decode(String.self, forKey: .type)
    }
}
