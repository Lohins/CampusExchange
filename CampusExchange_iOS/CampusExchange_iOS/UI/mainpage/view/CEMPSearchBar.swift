//
//  CEMPSearchBar.swift
//  CampusExchange_iOS
//
//  Created by S.t on 2017/3/8.
//  Copyright © 2017年 UBIELIFE Inc. All rights reserved.
//

import UIKit

class CEMPSearchBar: UIView {
    var view: UIView!
    
    // override initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        
        self.textField.returnKeyType = .done
        self.textField.delegate = self
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
        let nib = UINib(nibName: "CEMPSearchBar", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    var searchBlock: ((_ text: String)-> Void)?
    
    @IBOutlet var textField: UITextField!
    
    @IBAction func goAction(_ sender: Any) {
        guard let text = self.textField.text else{
            return
        }
        if let blk = self.searchBlock{
            blk(text)
        }
        
    }
    
    @IBAction func clearAction(_ sender: Any) {
        
        self.textField.text = ""
    }
    
    
    func show(){
        self.textField.becomeFirstResponder()
    }
    
    func dismiss(){
        self.textField.resignFirstResponder()
    }

}

extension CEMPSearchBar: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
