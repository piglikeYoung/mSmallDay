//
//  CityViewController.swift
//  mSmallDay
//
//  Created by piglikeyoung on 15/10/12.
//  Copyright © 2015年 pikeYoung. All rights reserved.
//

import UIKit

public let SD_Current_SelectedCity = "SD_Current_SelectedCity"
public let SD_Current_SelectedCityIndexPath = "SD_Current_SelectedCityIndexPath"
public let SD_CurrentCityChange_Notification = "SD_CurrentCityChange_Notification"

private let kCellIdentifier = "cellID"
private let kHeaderIdentifier = "headerViewID"
private let kFooterIdentifier = "FooterViewID"

class CityViewController: UIViewController {

    var colletionView: UICollectionView!
    var layout = UICollectionViewFlowLayout()
    
    lazy var domesticCitys: NSArray? = {
        let arr = NSArray(array: ["北京", "上海", "成都", "广州", "杭州", "西安", "重庆", "厦门", "台北"])
        return arr
    }()
    
    lazy var overseasCitys: NSArray? = {
        let arr = NSArray(array: ["罗马", "迪拜", "里斯本", "巴黎", "柏林", "伦敦"])
        return arr
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationItem()
        
        setCollectionView()
        
        // 获取存储的City的IndexPath，让colletionView选中
        if let currentCityIndex = NSUserDefaults.standardUserDefaults().objectForKey(SD_Current_SelectedCityIndexPath) as? Array<Int> {
            colletionView.selectItemAtIndexPath(NSIndexPath(forItem: currentCityIndex.last!, inSection: currentCityIndex.first!), animated: true, scrollPosition: UICollectionViewScrollPosition.None)
        }
    }
    
    
    
    private func setNavigationItem() {
        view.backgroundColor = SDBackgroundColor
        navigationItem.title = "选择城市"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .Done, target: self, action: "cancle")
    }
    
    private func setCollectionView() {
        // 设置布局
        let itemW = kScreenWidth / 3.0 - 1.0
        let itemH: CGFloat = 50.0
        layout.itemSize = CGSizeMake(itemW, itemH)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.headerReferenceSize = CGSizeMake(view.width, 60)
        
        // 设置collectionView
        colletionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        colletionView.backgroundColor = UIColor.colorWith(r: 247, g: 247, b: 247, a: 1)
        colletionView.delegate = self
        colletionView.dataSource = self
        colletionView.selectItemAtIndexPath(NSIndexPath(forItem: 0, inSection: 0), animated: true, scrollPosition: UICollectionViewScrollPosition.None)
        colletionView.registerClass(CityCollectionViewCell.self, forCellWithReuseIdentifier: kCellIdentifier)
        colletionView.registerClass(CityHeadCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderIdentifier)
        colletionView.registerClass(CityFootCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: kFooterIdentifier)
        colletionView.alwaysBounceVertical = true
        
        view.addSubview(colletionView)
    }
    
    func cancle() {
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
}

// MARK - UICollectionViewDelegate, UICollectionViewDataSource
extension CityViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return domesticCitys!.count
        } else {
            return overseasCitys!.count
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionFooter && indexPath.section == 1 {
            let footView = colletionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter, withReuseIdentifier: kFooterIdentifier, forIndexPath: indexPath)
            footView.height = 80
            return footView
        }
        
        let headView = colletionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderIdentifier, forIndexPath: indexPath) as! CityHeadCollectionReusableView
        if indexPath.section == 0 {
            headView.headTitle = "国内城市"
        } else {
            headView.headTitle = "国外城市"
        }
        
        return headView
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = colletionView.dequeueReusableCellWithReuseIdentifier(kCellIdentifier, forIndexPath: indexPath) as! CityCollectionViewCell
        if indexPath.section == 0 {
            cell.cityName = domesticCitys?.objectAtIndex(indexPath.row) as? String
        } else {
            cell.cityName = overseasCitys?.objectAtIndex(indexPath.row) as? String
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // 拿到点击的cell
        let cell = colletionView.cellForItemAtIndexPath(indexPath) as! CityCollectionViewCell
        let currentCity = cell.cityName
        let userDefaults = NSUserDefaults.standardUserDefaults()
        // 存储当前点击cell的City名
        userDefaults.setObject(currentCity, forKey: SD_Current_SelectedCity)
        // 存储当前点击cell的indexPath，把indexPath变成数组存储
        userDefaults.setObject([indexPath.section, indexPath.row], forKey: SD_Current_SelectedCityIndexPath)
        if userDefaults.synchronize() {
            // 同步成功，发送城市改变通知
            NSNotificationCenter.defaultCenter().postNotificationName(SD_CurrentCityChange_Notification, object: currentCity)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    /// 这方法是UICollectionViewDelegateFlowLayout 协议里面的， 我现在是 默认的flow layout， 没有自定义layout，所以就没有实现UICollectionViewDelegateFlowLayout协议,需要完全手敲出来方法,对应的也有设置header的尺寸方法
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSizeZero
        } else {
            return CGSizeMake(view.width, 120)
        }
    }
}
