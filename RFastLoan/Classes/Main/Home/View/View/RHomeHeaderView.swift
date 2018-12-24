//
//  RHomeHeaderView.swift
//  RFastLoan
//
//  Created by RPK on 2018/11/1.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import Kingfisher

protocol RHomeHeaderViewDelegate {
    func homeHeaderView(_ headerView:RHomeHeaderView, didSelectItemAtIndex model: RHomeBannerItem)
}

class RHomeHeaderView: UIView, SDCycleScrollViewDelegate {

    var cycleScrollView : SDCycleScrollView!
    var timer : Timer?
    var currentIndex : Int = 0
    var totalCount : Int = 0
    var imagesURLStrings = Array<String>()
    var bannerList:Array<RHomeBannerItem>!
    var delegate : RHomeHeaderViewDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }
    
    private func initView() {
        
        backgroundColor = UIColor.hexInt(0xFFFFFF)

        cycleScrollView = SDCycleScrollView.init(frame: CGRect.zero, delegate: self, placeholderImage:UIImage())
        cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        cycleScrollView.currentPageDotColor = UIColor.white;
        cycleScrollView.imageURLStringsGroup = imagesURLStrings;
        cycleScrollView.autoScrollTimeInterval = 5;
        cycleScrollView.currentPageDotColor = themeColor;
        cycleScrollView.pageDotColor = UIColor.white;
        cycleScrollView.layer.masksToBounds = true;
        cycleScrollView.layer.cornerRadius  = 4;
        addSubview(cycleScrollView)
        cycleScrollView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(0)
            make.height.equalTo(160)
        }
        
        
        let emptyView = UIView.init(frame: .zero)
        emptyView.backgroundColor = UIColor.hexInt(0xF0F2F5)
        addSubview(emptyView)
        emptyView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0);
            make.top.equalTo(cycleScrollView.snp.bottom)
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
    
    public func settingBannerList(_ list:Array<RHomeBannerItem>) {
        bannerList = list
        var titlesGroup = Array<String>()
        for item in list {
            imagesURLStrings.append(downloadImageUrl + item.coverImageUrl!)
            titlesGroup.append(item.title!)
        }
        cycleScrollView.imageURLStringsGroup = imagesURLStrings
        cycleScrollView.titlesGroup = titlesGroup

    }
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        if (self.delegate != nil) {
            self.delegate?.homeHeaderView(self, didSelectItemAtIndex: bannerList[index])
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
