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
//        webView.delegate = self
        webView.backgroundColor = .white
        let jsMeta = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);"
        
        webView.stringByEvaluatingJavaScript(from: jsMeta);
        
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
    
    override func webViewDidFinishLoad(_ webView: UIWebView) {
        let htmlWidth = CGFloat(Int(webView.stringByEvaluatingJavaScript(from: "document.body.scrollWidth")!)!);//获取 html 宽度
        webView.stringByEvaluatingJavaScript(from: "var element = document.createElement('meta');  element.name = \"viewport\";  element.content = \"width=device-width,initial-scale=\(webView.frame.size.width / htmlWidth),minimum-scale=0.1,maximum-scale=2.0,user-scalable=yes\"; var head = document.getElementsByTagName('head')[0]; head.appendChild(element);")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
