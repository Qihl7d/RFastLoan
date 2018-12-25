//
//  RAnnouncementNoticeViewController.swift
//  RFastLoan
//
//  Created by RPK on 2018/11/11.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import MJRefresh

class RAnnouncementNoticeViewController: RTableViewViewController {

    let identifier = "RAnnouncementNoticeTableViewCell"
    var dataSource : Array<RAnnouncement>!
    let pageSize = 20
    var pageIndex = 1
    let readBtn = UIButton()
    let unreadBtn = UIButton()
    var index = 0;
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData(index)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
//        loadData(0)
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

extension RAnnouncementNoticeViewController {
    func initView() {
        
        self.title = "通知公告"
        
        readBtn.setTitle("未读", for: .normal)
        readBtn.setTitleColor(themeColor, for: UIControl.State.normal)
        readBtn.titleLabel?.font = systemFont(15);
        readBtn.backgroundColor = UIColor.white
        view.addSubview(readBtn)
        readBtn.snp.makeConstraints { (make) in
            make.left.top.equalTo(0)
            make.right.equalTo(view.snp.centerX)
            make.height.equalTo(40)
        }
        
        let line1 = UIView()
        line1.backgroundColor = themeColor
        readBtn.addSubview(line1)
        line1.bringSubviewToFront(readBtn)
        line1.snp.makeConstraints { (make) in
            make.centerX.equalTo(readBtn)
            make.bottom.equalTo(0)
            make.width.equalTo(50)
            make.height.equalTo(2)
        }
        
        unreadBtn.setTitle("已读", for: .normal)
        unreadBtn.setTitleColor(hexColor666, for: .normal)
        unreadBtn.titleLabel?.font = systemFont(15)
        unreadBtn.backgroundColor = UIColor.white
        view.addSubview(unreadBtn)
        unreadBtn.snp.makeConstraints { (make) in
            make.top.right.equalTo(0)
            make.left.equalTo(view.snp.centerX)
            make.height.equalTo(40)
        }
        
        
        let line2 = UIView()
        line2.backgroundColor = UIColor.white
        unreadBtn.addSubview(line2)
        line2.bringSubviewToFront(unreadBtn)
        line2.snp.makeConstraints { (make) in
            make.centerX.equalTo(unreadBtn)
            make.bottom.equalTo(0)
            make.width.equalTo(50)
            make.height.equalTo(2)
        }
        
        unreadBtn.rx.tap
            .subscribe(onNext: { (_) in
                self.unreadBtn.setTitleColor(themeColor, for: UIControl.State.normal)
                line2.backgroundColor = themeColor
                self.readBtn.setTitleColor(hexColor666, for: UIControl.State.normal)
                line1.backgroundColor = UIColor.white
                self.index = 1
                self.loadData(1)
            })
            .disposed(by: disposeBag)
        
        readBtn.rx.tap
            .subscribe(onNext: { (_) in
                self.unreadBtn.setTitleColor(hexColor666, for: UIControl.State.normal)
                line2.backgroundColor = UIColor.white
                self.readBtn.setTitleColor(themeColor, for: UIControl.State.normal)
                line1.backgroundColor = themeColor
                self.index = 0
                self.loadData(0)
            })
            .disposed(by: disposeBag)
        
        self.dataSource = Array()
        tableView.backgroundColor = RbackgroundColor
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.rowHeight  = 69
        tableView.tableFooterView = UIView()
        tableView.register(RAnnouncementNoticeTableViewCell.classForCoder(), forCellReuseIdentifier: identifier)
        // tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.init(top: 40, left: 0, bottom: 0, right: 0))
        }
    }
}

extension RAnnouncementNoticeViewController {
    func loadData(_ readeStatus:Int) {
        
        let viewModel = RMineViewModel()
        viewModel.getAnnouncement(code: "notice", readeStatus: readeStatus)
            .subscribe(onNext:{ list in
                self.dataSource = list.toArray()
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
}

extension RAnnouncementNoticeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! RAnnouncementNoticeTableViewCell
        cell.selectionStyle = .none
//        if cell == nil {
//            cell = RAnnouncementNoticeTableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: identifier)
//        }
        cell.settingData(self.dataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model : RAnnouncement = self.dataSource[indexPath.row]
        let str = hostUrlStr + "loanManage/api/article/v1/getNoticeDetail?id=" + model.id! + "&token=" + RAccessToken.userAccessToken()
        let commonWebView = RCommonWebViewController.init(htmlName: str)
        commonWebView.title = model.title ?? ""
        self.navigationController?.pushViewController(commonWebView, animated: true)
    }
}


