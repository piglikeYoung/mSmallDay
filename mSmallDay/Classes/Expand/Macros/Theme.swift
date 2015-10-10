//
//  Theme.swift
//  mSmallDay
//
//  Created by piglikeyoung on 15/10/10.
//  Copyright © 2015年 pikeYoung. All rights reserved.
//

import UIKit

///  APP导航条barButtonItem文字大小
let SDNavItemFont: UIFont = UIFont.systemFontOfSize(16)
///  APP导航条titleFont文字大小
let SDNavTitleFont: UIFont = UIFont.systemFontOfSize(18)
/// ViewController的背景颜色
let SDBackgroundColor: UIColor = UIColor.colorWith(r: 255, g: 255, b: 255, a: 1)
/// webView的背景颜色
let SDWebViewBacagroundColor: UIColor = UIColor.colorWith(r: 245, g: 245, b: 245, a: 1)


struct ThemeManager {
    static func applyTheme() {
        // 设置UITabBarItem主题
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.blackColor(), NSFontAttributeName : UIFont.systemFontOfSize(12)], forState: .Selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.grayColor(), NSFontAttributeName : UIFont.systemFontOfSize(12)], forState: .Normal)
        
        // 设置导航栏主题
        // 是否透明
        UINavigationBar.appearance().translucent = false
        // 设置导航titleView字体
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName : SDNavTitleFont, NSForegroundColorAttributeName : UIColor.blackColor()]
        
        // 设置导航栏主题
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName : SDNavItemFont, NSForegroundColorAttributeName : UIColor.blackColor()], forState: .Normal)
        
    }
}