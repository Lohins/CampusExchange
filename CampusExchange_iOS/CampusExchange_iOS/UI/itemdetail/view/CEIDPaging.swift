//
//  CEIDPaging.swift
//  CampusExchange_iOS
//
//  Created by S.t on 2017/2/25.
//  Copyright © 2017年 UBIELIFE Inc. All rights reserved.
//

import UIKit

class CEIDPaging: UIView {
    
    var cell_width = CGFloat(32)
    
    var stackView: UIStackView!
    
    var numberPages: Int = 0
    
    var selectedImg : UIImage!
    
    var defaultImg: UIImage!
    
    var lastSelectedView: UIView?
    
    override init(frame: CGRect) {
        
        
        super.init(frame: frame)
    }
    
    convenience init( numOfPages: Int){
        
        self.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 32))
        
        self.numberPages = numOfPages
        
        self.selectedImg = UIImage.init(named: "pagecontroll_dot_active")
        
        self.defaultImg = UIImage.init(named: "pagecontroll_dot_inactive")
        
        setupUI()
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        let computeFrame = CGRect.init(x: 0, y: 0, width: cell_width * CGFloat( self.numberPages ), height: cell_width)
        stackView = UIStackView.init(frame: computeFrame)
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 0

        for _ in 0..<self.numberPages{
            let view = UIView.init()
            view.heightAnchor.constraint(equalToConstant: cell_width).isActive = true
            view.widthAnchor.constraint(equalToConstant: cell_width).isActive = true
            let imageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: cell_width / 2, height: cell_width / 2))
            imageView.center = CGPoint.init(x: cell_width / 2, y: cell_width / 2)
            imageView.image = self.defaultImg
            view.addSubview(imageView)
            self.stackView.addArrangedSubview(view)
        }
        
        self.frame = computeFrame
        self.addSubview(self.stackView)
    }
    
    
    func setCurrentPage(page: Int){
        if page > self.numberPages{
            return
        }
        
        if let view = self.lastSelectedView{
            let imgView = view.subviews[0] as! UIImageView
            imgView.image = self.defaultImg
        }
        
        let view = self.stackView.arrangedSubviews[page]
        let imgView = view.subviews[0] as! UIImageView
        imgView.image = self.selectedImg
        
        self.lastSelectedView = view
        
        
    }
    

}
