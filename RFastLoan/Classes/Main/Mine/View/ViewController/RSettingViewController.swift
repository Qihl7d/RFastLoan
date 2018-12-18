//
//  RSettingViewController.swift
//  RFastLoan
//
//  Created by RPK on 2018/11/7.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit

import RxSwift

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
        
        let bottomView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 140))
        bottomView.backgroundColor = RbackgroundColor
        let logout = UIButton.init(frame: CGRect.init(x: 0, y: 40, width: kScreenWidth, height: 50))
        logout.setTitle("退出登录", for: UIControl.State.normal)
        logout.setTitleColor(hexColor333, for: UIControl.State.normal)
        logout.backgroundColor  = .white
        logout.titleLabel?.font = systemFont(16)
        bottomView.addSubview(logout)
        
        tableView.backgroundColor = RbackgroundColor
        tableView.delegate        = self
        tableView.dataSource      = self
        tableView.rowHeight       = 50
        tableView.tableFooterView = bottomView
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0))
        }
        
        logout.rx.tap
            .subscribe(onNext: { [weak self] (_) in
                let alertController = UIAlertController.init(title: "退出登录提示", message: "您确定要退出登录吗？", preferredStyle: UIAlertController.Style.alert)
                let sure = UIAlertAction.init(title: "确定", style: UIAlertAction.Style.default, handler: { (_) in
                    let viewModel = RSettingViewModel()
                    viewModel.logout()
                        .subscribe(onNext: { (result) in
                            if result.code == 0 {
                                UserDefaults.standard.removeObject(forKey: "token")
                            }
                            self?.navigationController?.pushViewController(RLoginViewController(), animated: true)
                        })
                        .disposed(by: self!.disposeBag)
                })
                let cancel = UIAlertAction.init(title: "取消", style: UIAlertAction.Style.cancel, handler: nil)
                alertController.addAction(sure)
                alertController.addAction(cancel)
                self?.present(alertController, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    
    }
}

extension RSettingViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "kCellA")
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "kCellA")
            cell?.accessoryType    = .disclosureIndicator
        }
        cell?.textLabel?.text      = indexPath.row == 1 ? "清理缓存" : "修改登录密码"
        cell?.textLabel?.textColor = hexColor333
        cell?.textLabel?.font      = systemFont(16)
        if indexPath.row == 1 {
            // 缓存量
            let rightLabel = UILabel.init(frame: CGRect.init(x: kScreenWidth - 15, y: (50 - 25)/2.0, width: 60, height: 25))
            cell?.contentView.addSubview(rightLabel)
            
        }
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            let changePassword = RChangePasswordViewController()
            self.navigationController?.pushViewController(changePassword, animated: true)
        }
        else {
            let alertController = UIAlertController.init(title: "提示", message: "是否清理缓存？", preferredStyle: UIAlertController.Style.alert)
            let cancelAction = UIAlertAction.init(title: "取消", style: UIAlertAction.Style.cancel, handler: nil);
            // 清理缓存
            let confirmAction = UIAlertAction.init(title: "确认", style: UIAlertAction.Style.default) { (_) in
                
            }
            alertController.addAction(cancelAction)
            alertController.addAction(confirmAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
