//
//  ExploreViewController.swift
//  mSmallDay
//
//  Created by piglikeyoung on 15/10/12.
//  Copyright © 2015年 pikeYoung. All rights reserved.
//

import UIKit

class ExploreViewController: MainViewController, DoubleTextViewDelegate {

    private var backgroundScrollView: UIScrollView!
    private var doubleTextView: DoubleTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 初始化导航栏
        setNavgationItem()
        
    }

    /**
    设置导航栏
    */
    private func setNavgationItem() {
        // 点击进入附近控制器界面
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "附近", titleColor: UIColor.blackColor(), target: self, action: "nearClick")
        doubleTextView = DoubleTextView(leftText: "美天", rightText: "美辑")
        doubleTextView.frame = CGRectMake(0, 0, 120, 44)
        doubleTextView.delegate = self
        navigationItem.titleView = doubleTextView
        
    }
    
    /**
    附近action
    */
    private func nearClick() {
        navigationController?.pushViewController(NearbyViewController(), animated: true)
    }
    
    
    // MARK: - DoubleTextViewDelegate
    func doubleTextView(doubleTextView: DoubleTextView, didClickBtn btn: UIButton, toIndex index: Int) {
//        backgroundScrollView.setContentOffset(CGPointMake(kScreenWidth * CGFloat(index), 0), animated: true)
    }
}
