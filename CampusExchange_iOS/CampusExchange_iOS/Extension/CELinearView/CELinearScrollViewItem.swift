//
//  CELinearScrollViewItem.swift
//  CampusExchange_iOS
//
//  Created by UBIELIFE on 2017-02-24.
//  Copyright © 2017 UBIELIFE Inc. All rights reserved.
//

import UIKit

class CELinearScrollViewItem: NSObject {
    
    var view : UIView
    
    var paddingTop : CGFloat
    
    var paddingBottom : CGFloat
    
    var tag : NSInteger
    
    init(view: UIView , paddingTop : CGFloat , paddingBottom : CGFloat) {
        self.view = view
        self.paddingTop = paddingTop
        self.paddingBottom = paddingBottom
        self.tag = 0
    }

}
