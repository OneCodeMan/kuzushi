//
//  CoinFetcher.swift
//  kuzushi
//
//  Created by Dave Gumba on 2018-03-16.
//  Copyright © 2018 Dave's Organization. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CoinFetcher {
    
    var coins = [Coin]()
    var coinURL: URL?
    let URLstring = "https://api.coinmarketcap.com/v1/ticker/"
    
    func getCoins(completed: @escaping () -> Void) {
        
        coins = []
        
        coinURL = URL(string: URLstring)
        
        if let coinURL = coinURL {
            Alamofire.request(coinURL).responseJSON(completionHandler: { response in
                let result = response.result
                
                let rawCoinData = result.value ?? ""
                let coinData = JSON(rawCoinData)
                
                for (_, coin) in coinData {
                    let rank = coin["rank"].intValue
                    let name = coin["name"].stringValue
                    let symbol = coin["symbol"].stringValue
                    let priceUSD = coin["price_usd"].doubleValue
                    let priceBTC = coin["price_btc"].doubleValue
                    let hourlyPercentChange = coin["percent_change_24h"].doubleValue
                    
                    let coinInstance = Coin(rank: rank, name: name, symbol: symbol, priceUSD: priceUSD, priceBTC: priceBTC, hourlyPercentChange: hourlyPercentChange)
                    
                    self.coins.append(coinInstance)
                }
                
                completed()
            })
        }
    }
    
}
