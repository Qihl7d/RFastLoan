//
//  SelecteAddressPopView.swift
//  GreenAir
//
//  Created by BruceAlbert on 2017/10/16.
//  Copyright © 2017年 Mars. All rights reserved.
//

import UIKit
import ObjectMapper

class SelecteAddressPopView: UIView {

    lazy var cancel: UIButton = {
        let cancel = UIButton()
        cancel.setTitle("取消", for: .normal)
        cancel.setTitleColor(hexColor333, for: .normal)
        cancel.titleLabel?.font = UIFont.systemFont(ofSize: 19)
        return cancel
    }()
    
    lazy var confirm: UIButton = {
        let confirm = UIButton()
        confirm.setTitle("确定", for: .normal)
        confirm.setTitleColor(hexColor333, for: .normal)
        confirm.titleLabel?.font = UIFont.systemFont(ofSize: 19)
        return confirm
    }()
    
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView.init(frame: .zero)
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    var provinceList : Array<ProviceListModel> = []
    var cityList : Array<CityListModel> = []
    var districtList : Array<String> = []
    var selectDictionary : NSMutableDictionary = [:]
    var selectedProvince : String = ""
    var selectedCity = ""
    var selectedDisstrict = ""
    var address : Dictionary<String, String> {
        get{
            var parameter = Dictionary<String, String>()
            if selectedProvince.count == 0 {
                selectedProvince = (provinceList.first?.name)!
                parameter["province"] = selectedProvince
            }
            if selectedCity.count == 0 {
                selectedCity = (cityList.first?.name)!
                parameter["city"] = selectedCity
            }
            if selectedDisstrict.count == 0 {
                selectedDisstrict = districtList[0]
                parameter["disstrict"] = selectedDisstrict
            }
            parameter["province"] = selectedProvince
            parameter["city"] = selectedCity
            parameter["disstrict"] = selectedDisstrict
//            return selectedProvince + selectedCity + selectedDisstrict
            return parameter
        }
    }

    var returnString : String {
        get{
            if selectedProvince.count == 0 {
                selectedProvince = (provinceList.first?.name)!
            }
            if selectedCity.count == 0 {
                selectedCity = (cityList.first?.name)!
            }
            if selectedDisstrict.count == 0 {
                selectedDisstrict = districtList[0]
            }
            
            var str = selectedProvince + selectedCity + selectedDisstrict
            if selectedProvince == selectedCity {
                str = selectedProvince + selectedDisstrict
            }
            return str
        }
    }


    override init(frame: CGRect) {
        super.init(frame: frame)
        let dat = try? Data.init(contentsOf: R.file.provinceJson()!)
//        ProviceCityList
        do {
            let json = try JSONSerialization.jsonObject(with: dat!, options: .allowFragments) as! [[String: Any]]
            provinceList = Array<ProviceListModel>.init(JSONArray: json)
            selectedProvince = (provinceList.first?.name)!
            cityList = (provinceList.first?.city)!
            selectedCity = (cityList.first?.name)!
            districtList = (cityList.first?.area)!
            selectedDisstrict = districtList.first!
        }
        catch let error {
            print(error)
        }
        
        self.addSubview(cancel)
        cancel.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(10)
            make.height.equalTo(26)
        }
        
        self.addSubview(confirm)
        confirm.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.top.equalTo(10)
            make.height.equalTo(26)
        }
        
        self.addSubview(pickerView)
        pickerView.snp.makeConstraints { (make) in
            make.top.equalTo(cancel.snp.bottom).offset(10)
            make.left.right.bottom.equalTo(0)
        }
        
        let topLine = UIView()
        topLine.backgroundColor = themeColor
        pickerView.addSubview(topLine)
        topLine.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.centerY.equalTo(pickerView).offset(-23)
            make.height.equalTo(lineHeight)
        }
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = themeColor
        pickerView.addSubview(bottomLine)
        bottomLine.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.centerY.equalTo(pickerView).offset(23)
            make.height.equalTo(lineHeight)
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

extension SelecteAddressPopView : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return provinceList.count
        case 1:
            return cityList.count
        case 2:
            return districtList.count
        default:
            return 0
        }
    }
    
    //返回一个视图，用来设置pickerView的每行显示的内容。
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label  = UILabel(frame: CGRect(x: 0 , y: 0, width: kScreenWidth/3, height: 30))
        label.font = UIFont.systemFont(ofSize: 19)
        label.textColor = hexColor333
        label.tag = component*100+row
        label.textAlignment = .center
        switch component {
        case 0:
            label.text = provinceList[row].name
        case 1:
            label.text = cityList[row].name
        case 2:
            label.text = districtList[row]
            
        default:
            label.text = districtList[row]
        }
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 46
    }
    
    //当点击UIPickerView的某一列中某一行的时候，就会调用这个方法
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            selectedProvince = provinceList[row].name!
//            let arr : NSArray = selectDictionary.object(forKey: selectedProvince) as! NSArray
//            let dic : NSDictionary = arr.firstObject as! NSDictionary
//            cityList = dic.allKeys as! [String]
            cityList = provinceList[row].city!
            selectedCity = (cityList.first?.name)!
//            districtList = dic.object(forKey: selectedCity) as! Array
            districtList = (cityList.first?.area)!
            pickerView.reloadComponent(1)
            pickerView.selectRow(0, inComponent: 1, animated: true)
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 2, animated: true)
            break
        case 1:
            selectedCity = cityList[row].name!
//            let arr : NSArray = selectDictionary.object(forKey: selectedProvince) as! NSArray
//            let dic : NSDictionary = arr.firstObject as! NSDictionary
//            districtList = dic.object(forKey: selectedCity) as! Array
            districtList = (cityList[row].area)!
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 2, animated: true)
            break
        case 2:
            selectedDisstrict = districtList[row]
            break
        default:
            break
        }
        
    }
    
}

