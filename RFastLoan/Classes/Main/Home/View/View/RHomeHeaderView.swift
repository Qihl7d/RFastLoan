//
//  RHomeHeaderView.swift
//  RFastLoan
//
//  Created by RPK on 2018/11/1.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import Kingfisher

class RHomeHeaderView: UIView, UIScrollViewDelegate {

    let scrollView  = UIScrollView()
    let contentView = UIView()
    let pageControl = UIPageControl()
    var timer : Timer?
    var currentIndex : Int = 0
    var totalCount : Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }
    
    private func initView() {
        
        backgroundColor = UIColor.hexInt(0xFFFFFF)
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
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
        
        pageControl.pageIndicatorTintColor = UIColor.gray
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
    
    func setupTimer() {
        timer = Timer.init(timeInterval: 3, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: RunLoop.Mode.common)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func settingBannerList(_ list:Array<RHomeBannerItem>) {
        totalCount = list.count;
        for i in 0 ..< list.count + 2 {
            let imageView = UIImageView()
            let index = i % list.count
            let url = downloadImageUrl + list[index].coverImageUrl!
            imageView.kf.setImage(with: ImageResource.init(downloadURL: URL.init(string: url)!))
            contentView.addSubview(imageView)
            imageView.snp.makeConstraints { (make) in
                make.left.equalTo(CGFloat(i) * kScreenWidth)
                make.top.equalTo(0);
                make.bottom.equalTo(0)
                make.width.equalTo(kScreenWidth)
                if i == list.count + 1 {
                    make.right.equalTo(contentView.snp.right)
                }
            }
            
            pageControl.numberOfPages = list.count
            
        }
        setupTimer()
    }
    
    @objc func timerAction() {
        currentIndex += 1
        if currentIndex == totalCount {
            currentIndex = 0
        }
        if currentIndex == currentIndex + 1 {
            currentIndex = 1
        }
        pageControl.currentPage = currentIndex
        scrollView.contentOffset = CGPoint.init(x: CGFloat(currentIndex) * kScreenWidth, y: 0)
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer?.invalidate()
        timer = nil
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        setupTimer()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / kScreenWidth;
        let page = Int(index) % totalCount;
        scrollView.contentOffset = CGPoint.init(x: page * Int(kScreenWidth), y: 0)
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
