//
//  ExploreViewController.swift
//  mSmallDay
//
//  Created by piglikeyoung on 15/10/12.
//  Copyright © 2015年 pikeYoung. All rights reserved.
//

import UIKit

public let SD_RefreshImage_Height: CGFloat = 40
public let SD_RefreshImage_Width: CGFloat = 35

class ExploreViewController: MainViewController, DoubleTextViewDelegate {

    private var backgroundScrollView: UIScrollView!
    private var doubleTextView: DoubleTextView!
    private var dayTableView: UITableView!
    private var albumTableView: UITableView!
    private var everyDays: EveryDays?
    private var themes: ThemeModels?
    private var events: EveryDays?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 初始化导航栏
        setNavgationItem()
        
        // 设置ScrollView
        setScrollView()
        
        // 初始化美天tablieView
        setDayTableView()
        
        // 下拉加载数据
        dayTableView.header.beginRefreshing()
    }
    
    /**
    初始化美天tablieView
    */
    private func setDayTableView() {
        dayTableView = UITableView(frame: CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationH - kTabBarH), style: .Grouped)
        dayTableView.delegate = self
        dayTableView.dataSource = self
        dayTableView.separatorStyle = .None
        dayTableView.backgroundColor = SDBackgroundColor
        dayTableView.sectionHeaderHeight = 0.1
        dayTableView.sectionFooterHeight = 0.1
        dayTableView.contentInset = UIEdgeInsetsMake(-SD_RefreshImage_Width, 0, SD_RefreshImage_Width, 0)
        backgroundScrollView.addSubview(dayTableView)
        
        setTableViewHeader(self, refreshingAction: "pullLoadDayData", imageFrame: CGRectMake((kScreenWidth - SD_RefreshImage_Width) * 0.5, 47, SD_RefreshImage_Width, SD_RefreshImage_Height), tableView: dayTableView)
    }
    
    
    /**
    设置ScrollView
    */
    private func setScrollView () {
        /**
        这个属性是ScrollView是否导航栏底部出现，不会被导航栏覆盖，默认是true
        如果改为false就会在屏幕顶部出现，穿过导航栏
        */
//        self.automaticallyAdjustsScrollViewInsets = false
        backgroundScrollView = UIScrollView(frame: CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationH - kTabBarH))
        backgroundScrollView.backgroundColor = SDBackgroundColor
        backgroundScrollView.contentSize = CGSizeMake(kScreenWidth * 2.0, 0)
        backgroundScrollView.showsHorizontalScrollIndicator = false
        backgroundScrollView.showsVerticalScrollIndicator = false
        backgroundScrollView.pagingEnabled = true
        backgroundScrollView.delegate = self
        view.addSubview(backgroundScrollView)
    }

    /**
    设置导航栏
    */
    private func setNavgationItem() {
        // 点击进入附近控制器界面
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "附近", titleColor: UIColor.blackColor(), target: self, action: "nearClick")
        doubleTextView = DoubleTextView(leftText: "美天", rightText: "美辑")
        doubleTextView.frame = CGRectMake(0, 0, 120, 44)
        doubleTextView.delegate = self
        navigationItem.titleView = doubleTextView
        
    }
    
    /**
    设置TableView的HeaderView
    
    - parameter refreshingTarget: 刷新目标
    - parameter refreshingAction: 刷新方法
    - parameter tableView:        添加到的TableView
    */
    private func setTableViewHeader(refreshingTarget: AnyObject, refreshingAction: Selector, imageFrame: CGRect, tableView: UITableView) {
        let header = SDRefreshHeader(refreshingTarget: refreshingTarget, refreshingAction: refreshingAction)
        header.gifView!.frame = imageFrame
        tableView.header = header
        
    }
    
    /**
    附近action
    */
    private func nearClick() {
        navigationController?.pushViewController(NearbyViewController(), animated: true)
    }
    
    // MARK: - 下拉加载刷新数据
    func pullLoadDayData() {
        weak var tmpSelf = self
        // 模拟延时加载
        let time = dispatch_time(DISPATCH_TIME_NOW,Int64(1 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            EveryDays.loadEventsData({ (data, error) -> () in
                if error != nil {
                    SVProgressHUD.showErrorWithStatus("数据加载失败")
                    tmpSelf!.dayTableView.header.endRefreshing()
                    return
                }
                tmpSelf!.everyDays = data!
                tmpSelf!.dayTableView.reloadData()
                tmpSelf!.dayTableView.header.endRefreshing()
            })
        }
    }
    
    
    // MARK: - DoubleTextViewDelegate
    func doubleTextView(doubleTextView: DoubleTextView, didClickBtn btn: UIButton, toIndex index: Int) {
//        backgroundScrollView.setContentOffset(CGPointMake(kScreenWidth * CGFloat(index), 0), animated: true)
    }
}

// MARK: - UIScrollViewDelegate
extension ExploreViewController : UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView === backgroundScrollView {
            let index = Int(scrollView.contentOffset.x / kScreenWidth)
            doubleTextView.scrollToIndex(index)
        }
    }
}

// MARK:- UITableViewDelegate && UITableViewDataSource
extension ExploreViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView === albumTableView {
            return themes?.list?.count ?? 0
        } else {
            let event = everyDays?.list![section]
            if let _ = event?.themes?.last {
                return 2
            }
            
            return 1
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableView === albumTableView {
            return 240
        } else {
            if indexPath.row == 1 {
                return 220
            } else {
                return 253
            }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if tableView === albumTableView {
            return 1
        } else {
            return everyDays?.list?.count ?? 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        
        if tableView === albumTableView { // 美辑TableView
            
            let theme = themes!.list![indexPath.row]
            cell = ThemeCell.themeCellWithTableView(tableView)
            (cell as! ThemeCell).model = theme
            
        }   else { // 美天TableView
            let event = everyDays!.list![indexPath.section]
            
            if indexPath.row == 1 {
                cell = ThemeCell.themeCellWithTableView(tableView)
                (cell as! ThemeCell).model = event.themes?.last
            } else {
                cell = EventCellTableViewCell.eventCell(tableView)
                (cell as! EventCellTableViewCell).eventModel = event
            }
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}
