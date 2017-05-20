//
//  CEAddTextRowView.swift
//  CampusExchange_iOS
//
//  Created by S.t on 2017/2/28.
//  Copyright © 2017年 UBIELIFE Inc. All rights reserved.
//

import UIKit

class CEAddTextRowView: UIView {

    var view: UIView!
    
    @IBOutlet var textField: UITextField!
    
    
    // override initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        
    }
    
    convenience init(frame: CGRect , placeHolder: String){
        self.init(frame: frame)
        self.textField.placeholder = placeHolder
        self.textField.textColor = UIColor.black
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
        let nib = UINib(nibName: "CEAddTextRowView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    @IBAction func clickAction(){
        let vc = CEAddPhotoVC()
        
        self.getCurrentViewController()?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setContent(content: String){
        self.textField.text = content
    }
    
    func getContent() -> String?{
        let text = self.textField.text
        if text == nil || text == ""{
            return nil
        }
        else{
            return text
        }
    }
    
    func getContent_unnil() -> String!{
        return self.textField.text
    }

}
