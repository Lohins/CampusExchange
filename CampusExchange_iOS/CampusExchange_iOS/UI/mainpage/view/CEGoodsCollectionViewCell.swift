//
//  CEGoodsCollectionViewCell.swift
//  CampusExchange_iOS
//
//  Created by UBIELIFE on 2017-02-24.
//  Copyright © 2017 UBIELIFE Inc. All rights reserved.
//

import UIKit

class CEGoodsCollectionViewCell: UICollectionViewCell {

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        setupUI()
    }
    
    @IBOutlet weak var bookmarkIcon: UIImageView!
    
    @IBOutlet var avatarImageView: UIImageView!
    
    @IBOutlet weak var nickNameLabal: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    // 价格是否可以商议
    @IBOutlet weak var priceInfoLabel: UILabel!
    // 是否是 新发的产品
    @IBOutlet weak var postInfoLabel: UILabel!
    
    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var additionalInfoLabel: UILabel!
    
    var merchandise: CEMerchandise!
    
    func setupUI(){
        self.avatarImageView.layer.cornerRadius = self.avatarImageView.width / 2
        self.avatarImageView.clipsToBounds = true
    }
    
    
    func updateData(item: CEMerchandise){
        self.merchandise = item
        if let url = URL.init(string: self.merchandise.photoUrl){
            avatarImageView.setImageWith(url)
        }
        
        self.priceLabel.text = "\(self.merchandise.productPrice)"
        
        if self.merchandise.isBrandNew == 1{
            self.additionalInfoLabel.text = "New | \(self.merchandise.postTime)"
        }
        else{
            self.additionalInfoLabel.text = "Used | \(self.merchandise.postTime)"
        }
        
        
        if self.merchandise.productStatus == "new"{
            self.postInfoLabel.text = "New Post"
            self.postInfoLabel.textColor = UIColor.init(red: 211, green: 17, blue: 69, alpha: 1)
        }else if self.merchandise.productStatus == "expiresoon"{
            self.postInfoLabel.text = "Expire Soon"
        }else{
            self.postInfoLabel.text = "For Sale"
        }
        
        
        if self.merchandise.isNegotiable == 1{
            self.priceInfoLabel.text = "Negotiable"
        }
        else{
            self.priceInfoLabel.text = "Fixed Price"
        }
        
        self.productNameLabel.text = self.merchandise.productName
        
        print (self.merchandise.productName)
        
        self.nickNameLabal.text = self.merchandise.nickName
        
        if self.merchandise.isCollected == 1{
            self.bookmarkIcon.image = UIImage.init(named: "mainpage_bookmark_active")
        }
        else{
            self.bookmarkIcon.image = UIImage.init(named: "mainpage_bookmark_inactive")
        }
        
    }
    
    @IBAction func collecteAction(_ sender: Any) {
        

        let service = CEMerchandiseService()
        service.changeBookmarkStatusBy(postId: self.merchandise.postId, isCollected: 1 - self.merchandise.isCollected) { (flag) in
            if flag == true{
                self.merchandise.isCollected = 1 - self.merchandise.isCollected
            }
            if self.merchandise.isCollected == 0{
                self.bookmarkIcon.image = UIImage.init(named: "mainpage_bookmark_inactive")
            }
            else{
                self.bookmarkIcon.image = UIImage.init(named: "mainpage_bookmark_active")
            }
        }
        
    }
    

}
