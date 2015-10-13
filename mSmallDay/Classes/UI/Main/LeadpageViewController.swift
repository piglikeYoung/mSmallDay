//
//  LeadpageViewController.swift
//  mSmallDay
//
//  Created by piglikeyoung on 15/10/10.
//  Copyright © 2015年 pikeYoung. All rights reserved.
//  版本新特性

import UIKit

class LeadpageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var imageName: String?
        switch kScreenWidth {
            case 375:
                imageName = NSBundle.mainBundle().pathForResource("fourpage-375w-667h@2x.jpg", ofType: nil)
            case 414:
                imageName = NSBundle.mainBundle().pathForResource("fourpage-414w-736h@3x.jpg", ofType: nil)
            case 568:
                imageName = NSBundle.mainBundle().pathForResource("fourpage-568h@2x.jpg", ofType: nil)
            default:
                imageName = NSBundle.mainBundle().pathForResource("fourpage@2x.jpg", ofType: nil)
        }
        
        // 背景图片
        let backgroundIv = UIImageView(image: UIImage(contentsOfFile: imageName!))
        view.addSubview(backgroundIv)
        
        let startBtn: NoHighlightButton = NoHighlightButton()
        startBtn.setBackgroundImage(UIImage(named: "into_home"), forState: .Normal)
        startBtn.setTitle("开始小日子", forState: UIControlState.Normal)
        startBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        startBtn.frame = CGRect(x: (kScreenWidth - 210) * 0.5, y: kScreenHeight - 120, width: 210, height: 45)
        startBtn.addTarget(self, action: "showMainTabbar", forControlEvents: .TouchUpInside)
        view.addSubview(startBtn)
    }

    func showMainTabbar() {
        appShare.keyWindow?.rootViewController =  MainTabBarController()
    }
    
}
