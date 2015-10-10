//
//  Theme.swift
//  mSmallDay
//
//  Created by piglikeyoung on 15/10/10.
//  Copyright © 2015年 pikeYoung. All rights reserved.
//  全局公用属性

import UIKit

public let kNavigationH: CGFloat = 64
public let kAppWidth: CGFloat = UIScreen.mainScreen().bounds.size.width
public let kAppHeight: CGFloat = UIScreen.mainScreen().bounds.size.height
public let kMainBounds: CGRect = UIScreen.mainScreen().bounds

struct theme {
    ///  APP导航条barButtonItem文字大小
    static let SDNavItemFont: UIFont = UIFont.systemFontOfSize(16)
    ///  APP导航条titleFont文字大小
    static let SDNavTitleFont: UIFont = UIFont.systemFontOfSize(18)
    /// ViewController的背景颜色
    static let SDBackgroundColor: UIColor = UIColor.colorWith(r: 255, g: 255, b: 255, a: 1)
    /// webView的背景颜色
    static let SDWebViewBacagroundColor: UIColor = UIColor.colorWith(r: 245, g: 245, b: 245, a: 1)
    
    /// 友盟分享的APP key
    static let UMSharedAPPKey: String = "55e2f45b67e58ed4460012db"
    /// 自定义分享view的高度
    static let ShareViewHeight: CGFloat = 215
    static let GitHubURL: String = "https://github.com/piglikeYoung/"
    static let GitBookURL: String = "https://www.gitbook.com/book/piglikeyoung/piglikeyoung-study-notes/details"
    /// cache文件路径
    static let cachesPath: String = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true).last!
    /// UIApplication.sharedApplication()
    static let appShare = UIApplication.sharedApplication()
    static let sinaURL = "http://weibo.com/u/2696901241/home?topnav=1&wvr=6"
    /// 高德地图KEY
    static let GaoDeAPPKey = "2e6b9f0a88b4a79366a13ce1ee9688b8"
}
