//
//  Macros.swift
//  mSmallDay
//
//  Created by piglikeyoung on 15/10/10.
//  Copyright © 2015年 pikeYoung. All rights reserved.
//  全局公用属性

import UIKit
import Kingfisher
import XCGLogger

let kNavigationH: CGFloat = 64
let kTabBarH: CGFloat = 49
let kScreenWidth: CGFloat = UIScreen.mainScreen().bounds.size.width
let kScreenHeight: CGFloat = UIScreen.mainScreen().bounds.size.height
let kMainBounds: CGRect = UIScreen.mainScreen().bounds


/// 友盟分享的APP key
let UMSharedAPPKey: String = "55e2f45b67e58ed4460012db"
/// 自定义分享view的高度
let ShareViewHeight: CGFloat = 215
let GitHubURL: String = "https://github.com/piglikeYoung/"
let GitBookURL: String = "https://www.gitbook.com/book/piglikeyoung/piglikeyoung-study-notes/details"

/// UIApplication.sharedApplication()
let appShare = UIApplication.sharedApplication()
let sinaURL = "http://weibo.com/u/2696901241/home?topnav=1&wvr=6"
/// 高德地图KEY
let GaoDeAPPKey = "00de094fbf104b1ce5ee03da4349c919"
/// 图片缓存
let appImageCache = KingfisherManager.sharedManager.cache



/// 日志打印
let log: XCGLogger = {
    let log = XCGLogger.defaultInstance()
    let logPath : NSURL = cacheDirectory.URLByAppendingPathComponent("XCGLogger.Log")
    log.setup(.Debug, showThreadName: true, showLogLevel: true, showFileNames: true, showLineNumbers: false, writeToFile: logPath, fileLogLevel: .Info)
    log.xcodeColorsEnabled = true
    log.xcodeColors = [
        .Verbose: .lightGrey,
        .Debug: .darkGrey,
        .Info: .darkGreen,
        .Warning: .orange,
        .Error: .red,
        .Severe: .whiteOnRed
    ]
    
    return log
    }()

/// 文档文件夹路径
var documentsDirectory: NSURL {
    return NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last!
}

/// 缓存文件夹路径
var cacheDirectory: NSURL {
    return NSFileManager.defaultManager().URLsForDirectory(.CachesDirectory, inDomains: .UserDomainMask).last!
}

/// 没有高亮状态的按钮
class NoHighlightButton: UIButton {
    /// 重写setFrame方法
    override var highlighted: Bool {
        didSet{
            super.highlighted = false
        }
    }
}
