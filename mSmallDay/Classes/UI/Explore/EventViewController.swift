//
//  EventViewController.swift
//  mSmallDay
//
//  Created by piglikeyoung on 15/10/22.
//  Copyright © 2015年 pikeYoung. All rights reserved.
//  店.发现 店.详情控制器

import UIKit



class EventViewController: UIViewController {
    
    lazy var loadImage: LoadAnimatImageView = LoadAnimatImageView.sharedInstance
    private lazy var guessLikeView: GuessLikeView = GuessLikeView.guessLikeViewFromXib()
    private lazy var moreArr: [GuessLikeMoreView] = [GuessLikeMoreView]()
    private lazy var shareView: ShareView = ShareView.shareViewFromXib()
    private lazy var webView: EventWebView = EventWebView(frame: kMainBounds, webViewDelegate: self, webViewScrollViewDelegate: self)
    private lazy var backBtn: UIButton = UIButton()
    private lazy var likeBtn: UIButton = UIButton()
    private lazy var sharedBtn: UIButton = UIButton()
    private lazy var shopDetailContentView: ShopDetailContentView = ShopDetailContentView.shopDetailContentViewFromXib()
    ///  记录scrollView最后一次偏移的Y值
    private var lastOffsetY: CGFloat = 0
    
    /// 自定义导航栏
    private lazy var customNav: UIView = {
        let customNav = UIView(frame: CGRectMake(0, 0, kScreenWidth, kNavigationH))
        customNav.backgroundColor = UIColor.whiteColor()
        customNav.alpha = 0.0
        return customNav
    }()
    
    private lazy var topImageView: UIImageView = {
        let image = UIImageView(frame: CGRectMake(0, 0, kScreenWidth, kDetailViewController_TopImageView_Height))
        image.image = UIImage(named: "quesheng")
        image.contentMode = .ScaleToFill
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var detailScrollView: UIScrollView = {
        let detailSv = UIScrollView(frame: kMainBounds)
        detailSv.contentInset = UIEdgeInsets(top: kDetailViewController_TopImageView_Height + kEventViewController_ShopView_Height, left: 0, bottom: 0, right: 0)
        detailSv.showsHorizontalScrollIndicator = false
        detailSv.backgroundColor = SDWebViewBacagroundColor
        detailSv.alwaysBounceVertical = true
        detailSv.hidden = true
        detailSv.delegate = self
        detailSv.setContentOffset(CGPoint(x: 0, y: -(kDetailViewController_TopImageView_Height + kEventViewController_ShopView_Height)), animated: false)
        return detailSv
    }()
    
    private lazy var shopDetailView: ShopDetailView = {
        let shopView = ShopDetailView(frame: CGRect(x: 0, y: kDetailViewController_TopImageView_Height, width: kScreenWidth, height: kEventViewController_ShopView_Height))
        
        shopView.delegate = self
        return shopView
    }()
    
    var model: EventModel? {
        didSet {
            // TODO: 将设置模型数据的代码封装到模型的方法里
            loadImage.startLoadAnimatImageViewInView(view, center: view.center)
            webView.hidden = true
            // 将模型传入给店铺详情页
            shopDetailContentView.detailModel = model
            // 设置地图按钮点击回调闭包
            weak var tmpSelf = self
            
            shopDetailContentView.mapBtnClickCallback = {
                let showMapVc = ShowMapViewController()
                showMapVc.model = tmpSelf?.model
                tmpSelf?.navigationController?.pushViewController(showMapVc, animated: true)
            }
            
            detailScrollView.addSubview(shopDetailContentView)
            detailScrollView.contentSize = CGSize(width: kScreenWidth, height: shopDetailContentView.height - kEventViewController_ShopView_Height)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
    
    private func setUpUI() {
        view.clipsToBounds = true
        view.backgroundColor = SDWebViewBacagroundColor
        view.addSubview(webView)
    }
    
    private func setCustomNavigationItem() {
        view.addSubview(customNav)
        //添加返回按钮
        setNavigationBtn(btn: backBtn, frame: CGRectMake(-7, 20, 44, 44), imageName: "back_0", highlightedImageName: "back_2", action: "backButtonClick")
        view.addSubview(backBtn)
        // 添加收藏按钮
        setNavigationBtn(btn: likeBtn, frame: CGRectMake(kScreenWidth - 105, 20, 44, 44), imageName: "collect_0", highlightedImageName: "collect_0", action: "lickBtnClick")
        likeBtn.setImage(UIImage(named: "collect_2"), forState: .Selected)
        view.addSubview(likeBtn)
        // 添加分享按钮
        setNavigationBtn(btn: sharedBtn, frame: CGRectMake(kScreenWidth - 54, 20, 44, 44), imageName: "share_0", highlightedImageName: "share_2", action: "sharedBtnClick")
        view.addSubview(sharedBtn)
    }
    
    private func setNavigationBtn(btn btn: UIButton, frame: CGRect, imageName: String, highlightedImageName: String, action: Selector) {
        btn.frame = frame
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        btn.setImage(UIImage(named: highlightedImageName), forState: .Highlighted)
        btn.addTarget(self, action: action, forControlEvents: .TouchUpInside)
    }
    
    ///MARK:- 导航按钮Action
    func backButtonClick() {
        navigationController!.popViewControllerAnimated(true)
    }
    
    func lickBtnClick() {
        //TODO: 将对应的店铺数据插入到本地数据库
        likeBtn.selected = !likeBtn.selected
    }
    
    func sharedBtnClick() {
        view.addSubview(shareView)
        shareView.shareVC = self
        shareView.showShareView(CGRectMake(0, kScreenHeight - 215, kScreenWidth, 215))
    }

}

/// MARK: 处理内容滚动时的事件
extension EventViewController: UIScrollViewDelegate {
    
}

/// MARK: UIWebViewDelegate
extension EventViewController: UIWebViewDelegate {
    
}

/// MARK: ShopDetailViewDelegate
extension EventViewController: ShopDetailViewDelegate {

}

