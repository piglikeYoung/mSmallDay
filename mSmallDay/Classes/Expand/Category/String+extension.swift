//
//  String+extension.swift
//  mSmallDay
//
//  Created by piglikeyoung on 15/10/19.
//  Copyright © 2015年 pikeYoung. All rights reserved.
//

import Foundation

// MARK: - String扩展
extension String {
    
    /// 判断是否是邮箱
    func validateEmail() -> Bool {
        let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluateWithObject(self)
    }
    
    /// 判断是否是手机号
    func validateMobile() -> Bool {
        let phoneRegex: String = "^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0,0-9]))\\d{8}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluateWithObject(self)
    }
    
    /// 将字符串转换成经纬度
    func stringToCLLocationCoordinate2D(separator: String) -> CLLocationCoordinate2D? {
        let arr = self.componentsSeparatedByString(separator)
        if arr.count != 2 {
            return nil
        }
        
        let longitude: Double = NSString(string: arr[0]).doubleValue
        let latitude: Double = NSString(string: arr[1]).doubleValue
        
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

// MARK: - MutableString扩展
extension NSMutableString {
    class func changeHeigthAndWidthWithSrting(searchStr: NSMutableString) -> NSMutableString {
        var mut = [CGFloat]()
        var mutH = [CGFloat]()
        let imageW = kScreenWidth - 23
        let rxHeight = NSRegularExpression(pattern: "(?<= height=\")\\d*")
        let rxWidth = NSRegularExpression(pattern: "(?<=width=\")\\d*")
        let widthArray = rxWidth.matches(searchStr as String) as! [String]
        
        for width  in widthArray {
            Int(width)!
            mut.append(imageW/CGFloat(Int(width)!))
        }
        
        var widthMatches = rxWidth.matchesInString(searchStr as String, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, searchStr.length))
        
        for var i = widthMatches.count - 1; i >= 0; i-- {
            let widthMatch = widthMatches[i] as NSTextCheckingResult
            searchStr.replaceCharactersInRange(widthMatch.range, withString: "\(imageW)")
        }
        
        let newString = searchStr.mutableCopy() as! NSMutableString
        
        let heightArray = rxHeight.matches(newString as String) as! [String]
        for i in 0..<mut.count {
            mutH.append(mut[i] * CGFloat(Int(heightArray[i])!))
        }
        
        var matches = rxHeight.matchesInString(newString as String, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, newString.length))
        
        for var i = matches.count - 1; i >= 0; i--
        {
            let match = matches[i] as NSTextCheckingResult
            newString.replaceCharactersInRange(match.range, withString: "\(mutH[i])")
        }
        
        return newString
    }
}