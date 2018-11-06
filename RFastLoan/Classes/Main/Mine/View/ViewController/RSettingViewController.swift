//
//  RSettingViewController.swift
//  RFastLoan
//
//  Created by RPK on 2018/11/7.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit

class RSettingViewController: RTableViewViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RSettingViewController {
    func initView() {
        self.title = "设置"
        
    }
}
