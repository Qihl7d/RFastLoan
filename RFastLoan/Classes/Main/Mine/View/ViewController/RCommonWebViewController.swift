//
//  RCommonWebViewController.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/20.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit

class RCommonWebViewController: RBaseWebViewController {
    var htmlName:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        webView.backgroundColor = .white
//        let fileUrl = Bundle.main.url(forResource: htmlName, withExtension: nil)
        if htmlName.hasPrefix("http") {
            let fileUrl = URL.init(string: htmlName)
            let request = URLRequest.init(url: fileUrl!)
            webView.loadRequest(request)
        }
        else {
            webView.loadHTMLString(htmlName, baseURL: nil)
        }
        // Do any additional setup after loading the view.
    }
    
    init(htmlName:String) {
        self.htmlName = htmlName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
