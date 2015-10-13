//
//  DoubleTextView.swift
//  mSmallDay
//
//  Created by piglikeyoung on 15/10/13.
//  Copyright © 2015年 pikeYoung. All rights reserved.
//

import UIKit


/**
*  DoubleTextViewDelegate协议
*/
protocol DoubleTextViewDelegate: NSObjectProtocol{
    
    func doubleTextView(doubleTextView: DoubleTextView, didClickBtn btn: UIButton, toIndex index: Int)
    
}


class DoubleTextView: UIView {

    private let leftTextButton: NoHighlightButton = NoHighlightButton()
    private let rightTextButton: NoHighlightButton = NoHighlightButton()
    private let textColor: UIColor = UIColor.colorWith(r: 100, g: 100, b: 100, a: 1)
    private let textFont: UIFont = SDNavTitleFont
    private let bottomLineView: UIView = UIView()
    private var selectedBtn: UIButton?
    weak var delegate: DoubleTextViewDelegate?
    
    convenience init(leftText: String, rightText: String) {
        self.init()
        
        // 设置左边文字
        setButtonText(leftTextButton, title: leftText, tag: 100)
        // 设置右边文字
        setButtonText(rightTextButton, title: rightText, tag: 101)
        
        // 设置下划线View
        setBottomLineView()
        
        // 默认在左边
        titleButtonClick(leftTextButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let btnW = width * 0.5
        leftTextButton.frame = CGRectMake(0, 0, btnW, height)
        rightTextButton.frame = CGRectMake(btnW, 0, btnW, height)
        bottomLineView.frame = CGRectMake(0, height - 2, width * 0.5, 2)
    }
    
    /**
    设置下划线
    */
    private func setBottomLineView() {
        bottomLineView.backgroundColor = UIColor.colorWith(r: 60, g: 60, b: 60, a: 1)
        
        addSubview(bottomLineView)
    }
    
    /**
    设置按钮文字
    
    - parameter button: 设置的按钮
    - parameter title:  按钮文字
    - parameter tag:    标识
    */
    private func setButtonText(button: UIButton, title: String, tag: Int) {
        button.setTitleColor(UIColor.blackColor(), forState: .Selected)
        button.setTitleColor(textColor, forState: .Normal)
        button.titleLabel?.font = textFont
        button.tag = tag
        button.addTarget(self, action: "titleButtonClick:", forControlEvents: .TouchUpInside)
        button.setTitle(title, forState: .Normal)
        addSubview(button)
    }
    
    /**
    点击按钮
    
    */
    func titleButtonClick(btn: UIButton) {
        // 之前选中的btn变为false
        selectedBtn?.selected = false
        // 当前点击的btn选中
        btn.selected = true
        selectedBtn = btn
        // 下划线滚动
        bottomLineViewScrollTo(selectedBtn!.tag - 100)
        // 调用代理的方法
        delegate?.doubleTextView(self, didClickBtn: selectedBtn!, toIndex: selectedBtn!.tag - 100)
    }
    
    /**
    改变下划线位置
    
    - parameter index: 要滚动到btn的索引
    */
    private func bottomLineViewScrollTo(index: Int) {
        UIView.animateWithDuration(0.2) { () -> Void in
            self.bottomLineView.x = CGFloat(index) * self.bottomLineView.width
        }
    }
    
    /**
    当控制器滚动的时候，调用这个方法改变选中按钮
    
    - parameter index: 要滚动到btn的索引
    */
    func scrollToIndex(index: Int) {
        self.titleButtonClick(self.viewWithTag(index + 100) as! UIButton)
    }

}
