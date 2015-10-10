//
//  AppDelegate.swift
//  mSmallDay
//
//  Created by piglikeyoung on 15/10/10.
//  Copyright © 2015年 pikeYoung. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        setKeyWindow()
        
        setAppAppearance()
        
        setShared()
        
        setUserMapInfo()
        
        return true
    }
    
    func applicationDidReceiveMemoryWarning(application: UIApplication) {
        // 清除图片内存缓存
        appImageCache.clearMemoryCache()
        // 清除硬盘缓存
//        appImageCache.clearDiskCache()
    }

    
    private func setKeyWindow() {
        window = UIWindow(frame: kMainBounds)
        
        window?.rootViewController = showLeadpage()
        
        window?.makeKeyAndVisible()
    }
    
    // MARK: - 地图
    func setUserMapInfo() {
        UserInfoManager.sharedUserInfoManager.startUserlocation()
        MAMapServices.sharedServices().apiKey = GaoDeAPPKey
    }
    
    // MARK: - 友盟分享
    func setShared() {
//        UMSocialData.setAppKey(theme.UMSharedAPPKey)
//        //        UMSocialSinaHandler.openSSOWithRedirectURL("http://www.jianshu.com/users/5fe7513c7a57/latest_articles")
//        UMSocialSinaHandler.openSSOWithRedirectURL(nil)
//        UMSocialWechatHandler.setWXAppId("wx485c6ee1758251bd", appSecret: "468ab73eef432f59a2aa5630e340862f", url: theme.JianShuURL)
//        UMSocialConfig.hiddenNotInstallPlatforms([UMShareToWechatSession,UMShareToWechatTimeline])
    }
    
//    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
//        return UMSocialSnsService.handleOpenURL(url)
//    }
//    
//    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
//        return UMSocialSnsService.handleOpenURL(url)
//    }
    
    // MARK: - APP主题
    func setAppAppearance() {
        ThemeManager.applyTheme()
    }


    // MARK: - 引导页
    private func showLeadpage() -> UIViewController {
        let versionStr = "CFBundleShortVersionString"
        // 当前版本
        let currentVersion = NSBundle.mainBundle().objectForInfoDictionaryKey(versionStr) as! String
        // 偏好设置里的版本
        let oldVersion = NSUserDefaults.standardUserDefaults().objectForKey(versionStr) as? String
        // 偏好设置有值
        if let old = oldVersion {
            switch old.compare(currentVersion, options: NSStringCompareOptions.NumericSearch) {
            case .OrderedSame:
                log.info("偏好设置版本号 等于 当前版本号")
                return MainNavigationController(rootViewController: MainTabBarController());
            case .OrderedDescending:
                log.info("偏好设置版本号 大于 当前版本号")
                return MainNavigationController(rootViewController: MainTabBarController());
            case .OrderedAscending:
                log.info("偏好设置版本号 小于 当前版本号")
                NSUserDefaults.standardUserDefaults().setObject(currentVersion, forKey: versionStr)
                NSUserDefaults.standardUserDefaults().synchronize()
                return LeadpageViewController()
            }
        } else {
            NSUserDefaults.standardUserDefaults().setObject(currentVersion, forKey: versionStr)
            NSUserDefaults.standardUserDefaults().synchronize()
            return LeadpageViewController()
        }
    }
}

