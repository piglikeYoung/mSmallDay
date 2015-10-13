//
//  UIView+extension.swift
//  mSmallDay
//
//  Created by piglikeyoung on 15/10/12.
//  Copyright © 2015年 pikeYoung. All rights reserved.
//

import Foundation

extension UIView {
    
    /// X值
    var x: CGFloat {
        
        set(newX) {
            self.frame.origin.x = newX
        }
        get {
            return self.frame.origin.x
        }
        
    }
    
    /// Y值
    var y: CGFloat {
        set(newY) {
            self.frame.origin.y = newY
        }
        get {
            return self.frame.origin.y
        }
    }
    
    /// 宽度
    var width: CGFloat {
        set(newWidth) {
            self.frame.size.width = newWidth
        }
        get {
            return self.frame.size.width
        }
        
    }
    
    /// 高度
    var height: CGFloat {
        set(newHeight) {
            self.frame.size.height = newHeight
        }
        get {
            return self.frame.size.height
        }
        
    }
    
    /// size
    var size: CGSize {
        set(newSize) {
            self.frame.size = newSize
        }
        get {
            return self.frame.size
        }
        
    }
    
    var centerX: CGFloat {
        set(newCenterX) {
            self.center.x = newCenterX
        }
        get {
            return self.center.x
        }
    }
    
    var centerY: CGFloat {
        set(newCenterY) {
            self.center.y = newCenterY
        }
        get {
            return self.center.y
        }
    }
    
    var origin: CGPoint {
        set(newOrigin) {
            self.frame.origin = newOrigin
        }
        get {
            return self.frame.origin
        }
    }
}