//
//  RBillsCommonTableViewCell.swift
//  RFastLoan
//
//  Created by RPK on 2018/11/19.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import Foundation

class RBillsCommonTableViewCell: UITableViewCell {

    var titleLabel = UILabel()
    var timeLabel  = UILabel()
    var nameLabel  = UILabel()
    var priceLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initView()
    }
    
    private func initView() {
        
        priceLabel.textColor = hexColor333
        priceLabel.font      = systemFont(18)
        addSubview(priceLabel)
        priceLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.centerY.equalTo(self)
            make.height.equalTo(20)
            make.width.equalTo(0)
        }
        
        titleLabel.textColor = hexColor333
        titleLabel.font = systemFont(16)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(13)
            make.right.equalTo(self.snp.centerX).offset(-10)
            make.height.equalTo(20);
        }
        
        timeLabel.textColor = hexColor999
        timeLabel.font = systemFont(13)
        addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.bottom.equalTo(-13)
            make.right.equalTo(self.snp.centerX).offset(-10)
        }
        
        nameLabel.textColor = hexColor333
        nameLabel.font = systemFont(16)
        nameLabel.textAlignment = .center
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
    }
    
    public func setDataModel(_ model:RBillingItem) {
        titleLabel.text = model.loanPurpose
        // 账单记录
        // 2-还款中；3-还款完成；4-逾期；
        var str = ""
        var color = UIColor()
//        if model.status == "0" {
//            str = "待审核"
//            color = UIColor.init(red: 216.0/255.0, green: 101.0/255.0, blue: 21.0/255.0, alpha: 1)
//        }
//        else if model.status == "1" {
//            str = "审核通过"
//            color = UIColor.init(red: 24.0/255.0, green: 191.0/255.0, blue: 110.0/255.0, alpha: 1)
//        }
//        else
        if model.status == "2" {
            str = "还款中"
            color = UIColor.init(red: 236.0/255.0, green: 0.0, blue: 27.0/255.0, alpha: 1)
        }
        else if model.status == "3"{
            str = "打款完成"
            color = UIColor.init(red: 117.0/255.0, green: 117.0/255.0, blue: 117.0/255.0, alpha: 1)
        }
        else if (model.status == "4") {
            str = "逾期"
            color = UIColor.init(red: 236.0/255.0, green: 0.0, blue: 27.0/255.0, alpha: 1)
        }
        priceLabel.text = str
        priceLabel.textColor = color
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-DD HH:mm:ss"
        let currentTime = dateFormatter.string(from: Date())
        let time = SystemPublic.publicManage()?.timeInterval(fromLastTime: model.updateDate, lastTimeFormat: "yyyy-MM-DD HH:mm:ss", toCurrentTime: currentTime, currentTimeFormat: "yyyy-MM-DD HH:mm:ss")
        
        timeLabel.text  = time
        nameLabel.text  = model.cost! + "元"
        priceLabel.snp.updateConstraints { (make) in
            make.width.equalTo(priceLabel.rpk_textWith(height: 20))
        }
    }
    
    func setModel(_ model:RLoanItem) {
        titleLabel.text = model.loanPurpose
        // 申请记录
        var str = ""
        var color = UIColor()
        // 申请记录的状态值：0-待审核；1-审批通过；2-审批未过;3-打款完成
        if model.status == "0" {
            str = "待审核"
            color = UIColor.init(red: 216.0/255.0, green: 101.0/255.0, blue: 21.0/255.0, alpha: 1)
        }
        else if model.status == "1" {
            str = "审核通过"
            color = UIColor.init(red: 24.0/255.0, green: 191.0/255.0, blue: 110.0/255.0, alpha: 1)
        }
        else if model.status == "2" {
            str = "审核未过"
            color = UIColor.init(red: 236.0/255.0, green: 0.0, blue: 27.0/255.0, alpha: 1)
        }
        else {
            str = "打款完成"
            color = UIColor.init(red: 117.0/255.0, green: 117.0/255.0, blue: 117.0/255.0, alpha: 1)
        }
        priceLabel.text = str
        priceLabel.textColor = color
        timeLabel.text  = model.updateDate
        nameLabel.text  = model.cost! + "元"
        
        priceLabel.snp.updateConstraints { (make) in
            make.width.equalTo(priceLabel.rpk_textWith(height: 20))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
