//
//  nearCell.swift
//  mSmallDay
//
//  Created by piglikeyoung on 15/10/13.
//  Copyright © 2015年 pikeYoung. All rights reserved.
//  附近地图展示的cell



import UIKit

class nearCell: UICollectionViewCell {
    
    var nearModel: EventModel? {
        didSet {
            let urlStr = nearModel!.imgs![0]
            imageImageView.kf_setImageWithURL(NSURL(string: urlStr)!, placeholderImage: UIImage(named: "quesheng")!)
            adressLabel.text = nearModel?.address
            titleLabel.text = nearModel?.title
            disLabel.text = nearModel!.distanceForUser
        }
    }
    
    @IBOutlet private weak var disLabel: UILabel!
    @IBOutlet private weak var adressLabel: UILabel!
    @IBOutlet private weak var imageImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.whiteColor()
    }
    
}
