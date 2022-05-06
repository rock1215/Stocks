//
//  StockClient.swift
//  StockList
//
//  Created by Yansong Wang on 2022/5/5.
//

import Foundation

final class StockClient {
    private let baseURL = URL(string: "https://financialmodelingprep.com/api/v3/")!
    
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchAll(with request: StockRequest, completion: @escaping (Result<StockListResponse, DataResponseError>) -> Void) {
        let urlRequest = URLRequest(url: baseURL.appendingPathComponent(request.path))
        
        let encodedURLRequest = urlRequest.encode(with: request.parameters)
        
        self.session.dataTask(with: encodedURLRequest) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.hasSuccessStatusCode, let data = data else {
                completion(Result.failure(DataResponseError.network))
                
                return
            }
            
            guard let stocks = try? JSONDecoder().decode([StockItem].self, from: data) else {
                completion(Result.failure(DataResponseError.decoding))
                return
            }
            
            completion(Result.success(StockListResponse(with: stocks)))
        }.resume()
    }
}
