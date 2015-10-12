//
//  MainTabBarController.swift
//  mSmallDay
//
//  Created by piglikeyoung on 15/10/10.
//  Copyright © 2015年 pikeYoung. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpAllChildViewController()
        
        self.setValue(MainTabBar(), forKey: "tabBar")
    }

    /**
    初始化所有子控制器
    */
    private func setUpAllChildViewController() {
        // 探店
        addOneChlildVc(childVc: ExploreViewController(), title: "探店", imageName: "recommendation_1", selectedImageName: "recommendation_2")
        // 体验
        addOneChlildVc(childVc: ExperienceViewController(), title: "体验", imageName: "broadwood_1", selectedImageName: "broadwood_2")
        // 分类
        addOneChlildVc(childVc: ClassifyViewController(), title: "分类", imageName: "classification_1", selectedImageName: "classification_2")
        // 我的
        addOneChlildVc(childVc: MeViewController(), title: "我的", imageName: "my_1", selectedImageName: "my_2")
    }
    
    
    /**
    添加一个子控制器
    
    - parameter childVc:           子控制器
    - parameter title:             标题
    - parameter imageName:         图标
    - parameter selectedImageName: 选中图片
    */
    private func addOneChlildVc(childVc childVc: UIViewController ,title: String, imageName: String, selectedImageName: String) {
        childVc.title = title
        childVc.tabBarItem = UITabBarItem(title: title, image: UIImage(named: imageName), selectedImage: UIImage(named: selectedImageName))
        childVc.view.backgroundColor = SDBackgroundColor
        addChildViewController(MainNavigationController(rootViewController: childVc))
    }

}

class MainTabBar: UITabBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translucent = false
        self.backgroundImage = UIImage(named: "tabbar")
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}