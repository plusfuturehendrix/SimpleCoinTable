//
//  nfdsfds.swift
//  CoinTableView
//
//  Created by Danil Bochkarev on 03.04.2023.
//

import Foundation

class APIManager {
    func fetchCoinData(completion: @escaping ([String: Any]?, Error?) -> Void) {
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=15&page=1&sparkline=false&locale=en")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                let error = NSError(domain: "com.example", code: 0, userInfo: [NSLocalizedDescriptionKey: "Ошибка сервера"])
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "com.example", code: 0, userInfo: [NSLocalizedDescriptionKey: "Отсутствуют данные"])
                completion(nil, error)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                let coinData = json?.compactMap({ (element) -> [String: Any]? in
                    guard let symbol = element["symbol"] as? String,
                          let image = element["image"] as? String,
                          let currentPrice = element["current_price"] as? Double else {
                        return nil
                    }
                    //return ["symbol": symbol, "image": image, "currentPrice": currentPrice]
                    return ["symbol": symbol, "image": image, "currentPrice": currentPrice]
                })
                completion(["data": coinData ?? []], nil)
            } catch let error {
                completion(nil, error)
            }
        }
        task.resume()
    }
}




 

