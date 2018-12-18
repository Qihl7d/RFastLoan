//
//  BAProgressHUD.swift
//  GreenAir
//
//  Created by BruceAlbert on 2017/8/30.
//  Copyright © 2017年 Mars. All rights reserved.
//

import UIKit
import SVProgressHUD


fileprivate enum HUDType: Int {
    case success
    case errorObject
    case errorString
    case info
    case loading
}
class BAProgressHUD: NSObject {

    class func ba_initHUD() {
        SVProgressHUD.setBackgroundColor(UIColor ( red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7 ))
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setFont(UIFont.systemFont(ofSize: 14))
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.none)
    }

    class func showSuccess(_ success:String) {
        SVProgressHUD.show(R.image.形状1()!, status: success)
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.native)
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.custom)
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setBackgroundColor(UIColor.white)
        SVProgressHUD.setBackgroundLayerColor(UIColor.clear)
        SVProgressHUD.dismiss(withDelay: 2)
    }

    class func showError(_ error:String) {
//        SVProgressHUD.showInfo(withStatus: error)
        SVProgressHUD.showError(withStatus: error)
        SVProgressHUD.dismiss(withDelay: 2)
    }

    
    class func showIndicator() {
//        系统菊花旋转样式
        let view = UIViewController.current()?.view.window
//        设置控制器颜色
        indicator.style = .whiteLarge
        indicator.color = themeColor

        var exist = false
        for view in indicator.subviews {
            if let lable = view as? UILabel {
                lable.isHidden = false
                exist = true
                break
            }
        }

        if view != nil {
            view?.addSubview(indicator)
            indicator.snp.makeConstraints { (make) in
                make.center.equalTo(view!)
                make.size.equalTo(CGSize.init(width: 150, height: 150))
            }

            if !exist {
                let state = UILabel()
                state.text = "加载中"
                state.textColor = hexColor333
                state.font = UIFont.sysFont15()
                state.textAlignment = .center
                indicator.addSubview(state)
                state.snp.makeConstraints { (make) in
                    make.centerX.equalTo(indicator)
                    make.centerY.equalTo(indicator.snp.centerY).offset(40)
                    make.size.equalTo(CGSize.init(width: 100, height: 20))
                }
            }
        }
        indicator.startAnimating()
    }

    class func dismiss() {
//        for view in indicator.subviews {
//            if let lable = view as? UILabel {
//                lable.isHidden = true
//                break
//            }
//        }
        indicator.stopAnimating()
    }

    //成功
    class func showStatus(_ string: String?) {
        self.baProgressHUDShow(.success, status: string)

    }
    
    //失败 ，NSError
    class func ba_showError(withObject error: NSError) {
        self.baProgressHUDShow(.errorObject, status: nil, error: error)
    }
    
    //失败，String
    class func ba_showError(withStatus string: String?) {
        self.baProgressHUDShow(.errorString, status: string)
    }
    
    //转菊花
    class func ba_showWithStatus(_ string: String?) {
        self.baProgressHUDShow(.loading, status: string)
    }
    
    //警告
    class func ba_showWarning(withStatus string: String?) {
        self.baProgressHUDShow(.info, status: string)
    }
    
    //dismiss消失
    class func ba_dismiss() {
        BAProgressHUD.dismiss()
    }
    
    //私有方法
    fileprivate class func baProgressHUDShow(_ type: HUDType, status: String? = nil, error: NSError? = nil) {
        SVProgressHUD.setDefaultMaskType(.none)
        switch type {
        case .success:
//            SVProgressHUD.showSuccess(withStatus: status)
            SVProgressHUD.show(#imageLiteral(resourceName: "tipsPoint"), status: status)
            break
        case .errorObject:
            guard let newError = error else {
                SVProgressHUD.showError(withStatus: "Error:出错拉")
                return
            }
            
            if newError.localizedFailureReason == nil {
                SVProgressHUD.showError(withStatus: "Error:出错拉")
            } else {
                SVProgressHUD.showError(withStatus: error!.localizedFailureReason)
            }
            break
        case .errorString:
            SVProgressHUD.showError(withStatus: status)
            break
        case .info:
            SVProgressHUD.showInfo(withStatus: status)
            break
        case .loading:
            SVProgressHUD.setDefaultMaskType(.clear)
            SVProgressHUD.show(withStatus: status)
            break
        }
        SVProgressHUD.dismiss(withDelay: 1.5)
    }
}

extension SVProgressHUD {
    
}
