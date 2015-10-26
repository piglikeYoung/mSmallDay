//
//  ShowMapViewController.swift
//  mSmallDay
//
//  Created by piglikeyoung on 15/10/26.
//  Copyright © 2015年 pikeYoung. All rights reserved.
//  地图控制器，点击店详情里面的地图时跳转使用

import UIKit

private let kPointIndentifier = "pointIndentifier"

class ShowMapViewController: UIViewController {
    
    
    private lazy var mapView: MAMapView = {
        let mapView = MAMapView()
        mapView.frame = kMainBounds
        mapView.delegate = self
        mapView.showsCompass = false
        mapView.showsScale = false
        mapView.showsUserLocation = true
        mapView.logoCenter.x = kScreenWidth - mapView.logoSize.width + 20
        mapView.setZoomLevel(14, animated: true)
        return mapView
    }()
    
    var model: EventModel? {
        didSet {
            if let shopLocation = model?.position?.stringToCLLocationCoordinate2D(",") {
                let point  = MAPointAnnotation()
                point.coordinate = shopLocation
                self.mapView.addAnnotation(point)
                self.mapView.setCenterCoordinate(shopLocation, animated: true)
                self.mapView.setZoomLevel(15, animated: true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "位置"
        view.addSubview(mapView)
    }
    
    deinit {
        mapView.showsUserLocation = false
        mapView.clearDisk()
        log.info("ShowMapViewController被销毁了")
    }
}

extension ShowMapViewController: MAMapViewDelegate {
    func mapView(mapView: MAMapView!, viewForAnnotation annotation: MAAnnotation!) -> MAAnnotationView! {
        if annotation.isKindOfClass(MAPointAnnotation.self) {
            var annot = mapView.dequeueReusableAnnotationViewWithIdentifier(kPointIndentifier) as? CustomAnnotationView
            if annot == nil {
                annot = CustomAnnotationView(annotation: annotation, reuseIdentifier: "point") as CustomAnnotationView
            }
            annot!.userInteractionEnabled = false
            annot!.setSelected(true, animated: true)
            annot!.canShowCallout = false
            annot!.image = UIImage(named: "zuobiao1")
            annot!.center = CGPoint(x: 0, y: -(annot!.image.size.height * 0.5))
            annot!.calloutView?.adressTitle = model?.address
            return annot!
            
        }
        
        return nil
    }
}
