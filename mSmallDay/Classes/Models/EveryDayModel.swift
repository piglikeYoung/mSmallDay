//
//  EveryDayModel.swift
//  mSmallDay
//
//  Created by piglikeyoung on 15/10/15.
//  Copyright © 2015年 pikeYoung. All rights reserved.
//

import UIKit

class EveryDays: NSObject, DictModelProtocol {

    var msg: String?
    var code: Int = -1
    var list: [EveryDay]?
    
    class func loadEventsData(completion: (data: EveryDays?, error: NSError?)->()) {
        /// 加载events中json数据
        let path = NSBundle.mainBundle().pathForResource("events", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        
        if data != nil {
            /// 解析json数据
            let dict: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)) as! NSDictionary
            let modelTool = DictModelManager.sharedInstance
            /// 字典转模型
            let data = modelTool.objectWithDictionary(dict, cls: EveryDays.self) as? EveryDays
            /// 回调闭包方法，传输数据给外部调用方法
            completion(data: data, error: nil)
        }
    }
    
    static func customClassMapping() -> [String : String]? {
        return ["list" : "\(EveryDay.self)"]
    }
}



class EveryDay: NSObject, DictModelProtocol {
    
    // 辅助模型, 为了优化 每个模型只计算一次
    var month: String?
    var day: String?
    
    var themes: [ThemeModel]?
    var events: [EventModel]?
    
    static func customClassMapping() -> [String : String]? {
        return ["themes" : "\(ThemeModel.self)", "events" : "\(EventModel.self)"]
    }
    
    var date: NSString? {
        willSet{
            if let tmpDate = newValue {
                if tmpDate.length == 10 {
                    if let tmpM = Int(tmpDate.substringWithRange(NSRange(location: 5, length: 2))) {
                        switch tmpM {
                        case 1:
                            self.month = "Jan."
                        case 2:
                            self.month = "Feb."
                        case 3:
                            self.month = "Mar."
                        case 4:
                            self.month = "Apr."
                        case 5:
                            self.month = "May."
                        case 6:
                            self.month = "Jun."
                        case 7:
                            self.month = "Jul."
                        case 8:
                            self.month = "Aug."
                        case 9:
                            self.month = "Sep."
                        case 10:
                            self.month = "Oct."
                        case 11:
                            self.month = "Nov."
                        case 12:
                            self.month = "Dec."
                        default:
                            self.month = "\(tmpM)."
                        }
                    } else {
                        self.month = "Aug."
                    }
                    
                    self.day = tmpDate.substringWithRange(NSRange(location: 8, length: 2))
                } else {
                    self.date = newValue
                    return
                }
            }
            
            self.date = newValue
        }
    }
}

/// 美天model
class EventModel: NSObject, DictModelProtocol {
    var feel: String?
    /// 分享url地址
    var shareURL: String?
    var note: String?
    var questionURL: String?
    /// 电话
    var telephone: String?
    /// 标签
    var tag: String?
    /// 编号
    var id: Int = -1
    /// 标题
    var title:String?
    /// 详情
    var detail: String?
    /// cellTitle
    var feeltitle: String?
    /// 城市
    var city: String?
    /// 地址
    var address: String?
    /// 店详情店名
    var remark: String?
    /// 顶部图片数组
    var imgs: [String]?
    /// 猜你喜欢
    var more: [GuessLikeModel]?
    /// cell内容
    var mobileURL: String?
    /// 位置
    var position: String?
    
    // 辅助模型
    /// 标记是否需要显示距离
    var isShowDis = false
    /// 计算出用户当前位置距离店铺我距离,单位km
    var distanceForUser: String?
    
    static func customClassMapping() -> [String : String]? {
        return ["more" : "\(GuessLikeModel.self)"]
    }
}

/// 猜你喜欢
class GuessLikeModel: NSObject {
    /// 标题
    var title: String?
    /// 图片
    var imgs: [String]?
    /// 地址
    var address: String?
}

// MARK: - 美辑模型
/// 美辑model
class ThemeModel: NSObject {
    /// 美辑的url网址
    var themeurl: String?
    /// 图片url
    var img: String?
    /// cell主标题
    var title: String?
    /// 是否有web地址 1是有, 0没有
    var hasweb: Int = -1
    /// cell的副标题
    var keywords: String?
    /// 美辑的编号
    var id: Int = -1
    var text: String?
    
}

/// 美辑列表
class ThemeModels: NSObject , DictModelProtocol{
    
    var lastdate: String?
    var list: [ThemeModel]?
    
    class func loadThemesData(completion:(data: ThemeModels?, error: NSError?)->()) {
        let path = NSBundle.mainBundle().pathForResource("themes", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        if data != nil {
            let dict: NSDictionary = (try!
                NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)) as! NSDictionary
            let modelTool = DictModelManager.sharedInstance
            let data = modelTool.objectWithDictionary(dict, cls: ThemeModels.self) as? ThemeModels
            completion(data: data, error: nil)
        }
    }
    
    static func customClassMapping() -> [String : String]? {
        return ["list" : "\(ThemeModel.self)"]
    }
}
