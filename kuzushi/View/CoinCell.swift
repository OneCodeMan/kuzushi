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
    let priceUSD = UILabel()
    let hourlyPercentChange = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    private func setupLayout() {
        
        contentView.addSubview(rank)
        rank.font = UIFont.systemFont(ofSize: 50)
        rank.translatesAutoresizingMaskIntoConstraints = false
        rank.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        rank.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
        rank.sizeToFit()
        
        contentView.addSubview(symbol)
        symbol.font = UIFont.boldSystemFont(ofSize: 40)
        symbol.translatesAutoresizingMaskIntoConstraints = false
        symbol.leadingAnchor.constraint(equalTo: rank.trailingAnchor, constant: 15).isActive = true
        symbol.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        symbol.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.40).isActive = true
        
        contentView.addSubview(name)
        name.font = UIFont.italicSystemFont(ofSize: 15)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.leadingAnchor.constraint(equalTo: rank.trailingAnchor, constant: 15).isActive = true
        name.topAnchor.constraint(equalTo: symbol.bottomAnchor, constant: 2).isActive = true
        name.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        name.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.40).isActive = true
        
        contentView.addSubview(priceUSD)
        priceUSD.font = UIFont.systemFont(ofSize: 20)
        priceUSD.translatesAutoresizingMaskIntoConstraints = false
        priceUSD.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        priceUSD.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        priceUSD.leadingAnchor.constraint(greaterThanOrEqualTo: name.trailingAnchor).isActive = true
        
        contentView.addSubview(hourlyPercentChange)
        hourlyPercentChange.translatesAutoresizingMaskIntoConstraints = false
        hourlyPercentChange.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12).isActive = true
        hourlyPercentChange.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        
        
        
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
