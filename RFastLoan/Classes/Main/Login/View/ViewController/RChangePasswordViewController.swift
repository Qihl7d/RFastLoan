//
//  RChangePasswordViewController.swift
//  RFastLoan
//
//  Created by RPK on 2018/11/11.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit

class RChangePasswordViewController: RBaseViewController {

    let leftLabel   = UILabel()
    let middleLabel = UILabel()
    let rightLabel  = UILabel()
    let leftArrow   = UIImageView()
    let rightArrow  = UIImageView()
    
    let scrollView  = UIScrollView()
    let contentView = UIView()
    
    let authView = UIView()
    let smsView  = UIView()
    let successView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        authenticationView()
        smsVerification()
        successfulView()
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

extension RChangePasswordViewController {
    
    private func initView() {
        
        self.title = "修改登录密码"
        middleLabel.text = "短信验证"
        middleLabel.textColor = hexColor999
        middleLabel.textAlignment = .center
        middleLabel.font = systemFont(16)
        view.addSubview(middleLabel)
        middleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(18)
            make.width.equalTo(middleLabel.rpk_textWith() + 10)
            make.height.equalTo(20)
        }
        
        leftArrow.image = R.image.通用右箭头()
        leftArrow.sizeToFit()
        view.addSubview(leftArrow)
        leftArrow.snp.makeConstraints { (make) in
            make.right.equalTo(middleLabel.snp.left).offset(-5)
            make.centerY.equalTo(middleLabel)
            make.size.equalTo(leftArrow.mj_size)
        }
        
        rightArrow.image = R.image.通用右箭头()
        rightArrow.sizeToFit()
        view.addSubview(rightArrow)
        rightArrow.snp.makeConstraints { (make) in
            make.left.equalTo(middleLabel.snp.right).offset(5)
            make.centerY.equalTo(middleLabel)
            make.size.equalTo(rightArrow.mj_size)
        }
        
        leftLabel.textColor = themeColor
        leftLabel.text = "身份证验证"
        leftLabel.textAlignment = .center
        leftLabel.font = systemFont(16)
        view.addSubview(leftLabel)
        leftLabel.snp.makeConstraints { (make) in
            make.right.equalTo(leftArrow.snp.left).offset(-5)
            make.centerY.equalTo(leftArrow)
            make.width.equalTo(leftLabel.rpk_textWith() + 10)
            make.height.equalTo(20)
        }
        
        rightLabel.textColor = hexColor999
        rightLabel.text = "修改成功"
        rightLabel.textAlignment = .center
        rightLabel.font = systemFont(16)
        view.addSubview(rightLabel)
        rightLabel.snp.makeConstraints { (make) in
            make.left.equalTo(rightArrow.snp.right).offset(5)
            make.centerY.equalTo(rightArrow)
            make.width.equalTo(rightLabel.rpk_textWith() + 10)
            make.height.equalTo(20)
        }
        
        scrollView.backgroundColor = UIColor.white
        view.addSubview(scrollView)
        scrollView.isScrollEnabled = false
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.init(top: 42, left: 0, bottom: 0, right: 0))
        }
        
        contentView.backgroundColor = .white
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(scrollView)
            make.height.equalTo(scrollView)
            make.width.equalTo(3 * kScreenWidth)
        }
    }
    
    // 身份验证页面
    private func authenticationView() {
        
        scrollView.addSubview(authView)
        authView.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(0)
            make.width.equalTo(kScreenWidth)
        }
        
        let IDCardTextField = RTextField()
        IDCardTextField.textColor = hexColor666
        IDCardTextField.font = systemFont(16)
        IDCardTextField.layer.cornerRadius = 2
        IDCardTextField.layer.masksToBounds = true
        IDCardTextField.layer.borderColor = UIColor.hexInt(0xCCCCCC).cgColor
        IDCardTextField.layer.borderWidth = 1
        IDCardTextField.placeholder = "请输入身份证号码"
        authView.addSubview(IDCardTextField)
        IDCardTextField.snp.makeConstraints { (make) in
            make.left.equalTo(25)
            make.right.equalTo(-25)
            make.height.equalTo(48)
            make.top.equalTo(18)
        }
        
        let phoneNumber = RTextField()
        phoneNumber.textColor = hexColor666
        phoneNumber.font = systemFont(16)
        phoneNumber.layer.cornerRadius = 2
        phoneNumber.layer.masksToBounds = true
        phoneNumber.layer.borderColor = UIColor.hexInt(0xCCCCCC).cgColor
        phoneNumber.layer.borderWidth = 1
        phoneNumber.placeholder = "请输入身份证号码"
        authView.addSubview(phoneNumber)
        phoneNumber.snp.makeConstraints { (make) in
            make.left.equalTo(25)
            make.right.equalTo(-25)
            make.height.equalTo(48)
            make.top.equalTo(IDCardTextField.snp.bottom).offset(10)
        }
        
        let nextButton = UIButton()
        nextButton.setTitle("下一步", for: UIControl.State.normal)
        nextButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        nextButton.backgroundColor = themeColor
        nextButton.layer.cornerRadius = 2
        nextButton.layer.masksToBounds = true
        nextButton.titleLabel?.font = systemFont(16)
        authView.addSubview(nextButton)
        nextButton.snp.makeConstraints { (make) in
            make.right.left.height.equalTo(phoneNumber)
            make.top.equalTo(phoneNumber.snp.bottom).offset(40)
        }
        nextButton.rx.tap
            .subscribe(onNext: { [weak self] (_) in
//                if IDCardTextField.text?.count ?? 0 > 0 && phoneNumber.text?.count ?? 0 > 0 {
                    self?.middleLabel.textColor = themeColor
                    self?.leftArrow.image = R.image.blueRightArrow()
                    self?.scrollView.contentOffset = CGPoint.init(x: kScreenWidth, y: 0)
//                }
            })
            .disposed(by: disposeBag)
        
    }
    
    // 短信验证
    private func smsVerification() {
        scrollView.addSubview(smsView)
        smsView.snp.makeConstraints { (make) in
            make.left.equalTo(authView.snp.right)
            make.top.bottom.equalTo(authView)
            make.width.equalTo(kScreenWidth)
        }
        
        let placeholders : [String] = ["请输入手机号", "请输入验证码", "请输入新密码", "请确认新密码"]
        let verification = UIButton()
        verification.setTitle("获取验证码", for: UIControl.State.normal)
        verification.setTitleColor(themeColor, for: UIControl.State.normal)
        verification.titleLabel?.font = systemFont(16)
        verification.layer.cornerRadius = 2
        verification.layer.masksToBounds = true
        verification.layer.borderColor = themeColor.cgColor
        verification.layer.borderWidth = 1
        view.addSubview(verification)
        
        var lastTextField : RTextField!
        
        for i in 0 ..< 4 {
            let textField = RTextField()
            textField.textColor = hexColor666
            textField.font = systemFont(16)
            textField.layer.cornerRadius = 2
            textField.layer.masksToBounds = true
            textField.layer.borderColor = UIColor.hexInt(0xCCCCCC).cgColor
            textField.layer.borderWidth = 1
            textField.placeholder = placeholders[i]
            smsView.addSubview(textField)
            textField.snp.makeConstraints { (make) in
                make.left.equalTo(25)
                make.right.equalTo(i == 1 ? -25 - 10 - 120 : -25)
                make.top.equalTo(18 + i * (48 + 10))
                make.height.equalTo(48)
            }
            
            if i == 1 {
                verification.snp.makeConstraints { (make) in
                    make.left.equalTo(textField.snp.right).offset(10)
                    make.top.height.equalTo(textField)
                    make.right.equalTo(-25)
                }
            }
            lastTextField = textField
        }
        
        let commitButton = UIButton()
        commitButton.setTitle("确认提交", for: UIControl.State.normal)
        commitButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        commitButton.backgroundColor = themeColor
        commitButton.layer.cornerRadius = 2
        commitButton.layer.masksToBounds = true
        commitButton.titleLabel?.font = systemFont(16)
        authView.addSubview(commitButton)
        commitButton.snp.makeConstraints { (make) in
            make.right.left.height.equalTo(lastTextField)
            make.top.equalTo(lastTextField.snp.bottom).offset(40)
        }
        
        commitButton.rx.tap
            .subscribe(onNext: { (_) in //[weak self]
                //                if IDCardTextField.text?.count ?? 0 > 0 && phoneNumber.text?.count ?? 0 > 0 {
                self.rightLabel.textColor = themeColor
                self.rightArrow.image = R.image.blueRightArrow()
                self.scrollView.contentOffset = CGPoint.init(x: 2 * kScreenWidth, y: 0)
                //                }
            })
            .disposed(by: disposeBag)
    }
    
    // 成功页面
    private func successfulView() {
        scrollView.addSubview(successView)
        successView.snp.makeConstraints { (make) in
            make.left.equalTo(smsView.snp.right)
            make.top.bottom.width.equalTo(smsView)
        }
        
        let imageView = UIImageView.init(image: R.image.形状1())
        imageView.sizeToFit()
        successView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(successView)
            make.top.equalTo(90)
            make.size.equalTo(imageView.mj_size)
        }
        
        let successTips = UILabel()
        successTips.textColor = themeColor
        successTips.font = systemFont(14)
        successTips.text = "密码修改成功"
        successTips.textAlignment = .center
        successView.addSubview(successTips)
        successTips.snp.makeConstraints { (make) in
            make.centerY.equalTo(imageView)
            make.top.equalTo(imageView.snp.bottom).offset(15)
            make.width.equalTo(kScreenWidth - 40)
            make.height.equalTo(20)
        }
        
        let finishedButton = UIButton()
        finishedButton.setTitle("完成", for: UIControl.State.normal)
        finishedButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        finishedButton.backgroundColor = themeColor
        finishedButton.layer.cornerRadius = 2
        finishedButton.layer.masksToBounds = true
        finishedButton.titleLabel?.font = systemFont(16)
        successView.addSubview(finishedButton)
        finishedButton.snp.makeConstraints { (make) in
            make.left.equalTo(25)
            make.right.equalTo(-25)
            make.top.equalTo(successTips.snp.bottom).offset(115)
            make.height.equalTo(48)
        }
        
        finishedButton.rx.tap
            .subscribe(onNext: { [weak self] (_) in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
}

