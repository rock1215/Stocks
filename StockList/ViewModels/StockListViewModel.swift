//
//  StockListViewModel.swift
//  StockList
//
//  Created by Yansong Wang on 2022/5/5.
//

import Foundation

protocol StockListViewModelDelegate {
    func onFetchComplete()
    func onFetchFailed(with reason: String)
}

enum SortKey {
    case name, price
}

final class StockListViewModel {
    private var delegate: StockListViewModelDelegate?
    
    private var stocks: [StockItem] = []
    private var totalStocks: [StockItem] = []
    private var currentPage = 0
    private var isLoading = false
    
    init(delegate: StockListViewModelDelegate) {
        self.delegate = delegate
    }
    
    var totalCount: Int {
        return self.stocks.count + 1
    }
    
    var currentCount: Int {
        return self.stocks.count
    }
    
    func stock(at index: Int) -> StockItem? {
        if index < self.stocks.count {
            return self.stocks[index]
        } else {
            return .none
        }
    }
    
    func fetchStocks() {
        guard !self.isLoading else {
            return
        }
        self.isLoading = true
        let client = StockClient()
        
        client.fetchAll(with: StockRequest.all()) { result in
            self.isLoading = false
            switch (result) {
            case .failure(let error):
                self.delegate?.onFetchFailed(with: error.reason)
                break
            case .success(let response):
                self.totalStocks = response.stocks
                self.sort(by: .name)
                break
            }
        }
    }
    
    func sort(by key: SortKey) {
        if key == .name {
            self.totalStocks = self.totalStocks.sorted(by: { $0.name < $1.name })
            self.stocks = []
            self.currentPage = 0
            self.delegate?.onFetchComplete()
            self.showNext()
        } else {
            self.totalStocks = self.totalStocks.sorted(by: { $0.price > $1.price })
            self.stocks = []
            self.currentPage = 0
            self.delegate?.onFetchComplete()
            self.showNext()
        }
    }
    
    func showNext() {        
        if currentPage * 20 < self.totalStocks.count {
            guard !self.isLoading else {
                return
            }
            
            self.isLoading = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.isLoading = false
                if (self.currentPage + 1) * 20 >= self.totalStocks.count {
                    let added = Array(self.totalStocks[self.currentPage * 20 ..< self.totalStocks.count])
                    self.stocks.append(contentsOf: added)
                } else {
                    let added = Array(self.totalStocks[self.currentPage * 20 ..< (self.currentPage + 1) * 20])
                    self.stocks.append(contentsOf: added)
                }
                self.currentPage += 1
                self.delegate?.onFetchComplete()
            }
        }
        
    }
}
