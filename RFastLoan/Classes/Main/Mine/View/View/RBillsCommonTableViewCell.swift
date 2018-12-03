//
//  RBillsCommonTableViewCell.swift
//  RFastLoan
//
//  Created by RPK on 2018/11/19.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit

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
            //            make.right.equalTo(self.snp.centerX).offset(-10)
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
        
        
        titleLabel.text = "房屋装修"
        priceLabel.text = "20000元"
        timeLabel.text  = "刚刚"
        nameLabel.text  = "海***月"
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
