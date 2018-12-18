//
//  RUploadIDCardTableViewCell.swift
//  RFastLoan
//
//  Created by RPK on 2018/11/15.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit

class RUploadIDCardTableViewCell: UITableViewCell {
    
    let frontPhoto       = UIImageView()
    let reversePhoto     = UIImageView()
    let handHeldPhoto    = UIImageView()
    let frontPhotoTap    = UITapGestureRecognizer()
    let reversePhotoTap  = UITapGestureRecognizer()
    let handHeldPhotoTap = UITapGestureRecognizer()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        let label = UILabel()
        label.text = "上传身份证照片"
        label.textColor = UIColor.hexInt(0x333333)
        label.font = systemFont(14)
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(15)
            make.right.equalTo(-10)
            make.height.equalTo(18)
        }
        
        frontPhoto.image = R.image.实名认证上传身份证正面()
        frontPhoto.tag = 50
        frontPhoto.isUserInteractionEnabled = true
        frontPhoto.sizeToFit()
        frontPhoto.addGestureRecognizer(frontPhotoTap)
        addSubview(frontPhoto)
        frontPhoto.snp.makeConstraints { (make) in
            make.top.equalTo(label.snp.bottom).offset(15)
            make.right.equalTo(self.snp.centerX).offset(-20)
            make.size.equalTo(frontPhoto.mj_size)
        }
        
        reversePhoto.image = R.image.实名认证上传身份证反面()
        reversePhoto.tag = 51;
        reversePhoto.isUserInteractionEnabled = true
        reversePhoto.sizeToFit()
        reversePhoto.addGestureRecognizer(reversePhotoTap)
        addSubview(reversePhoto)
        reversePhoto.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.centerX).offset(20)
            make.centerY.equalTo(frontPhoto)
            make.size.equalTo(reversePhoto.mj_size)
        }
        
        let handHeldTips = UILabel()
        handHeldTips.textColor = hexColor333
        handHeldTips.text = "上传身份证照片"
        handHeldTips.font = systemFont(14)
        addSubview(handHeldTips)
        handHeldTips.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(frontPhoto.snp.bottom).offset(30)
            make.height.equalTo(18)
        }
        
        handHeldPhoto.image = R.image.实名认证手持身份证()
        handHeldPhoto.tag = 52;
        handHeldPhoto.isUserInteractionEnabled = true
        handHeldPhoto.sizeToFit()
        handHeldPhoto.addGestureRecognizer(handHeldPhotoTap)
        addSubview(handHeldPhoto)
        handHeldPhoto.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(handHeldTips.snp.bottom).offset(8)
            make.size.equalTo(handHeldPhoto.mj_size)
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
