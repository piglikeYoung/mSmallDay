//
//  NearbyViewController.swift
//  mSmallDay
//
//  Created by piglikeyoung on 15/10/13.
//  Copyright © 2015年 pikeYoung. All rights reserved.
//

import UIKit

public let kDetailCellHeight: CGFloat = 220

class NearbyViewController: UIViewController {

    private var nearModel: DetailModel?
    
    // MARK: - 懒加载
    private lazy var nearTableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.backgroundColor = SDBackgroundColor
        tableView.sectionHeaderHeight = 0.1
        tableView.sectionFooterHeight = 0.1
        tableView.rowHeight = kDetailCellHeight
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kNavigationH, right: 0)
        tableView.registerNib(UINib(nibName: "DetailCell", bundle: nil), forCellReuseIdentifier: SD_DetailCell_Identifier)
        let diyHeader = SDRefreshHeader(refreshingTarget: self, refreshingAction: "pullLoadDatas")
        diyHeader.gifView!.frame = CGRectMake((kScreenWidth - SD_RefreshImage_Width) * 0.5, 10, SD_RefreshImage_Width, SD_RefreshImage_Height)
        tableView.header = diyHeader
        return tableView
        
    }()
    
    /// 高德地图View
    private lazy var mapView: YJHMapView = YJHMapView(frame: self.view.bounds)
    
    /// 右侧地图按钮
    private lazy var rightItem: UIBarButtonItem = {
        let right = UIBarButtonItem(imageName: "map_2-1", highlImageName: "map_2", selectedImage: "list_1", target: self, action: "rightItemClick:")
        return right
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "附近"
        view.backgroundColor = SDBackgroundColor
        view.addSubview(nearTableView)

        nearTableView.header.beginRefreshing()
    }
    
    deinit {
        mapView.clearDisk()
        mapView.showsUserLocation = false
        log.info("地图控制器被销毁")
    }
    
    func pullLoadDatas() {
        weak var tmpSelf = self
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(0.8 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            DetailModel.loadNearDatas({ (data, error) -> () in
                if error != nil {
                    SVProgressHUD.showErrorWithStatus("网速不给力")
                    tmpSelf!.nearTableView.header.endRefreshing()
                    return
                }
                
                tmpSelf!.nearModel = data
                tmpSelf!.nearTableView.reloadData()
                tmpSelf!.nearTableView.header.endRefreshing()
                tmpSelf!.mapView.nearsModel = data
                tmpSelf!.addMapView()
            })
        }
    }

    func rightItemClick(sender: UIButton) {
        sender.selected = !sender.selected
        
        /**
        *  转换View
        */
        if sender.selected {
            UIView.transitionFromView(nearTableView, toView: mapView, duration: 1.0, options: UIViewAnimationOptions.TransitionFlipFromLeft, completion: nil)
        } else {
            UIView.transitionFromView(mapView, toView: nearTableView, duration: 1.0, options: UIViewAnimationOptions.TransitionFlipFromRight, completion: nil)
        }
    }
    
    private func addMapView() {
        
        /**
        *  模型中有数据才能显示地图
        */
        if nearModel?.list?.count > 0 {
            navigationItem.rightBarButtonItem = rightItem
        } else {
            navigationItem.rightBarButtonItem = nil
        }
        
        // 把当前控制器传过去，让地图View的ColletionView点击后能跳转
        mapView.pushVc = self
        view.insertSubview(mapView, belowSubview: nearTableView)
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension NearbyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nearModel?.list?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(SD_DetailCell_Identifier) as? DetailCell
        
        cell?.model = nearModel!.list![indexPath.row] as EventModel
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let deatilVc = EventViewController()
        deatilVc.model = nearModel?.list![indexPath.row]
        navigationController?.pushViewController(deatilVc, animated: true)
    }
}
