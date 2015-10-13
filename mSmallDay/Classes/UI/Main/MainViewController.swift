//
//  MainViewController.swift
//  mSmallDay
//
//  Created by piglikeyoung on 15/10/12.
//  Copyright © 2015年 pikeYoung. All rights reserved.
//  基类控制器, 带有选择城市的ViewController

import UIKit

class MainViewController: UIViewController {

    var cityLeftBtn: TextImageButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "cityChange:", name: SD_CurrentCityChange_Notification, object: nil)
        
        cityLeftBtn = TextImageButton(frame: CGRectMake(0, 20, 80, 44))
        let userDefault = NSUserDefaults.standardUserDefaults()
        if let currentCity = userDefault.objectForKey(SD_Current_SelectedCity) as? String {
            cityLeftBtn.setTitle(currentCity, forState: .Normal)
        } else {
            cityLeftBtn.setTitle("北京", forState: .Normal)
        }
        
        cityLeftBtn.titleLabel?.font = SDNavItemFont
        cityLeftBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        cityLeftBtn.setImage(UIImage(named: "home_down"), forState: .Normal)
        cityLeftBtn.addTarget(self, action: "modalCityView", forControlEvents: .TouchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cityLeftBtn)
    }
    
    func modalCityView () {
        presentViewController(MainNavigationController(rootViewController: CityViewController()), animated: true, completion: nil)
    }
    
    func cityChange(notification: NSNotification) {
        if let currentCityName = notification.object as? String {
            self.cityLeftBtn.setTitle(currentCityName, forState: .Normal)
        }
    }

    
    // MARK: 自定义button,文字在左边 图片在右边
    class TextImageButton: UIButton {
        override init(frame: CGRect) {
            super.init(frame: frame)
            titleLabel?.font = SDNavItemFont
            titleLabel?.contentMode = UIViewContentMode.Center
            imageView?.contentMode = UIViewContentMode.Left
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            titleLabel?.sizeToFit()
            titleLabel?.frame = CGRectMake(-5, 0, titleLabel!.width, height)
            imageView?.frame = CGRectMake(titleLabel!.width + 3 - 5, 0, width - titleLabel!.width - 3, height)
        }
    }

}
