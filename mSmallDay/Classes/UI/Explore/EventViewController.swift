//
//  EventViewController.swift
//  mSmallDay
//
//  Created by piglikeyoung on 15/10/22.
//  Copyright © 2015年 pikeYoung. All rights reserved.
//

import UIKit



class EventViewController: UIViewController {
    
    lazy var loadImage: LoadAnimatImageView = LoadAnimatImageView.sharedInstance
    var model: EventModel?
    private lazy var guessLikeView: GuessLikeView = GuessLikeView.guessLikeViewFromXib()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}
