//
//  UIBarButtonItem+extension.swift
//  mSmallDay
//
//  Created by piglikeyoung on 15/10/13.
//  Copyright © 2015年 pikeYoung. All rights reserved.
//  扩展UIBarButtonItem

import Foundation

extension UIBarButtonItem {
    
    /**
    针对导航条右边按钮的自定义item
    
    - parameter imageName:      默认图片
    - parameter highlImageName: 高亮图片
    - parameter targer:         目标
    - parameter action:         函数
    
    */
    convenience init(imageName: String, highlImageName: String, targer: AnyObject, action: Selector) {
        let button: UIButton = UIButton(type: .Custom)
        button.setImage(UIImage(named: imageName), forState: .Normal)
        button.setImage(UIImage(named: highlImageName), forState: .Highlighted)
        button.frame = CGRectMake(0, 0, 50, 44)
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10)
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
        button.addTarget(targer, action: action, forControlEvents: .TouchUpInside)
        
        self.init(customView: button)
    }
    
    /**
    针对导航条右边按钮有选中状态的自定义item
    
    - parameter imageName:      默认图片
    - parameter highlImageName: 高亮图片
    - parameter selectedImage:  选中图片
    - parameter target:         目标
    - parameter action:         函数
    
    */
    convenience init(imageName: String, highlImageName: String, selectedImage: String, target: AnyObject, action: Selector) {
        let button: UIButton = UIButton(type: .Custom)
        button.setImage(UIImage(named: imageName), forState: .Normal)
        button.setImage(UIImage(named: highlImageName), forState: .Highlighted)
        button.frame = CGRectMake(0, 0, 50, 44)
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10)
        button.setImage(UIImage(named: selectedImage), forState: .Selected)
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
        button.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        
        self.init(customView: button)
    }
    
    /**
    针对导航条左边按钮的自定义item
    
    - parameter imageName:  默认图片
    - parameter highlImageName: 高亮图片
    - parameter target:         目标
    - parameter action:         函数
    
    */
    convenience init(imageName: String, highlImageName: String, target: AnyObject, action: Selector) {
        let button: UIButton = UIButton(type: .Custom)
        button.setImage(UIImage(named: imageName), forState: .Normal)
        button.setImage(UIImage(named: highlImageName), forState: .Highlighted)
        button.frame = CGRectMake(0, 0, 80, 44)
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        button.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        
        self.init(customView: button)
    }
    
    
    /**
    导航条纯文字按钮
    
    - parameter title:      文字
    - parameter titleColor: 文字颜色
    - parameter targer:     目标
    - parameter action:     函数
    
    */
    convenience init(title: String, titleColor: UIColor, target: AnyObject ,action: Selector){
        
        let button = UIButton(type: .Custom)
        button.setTitle(title, forState: .Normal)
        button.setTitleColor(titleColor, forState: .Normal)
        button.titleLabel?.font = SDNavItemFont
        button.setTitleColor(UIColor.grayColor(), forState: .Highlighted)
        button.frame = CGRectMake(0, 0, 80, 44)
        button.titleLabel?.textAlignment = NSTextAlignment.Right
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5)
        button.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        
        self.init(customView: button)
    }
}
