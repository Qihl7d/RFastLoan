//
//  RLoanViewController.swift
//  RFastLoan
//
//  Created by RPK on 2018/11/11.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit

import Photos
import PhotosUI

class RLoanViewController: RBaseViewController {

    let scrollView   = UIScrollView()
    let contentView  = UIView()
    let topView      = UIView()
    let middleView   = UIView()
    let bottomView   = UIView()
    let protocolTips = UIButton()
    let loanRule     = UIButton()
    // 一行显示的图片张数
    let rowCount = 4
    
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

extension RLoanViewController {
    private func initView() {
        
        self.title = "借款"
        
        let cancelButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
        cancelButton.setTitle("取消", for: UIControl.State.normal)
        cancelButton.setTitleColor(.white, for: UIControl.State.normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        cancelButton.addTarget(self, action: #selector(cancelAction(_:)), for: UIControl.Event.touchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: cancelButton)
        
        let commitButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
        commitButton.setTitle("提交", for: UIControl.State.normal)
        commitButton.setTitleColor(.white, for: UIControl.State.normal)
        commitButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        commitButton.addTarget(self, action: #selector(commitAction(_:)), for: UIControl.Event.touchUpInside)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: commitButton)
        
        scrollView.backgroundColor = RbackgroundColor
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0))
        }
        
        contentView.backgroundColor = RbackgroundColor
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.greaterThanOrEqualTo(0)
        }
        
        topView.backgroundColor = .white
        contentView.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(0)
            make.height.equalTo(150)
        }
        
        let texts : [String] = ["用户姓名", "联系电话", "借款用途"]
        
        for i in 0 ..< 3 {
            let label = UILabel()
            label.textColor = hexColor333
            label.font = systemFont(16)
            label.text = texts[i]
            topView.addSubview(label)
            label.snp.makeConstraints { (make) in
                make.left.equalTo(10)
                make.top.equalTo(15 + i * 50)
                make.height.equalTo(20)
                make.width.equalTo(80)
            }
            
            let textField = UITextField()
            textField.textColor = hexColor999
            textField.font = systemFont(16)
            if i == 2 {
                let rightBut = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 50))
                rightBut.setImage(R.image.通用右箭头(), for: UIControl.State.normal)
                rightBut.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 5)
                textField.rightView = rightBut
                textField.rightViewMode = .always
            }
            topView.addSubview(textField)
            textField.snp.makeConstraints { (make) in
                make.right.equalTo(10)
                make.centerY.equalTo(label)
                make.left.equalTo(label.snp.right).offset(10)
                make.height.equalTo(label)
            }
            
            if i < 2 {
                let line = UIView()
                line.backgroundColor = lineColor
                topView.addSubview(line)
                line.snp.makeConstraints { (make) in
                    make.left.equalTo(10)
                    make.top.equalTo(50 + i * 50)
                    make.height.equalTo(0.6)
                    make.right.equalTo(0)
                }
            }
        }
        
        let height = (kScreenWidth - CGFloat((rowCount + 1) * 10))/CGFloat(rowCount);
        
        middleView.backgroundColor = .white
        contentView.addSubview(middleView)
        middleView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(topView.snp.bottom).offset(10)
            make.height.equalTo(46 + height)
        }
        
        let label = UILabel()
        label.text = "材料上传"
        label.textColor = hexColor999
        label.font = systemFont(16)
        middleView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(13)
            make.width.equalTo(80)
            make.height.equalTo(20)
        }
        
        let uploadBtn = UIButton()
        uploadBtn.setImage(R.image.我要借款添加图片加号(), for: UIControl.State.normal)
        middleView.addSubview(uploadBtn)
        uploadBtn.layer.borderColor   = UIColor.hexInt(0xCCCCCC).cgColor;
        uploadBtn.layer.borderWidth   = 1
        uploadBtn.layer.cornerRadius  = 2
        uploadBtn.layer.masksToBounds = true
        uploadBtn.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(label.snp.bottom).offset(8)
            make.width.height.equalTo(height)
        }
        

        bottomView.backgroundColor = .white
        contentView.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(middleView.snp.bottom).offset(10)
            make.height.equalTo(120)
        }
        
        let label1 = UILabel()
        label1.text = "借款描述"
        label1.textColor = hexColor999
        label1.font = systemFont(16)
        bottomView.addSubview(label1)
        label1.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(13)
            make.width.equalTo(80)
            make.height.equalTo(20)
        }
        
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.textColor = UIColor.hexInt(0xCCCCCC)
        textView.font = systemFont(16)
        textView.text = "请输入"
        bottomView.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.left.equalTo(label1)
            make.right.equalTo(-10)
            make.bottom.equalTo(-10)
            make.top.equalTo(label1.snp.bottom).offset(8)
        }
        

        protocolTips.setImage(R.image.我要借款未选择灰(), for: UIControl.State.normal)
        protocolTips.setImage(R.image.我要借款同意(), for: UIControl.State.selected)
        protocolTips.titleLabel?.font = systemFont(13)
        protocolTips.setTitle("我已仔细阅读", for: UIControl.State.normal)
        protocolTips.setTitleColor(hexColor999, for: UIControl.State.normal)
        protocolTips.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 5)
        protocolTips.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 5)
        protocolTips.contentHorizontalAlignment = .left
        contentView.addSubview(protocolTips)
        protocolTips.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(bottomView.snp.bottom).offset(14)
            make.height.equalTo(20)
            make.width.equalTo(110)
        }
        
        loanRule.setTitle("《借款规则》", for: UIControl.State.normal)
        loanRule.titleLabel?.font = systemFont(13)
        loanRule.setTitleColor(themeColor, for: UIControl.State.normal)
        contentView.addSubview(loanRule)
        loanRule.snp.makeConstraints { (make) in
            make.left.equalTo(protocolTips.snp.right)
            make.centerY.equalTo(protocolTips)
            make.height.equalTo(25)
            make.width.equalTo(80)
            make.bottom.equalTo(contentView.snp.bottom).offset(-20)
        }
        
    }
    
    @objc func cancelAction(_ sender:UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func commitAction(_ sender:UIBarButtonItem) {
        
    }
    
}
