//
//  RLoanApplicationViewController.swift
//  RFastLoan
//
//  Created by RPK on 2018/11/19.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit

// 借款申请记录
class RLoanApplicationViewController: RBaseViewController {
    
    let line = UIView()
    var leftButton   : UIButton!
    var middleButton : UIButton!
    var rightButton  : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        eventBinding()
    }
    
}

extension RLoanApplicationViewController {
    private func initView() {
        self.title = "借款申请记录"
        let items = ["全部", "申请通过", "审核未过"]
        let itemWidth = kScreenWidth / 3.0
        for i in 0 ..< 3 {
            let button = UIButton()
            button.setTitle(items[i], for: UIControl.State.normal)
            button.setTitleColor(hexColor666, for: UIControl.State.normal)
            button.setTitleColor(themeColor, for: UIControl.State.selected)
            button.titleLabel?.font = systemFont(16)
            view.addSubview(button)
            button.snp.makeConstraints { (make) in
                make.left.equalTo(CGFloat(i) * itemWidth)
                make.top.equalTo(0)
                make.height.equalTo(40)
                make.width.equalTo(itemWidth)
            }
            if i == 0 {
                leftButton = button
            }
            else if i == 1 {
                middleButton = button
            }
            else {
                rightButton = button
            }
        }
        
        line.backgroundColor = themeColor
        view.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.top.equalTo(38)
            make.centerX.equalTo(leftButton)
            make.width.equalTo(leftButton.titleLabel!.rpk_textWith())
            make.height.equalTo(2)
        }
        
    }
    
    // 事件绑定
    func eventBinding() {
        leftButton.rx.tap
            .subscribe(onNext: { [weak self] (_) in
                self?.updateLineConstraints(self!.leftButton)
            })
            .disposed(by: disposeBag)
        
        middleButton.rx.tap
            .subscribe(onNext: { [weak self] (_) in
                self?.updateLineConstraints(self!.middleButton)
            })
            .disposed(by: disposeBag)
        
        rightButton.rx.tap
            .subscribe(onNext: { [weak self] (_) in
                self?.updateLineConstraints(self!.rightButton)
            })
            .disposed(by: disposeBag)
    }
    
    func updateLineConstraints(_ button:UIButton) {
        line.snp.remakeConstraints { (make) in
            make.top.equalTo(38)
            make.height.equalTo(2)
            make.width.equalTo(button.titleLabel!.rpk_textWith())
            make.centerX.equalTo(button)
        }
    }
}

