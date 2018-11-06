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
    let images : [UIImage] = [R.image.个人中心通知公告()!, R.image.个人中心个人信息()!, R.image.个人中心常见问题()!, R.image.个人中心设置()!]
    let titles = ["通知公告", "个人信息", "常见问题", "设置"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        // Do any additional setup after loading the view.
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let login = RRegisterViewController()//RLoginViewController()
        self.navigationController?.pushViewController(login, animated: true)
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
        
        let headerView = RMineHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 200 + 100 + 10))

        tableView.tableHeaderView = headerView
        tableView.rowHeight       = 50
        tableView.delegate        = self
        tableView.dataSource      = self
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.init(top: -kNavigationBarAndStatusHeight, left: 0, bottom: kTabbarHeight, right: 0))
        }
    }
}


extension RMineViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
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
            break;
        case 1:
            break
        case 2:
            break
        case 3:
            let setting = RSettingViewController()
            self.navigationController?.pushViewController(setting, animated: true)
            break
        default:
            break
        }
    }
}





