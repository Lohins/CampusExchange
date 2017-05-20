//
//  CEPostedItemCell.swift
//  CampusExchange_iOS
//
//  Created by S.t on 2017/3/2.
//  Copyright © 2017年 UBIELIFE Inc. All rights reserved.
//

import UIKit

class CEPostedItemCell: UITableViewCell {
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(goods: CEMerchandise){
        self.priceLabel.text = "\(goods.productPrice)"
        if let url = URL.init(string: goods.photoUrl){
            self.iconImageView.setImageWith(url)
        }
        self.nameLabel.text = goods.productName
    }
    
}
