//
//  RBaseViewController.swift
//  RFastLoan
//
//  Created by RPK on 2018/9/12.
//  Copyright © 2018年 RPK. All rights reserved.
//

import UIKit

class RBaseViewController: UIViewController, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationColor()
        navigationController?.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func needHiddenBarInViewController(_ viewController:UIViewController) -> Bool {
        return false
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if !viewController.isKind(of: RHomeViewController.classForCoder()) && !viewController.isKind(of: RMineViewController.classForCoder()) {
            let tabbarController = viewController.tabBarController
            for view in (tabbarController?.view.subviews)! {
                if view.isKind(of: MainTabBarView.classForCoder()) {
                    view.isHidden = true
                }
            }
        }
        else {
            let tabbarController = viewController.tabBarController
            for view in (tabbarController?.view.subviews)! {
                if view.isKind(of: MainTabBarView.classForCoder()) {
                    view.isHidden = false
                }
            }
        }
        viewController.tabBarController?.tabBar.isHidden = true
        navigationController.setNavigationBarHidden(needHiddenBarInViewController(viewController), animated: animated)
        viewController.setNavigationColor()
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
