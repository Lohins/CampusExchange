//
//  String-Extension.swift
//  CampusExchange_iOS
//
//  Created by UBIELIFE on 2017-02-24.
//  Copyright © 2017 UBIELIFE Inc. All rights reserved.
//

import Foundation
import UIKit


extension String{
    
    /*
     描述： 获取给定字号字体下 string所占有的size
     */
    static func getBound(_ string: String,size:CGSize , options: NSStringDrawingOptions , attributes: [String : AnyObject]?, context: NSStringDrawingContext?) -> CGRect {
        let text: NSString = NSString(cString: string.cString(using: String.Encoding.utf8)! , encoding:String.Encoding.utf8.rawValue)!
        
        let bound = text.boundingRect(with: size , options: options, attributes: attributes, context: context)
        
        return bound
    }
    
    
}

