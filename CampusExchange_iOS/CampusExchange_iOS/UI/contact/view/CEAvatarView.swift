//
//  CEAvatarView.swift
//  CampusExchange_iOS
//
//  Created by S.t on 2017/3/2.
//  Copyright © 2017年 UBIELIFE Inc. All rights reserved.
//

import UIKit

class CEAvatarView: UIView {

    @IBOutlet var avatarImageView: UIImageView!
    
    @IBOutlet var changePhotoImageView: UIImageView!
    
    
    var view: UIView!
    
    var flag = false
    
    // override initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
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
        let nib = UINib(nibName: "CEAvatarView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    func getstatus() -> Bool {
        return self.flag
    }
    
    func getImage() -> UIImage {
        return self.avatarImageView.image!
    }
    
    @IBAction func tapAction(_ sender: Any) {
        if let nav = self.getCurrentViewController()?.navigationController{
            CEPhotoMediaManager.sharedInstance.show(in: nav, finishBlock: { [weak self] (image) -> Void in
                self?.flag = true
                if let weakSelf = self?.avatarImageView{
                    weakSelf.image = image
                }
            })
        }

    }
    

}
