//
//  RMineHeaderView.swift
//  RFastLoan
//
//  Created by RPK on 2018/11/4.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit

class RMineHeaderView: UIView {
    
    let balanceLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        
        let backgroundView = UIImageView.init(image: UIImage())
        self.addSubview(backgroundView)
        backgroundView.backgroundColor = RbackgroundColor
        backgroundView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(0)
            make.height.equalTo(200 + kStatusBarHeight)
        }
        
        balanceLabel.textColor = .white
        balanceLabel.font = systemFont(40)
        balanceLabel.text = "3600.00"
        balanceLabel.textAlignment = .center
        backgroundView.addSubview(balanceLabel)
        balanceLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(backgroundView)
            make.top.equalTo(90 + kStatusBarHeight)
            make.width.equalTo(kScreenWidth - 100)
            make.height.equalTo(30)
        }
        
        let tipsLabel = UILabel()
        tipsLabel.textColor = .white
        tipsLabel.font = systemFont(13)
        tipsLabel.text = "可用额度(元)"
        tipsLabel.textAlignment = .center
        backgroundView.addSubview(tipsLabel)
        tipsLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(backgroundView)
            make.top.equalTo(balanceLabel.snp.bottom).offset(10)
            make.width.equalTo(100)
            make.height.equalTo(16)
        }
        
        let images : [UIImage] = [R.image.个人中心实名认证()!, R.image.个人中心账单明细()!, R.image.个人中心借款申请记录()!]
        let titles = ["实名认证", "账单明细", "借款申请记录"]
        
        for i in 0 ..< 3 {
            let button = RButton.init(frame: CGRect.zero)
            button.setTitle(titles[i])
            button.setImage(images[i])
            addSubview(button)
            button.snp.makeConstraints { (make) in
                make.top.equalTo(backgroundView.snp.bottom)
                make.bottom.equalTo(-10)
                make.width.equalTo(kScreenWidth/3.0)
                make.left.equalTo(CGFloat(i) * kScreenWidth/3.0)
            }
        }
        
        let emptyView = UIView()
        emptyView.backgroundColor = RbackgroundColor
        addSubview(emptyView)
        emptyView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(10)
        }
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
