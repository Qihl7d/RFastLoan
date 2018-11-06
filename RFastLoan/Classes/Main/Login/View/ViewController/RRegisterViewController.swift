//
//  RRegisterViewController.swift
//  RNessGoods
//
//  Created by RPK on 2018/10/26.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit

class RRegisterViewController: RBaseViewController {
    
    var phoneNumber        = UITextField()
    var passwordInput      = UITextField()
    var registerProtocol   = UIButton()
    var registerBtn        = UIButton()
    var selecteProtocol    = UIButton()
    
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

extension RRegisterViewController {
    private func initView() {
        
        self.tabBarController?.tabBar.isHidden = true
        self.kNavigationColor = UIColor.white
        self.kTitleFontColor  = hexColor333
        self.title            = "注册"
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        
        let logoImageView = UIImageView.init(image: UIImage())
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(31)
            make.size.equalTo(CGSize.init(width: 70, height: 70))
        }
        
        let leftView    = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 50, height: 48))
        let imageView   = UIImageView()
        imageView.image = R.image.注册手机号码()
        imageView.sizeToFit()
        leftView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(leftView)
            make.centerY.equalTo(leftView)
            make.size.equalTo(imageView.mj_size)
        }
        
        phoneNumber.leftView            = leftView
        phoneNumber.leftViewMode        = .always
        phoneNumber.backgroundColor     = UIColor.hexInt(0xF4F4F4)
        phoneNumber.textColor           = hexColor666
        phoneNumber.font                = systemFont(16)
        phoneNumber.layer.cornerRadius  = 2;
        phoneNumber.layer.masksToBounds = true
        phoneNumber.placeholder         = "请输入手机号"
        view.addSubview(phoneNumber)
        phoneNumber.snp.makeConstraints { (make) in
            make.left.equalTo(25)
            make.right.equalTo(-25)
            make.height.equalTo(48)
            make.top.equalTo(logoImageView.snp.bottom).offset(40)
        }
        
        let leftView1    = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 50, height: 48))
        let imageView1   = UIImageView()
        imageView1.image = R.image.登录密码()
        imageView1.sizeToFit()
        leftView1.addSubview(imageView1)
        imageView1.snp.makeConstraints { (make) in
            make.centerX.equalTo(leftView1)
            make.centerY.equalTo(leftView1)
            make.size.equalTo(imageView1.mj_size)
        }
        
        let rightView = UIView.init(frame: .init(x: 0, y: 0, width: 100, height: 48))
        let sendVerificationCode = UIButton()
        sendVerificationCode.setTitle("获取验证码", for: UIControl.State.normal)
        sendVerificationCode.setTitleColor(themeColor, for: UIControl.State.normal)
        sendVerificationCode.titleLabel?.font = systemFont(12)
        rightView.addSubview(sendVerificationCode)
        let width2 = sendVerificationCode.titleLabel?.rpk_textWith(height: 20) ?? 0 + 20
        rightView.mj_w = width2 + 40
        sendVerificationCode.layer.cornerRadius  = 2
        sendVerificationCode.layer.masksToBounds = true
        sendVerificationCode.layer.borderColor   = themeColor.cgColor
        sendVerificationCode.layer.borderWidth   = 1
        sendVerificationCode.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
        }
        
        passwordInput.leftView            = leftView1
        passwordInput.leftViewMode        = .always
        passwordInput.rightView           = rightView
        passwordInput.rightViewMode       = .always
        passwordInput.backgroundColor     = UIColor.hexInt(0xF4F4F4)
        passwordInput.textColor           = hexColor666
        passwordInput.font                = systemFont(16)
        passwordInput.isSecureTextEntry   = true
        passwordInput.layer.cornerRadius  = 2;
        passwordInput.layer.masksToBounds = true
        passwordInput.placeholder         = "请输入密码"
        view.addSubview(passwordInput)
        passwordInput.snp.makeConstraints { (make) in
            make.left.equalTo(25)
            make.right.equalTo(-25)
            make.height.equalTo(48)
            make.top.equalTo(phoneNumber.snp.bottom).offset(15)
        }
        
        selecteProtocol.setImage(R.image.注册同意(), for: UIControl.State.normal)
        selecteProtocol.setTitle("我已阅读并同意", for: UIControl.State.normal)
        selecteProtocol.setTitleColor(hexColor666, for: UIControl.State.normal)
        selecteProtocol.titleLabel?.font = systemFont(12)
        selecteProtocol.contentHorizontalAlignment = .left
        selecteProtocol.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 0)
        selecteProtocol.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 5)
        let width = selecteProtocol.titleLabel?.rpk_textWith(height: 20) ?? 0
        view.addSubview(selecteProtocol)
        selecteProtocol.snp.makeConstraints { (make) in
            make.left.equalTo(passwordInput)
            make.top.equalTo(passwordInput.snp.bottom).offset(15)
            make.width.equalTo(width + 20);
            make.height.equalTo(20)
        }
        
        registerProtocol.setTitle("《注册协议》", for: UIControl.State.normal)
        registerProtocol.setTitleColor(themeColor, for: UIControl.State.normal)
        registerProtocol.titleLabel?.font = systemFont(14)
        registerProtocol.contentHorizontalAlignment = .left
        let width1 = registerProtocol.titleLabel?.rpk_textWith(height: 20) ?? 0
        view.addSubview(registerProtocol)
        registerProtocol.snp.makeConstraints { (make) in
            make.left.equalTo(selecteProtocol.snp.right)
            make.centerY.equalTo(selecteProtocol)
            make.width.equalTo(width1 + 10)
            make.height.equalTo(30)
        }
        
        registerBtn.setTitle("注册", for: UIControl.State.normal)
        registerBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        registerBtn.titleLabel?.font    = systemFont(16)
        registerBtn.backgroundColor     = themeColor
        registerBtn.layer.cornerRadius  = 2
        registerBtn.layer.masksToBounds = true
        view.addSubview(registerBtn)
        registerBtn.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(passwordInput)
            make.top.equalTo(selecteProtocol.snp.bottom).offset(23)
        }
        
    }
}

extension RRegisterViewController {
    private func initData() {
        
    }
}




