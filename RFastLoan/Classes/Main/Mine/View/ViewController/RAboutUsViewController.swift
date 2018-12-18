//
//  RAboutUsViewController.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/11.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit

import WebKit

class RAboutUsViewController: RBaseViewController, WKNavigationDelegate {

    let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "关于我们"
        webView.navigationDelegate = self
        webView.load(URLRequest.init(url: URL.init(string: "http://dk.shoux.net:9999/loanManage/api/article/v1/getArticleOne?code=contactUs")!))
        view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0))
        }
        
//        let viewModel = RMineViewModel()
//        viewModel.getAboutUs()
//            .subscribe(onNext: { (httpResult) in
////                webView.loadHTMLString(httpResult.data, baseURL: nil)
//            })
//            .disposed(by: disposeBag)
        
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
