//
//  CoinCell.swift
//  kuzushi
//
//  Created by Dave Gumba on 2018-03-06.
//  Copyright © 2018 Dave's Organization. All rights reserved.
//

import UIKit

class CoinCell: UITableViewCell {
    
    let coinName = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        coinName.translatesAutoresizingMaskIntoConstraints = false
        coinName.frame = CGRect(x: 10, y: 10, width: 100, height: 90)
        contentView.addSubview(coinName)
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
