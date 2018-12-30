//
//  RTableViewViewController.swift
//  RFastLoan
//
//  Created by RPK on 2018/9/14.
//  Copyright © 2018年 RPK. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxViewController
import MJRefresh
import RealmSwift


class RTableViewViewController: RBaseViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        return tableView
    }()
    
    var mjheader : MJRefreshNormalHeader?
    var mjfooter : MJRefreshAutoNormalFooter?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
