//
//  CELinearScrollView.swift
//  CampusExchange_iOS
//
//  Created by UBIELIFE on 2017-02-24.
//  Copyright © 2017 UBIELIFE Inc. All rights reserved.
//

import UIKit
import TPKeyboardAvoiding

class CELinearScrollView: TPKeyboardAvoidingScrollView {
    
    // variables
    
    var items = [CELinearScrollViewItem]()

    var autoAdjustFrameSize: Bool = false
    
    var autoAdjustContentSize : Bool = false
    
    var miniContentSizeHeight : CGFloat = 0
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        self.autoresizesSubviews = false
        
        self.backgroundColor = UIColor.white
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        
        self.miniContentSizeHeight = 0
    }
    
    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)
        self.autoresizesSubviews = false
        
        self.backgroundColor = UIColor.white
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        
        self.miniContentSizeHeight = 0
    }
    
    func setMiniHeight(_ height: CGFloat){
        self.miniContentSizeHeight = height
    }
    
    // 添加 view 到 scrollview 中， 需要参数有 上边缘高， 下边缘高。
    func linear_addSubview(_ view: UIView, paddingTop: CGFloat, paddingBottom: CGFloat){
        
        let item  = CELinearScrollViewItem.init(view: view, paddingTop: paddingTop, paddingBottom: paddingBottom)
        
        self.items.append(item)
        
        super.addSubview(view)
        
        if self.autoAdjustFrameSize == true{
            self.resetFrameSize()
        }
        
        if self.autoAdjustContentSize == true{
            self.resetContentSize()
        }
        
        self.linear_updateDisplay()
    }
    
    // 根据 view 来移除 view
    func linear_removeView(_ view: UIView){
        var target: CELinearScrollViewItem?
        for item in self.items {
            if item.view == view {
                target = item
                break
            }
        }
        if let item = target{
            item.view.removeFromSuperview()
            self.items.remove(at: self.items.index(of: item)!)
            self.linear_updateDisplay()
        }
    }
    
    // 根据 view 的index 来移除 view
    func linear_removeViewAtIndex(_ index: Int){
        if index >= self.items.count {
            return
        }
        let item = self.items[index]
        item.view.removeFromSuperview()
        self.items.remove(at: index)
        self.linear_updateDisplay()
    }
    
    // 清空所有的 view
    func linear_removeAllSubviews(){
        for item in self.items {
            item.view.removeFromSuperview()
        }
        self.items.removeAll()
        self.linear_updateDisplay()
    }
    
    // 使用 新的 items 替代 就得 items
    func liear_replaceWithItems(_ items: [CELinearScrollViewItem]){
        self.linear_removeAllSubviews()
        self.items = items
        self.linear_updateDisplay()
    }
    
    func resetFrameSize(){
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: self.layoutOffset())
        
        print(self.frame)
    }

    func linear_insertViewAtIndex(_ index: Int , view: UIView , paddingTop: CGFloat, paddingBottom: CGFloat){
        var location = 0
        if index >= self.items.count {
            location = self.items.count
        }
        else{
            location = index
        }
        
        if let parent = view.superview{
            if parent == self{
                return
            }
        }
        
        let item = CELinearScrollViewItem.init(view: view, paddingTop: paddingTop, paddingBottom: paddingBottom)
        super.addSubview(view)
        self.items.insert(item, at: location)
        self.linear_updateDisplay()
    }
    
    func resetContentSize(){
        
        
        
        var width = CGFloat(0)
        if self.frame.size.width > GlobalValue.SCREENBOUND.width{
            width = GlobalValue.SCREENBOUND.width
        }
        else{
            width = self.frame.size.width
        }

        var suitable = self.layoutOffset()
        if suitable - self.miniContentSizeHeight < 0{
            suitable = miniContentSizeHeight
        }
        self.contentSize = CGSize(width: width, height: suitable)
    }
    
    func linear_insertView(after previousView: UIView, for targetView: UIView,paddingTop: CGFloat, paddingBottom: CGFloat){
        var previousItem: CELinearScrollViewItem?
        for item in self.items{
            if item.view === previousView{
                previousItem = item
                break
            }
        }
        
        if let item  = previousItem{
            let index = self.items.index(of: item)
            let newItem = CELinearScrollViewItem.init(view: targetView, paddingTop: paddingTop, paddingBottom: paddingBottom)
            self.items.insert(newItem, at: index! + 1)
            super.addSubview(targetView)
            self.linear_updateDisplay()
        }
    }
    
    func linear_insertView(before afterView: UIView, for targetView: UIView,paddingTop: CGFloat, paddingBottom: CGFloat){
        var afterItem: CELinearScrollViewItem?
        for item in self.items{
            if item.view === afterView{
                afterItem = item
                break
            }
        }
        
        if let item  = afterItem{
            let index = self.items.index(of: item)
            let newItem = CELinearScrollViewItem.init(view: targetView, paddingTop: paddingTop, paddingBottom: paddingBottom)
            self.items.insert(newItem, at: index!)
            super.addSubview(targetView)
            self.linear_updateDisplay()
        }
    }
    
    func linear_updateDisplay(){
        var curBottom: CGFloat = 0
        
        for item in self.items {
            if item.view.isHidden == true {
                continue
            }
            curBottom = curBottom + item.paddingTop
            item.view.top = curBottom
            curBottom = curBottom + item.paddingBottom + item.view.height
        }
        
        let suitable = max(curBottom, self.miniContentSizeHeight)
        self.contentSize = CGSize(width: self.frame.size.width, height: suitable)
    }
    
    func layoutOffset() -> CGFloat{
        var curOffset: CGFloat = 0
        
        for item in self.items {
            if item.view.isHidden == true{
                continue
            }
            curOffset = curOffset + item.paddingTop + item.paddingBottom + item.view.height
        }
        return curOffset
    }

}
