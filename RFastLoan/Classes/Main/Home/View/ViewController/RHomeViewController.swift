//
//  RHomeViewController.swift
//  RFastLoan
//
//  Created by RPK on 2018/11/1.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit

import SnapKit

class RHomeViewController: RBaseViewController {
    
    var tableView : UITableView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initData()
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

extension RHomeViewController {
    
    private func initView() {
        
        let homeHeaderView = RHomeHeaderView.init(frame: CGRect.zero)
        homeHeaderView.backgroundColor = .white
        
        tableView = UITableView.init(frame: CGRect.zero, style: UITableView.Style.plain)
        tableView?.delegate        = self
        tableView?.dataSource      = self
        tableView?.rowHeight       = 70
        tableView?.tableHeaderView = homeHeaderView
        view.addSubview(tableView!)
        tableView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0))
        })
    }
}

extension RHomeViewController {
    private func initData() {
        
    }
}

extension RHomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "")
        return cell!
    }
    
    
}
