//
//  RPopListView.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/9.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit

protocol RPopListViewDelegate {
    func closeWindow()
    func selected(loanType:RLoanType)
}

class RPopListView: UIView, UITableViewDelegate, UITableViewDataSource {

    public let tableView = UITableView()
    public var dataSource = Array<RLoanType>()
    public var delegate : RPopListViewDelegate?
    override init(frame: CGRect) {
        
        super.init(frame: frame)
//        if #available(iOS 10.0, *) {
//            self.backgroundColor = UIColor.init(displayP3Red: 0, green: 0, blue: 0, alpha: 0.4)
//        } else {
            self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.4)
            // Fallback on earlier versions
//        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.layer.cornerRadius = 4
        tableView.layer.masksToBounds = true
        self.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(300)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "kCellA")
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier:"kCellA")
        }
        cell?.textLabel?.text = self.dataSource[indexPath.row].name
        cell?.textLabel?.font = UIFont.sysFont15()
        cell?.textLabel?.textColor = UIColor.hexInt(0x666666)
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.delegate != nil {
            self.delegate?.selected(loanType: self.dataSource[indexPath.row])
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.delegate != nil  {
            self.delegate?.closeWindow()
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
