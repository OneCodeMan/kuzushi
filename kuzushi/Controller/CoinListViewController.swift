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
    let coinFetcher = CoinFetcher()
    
    func buildHeaderView(withText text: String, ofSize size: CGFloat) -> UIView {
        
        let view = UIView()
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let label = UILabel()
        label.font = UIFont(name: Avenir.heavy.rawValue, size: size)
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
    
    func buildNoResultsView(withText text: String) -> UIView {
        let view = UIView()
        view.backgroundColor = .white
    
        let label = UILabel()
        label.font = UIFont(name: Avenir.medium.rawValue, size: 15)
        label.textAlignment = .center
        label.textColor = .black
        label.text = text
    
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
    
        return view
    }
    
    private var noConnectionView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        let label = UILabel()
        label.font = UIFont(name: Avenir.medium.rawValue, size: 15)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        label.text = "No internet connection. Please restart the app. 😔"
        
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20).isActive = true
        
        return view
    }()
    
    private var searchBarView: UISearchBar = {
       let searchBar = UISearchBar()
       searchBar.placeholder = "Find a coin.."
       return searchBar
    }()
    
    private var coinListRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        
        return refreshControl
    }()
    
    @objc fileprivate func refreshData() {
        coinFetcher.getCoins {
            self.coins = self.coinFetcher.coins
            
            if self.coins.isEmpty {
                self.coinListTableView.isHidden = true
                self.noConnectionView.isHidden = false
                
            } else {
                self.coinListTableView.isHidden = false
                self.noConnectionView.isHidden = true
                self.coinListRefreshControl.endRefreshing()
                self.coinListTableView.reloadData()
            }

        }
    }
    
    private var coinListTableView: UITableView = {
        var tableView = UITableView()
        
        return tableView
    }()
    
    private var timeSegmentedControl: UISegmentedControl = {
        var pct = UISegmentedControl()
        pct.tintColor = UIColor.flatSkyBlue()
        let font = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17)]
        pct.setTitleTextAttributes(font, for: .normal)
        pct.addTarget(self, action: #selector(handleSegmentIndexChange), for: .valueChanged)
        pct.insertSegment(withTitle: "Hourly", at: 0, animated: true)
        pct.insertSegment(withTitle: "Daily", at: 1, animated: true)
        pct.insertSegment(withTitle: "Weekly", at: 1, animated: true)
        pct.selectedSegmentIndex = 0
        return pct
    }()
    
    private var priceSegmentedControl: UISegmentedControl = {
        var sgc = UISegmentedControl()
        let font = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17)]
        sgc.setTitleTextAttributes(font, for: .normal)
        sgc.tintColor = UIColor.flatSkyBlue()
        sgc.addTarget(self, action: #selector(handleSegmentIndexChange), for: .valueChanged)
        sgc.insertSegment(withTitle: "USD", at: 0, animated: true)
        sgc.insertSegment(withTitle: "BTC", at: 1, animated: true)
        sgc.selectedSegmentIndex = 0
        return sgc
    }()
    
    @objc fileprivate func handleSegmentIndexChange() {
        print("price index: ", priceSegmentedControl.selectedSegmentIndex)
        print("time index: ", timeSegmentedControl.selectedSegmentIndex)
        coinListTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        refreshData()

    }
    
    // MARK: - Setup Layout
    
    fileprivate func setupLayout() {
        
        view.backgroundColor = .white
        
        let titleTextSize: CGFloat = 25
        
        let searchHeaderView = buildHeaderView(withText: "Search", ofSize: titleTextSize)
        view.addSubview(searchHeaderView)
        searchHeaderView.translatesAutoresizingMaskIntoConstraints = false
        searchHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        if #available(iOS 11.0, *) {
            searchHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            searchHeaderView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        }
        
        view.addSubview(searchBarView)
        searchBarView.translatesAutoresizingMaskIntoConstraints = false
        searchBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBarView.topAnchor.constraint(equalTo: searchHeaderView.bottomAnchor, constant: 0).isActive = true
        
        searchBarView.delegate = self
        
        let coinsListHeaderView = buildHeaderView(withText: "Coins", ofSize: titleTextSize)
        view.addSubview(coinsListHeaderView)
        coinsListHeaderView.translatesAutoresizingMaskIntoConstraints = false
        coinsListHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        coinsListHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        coinsListHeaderView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: 0).isActive = true
        
        view.addSubview(timeSegmentedControl)
        timeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        timeSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2).isActive = true
        timeSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2).isActive = true
        timeSegmentedControl.topAnchor.constraint(equalTo: coinsListHeaderView.bottomAnchor).isActive = true
        timeSegmentedControl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(priceSegmentedControl)
        priceSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        priceSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2).isActive = true
        priceSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2).isActive = true
        priceSegmentedControl.topAnchor.constraint(equalTo: timeSegmentedControl.bottomAnchor, constant: 1.5).isActive = true
        priceSegmentedControl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(coinListTableView)
        coinListTableView.translatesAutoresizingMaskIntoConstraints = false
        coinListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        coinListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        coinListTableView.topAnchor.constraint(equalTo: priceSegmentedControl.bottomAnchor).isActive = true
        coinListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        coinListTableView.rowHeight = 90
        
        coinListTableView.delegate = self
        coinListTableView.dataSource = self
        coinListTableView.register(CoinCell.self, forCellReuseIdentifier: "CoinCell")
        coinListRefreshControl.addTarget(self, action: #selector(CoinListViewController.refreshData), for: .valueChanged)
        if #available(iOS 10.0, *) {
            coinListTableView.refreshControl = coinListRefreshControl
        } else {
            coinListTableView.addSubview(coinListRefreshControl)
        }
        
        let noResultsView = buildNoResultsView(withText: "No results found 😜")
        view.addSubview(noResultsView)
        noResultsView.translatesAutoresizingMaskIntoConstraints = false
        noResultsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        noResultsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        noResultsView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        noResultsView.topAnchor.constraint(equalTo: coinsListHeaderView.bottomAnchor).isActive = true
        noResultsView.isHidden = true
        
        view.addSubview(noConnectionView)
        noConnectionView.translatesAutoresizingMaskIntoConstraints = false
        noConnectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        noConnectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        noConnectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        noConnectionView.topAnchor.constraint(equalTo: coinsListHeaderView.bottomAnchor).isActive = true
        noConnectionView.isHidden = true
        
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
            
            if let searchBarText = searchBar.text {
                let lower = searchBarText.lowercased()
                
                filteredCoins = coins.filter({ $0.name?.lowercased().range(of: lower) != nil || ($0.symbol?.lowercased().range(of: lower) != nil) })
                
                coinListTableView.reloadData()
                
            }
            
        }
    }
}

// MARK:- UITableViewDelegate, 

extension CoinListViewController: UITableViewDelegate, UITableViewDataSource {
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//       
//        var coin: Coin!
//        
//        if inSearchMode {
//            coin = filteredCoins[indexPath.row]
//        } else {
//            coin = coins[indexPath.row]
//        }
//        
//    }
    
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
        
        var percentChange: Double!
        var percentageText: String!
        var isNegative: Bool!
        
        switch timeSegmentedControl.selectedSegmentIndex {
        case 0:
            percentChange = coin.hourlyPercentChange
            break
        case 1:
            percentChange = coin.dailyPercentChange
            break
        case 2:
            percentChange = coin.weeklyPercentChange
            break
        default:
            percentChange = coin.hourlyPercentChange
            break
        }

        if let rawPercentageText = percentChange {
            isNegative = "\(rawPercentageText)".starts(with: "-")
            
            percentageText = isNegative ? "\(rawPercentageText)%" :
                                                "+\(rawPercentageText)%"
            
        } else {
            percentageText = "0.00"
        }
        
        cell.rank.text = "\(coin.rank ?? 0)"
        cell.symbol.text = coin.symbol ?? "N/A"
        cell.name.text = coin.name ?? "N/A"
        
        cell.coinPrice.text = priceSegmentedControl.selectedSegmentIndex == 0 ? "$\(coin.priceUSD ?? 0)" : "$\(coin.priceBTC ?? 0)"
        
        cell.percentChange.text = percentageText
        cell.percentChange.textColor = isNegative ? UIColor.red : UIColor.flatGreenColorDark()
        return cell
    }
}
