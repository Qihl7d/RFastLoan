//
//  RHomeHeaderView.swift
//  RFastLoan
//
//  Created by RPK on 2018/11/1.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit

class RHomeHeaderView: UIView {

    let scrollView  = UIScrollView()
    let contentView = UIView()
    let pageControl = UIPageControl()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }
    
    private func initView() {
        
        backgroundColor = UIColor.hexInt(0xFFFFFF)
        addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(0)
            make.height.equalTo(160)
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(scrollView)
            make.height.equalTo(scrollView)
            make.width.greaterThanOrEqualTo(0)
        }
        
        addSubview(pageControl)
        pageControl.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(scrollView.snp.bottom).offset(-10)
            make.width.equalTo(200);
            make.height.equalTo(10)
        }
        
        let emptyView = UIView.init(frame: .zero)
        emptyView.backgroundColor = UIColor.hexInt(0xF0F2F5)
        addSubview(emptyView)
        emptyView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0);
            make.top.equalTo(scrollView.snp.bottom)
            make.height.equalTo(10)
        }
        
        let noEventBtn = UIButton.init(frame: .zero)
        noEventBtn.isUserInteractionEnabled = false
        noEventBtn.isEnabled = false
        noEventBtn.setTitle("最新借款信息", for: UIControl.State.normal)
        noEventBtn.setImage(R.image.首页最新信息(), for: UIControl.State.normal)
        noEventBtn.setTitleColor(hexColor333, for: UIControl.State.normal)
        noEventBtn.titleLabel?.font = boldSystemFont(16)
        noEventBtn.contentHorizontalAlignment = .left
        noEventBtn.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 0)
        noEventBtn.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 5)
        addSubview(noEventBtn)
        noEventBtn.snp.makeConstraints { (make) in
            make.top.equalTo(emptyView.snp.bottom)
            make.left.equalTo(self).offset(10)
            make.width.equalTo(kScreenWidth - 10)
            make.height.equalTo(39.4)
        }
        
        let line = UIView.init(frame: CGRect.zero)
        line.backgroundColor = UIColor.hexInt(0xE5E5E5);
        addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(noEventBtn.snp.bottom)
            make.height.equalTo(0.6)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
