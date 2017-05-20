//
//  CEIDTextDetailView.swift
//  CampusExchange_iOS
//
//  Created by S.t on 2017/2/25.
//  Copyright © 2017年 UBIELIFE Inc. All rights reserved.
//

import UIKit

class CEIDTextDetailView: UIView {

    var view: UIView!
    
    var Descriptions: String = ""
    var phone: String = ""
    var email: String = ""
    
    var descContentLabel: UILabel!
    var phoneLabel : UILabel!
    var emailLabel : UILabel!
    
    // override initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    init(frame: CGRect , desc: String, phone:String , email: String) {
        super.init(frame: frame)
        
        self.Descriptions = desc
        
        self.phone = phone
        
        self.email = email
        
        self.setupUI()
    }
    

    
    func setupUI(){
        
        // description title
        
        let descTitleLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.width, height: 20))
        descTitleLabel.text = "Descriptions"
        descTitleLabel.top = 12
        descTitleLabel.textAlignment = .center
        descTitleLabel.textColor = UIColor.init(RGBWithRed: 211, green: 17, blue: 69, alpha: 1)
        descTitleLabel.font = UIFont.init(name: "SFUIText-Semibold", size: 16)
        self.addSubview(descTitleLabel)
        
        // description content
        let label_max_width =  self.width - 40
        let limitedSize = CGSize.init(width: label_max_width, height: GlobalValue.SCREENBOUND.height)
        let font = UIFont.init(name: "SFUIText-Regular", size: 12)
        let attr = [NSFontAttributeName: font!]
        let suitableSize = String.getBound(self.Descriptions, size: limitedSize, options: .usesLineFragmentOrigin, attributes: attr, context: nil)
        
        descContentLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: label_max_width, height: suitableSize.height))
        descContentLabel.center = CGPoint.init(x: self.width / 2, y: height / 2)
        descContentLabel.top = descTitleLabel.bottom + 10
        descContentLabel.text = self.Descriptions
        descContentLabel.font = font
        descContentLabel.lineBreakMode = .byWordWrapping
        descContentLabel.numberOfLines = 0
        descContentLabel.textAlignment = .center
        descContentLabel.textColor = UIColor.init(RGBWithRed: 83, green: 88, blue: 96, alpha: 1)
        self.addSubview(descContentLabel)
        
        // contact label
        let contactTitleLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.width, height: 20))
        contactTitleLabel.top = descContentLabel.bottom + 8
        contactTitleLabel.textAlignment = .center
        contactTitleLabel.textColor = UIColor.init(RGBWithRed: 211, green: 17, blue: 69, alpha: 1)
        contactTitleLabel.text = "Contact Information"
        contactTitleLabel.font = UIFont.init(name: "SFUIText-Semibold", size: 16)
        self.addSubview(contactTitleLabel)
        
        // contact phone label
        phoneLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.width, height: 16))
        phoneLabel.top = contactTitleLabel.bottom + 8
        phoneLabel.textAlignment = .center
        phoneLabel.textColor = UIColor.init(RGBWithRed: 83, green: 88, blue: 96, alpha: 1)
        phoneLabel.text = "Mobile: \(self.phone)"
        phoneLabel.font = UIFont.init(name: "SFUIText-Regular", size: 14)
        self.addSubview(phoneLabel)
        
        emailLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.width, height: 16))
        emailLabel.top = phoneLabel.bottom + 3
        emailLabel.textAlignment = .center
        emailLabel.textColor = UIColor.init(RGBWithRed: 83, green: 88, blue: 96, alpha: 1)
        emailLabel.text = "Mobile: \(self.email)"
        emailLabel.font = UIFont.init(name: "SFUIText-Regular", size: 14)
        self.addSubview(emailLabel)
        
        
        self.frame = CGRect.init(x: self.frame.origin.x, y: self.frame.origin.y, width: self.width, height: emailLabel.bottom + 10)
        

    }
    
    func updateData(goods: CEMerchandise){
        self.descContentLabel.text = goods.summary
        self.phoneLabel.text = goods.phone
        self.emailLabel.text = goods.contactInfo
    }
    

}
