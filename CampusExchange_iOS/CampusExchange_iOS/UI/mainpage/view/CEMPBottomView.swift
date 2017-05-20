//
//  CEMPBottomView.swift
//  CampusExchange_iOS
//
//  Created by UBIELIFE on 2017-02-24.
//  Copyright © 2017 UBIELIFE Inc. All rights reserved.
//

import UIKit

class CEMPBottomView: UIView {

    var view: UIView!
    
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
        let nib = UINib(nibName: "CEMPBottomView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }

    @IBAction func clickAction(){
        let vc = CEAddPhotoVC()
        
        self.getCurrentViewController()?.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func showPostedItemAction(_ sender: Any) {
        
        let vc = CEPostedItemVC()
        self.getCurrentViewController()?.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func showNewsAction(_ sender: Any) {
        
        let vc = CENewsVC()
        self.getCurrentViewController()?.present(vc, animated: true, completion: nil)

    }

    
}
