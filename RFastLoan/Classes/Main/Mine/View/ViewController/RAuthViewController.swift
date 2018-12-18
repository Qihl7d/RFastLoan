//
//  RAuthViewController.swift
//  RFastLoan
//
//  Created by RPK on 2018/11/14.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import Kingfisher

class RAuthViewController: RTableViewViewController, RSelectBulletBoxDelegate, UIImagePickerControllerDelegate {
    var checkInfo : Bool = false
//    var rightLabelTexts = Array<String>()
    var _oldUserInfo : RMemberInfo!
    var oldUserInfo: RMemberInfo {
        get {
            return _oldUserInfo
        }
        set {
            _oldUserInfo = newValue
            
        }
    }
    
    let dataSource : [[String]] = [
        ["用户姓名", "联系电话", "身份证号", "生日", "性别", "教育水平", "婚姻状态", "职业职位", "工作年限", "QQ号码", "微信号码", "现居地址", "详细地址"],
        ["联系人姓名", "联系电话", "与本人关系"],
        [""]]
    
    let sectionHeaderTitle : [String] = ["个人基本信息", "紧急联系人", "场景认证"]
    let commonIdentifier = "RAuthTableViewCell"
    let uploadPhotoIdentifier = "RUploadIDCardTableViewCell"
    let selectIdentifier = "RSelectAuthTableViewCell"
    var userInfo = Dictionary<String,String>()
    let dictionary : Dictionary<String, Array<String>> = ["24":["男", "女"], "25":["博士", "研究生", "本科", "大专", "高中及高中以下"], "26":["未婚", "已婚", "离异"], "28":["1年" ,"2年", "3年", "4年"], "42":["父亲","母亲","兄弟姐妹", "好友", "妻子","女友","其它"]]
    var clickImageView : UIImageView?
    
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

extension RAuthViewController {
    
    private func initView() {
        self.title = "实名认证"
        
        let footerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 60))
        let commitBtn = UIButton.init(frame: CGRect.init(x: 20, y: 10, width: kScreenWidth - 40, height: 40))
        commitBtn.setTitle("提交", for: UIControl.State.normal)
        commitBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        commitBtn.backgroundColor = themeColor
        commitBtn.titleLabel?.font = systemFont(16)
        commitBtn.layer.cornerRadius = 5;
        commitBtn.layer.masksToBounds = true
        footerView.addSubview(commitBtn)
        
        commitBtn.rx.tap
            .subscribe(onNext: { (_) in
                let viewModel = RMineViewModel()
                viewModel.commitProfileInfo(userInfo: self.userInfo)
                    .subscribe(onNext: { (httpResult) in
                        
                    })
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)
        
        
        tableView = UITableView.init(frame: CGRect.zero, style: UITableView.Style.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        if checkInfo {
            tableView.tableFooterView = UIView()
        }
        else {
            tableView.tableFooterView = footerView
        }
        tableView.sectionHeaderHeight = 40
        tableView.sectionFooterHeight = 0
        tableView.register(RAuthTableViewCell.classForCoder(), forCellReuseIdentifier: commonIdentifier)
        tableView.register(RUploadIDCardTableViewCell.classForCoder(), forCellReuseIdentifier: uploadPhotoIdentifier)
        tableView.register(RSelectAuthTableViewCell.classForCoder(), forCellReuseIdentifier: selectIdentifier)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0))
        }
        
    }
    
    func inputDataManipulate(textField:UITextField) {
        switch textField.tag {
        case 20:
            userInfo["name"] = textField.text
        case 21:
            userInfo["tel"] =  textField.text
        case 22:
            userInfo["idcard"] = textField.text;
        case 23:
            userInfo["birthday"] = textField.text
        case 24:
            userInfo["sex"] = textField.text
        case 25:
            userInfo["education"] = textField.text;
        case 26:
            userInfo["marriageStatus"] = textField.text;
        case 27:
            userInfo["jobName"] = textField.text;
        case 28:
            userInfo["workYears"] = textField.text;
        case 29:
            userInfo["qqcode"] = textField.text;
        case 30:
            userInfo["wechatCode"] = textField.text;
        case 31:
//          现居地址
//            userInfo["sheng"]
            break;
        case 32:
            userInfo["address"] = textField.text;
        case 40:
            userInfo["contactName"] = textField.text
        case 41:
            userInfo["contactTel"] = textField.text;
        case 42:
            userInfo["contactNexus"] = textField.text;
            
        default:
            break
        }
    }
    
    //    MARK: 选择地址弹窗
    func popViewSelecteAddress() {
        self.view.endEditing(true)
        let selecteView = SelecteAddressPopView.init(frame: .zero)
        selecteView.backgroundColor = .white
        self.view.window?.addSubview(selecteView)
        selecteView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(244)
        }
        
        //        点击view移除视图
        let bgTopView = UIView()
        bgTopView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
        self.view.window?.addSubview(bgTopView)
        bgTopView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(0)
            make.bottom.equalTo(selecteView.snp.top)
        }
        //        点击灰色背景移除弹框
        let tapTopPopView = UITapGestureRecognizer()
        bgTopView.addGestureRecognizer(tapTopPopView)
        tapTopPopView.rx.event
            .subscribe { (tap) in
                selecteView.removeFromSuperview()
                bgTopView.removeFromSuperview()
            }
            .disposed(by: disposeBag)
        //        选择省市区完成，
        selecteView.confirm.rx
            .tap.subscribe(onNext:{
                selecteView.removeFromSuperview()
                bgTopView.removeFromSuperview()
                let cell : RSelectAuthTableViewCell = self.tableView.cellForRow(at: .init(row: 11, section: 0)) as! RSelectAuthTableViewCell
                cell.rightLabel.text = selecteView.returnString
                self.userInfo["sheng"] = selecteView.address["province"];
                self.userInfo["shi"] = selecteView.address["city"]
                self.userInfo["xian"] = selecteView.address["disstrict"]
            })
            .disposed(by: disposeBag)
        //        关闭省市区选择弹窗
        selecteView.cancel.rx.tap.subscribe(onNext:{
            selecteView.removeFromSuperview()
            bgTopView.removeFromSuperview()
        })
            .disposed(by: disposeBag)
    }

    
}

extension RAuthViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section != 2 {
            return 50
        }
        else {
            return 280
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: .init(x: 0, y: 0, width: kScreenWidth, height: 40))
        headerView.backgroundColor = RbackgroundColor
        
        let label = UILabel()
        label.textColor = hexColor999
        label.font = systemFont(14)
        label.text = sectionHeaderTitle[section]
        headerView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.centerY.equalTo(headerView)
            make.width.equalTo(kScreenWidth - 20)
            make.height.equalTo(20)
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section != 2 {
            let showRightView = ((indexPath.row == 4 || indexPath.row == 5 || indexPath.row == 6 || indexPath.row == 8 || indexPath.row == 11) && indexPath.section == 0) || ((indexPath.row == 2) && indexPath.section == 1)
            if showRightView {
                let cell : RSelectAuthTableViewCell = tableView.dequeueReusableCell(withIdentifier: selectIdentifier) as! RSelectAuthTableViewCell
                let string = dataSource[indexPath.section][indexPath.row]
                cell.leftLabel.text = string
                cell.setAccessoryType(!checkInfo)
                if checkInfo {
                    if indexPath.section == 0 {
                        if indexPath.row == 4 {
                            cell.rightLabel.text  = oldUserInfo.sex ?? ""
                        }
                        else if indexPath.row == 5 {
                            cell.rightLabel.text = oldUserInfo.education ?? ""
                        }
                        else if indexPath.row == 6 {
                            cell.rightLabel.text = oldUserInfo.marriageStatus ?? ""
                        }
                        else if (indexPath.row == 8) {
                            cell.rightLabel.text = oldUserInfo.workYears ?? ""
                        }
                        else if indexPath.row == 11 {
                            let sheng = oldUserInfo.sheng ?? ""
                            let shi = oldUserInfo.shi ?? ""
                            let xian = oldUserInfo.xian ?? ""
                            var str = sheng + shi + xian
                            if sheng == shi {
                                str = sheng + xian
                            }
                            cell.rightLabel.text = str
                        }
                    }
                    else if indexPath.section == 1 {
                        if indexPath.row == 2 {
                            cell.rightLabel.text = oldUserInfo.contactNexus ?? ""
                        }
                    }
                }
                return cell
            }
            else {
                let cell : RAuthTableViewCell = tableView.dequeueReusableCell(withIdentifier: commonIdentifier, for: indexPath) as! RAuthTableViewCell
                let string = dataSource[indexPath.section][indexPath.row]
                if (indexPath.section == 0 && (indexPath.row == 1 || indexPath.row == 9)) || (indexPath.section == 1 && indexPath.row == 1) {
                    cell.textField.keyboardType = .numberPad
                }
                cell.setText(string)
                // 20 + / 40 + //
                cell.setTextFieldTag(tag: (indexPath.section + 1) * 20 + indexPath.row)
                cell.setTextFieldRightView(showRightView)
                //            cell.showVerificationBtn(string == "短信验证码")
                cell.showVerificationBtn(false)
                cell.textFieldDidChangeBlock = { textField in
                    self.inputDataManipulate(textField: textField)
                }
                cell.textField.isEnabled = !checkInfo
                if checkInfo {
                    if indexPath.section == 0 {
                        if indexPath.row == 0 {
                            cell.textField.text = oldUserInfo.name
                        }
                        else if indexPath.row == 1 {
                            cell.textField.text = oldUserInfo.code
                        }
                        else if indexPath.row == 2 {
                            cell.textField.text = oldUserInfo.idcard
                        }
                        else if indexPath.row == 3 {
                            cell.textField.text = oldUserInfo.birthday
                        }
                        else if indexPath.row == 7 {
                            cell.textField.text = oldUserInfo.jobName
                        }
                        else if indexPath.row == 9 {
                            cell.textField.text = oldUserInfo.qqcode
                        }
                        else if indexPath.row == 10 {
                            cell.textField.text = oldUserInfo.wechatCode
                        }
                        else if indexPath.row == 12 {
                            cell.textField.text = oldUserInfo.address
                        }
                    }
                    else if indexPath.section == 1 {
                        if indexPath.row == 0 {
                            cell.textField.text = oldUserInfo.contactName
                        }
                        else if indexPath.row == 1 {
                            cell.textField.text = oldUserInfo.contactTel
                        }
                    }
                }
                else {
                    cell.textField.placeholder = "请输入"
                }
                return cell
            }
        }
        else {
            let cell : RUploadIDCardTableViewCell = tableView.dequeueReusableCell(withIdentifier: uploadPhotoIdentifier) as! RUploadIDCardTableViewCell
            if checkInfo {
                cell.frontPhoto.kf.setImage(with: ImageResource.init(downloadURL: URL.init(string: oldUserInfo.promoteCode ?? "")!))
                cell.reversePhoto.kf.setImage(with: ImageResource.init(downloadURL: URL.init(string: oldUserInfo.idcardImg02 ?? "")!))
                cell.handHeldPhoto.kf.setImage(with: ImageResource.init(downloadURL: URL.init(string: oldUserInfo.idcardImg03 ?? "")!))
            }
            // 正面照
            cell.frontPhotoTap.rx.event
                .subscribe(onNext: { (_) in
                    self.clickImageView = cell.frontPhoto
                    self.choosePhotos()
                })
                .disposed(by: disposeBag)
            // 反面照
            cell.reversePhotoTap.rx.event
                .subscribe(onNext: { (_) in
                    self.clickImageView = cell.reversePhoto
                    self.choosePhotos()
                })
                .disposed(by: disposeBag)
            // 手持照
            cell.handHeldPhotoTap.rx.event
                .subscribe(onNext: { (_) in
                    self.clickImageView = cell.handHeldPhoto
                    self.choosePhotos()
                })
                .disposed(by: disposeBag)
            return cell
        }
    }
    
    func choosePhotos() {
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
    
    func open(_ type:UIImagePickerController.SourceType)  {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = type
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if ((indexPath.row == 4 || indexPath.row == 5 || indexPath.row == 6 || indexPath.row == 8) && indexPath.section == 0) || ((indexPath.row == 2) && indexPath.section == 1) {
            self.view.endEditing(true)
            let bulletBox = RSelectBulletBox.init(frame: UIScreen.main.bounds)
            bulletBox.tag = (indexPath.section + 1) * 20 +  indexPath.row
            bulletBox.indexPath = indexPath
            let key = "\(bulletBox.tag)"
            bulletBox.delegate = self
            bulletBox.dataSource = dictionary[key]!
            self.view.addSubview(bulletBox)
            bulletBox.snp.makeConstraints { (make) in
                make.edges.equalTo(UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0))
            }
        }
        else if indexPath.row == 11 {
            popViewSelecteAddress()
        }
        
        
    }
    
    func selectBulletBox(bulletBox: RSelectBulletBox, didClickCancel indexPath: IndexPath) {
        
        bulletBox.removeFromSuperview()
        
    }
    
    func selectBulletBox(bulletBox: RSelectBulletBox, didClickConfirm indexPath: IndexPath) {
        
        let cell : RSelectAuthTableViewCell = self.tableView.cellForRow(at: indexPath) as! RSelectAuthTableViewCell
        cell.rightLabel.text = bulletBox.returnString
        switch bulletBox.tag {
        case 24:
            userInfo["sex"] = bulletBox.returnString
        case 25:
            userInfo["education"] = bulletBox.returnString
        case 26:
            userInfo["marriageStatus"] = bulletBox.returnString
        case 28:
            userInfo["workYears"] = bulletBox.returnString
        case 29:
            userInfo["qqcode"] = bulletBox.returnString
        case 30:
            userInfo["wechatCode"] = bulletBox.returnString
        default:
            break
        }
        
        
        bulletBox.removeFromSuperview()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        let selectImage = info[.originalImage] as! UIImage
        self.clickImageView?.image = selectImage
        
        let data = selectImage.jpegData(compressionQuality: 0.5)!
        let request = RCommonRequest()
        request.upload(urlString: "http://dk.shoux.net:9999/loanManage/api/common/v1/upload", params: nil, imageData: data, success: { (result) in
            if self.clickImageView?.tag == 50 {
                self.userInfo["idcardImg01"] = result["data"] ?? ""
            }
            else if (self.clickImageView?.tag == 51) {
                self.userInfo["idcardImg02"] = result["data"] ?? ""
            }
            else {
                self.userInfo["idcardImg03"] = result["data"] ?? ""
            }
        }) { (error) in
            BAProgressHUD.ba_showWithStatus("图片上传失败")
        };
        
        
        
    }
}
