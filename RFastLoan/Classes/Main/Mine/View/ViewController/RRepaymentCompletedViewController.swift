//
//  RRepaymentCompletedViewController.swift
//  RFastLoan
//
//  Created by RPK on 2018/11/19.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit

// 账单明细 -- 还款完成
class RRepaymentCompletedViewController: RTableViewViewController {

    let identifier = "RBillsCommonTableViewCell"
    var dataSource = Array<RBillingItem>()
    
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

extension RRepaymentCompletedViewController {
    private func initView() {
        
        tableView = UITableView.init(frame: CGRect.zero, style: UITableView.Style.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 70
        tableView.tableFooterView = UIView()
        tableView.register(RBillsCommonTableViewCell.classForCoder(), forCellReuseIdentifier: identifier)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(0)
        }
        tableView.register(RBillsCommonTableViewCell.classForCoder(), forCellReuseIdentifier: identifier)
    }
    
    private func initData() {
        let viewModel = RMineViewModel()
        viewModel.getBillingList(status: 3)
            .subscribe(onNext: { (list) in
                self.dataSource = list.toArray()
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

extension RRepaymentCompletedViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : RBillsCommonTableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier) as! RBillsCommonTableViewCell
//        if cell == nil {
//            cell = RBillsCommonTableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: identifier)
//        }
        cell.setDataModel(self.dataSource[indexPath.row])
        return cell
    }
    
    
}
