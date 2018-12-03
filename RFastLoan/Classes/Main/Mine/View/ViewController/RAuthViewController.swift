//
//  RAuthViewController.swift
//  RFastLoan
//
//  Created by RPK on 2018/11/14.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit

class RAuthViewController: RTableViewViewController {

    let dataSource : [[String]] = [
        ["用户姓名", "联系电话", "短信验证码", "身份证号", "教育水平", "婚姻状态", "职业职位", "工作年限", "QQ号码", "微信号码", "现居地址", "详细地址"],
        ["联系人姓名", "联系电话", "与本人关系"],
        [""]]
    
    let sectionHeaderTitle : [String] = ["个人基本信息", "紧急联系人", "场景认证"]
    let commonIdentifier = "RAuthTableViewCell"
    let uploadPhotoIdentifier = "RUploadIDCardTableViewCell"
    
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

extension RAuthViewController {
    
    private func initView() {
        self.title = "实名认证"
        let commitBtn = UIButton()
        commitBtn.setTitle("提交", for: UIControl.State.normal)
        commitBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        commitBtn.titleLabel?.font = systemFont(16)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: commitBtn)
        
        commitBtn.rx.tap
            .subscribe(onNext: { (_) in
            
            })
            .disposed(by: disposeBag)
        
        tableView = UITableView.init(frame: CGRect.zero, style: UITableView.Style.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.sectionHeaderHeight = 40
        tableView.sectionFooterHeight = 0
        tableView.register(RAuthTableViewCell.classForCoder(), forCellReuseIdentifier: commonIdentifier)
        tableView.register(RUploadIDCardTableViewCell.classForCoder(), forCellReuseIdentifier: uploadPhotoIdentifier)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0))
        }
        
    }
}

extension RAuthViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section != 2 {
            return 50
        }
        else {
            return 280
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: .init(x: 0, y: 0, width: kScreenWidth, height: 40))
        headerView.backgroundColor = RbackgroundColor
        
        let label = UILabel()
        label.textColor = hexColor999
        label.font = systemFont(14)
        label.text = sectionHeaderTitle[section]
        headerView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.centerY.equalTo(headerView)
            make.width.equalTo(kScreenWidth - 20)
            make.height.equalTo(20)
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section != 2 {
            let cell : RAuthTableViewCell = tableView.dequeueReusableCell(withIdentifier: commonIdentifier, for: indexPath) as! RAuthTableViewCell
            let string = dataSource[indexPath.section][indexPath.row]
            let showRightView = ((indexPath.row == 4 || indexPath.row == 5 || indexPath.row == 7 || indexPath.row == 10) && indexPath.section == 0) || ((indexPath.row == 2) && indexPath.section == 1)
            cell.setText(string)
            cell.setTextFieldRightView(showRightView)
            cell.showVerificationBtn(string == "短信验证码")
            // 弹出选择框
            cell.rightBtn.rx.tap
                .subscribe(onNext: { (_) in
                    
                })
                .disposed(by: disposeBag)
            return cell
        }
        else {
            let cell : RUploadIDCardTableViewCell = tableView.dequeueReusableCell(withIdentifier: uploadPhotoIdentifier) as! RUploadIDCardTableViewCell
            // 正面照
            cell.frontPhotoTap.rx.event
                .subscribe(onNext: { (_) in
                
                })
                .disposed(by: disposeBag)
            // 反面照
            cell.reversePhotoTap.rx.event
                .subscribe(onNext: { (_) in
                    
                })
                .disposed(by: disposeBag)
            // 手持照
            cell.handHeldPhotoTap.rx.event
                .subscribe(onNext: { (_) in
                    
                })
                .disposed(by: disposeBag)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
