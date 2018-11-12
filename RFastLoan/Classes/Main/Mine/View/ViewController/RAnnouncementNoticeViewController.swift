//
//  RAnnouncementNoticeViewController.swift
//  RFastLoan
//
//  Created by RPK on 2018/11/11.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit

class RAnnouncementNoticeViewController: RTableViewViewController {

    let identifier = "RAnnouncementNoticeTableViewCell"
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

extension RAnnouncementNoticeViewController {
    func initView() {
        
        self.title = "通知公告"
        tableView.backgroundColor = RbackgroundColor
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.rowHeight  = 69
        tableView.tableFooterView = UIView()
        tableView.register(RAnnouncementNoticeTableViewCell.classForCoder(), forCellReuseIdentifier: identifier)
        // tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
}

extension RAnnouncementNoticeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = RAnnouncementNoticeTableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: identifier)
        }
        
        return cell!
    }
    
    
}


