//
//  RBaseWebViewController.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/20.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit

class RBaseWebViewController: RBaseViewController {
    let webView = UIWebView()
    var newAgent : String = ""
    lazy var progressView: NJKWebViewProgressView = {
        let progressView = NJKWebViewProgressView.init()
        return progressView
    }()
    
    lazy var progressProxy: NJKWebViewProgress = {
        let progressProxy = NJKWebViewProgress.init()
        return progressProxy
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if #available(iOS 11.0, *) {
            webView.scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }
//        let infoDic = Bundle.main.infoDictionary
//        let appVersion : String = infoDic!["CFBundleShortVersionString"] as! String
//        let oldAgent = webView.stringByEvaluatingJavaScript(from: "navigator.userAgent")
//        newAgent = oldAgent! + "/GreenAir/" + appVersion
        view.addSubview(webView)
        webView.backgroundColor = .white
        webView.delegate = progressProxy
        progressProxy.webViewProxyDelegate = self
        progressProxy.progressDelegate = self
        
        let progressBarHeight : CGFloat = 2.0
        let navigationBarBounds : CGRect = self.navigationController!.navigationBar.bounds
        let barFrame : CGRect = CGRect.init(x: 0, y: navigationBarBounds.size.height - progressBarHeight, width: kScreenWidth, height: progressBarHeight)
        progressView = NJKWebViewProgressView.init(frame: barFrame)
        //        progressView.autoresizingMask = .flexibleWidth | .flexibleTopMargin
        
        webView.snp.makeConstraints { (make) in
            
            make.edges.equalTo(UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0))
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.addSubview(progressView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        progressView.removeFromSuperview()
        if #available(iOS 11.0, *) {
            webView.scrollView.contentInsetAdjustmentBehavior = .automatic
        } else {
            // Fallback on earlier versions
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension RBaseWebViewController : UIWebViewDelegate, NJKWebViewProgressDelegate {
    
    
    func webViewProgress(_ webViewProgress: NJKWebViewProgress!, updateProgress progress: Float) {
        progressView.setProgress(progress, animated: true)
//        let ss = webView.stringByEvaluatingJavaScript(from: "document.title")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
//        progressView.isHidden = true
        progressView.setProgress(1, animated: true)
    }
    
}
