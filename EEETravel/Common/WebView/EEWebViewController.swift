//
//  EEWebViewController.swift
//  GMDoctor
//
//  Created by Thierry on 16/6/20.
//  Copyright © 2016年 Gengmei. All rights reserved.
//
import UIKit
import WebKit
//import GMUtil
//import GMKit
import EVReflection
//import GMPhobos
//import GMNetworking
//import SwiftyJSON
//import GMediator
//import GMAlbum

@objc protocol WebViewDelegate {
    
    @objc optional func handleLinkTap(_ url: String, host: String?, params: [String: AnyObject]?)
    @objc optional func handleGlobalPageData(_ data: [String: AnyObject])
    // TODO: Share的各种行为都应该交给H5来控制，此处待重构，（此方法有待废弃）
    // 在某个子类控制器 重写特定显示的与不显示的
//    optional func willShowShare(_ shareView: GMShareView!)
//    @objc optional func showShareArea()
    
}
// GMShareViewDelegate
class EEWebViewController: EEBaseController, GMShareComponent {

    let configuration = WKWebViewConfiguration()
    let userContent = WKUserContentController()
    var webEngine = EEWebEngine()
    
//    var weixinShareObject: GMShareObject?
    var hideShare = true
    var isFavord = false
    
    // 是否是自己的帖子
    var isPrivate = false
    var isShowScreenshot: Bool?
    var favUrl = ""
    var moreQueryParams = ""
    // 接受h5的参数，图片上传成功后，以这个参数为key，把图片Url返回给h5
    var requestCoder = ""
    var fullUrl = ""
    
    fileprivate var path = ""
    fileprivate weak var delegate: WebViewDelegate?
    var webView: WKWebView!
    var progressView: UIProgressView!
    
    convenience init(delegate: WebViewDelegate, path: String, moreQueryParams: String = "") {
        self.init()
        self.path = path
        self.delegate = delegate
        self.moreQueryParams = moreQueryParams
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
        initUserContent()
        initWebView()
        initProgressView()
        addObserver()
        sendRequest()
//        initShareComponent()
    }
    
    /**
     初始化userContent
     同步Ajax Cookie
     */
    fileprivate func initUserContent() {
        userContent.add(self, name: "gmdoctor")
        let ajaxCookieScript = WKUserScript(source: webEngine.ajaxCookie(), injectionTime: .atDocumentStart, forMainFrameOnly: false)
        userContent.addUserScript(ajaxCookieScript)
        configuration.userContentController = userContent
    }
    
    /**
     初始化WebView
     */
    fileprivate func initWebView() {
        webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        webEngine.webView = webView
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.snp.edges)
        }
    }
    
    func initProgressView() {
        progressView = UIProgressView(progressViewStyle: UIProgressViewStyle.bar)
        progressView.progressTintColor = UIColor.mainVisualColor()
        view.addSubview(progressView)
        progressView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(1)
        }
    }
    
    /**
     发送Request
     */
    fileprivate func sendRequest() {
        let request = NSMutableURLRequest(url: URL(string: wrapUrl())!)
        request.setValue(webEngine.webCookie(), forHTTPHeaderField: "Cookie")
        webView.load(request as URLRequest)
    }
    
    func addObserver() {
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "title", options: .new, context: nil)
    }
    
    func wrapUrl() -> String {
        if !fullUrl.isEmpty {
            return fullUrl
        } else {
            let url = "\(EEServerDomain.sharedInstance.APIHost)\(path)\(EEURLCommonParams())\(self.moreQueryParams)"
            return url
        }
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "title" {
            navigationBar.title = webView.title
            if self.parent != nil {
                self.parent?.navigationBar.title = webView.title
            }
        } else if keyPath == "estimatedProgress" {
            //TODO TEST 
            let changeDict =  NSDictionary(dictionary: change!)
            if let currentProgress = changeDict["new"] as? Float {
                progressView.setProgress(currentProgress, animated: true)
            }
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func willShowShareView(shareView: GMShareView!) {
//        shareView.showDelete = isPrivate
//        shareView.showFavor = isFavord
//        shareView.showReport = !isPrivate
//        self.delegate?.willShowShare?(shareView)
//    }
    
    func refreshWebView() {
        self.webView.reload()
    }
    
//    func fetchSharePublishContent(_ shareType: GMShareType) -> NSMutableDictionary {
//        return self.doFetchSharePublishContent(shareType)
//    }
//    
//    func copyShareUrl() {
//        self.doCopyShareUrl()
//    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        webView.removeObserver(self, forKeyPath: "title")
    }
    
}

extension EEWebViewController: WKNavigationDelegate {
    
    /**
     开始发送Request
     in 2.3.0
     */
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("didStartProvisionalNavigation")
        progressView.isHidden = false
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
        webEngine.parseJSPageData { [weak self] (data: [String: AnyObject]) in
            self?.hideShare = data["hide_share"] as? Bool ?? false
            self?.isFavord = data["is_favord"] as? Bool ?? false
            self?.isPrivate = data["is_private"] as? Bool ?? false
            if data["share_data"] != nil {
//                self?.shareObject = GMShareObject(dictionary: data["share_data"] as! NSDictionary)
            }
            self?.delegate?.handleGlobalPageData?(data)
        }
//        delay(0.5) {
//            self.progressView.isHidden = true
//        }
    }
    
    /**
     URL重定向
     in 2.3.0
     */
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else {
            decisionHandler(.allow)
            return
        }
        if url.scheme == EEURLScheme {
            
            guard let host = url.host, !host.isEmpty else {
                decisionHandler(.allow)
                return
            }
            //TODO:
//            guard let params = NSString(string: url.absoluteString).urlQueryToDictionary() else {
//                decisionHandler(.allow)
//                return
//            }
//            if let _ = delegate?.handleLinkTap?(url.absoluteString, host: host, params: params as? [String: AnyObject]) {
//                decisionHandler(.cancel)
//            } else {
//                decisionHandler(.allow)
//            }
        } else {
            decisionHandler(.allow)
        }
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        progressView.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        progressView.isHidden = true
    }
    
}


// MARK: - WKUIDelegate，WKWebView不支持直接JS Alert，需要通过下面的Delegate方法处理
extension EEWebViewController: WKUIDelegate {
    
    // WebView Alert Handler
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let ac = UIAlertController(title: webView.title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        ac.addAction(UIAlertAction(title: "确定", style: .cancel, handler: { (aa) -> Void in
            completionHandler()
        }))
        self.present(ac, animated: true, completion: nil)
    }
    
    // WebView Confirm Handler
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let ac = UIAlertController(title: webView.title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        ac.addAction(UIAlertAction(title: "确定", style: .default, handler: { (aa) -> Void in
            completionHandler(true)
        }))
        ac.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (aa) -> Void in
            completionHandler(false)
        }))
        self.present(ac, animated: true, completion: nil)
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


// MARK: - JS Call Native Method
extension EEWebViewController: GMClientH5BridgeDelegate {
    func jsHideLoading() {

    }
    
    func jsShowLoading() {
        
    }

    func jsShowAlertViewWithJSONString(JSONString: String) {
        
    }
    
    func jsShowToastWithJSONString(JSONString: String) {
        
    }
    
    func jsShowConfirmViewWithJSONString(JSONString: String) {
        
    }
    
    func jsOpenBrowser(_ url: String) {
        
    }
}

