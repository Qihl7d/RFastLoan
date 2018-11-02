//
//  RMainTabBarViewController.swift
//  RFastLoan
//
//  Created by RPK on 2018/9/12.
//  Copyright © 2018年 RPK. All rights reserved.
//

import UIKit

class RMainTabBarViewController: UITabBarController, MainTabBarDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createController()
        createMainTabBarView()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    private func createController() {
        let homeNav = RBaseNavViewController.init(rootViewController: RHomeViewController());
        let mineNav = RBaseNavViewController.init(rootViewController: RMineViewController())
        self.viewControllers = [homeNav, mineNav]
    }
    
    private func createMainTabBarView() {
        let tabBarRect = CGRect.init(x: 0, y: RscreenHeight - tabbarHeight, width: RscreenWidth, height: tabbarHeight);
        self.tabBar.isHidden = true;
        //3.使用得到的frame，和plist数据创建自定义标签栏
        let mainTabBarView = MainTabBarView(frame: tabBarRect);
        mainTabBarView.delegateTabbar = self
        self.view.addSubview(mainTabBarView)
    }
    
    func didChooseItem(itemIndex: Int) {
        if itemIndex == 1 {
            print("---------------")
        }
        else if itemIndex == 0 {
            self.selectedIndex = 0
        }
        else {
            self.selectedIndex = 1
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

