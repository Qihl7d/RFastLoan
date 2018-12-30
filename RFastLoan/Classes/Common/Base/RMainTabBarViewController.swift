//
//  RMainTabBarViewController.swift
//  RFastLoan
//
//  Created by RPK on 2018/9/12.
//  Copyright © 2018年 RPK. All rights reserved.
//

import UIKit
import RxSwift

class RMainTabBarViewController: UITabBarController, RootTabBarDelegate {
    let tabBarNormalImages = [R.image.首页1(), R.image.首页个人中心1()]
    let tabBarSelectedImages = [R.image.首页2(), R.image.首页个人中心2()]
    let tabBarTitles = ["首页","我的"]
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().backgroundColor = UIColor.hexInt(0xf3f3f5)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tab = RootTabBar()
        tab.addDelegate = self
        self.setValue(tab, forKey: "tabBar")
        self.setRootTabbarConntroller()
        // Do any additional setup after loading the view.
    }
    
    /// 上传按钮执行方法
    func addClick() {
        
        let viewController = self.viewControllers![selectedIndex]
        let loanViewController = RLoanViewController()
        let loanViewControllerNav = RBaseNavViewController.init(rootViewController: loanViewController)
        viewController.present(loanViewControllerNav, animated: true, completion: nil)
    }
    
    func setRootTabbarConntroller(){
        
        var vc : UIViewController?
        
        for i in 0..<self.tabBarNormalImages.count {
            
            //创建根控制器
            switch i {
            case 0:
                vc = RHomeViewController()
            case 1:
                vc = RMineViewController()
            default:
                break
            }
            
            //创建导航控制器
            let nav = RBaseNavViewController.init(rootViewController: vc!)
            
            //1.创建tabbarItem
            let barItem = UITabBarItem.init(title: self.tabBarTitles[i], image:  self.tabBarNormalImages[i]?.withRenderingMode(.alwaysOriginal), selectedImage: self.tabBarSelectedImages[i]?.withRenderingMode(.alwaysOriginal))
            
            //2.更改字体颜色
            barItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor :  UIColor.hexInt(0x666666), NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)], for: .normal)
            barItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.hexInt(0x4DB4FF), NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)], for: .selected)
            
            //设置标题
            vc?.title = self.tabBarTitles[i]
            
            //设置根控制器
            vc?.tabBarItem = barItem
            
            //添加到当前控制器
            self.addChild(nav)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}

/// 上传按钮点击代理
protocol RootTabBarDelegate:NSObjectProtocol {
    func addClick()
}

/// 自定义tabbar，修改UITabBarButton的位置
class RootTabBar: UITabBar {
    
    weak var addDelegate: RootTabBarDelegate?
    
    private lazy var addButton:UIButton = {
        return UIButton()
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        addButton.setBackgroundImage(R.image.首页借款(), for: .normal)
        addButton.setTitle("借款", for: UIControl.State.normal)
        addButton.setTitleColor(hexColor666, for: UIControl.State.normal)
        addButton.setTitleColor(themeColor, for: UIControl.State.selected)
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        addButton.titleEdgeInsets = UIEdgeInsets.init(top: 75, left: 0, bottom: 0, right: 0)
        addButton.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        addButton.addTarget(self, action: #selector(RootTabBar.addButtonClick), for: .touchUpInside)
        self.addSubview(addButton)
        /// tabbar设置背景色
        self.backgroundColor = UIColor.white
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func addButtonClick(_ sender:UIButton){
        sender.isSelected = true 
        if addDelegate != nil{
            addDelegate?.addClick()
        }
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        let buttonX = self.frame.size.width/3
        var index = 0
        for barButton in self.subviews{
            
            if barButton.isKind(of: NSClassFromString("UITabBarButton")!){
                
                if index == 1{
                    /// 设置添加按钮位置
                    addButton.frame.size = CGSize.init(width: (addButton.currentBackgroundImage?.size.width)!, height: (addButton.currentBackgroundImage?.size.height)!)
                    addButton.center = CGPoint.init(x: self.center.x, y: 0)
                    index += 1
                }
                barButton.frame = CGRect.init(x: buttonX * CGFloat(index), y: 0, width: buttonX, height: self.frame.size.height - kTabbarSafeBottomMargin)
                index += 1
                
            }
        }
        self.bringSubviewToFront(addButton)
    }
    
    /// 重写hitTest方法，监听按钮的点击 让凸出tabbar的部分响应点击
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        /// 判断是否为根控制器
        if self.isHidden {
            /// tabbar隐藏 不在主页 系统处理
            return super.hitTest(point, with: event)
            
        }else{
            /// 将单钱触摸点转换到按钮上生成新的点
            let onButton = self.convert(point, to: self.addButton)
            /// 判断新的点是否在按钮上
            if self.addButton.point(inside: onButton, with: event){
                return addButton
            }else{
                /// 不在按钮上 系统处理
                return super.hitTest(point, with: event)
            }
        }
    }
}
