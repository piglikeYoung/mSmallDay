//
//  YJHMapView.swift
//  mSmallDay
//
//  Created by piglikeyoung on 15/10/19.
//  Copyright © 2015年 pikeYoung. All rights reserved.
//  附近控制器地图View

import UIKit

private let kPointReuseIndentifier = "pointReuseIndentifier"

class YJHMapView: MAMapView {

    /// 地图上的点数组
    var flags: [MAPointAnnotation] = [MAPointAnnotation]()
    /// 最后点击的大头针
    var lastMAAnnotationView: MAAnnotationView?
    /// NearbyViewController
    weak var pushVc: NearbyViewController?
    
    var nearsModel: DetailModel? {
        didSet {
            // 移除之前的点
            flags.removeAll(keepCapacity: true)
            nearCollectionView.reloadData()
            
            // 将每个点添加到地图上
            for i in 0..<nearsModel!.list!.count {
                let eventModel = nearsModel!.list![i]
                // 坐标转成经纬度
                if let position = eventModel.position?.stringToCLLocationCoordinate2D(",") {
                    let po = MAPointAnnotation()
                    po.coordinate = position
                    flags.append(po)
                    addAnnotation(po)
                    
                    // 默认选中第一个点
                    if i == 0 {
                        selectAnnotation(po, animated: true)
                    }
                }
            }
        }
    }
    
    private lazy var nearCollectionView: UICollectionView = {
        let nearH: CGFloat = 105 // item的高度
        let nearBottomMargin: CGFloat = 10 // 距离底部的高度
        let itemW = kScreenWidth - 35 - 10 // Item宽度
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        layout.itemSize = CGSizeMake(itemW, nearH)
        
        let nearCV = UICollectionView(frame: CGRectMake(15, kScreenHeight - nearH - nearBottomMargin - kNavigationH, kScreenWidth - 35, nearH), collectionViewLayout: layout)
        nearCV.delegate = self
        nearCV.dataSource = self
        nearCV.clipsToBounds = false
        nearCV.registerNib(UINib(nibName: "nearCell", bundle: nil), forCellWithReuseIdentifier: "nearCell")
        nearCV.pagingEnabled = true
        nearCV.showsVerticalScrollIndicator = false
        nearCV.backgroundColor = UIColor.clearColor()
        return nearCV
    }()
    
    private lazy var myLocalBtn: UIButton = {
        let btnWH: CGFloat = 57
        let btn = UIButton(frame: CGRectMake(20, kScreenHeight - 180 - btnWH, btnWH, btnWH)) as UIButton
        btn.setBackgroundImage(UIImage(named: "dingwei_1"), forState: .Normal)
        btn.setBackgroundImage(UIImage(named: "dingwei_2"), forState: .Highlighted)
        btn.addTarget(self, action: "backCurrentLocal", forControlEvents: .TouchUpInside)
        return btn
    }()
    
    /**
     定位当前用户的位置到地图中心
     */
    func backCurrentLocal() {
        setCenterCoordinate(userLocation.coordinate, animated: true)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        delegate = self
        showsCompass = false
        showsScale = false
        showsUserLocation = true
        // 高德地图水印位置
        logoCenter.x = kScreenWidth - logoSize.width + 20
        zoomLevel = 12
        setCenterCoordinate(CLLocationCoordinate2D(latitude: 22.5633480000, longitude: 114.0795910000), animated: true)
        mapType = MAMapType.Standard
        addSubview(myLocalBtn)
        addSubview(nearCollectionView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        clearDisk()
        showsUserLocation = false
        log.info("地图view被销毁")
    }
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension YJHMapView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nearsModel?.list?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("nearCell", forIndexPath: indexPath) as! nearCell
        let model = nearsModel?.list![indexPath.item]
        cell.nearModel = model
        cell.titleLabel.text = "\(indexPath.row + 1)." + cell.titleLabel.text!
        return cell
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let currentIndex = Int(nearCollectionView.contentOffset.x / nearCollectionView.width + 0.5)
        selectAnnotation(flags[currentIndex], animated: true)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let eventVc = EventViewController()
        eventVc.model = nearsModel?.list![indexPath.item]
        pushVc?.navigationController?.pushViewController(eventVc, animated: true)
    }
}

// MARK: - MAMapViewDelegate
extension YJHMapView: MAMapViewDelegate {

    func mapView(mapView: MAMapView!, viewForAnnotation annotation: MAAnnotation!) -> MAAnnotationView! {
        if annotation.isKindOfClass(MAPointAnnotation.self) {
            var annot = mapView.dequeueReusableAnnotationViewWithIdentifier(kPointReuseIndentifier)
            if annot == nil {
                annot = MAPinAnnotationView(annotation: annotation, reuseIdentifier: kPointReuseIndentifier) as MAPinAnnotationView
            }
            annot.image = UIImage(named: "zuobiao1")
            annot.center = CGPoint(x: 0, y: -(annot.image.size.height * 0.5))
            return annot
        }
        
        return nil
    }
    
    func mapView(mapView: MAMapView!, didSelectAnnotationView view: MAAnnotationView!) {
        lastMAAnnotationView?.image = UIImage(named: "zuobiao1")
        view.image = UIImage(named: "zuobiao2")
        lastMAAnnotationView = view
        setCenterCoordinate(view.annotation.coordinate, animated: true)
        
        /// 获取点击大头针在flags的索引
        let currentIndex = CGFloat(annotationViewWithIndex(view))
        nearCollectionView.setContentOffset(CGPoint(x: currentIndex * nearCollectionView.width, y: 0), animated: true)
    }
    
    /**
     把点击的大头针和flags里面的大头针比较，如果相同返回flags的索引
     
     - parameter anno: 点击的大头针
     
     - returns: flags的索引
     */
    private func annotationViewWithIndex(anno: MAAnnotationView) -> Int {
        for i in 0..<flags.count {
            let point = flags[i]
            if viewForAnnotation(point) === anno {
                return i
            }
        }
        
        return 0
    }
}
