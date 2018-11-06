//
//  RLoginViewController.swift
//  RNessGoods
//
//  Created by RPK on 2018/10/26.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit

class RLoginViewController: RBaseViewController {
    
    var phoneNumber   = UITextField()
    var passwordInput = UITextField()
    var registerBtn   = UIButton()
    var loginBtn      = UIButton()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
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

extension RLoginViewController {
    
    private func initView() {
        
        self.tabBarController?.tabBar.isHidden = true
        self.kNavigationColor = UIColor.white
        self.kTitleFontColor  = hexColor333
        self.title            = "登录"
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
        
        passwordInput.leftView            = leftView1
        passwordInput.leftViewMode        = .always
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
        
        loginBtn.setTitle("登录", for: UIControl.State.normal)
        loginBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        loginBtn.titleLabel?.font    = systemFont(16)
        loginBtn.backgroundColor     = themeColor
        loginBtn.layer.cornerRadius  = 2
        loginBtn.layer.masksToBounds = true
        view.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(passwordInput)
            make.top.equalTo(passwordInput.snp.bottom).offset(35)
        }
        
        let noAccount       = UILabel()
        noAccount.text      = "还没有账号吗？"
        noAccount.textColor = hexColor666
        noAccount.font      = systemFont(14)
        view.addSubview(noAccount)
        noAccount.snp.makeConstraints { (make) in
            make.left.equalTo(loginBtn)
            make.top.equalTo(loginBtn.snp.bottom).offset(15)
            make.width.equalTo(noAccount.rpk_textWith(height: 20))
            make.height.equalTo(20)
        }
        
        registerBtn.setTitle("注册", for: UIControl.State.normal)
        registerBtn.setTitleColor(themeColor, for: UIControl.State.normal)
        registerBtn.titleLabel?.font = systemFont(14)
        view.addSubview(registerBtn)
        registerBtn.snp.makeConstraints { (make) in
            make.left.equalTo(noAccount.snp.right)
            make.centerY.equalTo(noAccount)
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
    }
}




