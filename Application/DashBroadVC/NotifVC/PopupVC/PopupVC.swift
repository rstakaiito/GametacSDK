//
//  PopupVC.swift
//  AppsFlyer
//
//  Created by Linh Phan on 10/2/19.
//  Copyright © 2019 Linh Phan. All rights reserved.
//

import UIKit
import WebKit

class PopupVC: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var ActInd: UIActivityIndicatorView!
    
    @IBAction func btnClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.layer.cornerRadius = 5
        webView.layer.masksToBounds = true
        webView.addSubview(ActInd)
        ActInd.startAnimating()
        webView.navigationDelegate = self
        ActInd.hidesWhenStopped = true
        let url = URL(string: "https://www.apple.com")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 20.0)
        self.webView.load(request)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ActInd.stopAnimating()
    }
}
