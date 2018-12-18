//
//  RAuthTableViewCell.swift
//  RFastLoan
//
//  Created by RPK on 2018/11/14.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit

class RAuthTableViewCell: UITableViewCell, UITextFieldDelegate {
    public typealias TextFieldDidChangeBlock = (_ textField: UITextField) -> Void
    
    let titleLabel = UILabel()
    let textField = UITextField()
    let rightBtn  = UIButton()
    let verificationBtn = UIButton()
    var textFieldDidChangeBlock : TextFieldDidChangeBlock?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        separatorInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 0)
        
        titleLabel.textColor = hexColor333
        titleLabel.font = systemFont(14)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.centerY.equalTo(self)
            make.width.equalTo(60)
            make.height.equalTo(20)
        }
        
        verificationBtn.setTitle("发送验证码", for: UIControl.State.normal)
        verificationBtn.setTitleColor(themeColor, for: UIControl.State.normal)
        verificationBtn.titleLabel?.font = systemFont(14)
        verificationBtn.layer.cornerRadius = 2
        verificationBtn.layer.masksToBounds = true
        verificationBtn.layer.borderColor = themeColor.cgColor
        verificationBtn.layer.borderWidth = 1
        verificationBtn.isHidden = true
        addSubview(verificationBtn)
        verificationBtn.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.right).offset(10)
            make.centerY.equalTo(titleLabel)
            make.height.equalTo(28)
            make.width.equalTo(0)
        }
        
        rightBtn.frame = CGRect.init(x: 0, y: 0, width: 20, height: 30)
//        rightBtn.isUserInteractionEnabled = false
        rightBtn.setImage(R.image.通用右箭头(), for: UIControl.State.normal)
        
        textField.textColor = hexColor333
        textField.font = systemFont(14)
        textField.textAlignment = .right
//        textField.placeholder = "请输入"
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.left.equalTo(verificationBtn.snp.right).offset(10)
            make.centerY.equalTo(self)
            make.right.equalTo(-10)
            make.height.equalTo(30)
        }
        
    }
    
    func setTextFieldRightView(_ isSetting:Bool) {
        if isSetting {
            textField.placeholder = "请选择"
            textField.isEnabled = false
            textField.rightView = rightBtn
            textField.rightViewMode = .always
        }
        else {
            textField.rightView = nil
            textField.rightViewMode = .never
        }
    }
    
    func showVerificationBtn(_ isShow:Bool) {
        if isShow {
            verificationBtn.isHidden = false
            verificationBtn.snp.updateConstraints { (make) in
                make.width.equalTo(verificationBtn.titleLabel!.rpk_textWith() + 20)
            }
        }
        else {
            verificationBtn.isHidden = true
            verificationBtn.snp.updateConstraints { (make) in
                make.width.equalTo(0)
            }
        }
    }
    
    func setText(_ text:String) {
        if text == "详细地址" {
            textField.placeholder = "请输入您的详细地址"
        }
        titleLabel.text = text
        titleLabel.snp.updateConstraints({ (make) in
            make.width.equalTo(titleLabel.rpk_textWith() + 1)
        })
    }
    
    func setTextFieldTag(tag:NSInteger) {
        textField.tag = tag;
    }
    
    @objc func textFieldDidChange(_ textField:UITextField) {
        if textFieldDidChangeBlock != nil {
            textFieldDidChangeBlock!(textField)
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

class RSelectAuthTableViewCell: UITableViewCell {
    
    lazy var leftLabel: UILabel = {
        let leftLabel = UILabel()
        leftLabel.textColor = hexColor333
        leftLabel.font = systemFont(14)
        return leftLabel
    }()
    
    lazy var rightLabel: UILabel = {
        let rightLabel = UILabel()
        rightLabel.textColor = hexColor333
        rightLabel.font = systemFont(14)
        rightLabel.textAlignment = .right
        rightLabel.text = "请选择"
        return rightLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        addSubview(leftLabel)
        leftLabel.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.centerY.equalTo(self)
            make.width.equalTo(80)
            make.height.equalTo(20)
        }
        
        addSubview(rightLabel)
        rightLabel.snp.makeConstraints { (make) in
            make.left.equalTo(leftLabel.snp.right).offset(10)
            make.centerY.equalTo(self)
            make.right.equalTo(-10)
            make.height.equalTo(30)
        }
        
    }
    
    func setAccessoryType(_ showRightArrow : Bool) {
        if showRightArrow {
            self.accessoryType = .disclosureIndicator
            rightLabel.snp.updateConstraints { (make) in
                make.right.equalTo(-28)
            }
        }
        else {
            self.accessoryType = .none
            rightLabel.snp.updateConstraints { (make) in
                make.right.equalTo(-10)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


