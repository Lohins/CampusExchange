//
//  UIColor-Extension.swift
//  UBIEAT
//
//  Created by UBIELIFE on 2016-08-27.
//  Copyright © 2016 UBIELIFE Inc. All rights reserved.
//

import UIKit

extension UIColor{
    convenience init(RGBWithRed: Float, green: Float, blue: Float, alpha: Float) {
        self.init(red: CGFloat(RGBWithRed)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: CGFloat(alpha))
    }
}
