//
//  ViewController.swift
//  kuzushi
//
//  Created by Dave Gumba on 2018-03-05.
//  Copyright © 2018 Dave's Organization. All rights reserved.
//

import UIKit
import ChameleonFramework

class CoinListViewController: UIViewController {
    
    var coins = [Coin]()
    var filteredCoins = [Coin]()
    var inSearchMode = false
    
    func buildHeaderView(withText text: String, ofSize size: CGFloat) -> UIView {
        
        let view = UIView()
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: size)
        label.textAlignment = .left
        label.textColor = .black
        label.text = text
        
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 5).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 5).isActive = true
        
        return view
    }
    
    private var searchBarView: UISearchBar = {
       let searchBar = UISearchBar()
       searchBar.placeholder = "Find a coin.."
       return searchBar
    }()
    
    private var coinListTableView: UITableView = {
        var tableView = UITableView()
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coins = [Coin(rank: 1, name: "Bitcoin", symbol: "BTC", priceUSD: 8562.75, hourlyPercentChange: 0.76),
                 Coin(rank: 81, name: "Smart Cash", symbol: "SMART", priceUSD: 0.181687, hourlyPercentChange: 0.95),
                 Coin(rank: 65, name: "Basic Attention Token", symbol: "BAT", priceUSD: 0.200013, hourlyPercentChange: -1.09),
                 Coin(rank: 100, name: "Test Test", symbol: "ETH", priceUSD: 223232.23, hourlyPercentChange: 2.2323)]
        
        setupLayout()

    }
    
    private func setupLayout() {
        let searchHeaderView = buildHeaderView(withText: "Search", ofSize: 20)
        view.addSubview(searchHeaderView)
        searchHeaderView.translatesAutoresizingMaskIntoConstraints = false
        searchHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchHeaderView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        view.addSubview(searchBarView)
        searchBarView.translatesAutoresizingMaskIntoConstraints = false
        searchBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBarView.topAnchor.constraint(equalTo: searchHeaderView.bottomAnchor, constant: 0).isActive = true
        
        searchBarView.delegate = self
        
        let coinsListHeaderView = buildHeaderView(withText: "Coins", ofSize: 25)
        view.addSubview(coinsListHeaderView)
        coinsListHeaderView.translatesAutoresizingMaskIntoConstraints = false
        coinsListHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        coinsListHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        coinsListHeaderView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: 0).isActive = true
        
        view.addSubview(coinListTableView)
        coinListTableView.translatesAutoresizingMaskIntoConstraints = false
        coinListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        coinListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        coinListTableView.topAnchor.constraint(equalTo: coinsListHeaderView.bottomAnchor).isActive = true
        coinListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        coinListTableView.rowHeight = 90
        
        coinListTableView.delegate = self
        coinListTableView.dataSource = self
        coinListTableView.register(CoinCell.self, forCellReuseIdentifier: "CoinCell")
    }
}

extension CoinListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            
            inSearchMode = false
            coinListTableView.reloadData()
            view.endEditing(true)
            
        } else {
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            
            filteredCoins = coins.filter({ $0.name!.lowercased().range(of: lower) != nil || ($0.symbol!.lowercased().range(of: lower) != nil) })
            coinListTableView.reloadData()
            
        }
    }
}

extension CoinListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        var coin: Coin!
        
        if inSearchMode {
            coin = filteredCoins[indexPath.row]
        } else {
            coin = coins[indexPath.row]
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredCoins.count
        }
        
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CoinCell(style: UITableViewCellStyle.default, reuseIdentifier: "CoinCell")
        
        let coin: Coin!
        
        if inSearchMode {
            
            coin = filteredCoins[indexPath.row]
            
        } else {
            
            coin = coins[indexPath.row]
        }
        
        let isNegative = "\(coin.hourlyPercentChange!)".starts(with: "-")
        let hourlyPercentageText = isNegative ?
                                    "\(coin.hourlyPercentChange!)" :
                                    "+\(coin.hourlyPercentChange!)"
        
        cell.rank.text = "\(coin.rank!)"
        cell.symbol.text = coin.symbol!
        cell.name.text = coin.name!
        cell.priceUSD.text =  "$\(coin.priceUSD!)"
        cell.hourlyPercentChange.text = "\(hourlyPercentageText)%"
        cell.hourlyPercentChange.textColor = isNegative ? UIColor.red : UIColor.green
        return cell
    }
}
