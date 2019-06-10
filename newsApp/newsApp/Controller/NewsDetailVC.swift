//
//  NewsDetailVC.swift
//  newsApp
//
//  Created by Stephenson Ang on 30/05/2019.
//  Copyright © 2019 Stephenson Ang. All rights reserved.
//

import UIKit
import WebKit

class NewsDetailVC: UIViewController, WKUIDelegate {

    @IBOutlet weak var webView: WKWebView!
    
    var siteUrl: String?
    
    func initData(site: String) {
        self.siteUrl = site
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.uiDelegate = self

        let myURL = URL(string: siteUrl!)
        
        let myRequest = URLRequest(url: myURL!)
        
        webView.load(myRequest)
    }
    
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
}
