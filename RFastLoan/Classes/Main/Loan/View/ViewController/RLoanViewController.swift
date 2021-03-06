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

class RLoanViewController: RBaseViewController, RPopListViewDelegate, UITextViewDelegate, UIImagePickerControllerDelegate {

    let scrollView   = UIScrollView()
    let contentView  = UIView()
    let topView      = UIView()
    let middleView   = UIView()
    let bottomView   = UIView()
    let protocolTips = UIButton()
    let loanRule     = UIButton()
    let uploadBtn    = UIButton()
    let label        = UILabel()
    let textView     = UITextView()
    var lastImageView : UIImageView? = nil
    var costTextField : UITextField?
    var loanTypeTextField :UITextField?
    var loanTypeList = Array<RLoanType>()
    var selectImages = Array<UIImage>()
    var selectImageUrls = Array<String>()
    // 一行显示的图片张数
    let rowCount = 4
    
    var loanType : String = ""
    var cost : String = ""
    var remark : String = ""
    var paths : String = ""
    var popView : RPopListView?
    var parameters = Dictionary<String, String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        initData()
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
        
        
        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: commitButton)
        
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
            make.height.equalTo(100)
        }
        
        let texts : [String] = ["借款用途", "借款金额"]
        
        for i in 0 ..< texts.count {
            let label = UILabel()
            label.textColor = hexColor333
            label.font = systemFont(16)
            label.text = texts[i]
            topView.addSubview(label)
            label.snp.makeConstraints { (make) in
                make.left.equalTo(10)
                make.top.equalTo(10 + i * 50)
                make.height.equalTo(30)
                make.width.equalTo(80)
            }
            
            let textField = UITextField()
            textField.textColor = hexColor666
            textField.font = systemFont(16)
            if i == 0 {
                let rightBut = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 50))
                rightBut.setImage(R.image.通用右箭头(), for: UIControl.State.normal)
                rightBut.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 5)
                textField.rightView = rightBut
                textField.rightViewMode = .always
                
                let view1 = UIView()
                view1.bringSubviewToFront(topView)
                topView.addSubview(view1)
                view1.snp.makeConstraints { (make) in
                    make.left.equalTo(0)
                    make.right.equalTo(0)
                    make.centerY.equalTo(label)
                    make.height.equalTo(label)
                }
                
                let tap = UITapGestureRecognizer()
                view1.addGestureRecognizer(tap)
                tap.rx.event
                    .subscribe(onNext: { (_) in
                        let popView = RPopListView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
                        popView.delegate = self
                        popView.dataSource = self.loanTypeList
                        popView.tableView.reloadData()
                        self.view.window?.addSubview(popView)
                        self.popView = popView
                    })
                    .disposed(by: disposeBag)
            }
            textField.textAlignment = .right
            topView.addSubview(textField)
            textField.snp.makeConstraints { (make) in
                if i == 0 {
                    make.right.equalTo(0)
                }
                else {
                    make.right.equalTo(-20)
                }
                make.centerY.equalTo(label)
                make.left.equalTo(label.snp.right).offset(10)
                make.height.equalTo(label)
            }
            if i == 0 {
                loanTypeTextField = textField
            }
            else {
                textField.placeholder = "请输入借款金额"
                textField.textColor = hexColor666
                textField.keyboardType = .numberPad
                costTextField = textField
            }
            
            if i < 1 {
                textField.isEnabled = false
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
            else {
                self.costTextField = textField
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
        
        uploadBtn.setImage(R.image.我要借款添加图片加号(), for: UIControl.State.normal)
        middleView.addSubview(uploadBtn)
        uploadBtn.layer.borderColor   = UIColor.hexInt(0xCCCCCC).cgColor;
        uploadBtn.layer.borderWidth   = 1
        uploadBtn.layer.cornerRadius  = 2
        uploadBtn.layer.masksToBounds = true
        uploadBtn.addTarget(self, action: #selector(uploadBtnAction(_:)), for: UIControl.Event.touchUpInside)
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
        
        
        textView.backgroundColor = .white
        textView.textColor = UIColor.hexInt(0xCCCCCC)
        textView.font = systemFont(16)
        textView.text = "请输入"
        textView.delegate = self
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
        protocolTips.setTitle("我已阅读并同意", for: UIControl.State.normal)
        protocolTips.setTitleColor(hexColor999, for: UIControl.State.normal)
        protocolTips.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 5)
        protocolTips.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 5)
        protocolTips.contentHorizontalAlignment = .left
        protocolTips.addTarget(self, action: #selector(protocolTipsAction(_:)), for: UIControl.Event.touchUpInside)
        contentView.addSubview(protocolTips)
        protocolTips.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(bottomView.snp.bottom).offset(14)
            make.height.equalTo(20)
            make.width.equalTo(117)
        }
        
        let loanRuleAtt = NSMutableAttributedString.init(string: "借款规则", attributes: [NSAttributedString.Key.foregroundColor : themeColor, NSAttributedString.Key.font : systemFont(13)])
//        loanRuleAtt.addAttribute(NSAttributedString.Key.underlineColor, value: themeColor, range: NSRange.init(location: 0, length: loanRuleAtt.length))
        loanRuleAtt.addAttribute(NSAttributedString.Key.underlineStyle, value: NSNumber.init(value: NSUnderlineStyle.single.rawValue), range: NSRange.init(location: 0, length: loanRuleAtt.length))
//        loanRule.setTitle("借款规则", for: UIControl.State.normal)
        loanRule.titleLabel?.font = systemFont(13)
        loanRule.setAttributedTitle(loanRuleAtt, for: UIControl.State.normal)
        loanRule.setTitleColor(themeColor, for: UIControl.State.normal)
        loanRule.contentHorizontalAlignment = .left
        contentView.addSubview(loanRule)
        loanRule.snp.makeConstraints { (make) in
            make.left.equalTo(protocolTips.snp.right)
            make.centerY.equalTo(protocolTips)
            make.height.equalTo(25)
            make.width.equalTo(80)
//            make.bottom.equalTo(contentView.snp.bottom).offset(-20)
        }
        
        let commitButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
        commitButton.setTitle("提交", for: UIControl.State.normal)
        commitButton.setTitleColor(.white, for: UIControl.State.normal)
        commitButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        commitButton.backgroundColor = themeColor
        commitButton.layer.cornerRadius = 3
        commitButton.layer.masksToBounds = true
//        commitButton.addTarget(self, action: #selector(commitAction(_:)), for: UIControl.Event.touchUpInside)
        
        contentView.addSubview(commitButton)
        commitButton.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(45);
            make.top.equalTo(loanRule.snp.bottom).offset(20)
            make.bottom.equalTo(contentView.snp.bottom).offset(-20)
        }
        
        commitButton.rx.tap
            .subscribe(onNext: { (_) in
                self.view.endEditing(true)
                if self.protocolTips.isSelected {
                    let str0 = self.loanTypeTextField?.text ?? ""
                    self.paths = self.selectImageUrls.joined(separator: ",")
                    let str = self.costTextField?.text ?? ""
                    let str1 = self.textView.text ?? ""
                    if self.loanType.count > 0 {
                        self.parameters["loanPurpose"] = self.loanTypeTextField?.text
                        if str.count > 0 {
                            self.parameters["cost"] = self.costTextField?.text
                            if str1.count > 0 {
                                self.parameters["remark"] = self.textView.text
                                if self.paths.count > 0 {
                                    self.parameters["paths"] = self.paths
                                    let viewModel = RLoanViewModel()
                                    viewModel.commitLoanInfo(loanPurpose: str0, cost: str, remark: str1, paths: self.paths)
                                        .subscribe(onNext: { (httpResult) in
                                            // self .dismiss(animated: true, completion: nil)
                                            let str = httpResult.url
                                            let commonWebView = RCommonWebViewController.init(htmlName: str)
                                            commonWebView.title = "提示信息"
                                            self.navigationController?.pushViewController(commonWebView, animated: true)
                                        })
                                        .disposed(by: self.disposeBag)
                                }
                                else {
                                    BAProgressHUD.ba_showWithStatus("请上传证件图片")
                                }
                            }
                            else {
                                BAProgressHUD.ba_showWithStatus("请输入备注信息")
                            }
                        }
                        else {
                            BAProgressHUD.ba_showWithStatus("请输入借款金额")
                        }
                    }
                    else {
                        BAProgressHUD.ba_showWithStatus("请输入借款类型")
                    }
                }
                else {
                    BAProgressHUD.ba_showWithStatus("请查看并同意借款协议")
                }
            })
            .disposed(by: disposeBag)
        
    }
    
    @objc func protocolTipsAction(_ sender:UIButton) {
        sender.isSelected = !sender.isSelected;
    }
    
    @objc func cancelAction(_ sender:UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func uploadBtnAction(_ sender:UIButton) {
        let sheetView = UIAlertController.init(title: "选择图片", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let cancel = UIAlertAction.init(title: "取消", style: UIAlertAction.Style.cancel, handler: nil)
        let carme = UIAlertAction.init(title: "相机", style: UIAlertAction.Style.default) { (_) in
            self.open(.camera)
        }
        let lib = UIAlertAction.init(title: "相册", style: UIAlertAction.Style.default) { (_) in
            self.open(.photoLibrary)
        }
        sheetView.addAction(cancel)
        sheetView.addAction(carme)
        sheetView.addAction(lib)
        self.present(sheetView, animated: true, completion: nil)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func open(_ type:UIImagePickerController.SourceType)  {
        if self.selectImages.count < 3 {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = type
            self.present(imagePicker, animated: true, completion: nil)
        }
        else {
            BAProgressHUD.ba_showWithStatus("最多只能上传3张图片")
        }
    }
    
    @objc func deleteAction(_ sender:UIButton) {
        
        let height = (kScreenWidth - CGFloat((rowCount + 1) * 10))/CGFloat(rowCount);
        let imageView = sender.superview as! UIImageView
        let curTag = imageView.tag
        let preImageView = middleView.viewWithTag(curTag - 1)
        let nextImageView = middleView.viewWithTag(curTag + 1)
        imageView.removeFromSuperview()
        if preImageView == nil && nextImageView == nil {
            lastImageView = nil
            uploadBtn.snp.remakeConstraints { (make) in
                make.left.equalTo(10)
                make.top.equalTo(label.snp.bottom).offset(8)
                make.width.height.equalTo(height)
            }
        }
        else if preImageView == nil && nextImageView != nil {
            nextImageView!.snp.remakeConstraints { (make) in
                make.left.equalTo(10)
                make.top.equalTo(label.snp.bottom).offset(8)
                make.width.height.equalTo(height)
            }
        }
        else if preImageView != nil && nextImageView == nil {
            lastImageView = preImageView as? UIImageView
            uploadBtn.snp.remakeConstraints { (make) in
                make.left.equalTo(preImageView!.snp.right).offset(10)
                make.top.equalTo(label.snp.bottom).offset(8)
                make.width.height.equalTo(height)
            }
        }
        else {
            nextImageView!.snp.remakeConstraints { (make) in
                make.left.equalTo(preImageView!.snp.right).offset(10)
                make.top.equalTo(label.snp.bottom).offset(8)
                make.width.height.equalTo(height)
            }
        }
        if curTag - 10 + 1 < selectImages.count {
            for index in curTag - 10 + 1 ... selectImages.count {
                let imageView = middleView.viewWithTag(index + 10) as! UIImageView
                imageView.tag = index + 10 - 1
            }
        }
        
        
        selectImages.remove(at: curTag - 11)
        if selectImageUrls.count > curTag - 11 {
            selectImageUrls.remove(at: curTag - 11)
        }
    }
    
//    @objc func commitAction(_ sender:UIBarButtonItem) {
//
//
//        let viewModel = RLoanViewModel()
////        viewModel.commitLoanInfo(loanPurpose: self.loanType, cost: self.costTextField?.text ?? "", remark: self.textView.text ?? "", paths: <#T##String#>)
//    }
    
    
}

extension RLoanViewController {
    func initData() {
        let viewModel = RLoanViewModel()
        viewModel.getLoanTypeList(code: "c12")
            .subscribe(onNext: { (list) in
                self.loanTypeList = list.toArray()
            })
            .disposed(by: disposeBag)
        
        
    }
}

extension RLoanViewController {
    func closeWindow() {
        self.popView?.removeFromSuperview()
        self.popView = nil
    }
    
    func selected(loanType: RLoanType) {
        self.popView?.removeFromSuperview()
        self.popView = nil
        self.loanType = loanType.id ?? ""
        self.loanTypeTextField?.text = loanType.name
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.text == "请输入" {
            textView.text = ""
            textView.textColor = hexColor666
        }
        return true
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        let selectImage = info[.originalImage] as! UIImage
        
        selectImages.append(selectImage)
        let height = (kScreenWidth - CGFloat((rowCount + 1) * 10))/CGFloat(rowCount);
        
        let imageView = UIImageView.init(image: selectImage)
        imageView.isUserInteractionEnabled = true
        imageView.tag = 10 + selectImages.count
        middleView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            if lastImageView == nil {
                make.left.equalTo(10)
            }
            else {
                make.left.equalTo(lastImageView!.snp.right).offset(10)
            }
            make.top.equalTo(label.snp.bottom).offset(8)
            make.width.height.equalTo(height)
        }
    
        lastImageView = imageView
        
        let delete = UIButton()
        delete.setImage(R.image.del(), for: .normal)
        delete.addTarget(self, action: #selector(deleteAction(_:)), for: UIControl.Event.touchUpInside)
        imageView.addSubview(delete)
        delete.snp.makeConstraints { (make) in
            make.right.top.equalTo(0)
            make.width.height.equalTo(20)
        }
        
        uploadBtn.snp.remakeConstraints { (make) in
            make.left.equalTo(imageView.snp.right).offset(10)
            make.top.equalTo(imageView)
            make.width.height.equalTo(height)
        }
        
        let data = selectImage.jpegData(compressionQuality: 0.5)!
        let request = RCommonRequest()
        request.upload(urlString: "http://dk.shoux.net:9999/loanManage/api/common/v1/upload", params: nil, imageData: data, success: { (result) in
            self.selectImageUrls.append(result["data"] ?? "")
//            self.paths = result["data"] ?? ""
        }) { (error) in
            BAProgressHUD.ba_showWithStatus("图片上传失败")
        };
//        let viewModel = RLoanViewModel()
//        viewModel.uploadImage(imageData: data)
//            .subscribe(onNext: { (httpResult) in
//                dump(httpResult)
//            })
//            .disposed(by: disposeBag)
        
        
    }
}
