//
//  EEWebViewController.swift
//  GMDoctor
//
//  Created by Thierry on 16/6/20.
//  Copyright © 2016年 Gengmei. All rights reserved.
//
import UIKit
import WebKit
import EVReflection

@objc protocol WebViewDelegate {
    
    @objc optional func handleLinkTap(_ url: String, host: String?, params: [String: AnyObject]?)
    @objc optional func handleGlobalPageData(_ data: [String: AnyObject])
}
// GMShareViewDelegate
class EEWebViewController: EEBaseController, GMShareComponent {

    let configuration = WKWebViewConfiguration()
    let userContent = WKUserContentController()

    var moreQueryParams = ""
    // 接受h5的参数，图片上传成功后，以这个参数为key，把图片Url返回给h5
    var requestCoder = ""
    var fullUrl = ""
    
    fileprivate var path = ""
    fileprivate weak var delegate: WebViewDelegate?
    var webView: WKWebView!
    
    convenience init(delegate: WebViewDelegate, path: String, moreQueryParams: String = "") {
        self.init()
        self.path = path
        self.delegate = delegate
        self.moreQueryParams = moreQueryParams
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initWebView()
        sendRequest()
    }

    /**
     初始化WebView
     */
    fileprivate func initWebView() {
        webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.snp.edges)
        }
    }

    /**
     发送Request
     */
    fileprivate func sendRequest() {
        let request = NSMutableURLRequest(url: URL(string: wrapUrl())!)
        webView.load(request as URLRequest)
    }
    
    func wrapUrl() -> String {
        if !fullUrl.isEmpty {
            return fullUrl
        } else {
            let url = "\(EEServerDomain.APIHost)\(path)\(self.moreQueryParams)"
            return url
        }
    }

    func refreshWebView() {
        self.webView.reload()
    }
    
}

extension EEWebViewController: WKNavigationDelegate {
    
    /**
     开始发送Request
     in 2.3.0
     */
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        SwiftNotice.wait()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        print("didStartProvisionalNavigation")
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        SwiftNotice.clear()
    }
    
    /**
     Request请求完毕，内容开始返回
     in 2.3.0
     */
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("didCommitNavigation")
    }
    
    /**
     页面加载完毕
     in 2.3.0
     */
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        SwiftNotice.clear()
    }
    
    /**
     URL重定向
     in 2.3.0
     */
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard navigationAction.request.url != nil else {
            decisionHandler(.allow)
            return
        }
        //这句话很重要，没有的话，html里的超链接都无法跳转
        if navigationAction.targetFrame == nil {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            self.webView.load(navigationAction.request)
        }
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        SwiftNotice.clear()
    }
    
}

// MARK: - WKUIDelegate，WKWebView不支持直接JS Alert，需要通过下面的Delegate方法处理
extension EEWebViewController: WKUIDelegate {
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            self.webView.load(navigationAction.request)
        }
        return nil
    }
}

// MARK: - WKScriptMessageHandler
extension EEWebViewController: WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.body)
        if let dict = message.body as? [String: AnyObject] {
            let method: String = dict["method"] as! String
            // 带参数的情况
            if let param = dict["param"] {
                let sel = "\(method):"
                if self.responds(to: Selector(sel)) {
                    self.perform(Selector(sel), with: param)
                }
            } else {
                let sel = "\(method)"
                if self.responds(to: Selector(sel)) {
                    self.perform(Selector(sel))
                }
            }
        }
    }
}
