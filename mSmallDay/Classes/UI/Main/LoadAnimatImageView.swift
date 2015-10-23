//
//  LoadAnimatImageView.swift
//  mSmallDay
//
//  Created by piglikeyoung on 15/10/23.
//  Copyright © 2015年 pikeYoung. All rights reserved.
//  加载时等待的ImageView动画

import UIKit

class LoadAnimatImageView: NSObject {

    static let sharedInstance = LoadAnimatImageView() // 单例模式
    private override init() {} // 这就阻止其他对象使用这个类的默认的'()'初始化方法
    
    
    private lazy var loadAnimImages: [UIImage]? = {
       var images = [UIImage]()
        for i in 0...92 {
            let image = UIImage(named: String(format: "wnx%02d", i))
            images.append(image!)
        }
        
        return images
    }()
    
    private lazy var loadImageView: UIImageView! = {
        let loadImageView = UIImageView()
        loadImageView.animationImages = self.loadAnimImages!
        loadImageView.animationRepeatCount = 10000
        loadImageView.animationDuration = 1.0
        loadImageView.frame = CGRectMake(0, 0, 44, 51)
        return loadImageView
    }()
    
    func startLoadAnimatImageViewInView(view: UIView, center: CGPoint){
        loadImageView.center = center
        view.addSubview(loadImageView)
        loadImageView.startAnimating()
    }
    
    func stopLoadAnimatImageView() {
        loadImageView.removeFromSuperview()
        loadImageView.stopAnimating()
    }
    
}
