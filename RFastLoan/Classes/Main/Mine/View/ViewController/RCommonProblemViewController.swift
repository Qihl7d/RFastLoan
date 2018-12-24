//
//  RCommonProblemViewController.swift
//  RFastLoan
//
//  Created by RPK on 2018/11/11.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import MJRefresh

class RCommonProblemViewController: RTableViewViewController {

//    let titles : [String] = ["我的可贷额度和什么有关?", "实名认证提供材料信息", "如何还款", "预期带来的影响", "良好的信用带来的好处", "其他常见问题"]
    var dataSource : Array<RCommonProblem>!
    let pageSize = 20
    var pageIndex = 1
    
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

extension RCommonProblemViewController {
    func initView() {
        
        self.title = "常见问题"
        self.dataSource = Array()
        tableView.backgroundColor = RbackgroundColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
}

extension RCommonProblemViewController {
    func initData() {
        let viewModel = RMineViewModel()
        viewModel.getCommonProblem(code: "problem", page: self.pageIndex, pageSize: self.pageSize)
            .subscribe(onNext:{ list in
                self.dataSource = list.toArray()
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    private func loadMoreData() {
        let viewModel = RMineViewModel()
        tableView.mj_header = MJRefreshHeader.init(refreshingBlock: {
            self.pageIndex = 1
            viewModel.getCommonProblem(code: "problem", page: self.pageIndex, pageSize: self.pageSize)
                .subscribe(onNext: { (list) in
                    self.dataSource.removeAll()
                    self.dataSource = list.toArray()
                    self.tableView.reloadData()
                })
                .disposed(by: self.disposeBag)
        })
        
        tableView.mj_footer = MJRefreshAutoFooter.init(refreshingBlock: {
            self.pageIndex += 1;
            viewModel.getCommonProblem(code: "problem", page: self.pageIndex, pageSize: self.pageSize)
                .subscribe(onNext:{ list in
                    self.dataSource.append(contentsOf: list.toArray())
                    self.tableView.reloadData()
                })
                .disposed(by: self.disposeBag)
        })
    }
}

extension RCommonProblemViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "kCellA")
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "kCellA")
            cell?.accessoryType = .disclosureIndicator
        }
        cell?.selectionStyle  = .none
        cell?.textLabel?.text = dataSource[indexPath.row].content
        cell?.textLabel?.font = systemFont(14)
        cell?.textLabel?.textColor = hexColor333
        return cell!
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == dataSource.count - 1 {
            cell.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let model : RCommonProblem = self.dataSource[indexPath.row]
        let str = hostUrlStr + "loanManage/api/article/v1/getArticleDetailNews?id=" + model.id!
        let commonWebView = RCommonWebViewController.init(htmlName: str)
        commonWebView.title = model.title ?? ""
        self.navigationController?.pushViewController(commonWebView, animated: true)
    }
}
