//
//  YJHMapView.swift
//  mSmallDay
//
//  Created by piglikeyoung on 15/10/19.
//  Copyright © 2015年 pikeYoung. All rights reserved.
//

import UIKit

private let kPointReuseIndentifier = "pointReuseIndentifier"

class YJHMapView: MAMapView {

    var flags: [MAPointAnnotation] = [MAPointAnnotation]()
    var lastMAAnnotationView: MAAnnotationView?
    
}
