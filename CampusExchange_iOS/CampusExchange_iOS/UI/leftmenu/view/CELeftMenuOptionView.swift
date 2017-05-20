//
//  CELeftMenuOptionView.swift
//  CampusExchange_iOS
//
//  Created by UBIELIFE on 2017-02-24.
//  Copyright © 2017 UBIELIFE Inc. All rights reserved.
//

import UIKit

class CELeftMenuOptionView: UIView {
    
    var block: ( ()-> Void)?
    
    init(frame: CGRect, text: String, action: @escaping (() -> Void)) {
        block = action
        super.init(frame: frame)
                
        let label = UILabel.init(frame: frame)
        label.text = text
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont.init(name: "SFUIText-Semibold", size: 20)
        self.addSubview(label)
        
        self.backgroundColor = UIColor.clear
        
        let tapGesture = UITapGestureRecognizer.init()
        tapGesture.numberOfTapsRequired = 1
        tapGesture.addTarget(self, action: #selector(self.tapAction))
        self.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tapAction(){
        print("tap hahah")
        if let blk = self.block{
            blk()
        }
    }

}
