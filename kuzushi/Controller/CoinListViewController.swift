//
//  ViewController.swift
//  kuzushi
//
//  Created by Dave Gumba on 2018-03-05.
//  Copyright © 2018 Dave's Organization. All rights reserved.
//

import UIKit

class CoinListViewController: UIViewController {
    
    private var coinSearchBar: UISearchBar!
    private var favoritesListTableView: UITableView!
    private var coinListTableView = UITableView()
    
    private let headerLabel: UIView = {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 21))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22)
        label.textAlignment = .center
        label.text = "Test Label"
        label.textColor = .blue
        label.numberOfLines = 1
        
        return label
    }()
    
    private let searchBarView: UISearchBar = {
       let searchBar = UISearchBar()
        
       return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Coin List"
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        self.view.addSubview(headerLabel)
        
        coinListTableView.frame = CGRect(x: 0, y: 150, width: screenWidth, height: screenHeight)
        coinListTableView.delegate = self
        coinListTableView.dataSource = self
        coinListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "CoinCell")
        self.view.addSubview(coinListTableView)
        
        
//        coinSearchBar.delegate = self
//        favoritesListTableView.delegate = self
//        favoritesListTableView.dataSource = self
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoinCell", for: indexPath as IndexPath)
        cell.textLabel?.text = "Test"
        return cell
    }
}
