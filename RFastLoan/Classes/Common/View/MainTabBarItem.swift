//
//  MainTabBarItem.swift
//  RFastLoan
//
//  Created by RPK on 2018/10/31.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import SnapKit

class MainTabBarItem: UIControl {
    
    let image       : UIImage
    let title       : String
    let imgView     : UIImageView
    let titleLabel  : UILabel
    let selectImage : UIImage
    
    //属性观察器
    var currentSelectState = false {
        didSet{
            if currentSelectState {
                //被选中
                imgView.image = selectImage
                titleLabel.textColor = UIColor.hexInt(0x4DB4FF)
            }else{
                //没被选中
                imgView.image = image
                titleLabel.textColor = UIColor.hexInt(0x666666)
            }
        }
    }
    
    init(frame:CGRect, title:String, image:UIImage, selectImage:UIImage, itemIndex:Int) {
        
        self.title = title
        self.image = image
        self.selectImage = selectImage
        
        //布局使用的参数
        let defaulutLabelH:CGFloat = 20.0 + tabbarSafeBottomMargin //文字的高度
        var imgTop:CGFloat = 3
        var imgWidth:CGFloat = 25
        //中间的按钮的布局参数做特殊处理
        if itemIndex == 1{
            imgTop = -25
            imgWidth = 60
        }
        let imgLeft:CGFloat = (frame.size.width - imgWidth)/2
        //
        imgView = UIImageView(frame: .init(x: imgLeft, y: imgTop, width: imgWidth, height: imgWidth))
        imgView.image = image
        imgView.contentMode = UIView.ContentMode.scaleAspectFit
        if itemIndex == 1 {
            let bezierPath = UIBezierPath.init(roundedRect: imgView.bounds, byRoundingCorners: UIRectCorner(rawValue: UIRectCorner.topLeft.rawValue | UIRectCorner.topRight.rawValue), cornerRadii: imgView.bounds.size);
            let shapeLayer = CAShapeLayer.init()
            shapeLayer.frame = imgView.bounds
            shapeLayer.path = bezierPath.cgPath
            imgView.layer.mask = shapeLayer            
        }
        
        //init(x: 0, y: 31, width: frame.size.width, height: 49.0 - 31)
        titleLabel = UILabel(frame: .zero)
        titleLabel.text = title
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        titleLabel.textColor = UIColor.lightGray
        
        super.init(frame: frame)
        self.addSubview(imgView)
        self.addSubview(titleLabel)
        imgView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(imgTop)
            make.size.equalTo(CGSize.init(width: imgWidth, height: imgWidth))
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
//            make.top.equalTo(imgView.snp.bottom).offset(3)
            make.top.equalTo(31)
            make.size.equalTo(CGSize.init(width: frame.size.width, height: 20))
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
