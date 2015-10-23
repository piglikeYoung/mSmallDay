//
//  ShareModel.swift
//  mSmallDay
//
//  Created by piglikeyoung on 15/10/23.
//  Copyright © 2015年 pikeYoung. All rights reserved.
//  分享model

import UIKit

class ShareModel: NSObject {
   
    var shareTitle: String?
    var shareURL: String?
    var img: UIImage?
    var shareDetail: String?
    init(shareTitle: String?, shareURL: String?, image: UIImage?, shareDetail: String?) {
        super.init()
        if shareDetail != nil {
            if let text: NSString = NSString(CString: shareDetail!.cStringUsingEncoding(NSUTF8StringEncoding)!,encoding: NSUTF8StringEncoding) {
                if text.length > 50 {
                    let aa = text.substringToIndex(50)
                    self.shareDetail = aa as String
                } else {
                    self.shareDetail = shareDetail
                }
            }
        }
        self.shareTitle = shareTitle
        self.img = image
        self.shareURL = shareURL
    }
}
