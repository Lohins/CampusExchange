//
//  CERankTableCell.swift
//  CampusExchange_iOS
//
//  Created by S.t on 2017/2/26.
//  Copyright © 2017年 UBIELIFE Inc. All rights reserved.
//

import UIKit

class CERankTableCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var checkView: UIImageView!
    
    var item : CERankItem!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
        
        if selected == true{
            self.checkView.isHidden = false
        }
        else{
            self.checkView.isHidden = true
        }
        
    }
    
    
    func setContent(title: String){
        self.titleLabel.text = title
    }
    
    func setDataItem(item : CERankItem){
        self.item = item
        
        self.setContent(title: self.item.name)
    }
    
    
    
}
