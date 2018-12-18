//
//  RMineViewController.swift
//  RNessGoods
//
//  Created by RPK on 2018/10/26.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit

class RMineViewController: RBaseViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView = UITableView.init(frame: .zero, style: UITableView.Style.plain)
    let images : [UIImage] = [R.image.个人中心通知公告()!, R.image.个人中心个人信息()!, R.image.个人中心常见问题()!, R.image.个人中心设置()!, R.image.个人中心检查更新()!, R.image.个人中心联系我们()!]
    let titles = ["通知公告", "个人信息", "常见问题", "设置", "检查更新", "关于我们"]
    let headerView = RMineHeaderView()
    var userInfo : RMemberInfo!
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

extension RMineViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.kNavigationColor = UIColor.clear
        self.kTitleFontColor  = hexColor333
    }
    private func initView() {
        
        self.title = "个人中心"
        self.kNavigationColor = UIColor.clear
        self.kTitleFontColor  = hexColor333
        view.backgroundColor  = RbackgroundColor
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
//        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
//        self.extendedLayoutIncludesOpaqueBars = false
//        self.modalPresentationCapturesStatusBarAppearance = false
//        self.automaticallyAdjustsScrollViewInsets = false
        
        headerView.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 200 + 100 + 10 + kStatusBarHeight)
        
    
        headerView.clickButtonAction = { [weak self] (button) in
            if button.titleLabel.text == "实名认证" {
                let viewController = RAuthViewController()
                self?.navigationController?.pushViewController(viewController, animated: true)
            }
            else if (button.titleLabel.text == "账单明细") {
                let billingDetails = RBillingDetailsViewController()
                self?.navigationController?.pushViewController(billingDetails, animated: true)
            }
            else {
                let loanApplication = RLoanApplicationViewController()
                self?.navigationController?.pushViewController(loanApplication, animated: true)
            }
        }

        tableView.tableHeaderView = headerView
        tableView.rowHeight       = 50
        tableView.delegate        = self
        tableView.dataSource      = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = RbackgroundColor
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.init(top: -kNavigationBarAndStatusHeight, left: 0, bottom: -kTabbarHeight, right: 0))
        }
    }
}

extension RMineViewController {
    func initData() {
        let viewModel = RMineViewModel()
        viewModel.getUserInfo()
            .subscribe(onNext:{ (info) in
                self.userInfo = info
                if ((info.credit?.count) != nil) {
                    self.headerView.balanceLabel.text = info.credit
                }
                else {
                    self.headerView.balanceLabel.text = "0"
                }
            })
            .disposed(by: disposeBag)
    }
}


extension RMineViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView.contentOffset.y < 0 {
//            scrollView.contentOffset = CGPoint.init(x: 0, y: 0)
//        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "RCellA"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: identifier)
            cell?.accessoryType = .disclosureIndicator
        }
        
        cell?.imageView?.image     = images[indexPath.row]
        cell?.textLabel?.text      = titles[indexPath.row]
        cell?.textLabel?.font      = systemFont(16)
        cell?.textLabel?.textColor = hexColor333
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.init(top: tableView.rowHeight - 0.4, left: 10, bottom: 0, right: 0)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            let announcementNotice = RAnnouncementNoticeViewController()
            self.navigationController?.pushViewController(announcementNotice, animated: true)
            break;
        case 1:
            let login = RAuthViewController()//RRegisterViewController()//RLoginViewController()
            login.checkInfo = true
            login.oldUserInfo = userInfo
            self.navigationController?.pushViewController(login, animated: true)
            break
        case 2:
            let commonProblem = RCommonProblemViewController()
            self.navigationController?.pushViewController(commonProblem, animated: true)
            break
        case 3:
            let setting = RSettingViewController()
            self.navigationController?.pushViewController(setting, animated: true)
            break
        case 4:
            let about = RAboutUsViewController()
            self.navigationController?.pushViewController(about, animated: true)
        default:
            break
        }
    }
}






