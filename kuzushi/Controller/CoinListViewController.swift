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
    
    private var favoritesListTableView: UITableView!
    
    func buildHeaderView(withText text: String) -> UIView {
        
        let view = UIView()
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: 65).isActive = true
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
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
       searchBar.backgroundColor = UIColor.flatForestGreen()
       return searchBar
    }()
    
    private var coinListTableView: UITableView = {
        var tableView = UITableView()
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()

    }
    
    private func setupLayout() {
        let searchHeaderView = buildHeaderView(withText: "Search")
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
        
        let coinsListHeaderView = buildHeaderView(withText: "Coins")
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
        
        coinListTableView.delegate = self
        coinListTableView.dataSource = self
        coinListTableView.register(CoinCell.self, forCellReuseIdentifier: "CoinCell")
    }
}

extension CoinListViewController: UISearchBarDelegate {
    
}

extension CoinListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CoinCell(style: UITableViewCellStyle.default, reuseIdentifier: "CoinCell")
        cell.coinName.text = "POOOO"
        return cell
    }
}
