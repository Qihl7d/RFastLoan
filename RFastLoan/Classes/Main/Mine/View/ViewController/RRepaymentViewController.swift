//
//  RRepaymentViewController.swift
//  RFastLoan
//
//  Created by RPK on 2018/11/19.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit

// 账单明细 -- 还款中
class RRepaymentViewController: RTableViewViewController {

    let identifier = "RBillsCommonTableViewCell"
    
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

extension RRepaymentViewController {
    private func initView() {
        
        tableView = UITableView.init(frame: CGRect.zero, style: UITableView.Style.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(0)
        }
        tableView.register(RBillsCommonTableViewCell.classForCoder(), forCellReuseIdentifier: identifier)
    }
    
    private func initData() {
        
    }
}

extension RRepaymentViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = RBillsCommonTableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: identifier)
        }
        return cell!
    }
    
    
}
