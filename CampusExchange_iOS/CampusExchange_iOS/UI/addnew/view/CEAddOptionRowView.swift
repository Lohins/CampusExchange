//
//  CEAddOptionRowView.swift
//  CampusExchange_iOS
//
//  Created by S.t on 2017/2/28.
//  Copyright © 2017年 UBIELIFE Inc. All rights reserved.
//

import UIKit

class CEAddOptionRowView: UIView {

    @IBOutlet var contentLabel: UILabel!
    var view: UIView!
    
    var title = "Category"
    var msg = "Select product category"
    var options = Dictionary<String, Int>()
    
    // override initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        self.initGesture()
        
    }
    
    func updateOptions(options: Dictionary<String, Int>){
        self.options = options
    }
    
    func updateHeader(title: String, msg: String){
        self.msg = msg
        self.title = title
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
        let nib = UINib(nibName: "CEAddOptionRowView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    func initGesture(){
        let tapGesture = UITapGestureRecognizer.init()
        tapGesture.numberOfTapsRequired = 1
        tapGesture.addTarget(self, action: #selector(self.displayOptions))
        self.addGestureRecognizer(tapGesture)
    }
    
    func displayOptions(){
    
        let list = self.options.keys
        
        let alertVC = UIAlertController.init(title: self.title, message: self.msg, preferredStyle: .actionSheet)
        alertVC.view.tintColor = UIColor.black
        for item in list{
            let action = UIAlertAction.init(title: item, style: .default, handler: {[weak self] (action) in
                if let weakSelf = self{
                    weakSelf.contentLabel.text = item
                }
            })
            alertVC.addAction(action)
        }
        
        self.getCurrentViewController()?.navigationController?.present(alertVC, animated: true, completion: nil)
    }
    
    func getSelectedKey() -> String?{
        if let content = self.contentLabel.text{
            if self.options.keys.contains(content){
                return content
            }
            else{
                return nil
            }
        }
        return nil
    }
    
    func getSelectedValue() -> Int?{
        if let content = self.contentLabel.text{
            if self.options.keys.contains(content){
                return self.options[content]
            }
            else{
                return nil
            }
        }
        return nil
    }
    
    func setValue(id:Int){
        for item in self.options {
            if item.value == id{
                self.contentLabel.text = item.key
            }
        }
        
    }
    
    @IBAction func clickAction(){
        let vc = CEAddPhotoVC()
        
        self.getCurrentViewController()?.navigationController?.pushViewController(vc, animated: true)
    }

}
