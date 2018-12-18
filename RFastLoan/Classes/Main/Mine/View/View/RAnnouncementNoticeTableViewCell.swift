//
//  RAnnouncementNoticeTableViewCell.swift
//  RFastLoan
//
//  Created by RPK on 2018/11/11.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit

class RAnnouncementNoticeTableViewCell: UITableViewCell {
    
    let dotView    = UIView()
    let titleLabel = UILabel()
    let timeLabel  = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initView()
    }
    
    private func initView() {
        
        dotView.backgroundColor     = UIColor.hexInt(0xEE4E23)
        dotView.layer.cornerRadius  = 5
        dotView.layer.masksToBounds = true
        addSubview(dotView)
        dotView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(20)
            make.width.height.equalTo(10)
        }
        
        titleLabel.textColor = hexColor333
        titleLabel.font      = systemFont(16)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(dotView.snp.right).offset(5)
            make.centerY.equalTo(dotView)
            make.right.equalTo(-10)
            make.height.equalTo(20)
        }
        
        timeLabel.textColor = hexColor999
        timeLabel.font      = systemFont(13)
        addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.right.equalTo(-10)
            make.height.equalTo(16)
        }
        
        separatorInset = UIEdgeInsets.init(top: 0, left: 25, bottom: 0, right: 0)
        
//        titleLabel.text = "您的10月份贷款即将到期，请准时还款"
//        timeLabel.text = "2019-07-31 22:08"
    }
    
    func settingData(_ data:RAnnouncement) {
        titleLabel.text = data.content
        timeLabel.text = data.updateDate
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
