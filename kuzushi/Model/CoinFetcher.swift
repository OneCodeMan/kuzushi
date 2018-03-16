//
//  CoinFetcher.swift
//  kuzushi
//
//  Created by Dave Gumba on 2018-03-16.
//  Copyright © 2018 Dave's Organization. All rights reserved.
//

import Foundation
import Alamofire

class CoinFetcher {
    
    var coins = [Coin]()
    
    let coinURL = URL(string: "https://api.coinmarketcap.com/v1/ticker/")!
    
    func getCoins(completed: @escaping () -> Void) {
        
        Alamofire.request(coinURL).responseJSON(completionHandler: { response in
            let result = response.result
            
            if let coinData = result.value! as? [[String:Any]] {
                
                for coin in coinData {
                    let rank = coin["rank"]! as? Int
                    let name = coin["name"]! as? String
                    let symbol = coin["symbol"]! as? String
                    let priceUSD = coin["price_usd"]! as? Double
                    let hourlyPercentChange = coin["percent_change_24h"]! as? Double
                    
                    let coinInstance = Coin(rank: rank, name: name, symbol: symbol, priceUSD: priceUSD, hourlyPercentChange: hourlyPercentChange)
                    
                    self.coins.append(coinInstance)
                }
            } else {
                print("Coins not working")
            }
            
            completed()
        })
    }
    
}
