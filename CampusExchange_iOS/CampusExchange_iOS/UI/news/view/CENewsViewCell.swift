//
//  CENewsViewCell.swift
//  CampusExchange_iOS
//
//  Created by Weibo Wang on 2017/3/20.
//  Copyright © 2017年 UBIELIFE Inc. All rights reserved.
//

import UIKit

class CENewsViewCell: UITableViewCell {

    @IBOutlet weak var PicView: UIImageView!
    
    @IBOutlet weak var TitleLabel: UILabel!
    
    @IBOutlet weak var PosttimeLabel: UILabel!
    
    @IBOutlet weak var ContentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func updateUI(news: CENewsItem){
        self.TitleLabel.text = news.title
        self.PosttimeLabel.text = news.createDate
        self.ContentLabel.text = news.content
        if let url = URL.init(string: news.photoUrl){
            self.PicView.setImageWith(url)
        }

    }
    

}
