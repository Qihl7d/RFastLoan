//
//  RMainTabBarViewController.swift
//  RFastLoan
//
//  Created by RPK on 2018/9/12.
//  Copyright © 2018年 RPK. All rights reserved.
//

import UIKit
import RxSwift

class RMainTabBarViewController: UITabBarController, MainTabBarDelegate {
    
    var mainTabBarView : MainTabBarView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBar.isHidden = true
    }
    
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
        self.tabBar.isHidden = true
        
        let tabBarRect = CGRect.init(x: 0, y: kScreenHeight - kTabbarHeight, width: kScreenWidth, height: kTabbarHeight);
        //3.使用得到的frame，和plist数据创建自定义标签栏
        mainTabBarView = MainTabBarView(frame: tabBarRect);
        mainTabBarView.delegateTabbar = self
        self.view.addSubview(mainTabBarView)
        
        self.rx.observe(Bool.self, "tabBar.isHidden")
            .subscribe(onNext:{ (isHidden) in
                self.mainTabBarView.isHidden = isHidden ?? false
            })
        .dispose()
        
        self.rx.observe(Bool.self, "tabBarController.tabBar.isHidden")
            .subscribe(onNext:{ (isHidden) in
                self.mainTabBarView.isHidden = isHidden ?? false
            })
            .dispose()
        
    }
    
    func didChooseItem(itemIndex: Int) {
        if itemIndex == 1 {
            let viewController = self.viewControllers![selectedIndex]
            let loanViewController = RLoanViewController()
            let loanViewControllerNav = RBaseNavViewController.init(rootViewController: loanViewController)
            viewController.present(loanViewControllerNav, animated: true, completion: nil)
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

