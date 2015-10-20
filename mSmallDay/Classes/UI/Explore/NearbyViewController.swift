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
    private lazy var backView: UIView = {
        let backView = UIView(frame: self.view.bounds)
        backView.backgroundColor = SDBackgroundColor
        return backView
    }()
    
    private lazy var nearTableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .Plain)
//        tableView.delegate = self
//        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.backgroundColor = SDBackgroundColor
        tableView.sectionHeaderHeight = 0.1
        tableView.sectionFooterHeight = 0.1
        tableView.rowHeight = kDetailCellHeight
        tableView.registerNib(UINib(nibName: "DetailCell", bundle: nil), forCellReuseIdentifier: SD_DetailCell_Identifier)
        let diyHeader = SDRefreshHeader(refreshingTarget: self, refreshingAction: "pullLoadDatas")
        diyHeader.gifView!.frame = CGRectMake((kScreenWidth - SD_RefreshImage_Width) * 0.5, 10, SD_RefreshImage_Width, SD_RefreshImage_Height)
        tableView.header = diyHeader
        return tableView
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    

}
