//
//  EventWebView.swift
//  mSmallDay
//
//  Created by piglikeyoung on 15/10/23.
//  Copyright © 2015年 pikeYoung. All rights reserved.
//  美天详情webView

import UIKit

class EventWebView: UIWebView {

    init(frame: CGRect, webViewDelegate: UIWebViewDelegate?, webViewScrollViewDelegate: UIScrollViewDelegate?) {
        super.init(frame: frame)
        
        let topImageShopViewHeight: CGFloat = kDetailViewController_TopImageView_Height - 20 + kEventViewController_ShopView_Height
        scrollView.contentInset = UIEdgeInsets(top: topImageShopViewHeight, left: 0, bottom: 0, right: 0)
        scrollView.setContentOffset(CGPoint(x: 0, y: -topImageShopViewHeight), animated: false)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = webViewScrollViewDelegate
        delegate = webViewDelegate
        backgroundColor = SDWebViewBacagroundColor
        paginationBreakingMode = UIWebPaginationBreakingMode.Column
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
