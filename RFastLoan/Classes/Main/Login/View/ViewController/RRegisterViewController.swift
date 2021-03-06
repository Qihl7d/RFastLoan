//
//  RRegisterViewController.swift
//  RNessGoods
//
//  Created by RPK on 2018/10/26.
//  Copyright © 2018 RPK. All rights reserved.
//
import UIKit

import RxSwift

class RRegisterViewController: RBaseViewController {
    
    var phoneNumber        = UITextField()
    var verificationCode   = UITextField()
    var passwordInput      = UITextField()
    var registerProtocol   = UIButton()
    var registerBtn        = UIButton()
    var selecteProtocol    = UIButton()
    let sendVerificationCode = UIButton()
    let viewModel = RUserRegisterViewModel()
    // 发送验证码计时器
    var timer : Timer?
    // 倒计时时间
    var countdown = Variable(60)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initData()
        attachEvent()
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
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: R.image.通用返回箭头(), style: UIBarButtonItem.Style.plain, target: self, action: #selector(back))
        
        let logoImageView = UIImageView.init(image: R.image.登录页面logo())
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
        
        verificationCode.leftView            = leftView1
        verificationCode.leftViewMode        = .always
        verificationCode.rightView           = rightView
        verificationCode.rightViewMode       = .always
        verificationCode.backgroundColor     = UIColor.hexInt(0xF4F4F4)
        verificationCode.textColor           = hexColor666
        verificationCode.font                = systemFont(16)
//        verificationCode.isSecureTextEntry   = true
        verificationCode.layer.cornerRadius  = 2;
        verificationCode.layer.masksToBounds = true
        verificationCode.placeholder         = "请输入密码"
        view.addSubview(verificationCode)
        verificationCode.snp.makeConstraints { (make) in
            make.left.equalTo(25)
            make.right.equalTo(-25)
            make.height.equalTo(48)
            make.top.equalTo(phoneNumber.snp.bottom).offset(15)
        }
        
        let leftView2    = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 50, height: 48))
        let imageView2   = UIImageView()
        imageView2.image = R.image.登录密码()
        imageView2.sizeToFit()
        leftView2.addSubview(imageView2)
        imageView2.snp.makeConstraints { (make) in
            make.centerX.equalTo(leftView2)
            make.centerY.equalTo(leftView2)
            make.size.equalTo(imageView2.mj_size)
        }
        
        passwordInput.leftView            = leftView2
        passwordInput.leftViewMode        = .always
//        passwordInput.rightView           = rightView
//        passwordInput.rightViewMode       = .always
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
            make.top.equalTo(verificationCode.snp.bottom).offset(15)
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
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }

    func attachEvent() {
        sendVerificationCode.rx.tap
            .subscribe(onNext: { (_) in
                let phone = self.phoneNumber.text ?? ""
                if phone.count == 0 {
                    BAProgressHUD.ba_showWithStatus("请输入手机号")
                }
                else if RCommonFuncation.isTelNumber(num:phone as NSString) {
    //                self.timer?.fireDate = NSDate.distantPast
                    self.viewModel.sendVerificationCode(self.phoneNumber.text!)
                        .subscribe(onNext:{ (success, msg) in
                            if success {
                                BAProgressHUD.ba_showWithStatus("获取验证码成功")
                                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countdownCountDegressive), userInfo: nil, repeats: true )
                                self.timer?.fire()
                            }
                            else {
                                BAProgressHUD.ba_showError(withStatus: msg)
                            }
                        })
                        .disposed(by: self.disposeBag)
                }
                else {
                    BAProgressHUD.ba_showWithStatus("请输入手机号")
                }
            })
            .disposed(by: disposeBag)
        
        registerBtn.rx.tap
            .subscribe(onNext:{ _ in
                let str = self.phoneNumber.text ?? ""
                let verStr = self.verificationCode.text ?? ""
                let pswStr = self.passwordInput.text ?? ""
                if RCommonFuncation.isTelNumber(num: str as NSString) {
                    if verStr.count > 0 {
                        if pswStr.count > 0 {
//                            let viewModel = RLoginViewModel()
//                            viewModel.userRegister(userPhone: str, authCode: verStr, password: pswStr)
//                                .subscribe(onNext: { (httpResult) in
//                                    if httpResult.code == requestSuccess {
//                                        BAProgressHUD.ba_showWithStatus("注册成功")
//                                    }
//                                })
//                                .disposed(by: self.disposeBag)
                            let commonRequest = RCommonRequest()
                            commonRequest.userRegister(userPhone: str, authCode: verStr, password: pswStr, success: { (dic) in
                                if dic["code"] == "0" {
                                    self.navigationController?.popViewController(animated: true)
                                }
                            }, failture: { (error) in
                                
                            })
                        }
                        else {
                            BAProgressHUD.ba_showWithStatus("请输入密码")
                        }
                    }
                    else {
                        BAProgressHUD.ba_showWithStatus("请输入验证码")
                    }
                }
                else {
                    BAProgressHUD.ba_showWithStatus("请输入正确的手机号")
                }
            })
            .disposed(by: disposeBag)
    }
    
    //MARK: 倒计时数字递减
    @objc func countdownCountDegressive() {
        countdown.value = countdown.value - 1
        if countdown.value != 0 {
            sendVerificationCode.setTitle("\(countdown.value)秒后重试", for: UIControl.State.normal)
            sendVerificationCode.isEnabled = false
        }
        else if countdown.value == 0 || countdown.value < 0 {

            sendVerificationCode.setTitle("获取验证码", for: UIControl.State.normal)
            sendVerificationCode.isEnabled = true
            timer?.invalidate()
            timer = nil
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
