//
//  GuessLikeView.swift
//  mSmallDay
//
//  Created by piglikeyoung on 15/10/23.
//  Copyright © 2015年 pikeYoung. All rights reserved.
//  猜你喜欢headerView

import UIKit

class GuessLikeView: UIView {

    class func guessLikeViewFromXib() -> GuessLikeView {
        let guessLike = NSBundle.mainBundle().loadNibNamed("GuessLikeView", owner: nil, options: nil).last as! GuessLikeView
        return guessLike
    }

}
