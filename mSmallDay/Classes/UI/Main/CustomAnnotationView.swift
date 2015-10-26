//
//  CustomAnnotationView.swift
//  mSmallDay
//
//  Created by piglikeyoung on 15/10/26.
//  Copyright © 2015年 pikeYoung. All rights reserved.
//

import UIKit

class CustomAnnotationView: MAAnnotationView {
    
    var calloutView: CustomCalloutView?
    
    override func setSelected(selected: Bool, animated: Bool) {
        calloutView = CustomCalloutView(frame: CGRect(x: 0, y: 0, width: kScreenWidth - 50, height: 60))
        calloutView!.center = CGPointMake(CGRectGetWidth(self.bounds) * 0.5 + calloutOffset.x,
            -CGRectGetHeight(calloutView!.bounds) * 0.5 + calloutOffset.y)
        addSubview(calloutView!)
    }
}
