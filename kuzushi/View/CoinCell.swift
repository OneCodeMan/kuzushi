//
//  CoinCell.swift
//  kuzushi
//
//  Created by Dave Gumba on 2018-03-06.
//  Copyright © 2018 Dave's Organization. All rights reserved.
//

import UIKit

class CoinCell: UITableViewCell {
    
    let rank = UILabel()
    let symbol = UILabel()
    let name = UILabel()
    let coinPrice = UILabel()
    let percentChange = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    private func setupLayout() {
        
        contentView.addSubview(rank)
        rank.font = UIFont(name: Avenir.medium.rawValue, size: 50)
        rank.numberOfLines = 1
        rank.textAlignment = .center
        rank.adjustsFontSizeToFitWidth = true
        rank.sizeToFit()
        rank.translatesAutoresizingMaskIntoConstraints = false
        rank.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.15).isActive = true
        rank.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        rank.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
        
        contentView.addSubview(symbol)
        symbol.font = UIFont(name: Avenir.heavy.rawValue, size: 40)
        symbol.translatesAutoresizingMaskIntoConstraints = false
        symbol.adjustsFontSizeToFitWidth = true
        symbol.leadingAnchor.constraint(equalTo: rank.trailingAnchor, constant: 15).isActive = true
        symbol.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        symbol.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.40).isActive = true
        
        contentView.addSubview(name)
        name.font = UIFont(name: Avenir.lightOblique.rawValue, size: 15)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.adjustsFontSizeToFitWidth = true
        name.leadingAnchor.constraint(equalTo: rank.trailingAnchor, constant: 15).isActive = true
        name.topAnchor.constraint(equalTo: symbol.bottomAnchor, constant: 2).isActive = true
        name.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        name.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.37).isActive = true
        
        contentView.addSubview(coinPrice)
        coinPrice.font = UIFont(name: Avenir.normal.rawValue, size: 18)
        coinPrice.translatesAutoresizingMaskIntoConstraints = false
        coinPrice.adjustsFontSizeToFitWidth = true
        coinPrice.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        coinPrice.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        coinPrice.leadingAnchor.constraint(greaterThanOrEqualTo: name.trailingAnchor).isActive = true
        
        contentView.addSubview(percentChange)
        percentChange.font = UIFont(name: Avenir.normal.rawValue, size: 18)
        percentChange.translatesAutoresizingMaskIntoConstraints = false
        percentChange.adjustsFontSizeToFitWidth = true
        percentChange.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12).isActive = true
        percentChange.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
