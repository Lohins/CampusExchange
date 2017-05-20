//
//  CEIDHeaderView.swift
//  CampusExchange_iOS
//
//  Created by S.t on 2017/2/25.
//  Copyright © 2017年 UBIELIFE Inc. All rights reserved.
//

import UIKit

class CEIDHeaderView: UIView {

    var view: UIView!
    
    // override initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        
        setupUI()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        xibSetup()
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view)
        
    }
    
    func loadViewFromNib()-> UIView{
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CEIDHeaderView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    // custom
    @IBOutlet var avatarImageView: UIImageView!
    
    @IBOutlet weak var nickNameLabel: UILabel!
    
    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var postInfoLabel: UILabel!
    
    @IBOutlet weak var conditionLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var priceInfoLabel: UILabel!
    
    
    func setupUI(){
        self.avatarImageView.layer.cornerRadius = self.avatarImageView.width / 2
        self.avatarImageView.clipsToBounds = true
    }
    
    func updateUI(goods: CEMerchandise){
        if let url = URL.init(string: goods.photoUrl){
            self.avatarImageView.setImageWith(url)
        }
        
        self.nickNameLabel.text = goods.nickName
        
        self.productNameLabel.text = goods.productName
        
        self.priceLabel.text = "$\(goods.productPrice)"
        
        self.postInfoLabel.text = "Posted: \(goods.postTime)"
        
        if goods.isBrandNew == 1{
            self.conditionLabel.text = "Condition: Brand New"
        }
        else{
            self.conditionLabel.text = "Condition: Used"
        }
        
        
        if goods.isNegotiable == 1{
            self.priceInfoLabel.text = "Negotiable"
        }
        else{
            self.priceInfoLabel.text = "Fixed Price"
        }
    }

}
