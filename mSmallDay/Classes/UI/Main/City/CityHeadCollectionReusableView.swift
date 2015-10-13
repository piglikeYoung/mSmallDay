//
//  CityHeadCollectionReusableView.swift
//  mSmallDay
//
//  Created by piglikeyoung on 15/10/12.
//  Copyright © 2015年 pikeYoung. All rights reserved.
//  城市选择的headerView + footerView

import UIKit

class CityHeadCollectionReusableView: UICollectionReusableView {

    private let headTitleLabel: UILabel = UILabel()
    var headTitle: String? {
        didSet {
            headTitleLabel.text = headTitle
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        headTitleLabel.textAlignment = .Center
        headTitleLabel.font = UIFont.systemFontOfSize(22)
        headTitleLabel.textColor = UIColor.blackColor()
        addSubview(headTitleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.headTitleLabel.frame = self.bounds
    }

}


class CityFootCollectionReusableView: UICollectionReusableView {
    
    private var footTitleLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        footTitleLabel = UILabel()
        footTitleLabel?.text = "更多城市,敬请期待..."
        footTitleLabel?.textAlignment = .Center
        footTitleLabel?.textColor = UIColor.darkGrayColor()
        footTitleLabel?.font = UIFont.systemFontOfSize(16)
        addSubview(footTitleLabel!)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        footTitleLabel?.frame = self.bounds
    }
    
}
