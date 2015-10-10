//
//  UIColor+extension.swift
//  mSmallDay
//
//  Created by piglikeyoung on 15/10/10.
//  Copyright © 2015年 pikeYoung. All rights reserved.
//

import UIKit


extension UIColor {
    class func colorWith(r red: Int, g green: Int, b blue: Int, a alpha: CGFloat) -> UIColor{
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: alpha)
    }
}