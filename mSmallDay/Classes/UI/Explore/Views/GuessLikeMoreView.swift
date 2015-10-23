//
//  GuessLikeMoreView.swift
//  mSmallDay
//
//  Created by piglikeyoung on 15/10/23.
//  Copyright © 2015年 pikeYoung. All rights reserved.
//  猜你喜欢View

import UIKit

class GuessLikeMoreView: UIView {

    @IBOutlet weak private var imageImageView: UIImageView!
    @IBOutlet weak private var adressLabel: UILabel!
    @IBOutlet weak private var titleLabel: UILabel!
    
    var model: GuessLikeModel? {
        didSet {
            titleLabel.text = model?.title
            adressLabel.text = model?.address
            if let imgStr = model?.imgs?.last {
                imageImageView.kf_setImageWithURL(NSURL(string: imgStr)!, placeholderImage: UIImage(named: "quesheng")!)
            }
        }
    }
    
    class func moreViewWithGuessLikeModel(model: GuessLikeModel) -> GuessLikeMoreView{
        let moreView = NSBundle.mainBundle().loadNibNamed("MoreView", owner: nil, options: nil).last as! GuessLikeMoreView
        moreView.model = model
        return moreView
    }
}
