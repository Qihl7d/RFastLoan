//
//  RSelectBulletBox.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/12.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import RxSwift

protocol RSelectBulletBoxDelegate {
    func selectBulletBox(bulletBox:RSelectBulletBox, didClickCancel indexPath:IndexPath)
    func selectBulletBox(bulletBox:RSelectBulletBox, didClickConfirm indexPath:IndexPath)
}

class RSelectBulletBox: UIView {
    
    let disposeBag = DisposeBag()
    let identifier = "identifier"
    let bgView = UIView()
    var delegate : RSelectBulletBoxDelegate?
    var indexPath : IndexPath?
    
    lazy var cancel: UIButton = {
        let cancel = UIButton()
        cancel.setTitle("取消", for: .normal)
        cancel.setTitleColor(hexColor333, for: .normal)
        cancel.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return cancel
    }()
    
    lazy var confirm: UIButton = {
        let confirm = UIButton()
        confirm.setTitle("确定", for: .normal)
        confirm.setTitleColor(hexColor333, for: .normal)
        confirm.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return confirm
    }()
    
    lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame: .zero, style: UITableView.Style.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: identifier)
        return tableView
    }()
    private var _dataSource = Array<String>()
    var dataSource : Array<String> {
        get {
            
            return _dataSource
        }
        set {
            _dataSource = newValue
            self.tableView.reloadData()
            let count = newValue.count >= 6 ? 6 : newValue.count;
            bgView.snp.updateConstraints { (make) in
                make.height.equalTo(CGFloat((count + 1) * 44) + kTabbarSafeBottomMargin)
            }
        }
    }
    
    var selecteValue : String = ""
    
    var returnString: String {
        get {
            return selecteValue
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
        eventBunding()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension RSelectBulletBox {
    func initView() {
        
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.4)
        let count = self.dataSource.count >= 6 ? 6 : self.dataSource.count;
        
        tableView.isScrollEnabled = self.dataSource.count > 6;
        
        bgView.backgroundColor = UIColor.white
        self.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(CGFloat((count + 1) * 44) + kTabbarSafeBottomMargin)
        }
        
        bgView.addSubview(cancel)
        cancel.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(0)
            make.height.equalTo(36)
        }
        
        bgView.addSubview(confirm)
        confirm.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.top.equalTo(0)
            make.height.equalTo(36)
        }
        
        let line = UIView()
        line.backgroundColor = UIColor.hexInt(0xEEEEEE)
        bgView.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(confirm.snp.bottom).offset(-1)
            make.height.equalTo(0.8)
        }
        
        bgView.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(cancel.snp.bottom)
            make.left.right.equalTo(0)
            make.bottom.equalTo(-kTabbarSafeBottomMargin)
        }
    }
    
    func eventBunding() {
        cancel.rx.tap
            .subscribe(onNext: { (_) in
                if (self.delegate != nil) {
                    self.delegate?.selectBulletBox(bulletBox: self, didClickCancel: self.indexPath!)
                }
            })
            .disposed(by: disposeBag)
        
        confirm.rx.tap
            .subscribe(onNext: { _ in
                if (self.delegate != nil) {
                    self.delegate?.selectBulletBox(bulletBox: self, didClickConfirm: self.indexPath!)
                }
            })
            .disposed(by: disposeBag)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}


extension RSelectBulletBox : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: identifier)
        }
        cell?.textLabel?.textAlignment = .center
        cell?.textLabel?.textColor = hexColor333
        cell?.textLabel?.text = dataSource[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selecteValue = self.dataSource[indexPath.row]
    }
}
