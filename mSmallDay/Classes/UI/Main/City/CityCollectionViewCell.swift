//
//  CityCollectionViewCell.swift
//  mSmallDay
//
//  Created by piglikeyoung on 15/10/12.
//  Copyright © 2015年 pikeYoung. All rights reserved.
//  城市选择的Cell

import UIKit


class CityCollectionViewCell: UICollectionViewCell {
    
    private let cityLabel: UILabel = UILabel()
    
    var cityName: String? {
        didSet {
            cityLabel.text = cityName
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        cityLabel.textColor = UIColor.blackColor()
        cityLabel.highlightedTextColor = UIColor.redColor()
        cityLabel.textAlignment = .Center
        cityLabel.backgroundColor = UIColor.whiteColor()
        contentView.addSubview(cityLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cityLabel.frame = self.bounds
    }
}
