//
//  CEMPHeaderView.swift
//  CampusExchange_iOS
//
//  Created by UBIELIFE on 2017-02-24.
//  Copyright © 2017 UBIELIFE Inc. All rights reserved.
//

import UIKit

class CEMPHeaderView: UIView {
    
    var sortBlock: (() -> Void)?
    
    var filterBlock: (() -> Void)?


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
        let nib = UINib(nibName: "CEMPHeaderView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    @IBAction func filterAction(_ sender: Any) {
        if let blk = self.filterBlock{
            blk()
        }
//        let vc = CEFilterTableViewController()
//        self.getCurrentViewController()?.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBOutlet var sortAction: UIButton!
    
    @IBAction func sortAction(_ sender: Any) {
        if let blk = self.sortBlock{
            blk()
        }
//        let vc = CESortTableViewController()
//        self.getCurrentViewController()?.navigationController?.pushViewController(vc, animated: true)
    }

}
