//
//  CEAddButtonRow.swift
//  CampusExchange_iOS
//
//  Created by S.t on 2017/2/28.
//  Copyright © 2017年 UBIELIFE Inc. All rights reserved.
//

import UIKit

class CEAddButtonRow: UIView {
    
    @IBOutlet var button1: UIButton!
    
    @IBOutlet var button2: UIButton!
    
    var block1: (()-> Void)?
    
    var block2: (()-> Void)?

    var view: UIView!
    
    // override initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        
    }
    
    convenience init(frame: CGRect, text1: String, text2: String){
        self.init(frame : frame)
        
        self.button1.setTitle(text1, for: .normal)
        self.button2.setTitle(text2, for: .normal)
        
        
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
        let nib = UINib(nibName: "CEAddButtonRow", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    func setDefaultIndex(index: Int){
        if index == 0{
            self.button1.isSelected = true
        }
        else{
            self.button2.isSelected = true
        }
    }
    
    @IBAction func button1Action(_ sender: Any) {
        
        if self.button1.isSelected != true{
            self.button1.isSelected = true
            self.button2.isSelected = false
            if let blk = self.block1{
                blk()
            }
        }
        

    }
    
    @IBAction func button2Action(_ sender: Any) {
        if self.button2.isSelected != true{
            self.button2.isSelected = true
            self.button1.isSelected = false
            if let blk = self.block2{
                blk()
            }
        }
    }
    
    func getSelectedId() -> Int{
        if self.button1.isSelected == true{
            return 1
        }
        else{
            return 0
        }
    }
    
}
