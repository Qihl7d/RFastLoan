//
//  MainTabBarView.swift
//  RFastLoan
//
//  Created by RPK on 2018/10/31.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit

//自定义标签栏代理协议
protocol MainTabBarDelegate {
    func didChooseItem(itemIndex:Int)
}

class MainTabBarView: UIView {
    var delegateTabbar  : MainTabBarDelegate? //代理,点击item
    var itemArray : [MainTabBarItem] = [] //标签Item数组
    var centerButton : MainTabBarItem!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.hexInt(0xF3F3F3)
        
        let screenW      = UIScreen.main.bounds.size.width
        let titles       = ["首页", "借款", "个人中心"]
        let images       = [R.image.首页1(), R.image.首页借款(), R.image.首页个人中心1()]
        let selectImages = [R.image.首页2(), R.image.首页借款(), R.image.首页个人中心2()]
        let itemWidth    = screenW / CGFloat(titles.count)
        
        for i in 0 ..< titles.count {
            
            let itemFrame = CGRect(x: itemWidth * CGFloat(i) , y: 0, width: itemWidth, height: frame.size.height)
            //创建Item视图
            let itemView  = MainTabBarItem.init(frame: itemFrame, title: titles[i], image: images[i]!, selectImage: selectImages[i]!, itemIndex: i)
            self.addSubview(itemView)
            self.itemArray.append(itemView)
            //添加事件点击处理
            itemView.tag = i
            itemView.addTarget(self, action:#selector(self.didItemClick(item:))  , for: UIControl.Event.touchUpInside)
            
            //默认点击第一个,即首页
            if i == 0 {
                self.didItemClick(item: itemView)
            }
            else if i == 1 {
                centerButton = itemView;
            }
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //点击单个标签视图，通过currentSelectState的属性观察器更新标签的显示
    //并且通过代理方法切换标签控制器的当前视图控制器
    @objc func didItemClick(item:MainTabBarItem) {
        
        for i in 0..<itemArray.count {
            
            let tempItem = itemArray[i]
            if i == item.tag {
                tempItem.currentSelectState = true
            } else {
                tempItem.currentSelectState = false
            }
        }
        //执行代理方法
        self.delegateTabbar?.didChooseItem(itemIndex: item.tag)
    }
    
    // 这个方法就是为了让超出的加号部分也能点击响应
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        // 只有在没有被隐藏的时候才会需要
        if self.isHidden == false
        {
            let newPoint: CGPoint = self.convert(point, to: self.centerButton.imgView)
            let newPoint1: CGPoint = self.convert(point, to: self.centerButton)
            // 判断点击的点在加号的范围里面  那么响应的范围就是加号的范围
            if self.centerButton.imgView.point(inside: newPoint, with: event) || self.centerButton.point(inside: newPoint1, with: event)
            {
                return self.centerButton
            }else
            {// 其他时候  就按照系统的方法走就行了
                return super.hitTest(point, with: event)
            }
            
        }else
        {
            // 其他时候  就按照系统的方法走就行了
            return super.hitTest(point, with: event)
        }
    }
}
