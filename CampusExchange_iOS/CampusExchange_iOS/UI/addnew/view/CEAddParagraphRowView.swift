//
//  CEAddParagraphRowView.swift
//  CampusExchange_iOS
//
//  Created by S.t on 2017/2/28.
//  Copyright © 2017年 UBIELIFE Inc. All rights reserved.
//

import UIKit

class CEAddParagraphRowView: UIView {
    
    @IBOutlet weak var textField: UITextView!
    

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
        let nib = UINib(nibName: "CEAddParagraphRowView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    
    
    func getContent() -> String{
        if let content = self.textField.text{
            return content
        }
        return ""
    }
    
    func setContent(content: String) {
        self.textField.text = content
    }

}
