//
//  VCWebView.swift
//  News IN
//
//  Created by PraTeek Mishra on 06/06/20.
//  Copyright © 2020 PraTeek Mishra. All rights reserved.
//

import UIKit
import WebKit

class VCWebView: UIViewController, WKNavigationDelegate {
    
    var urlReceived: String?
    
    var webView: WKWebView!
    
    override func loadView() {
        
        ///Creating an object of WKWebView class, then assigning the main view to webView.
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        if let finalUrl = urlReceived {
            
            print("Received url is: \(finalUrl)")
            
            if let url = URL(string: finalUrl){
                
                webView.load(URLRequest(url: url))
                webView.allowsBackForwardNavigationGestures = true
                
            }
            
            
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.navigationBar.barTintColor = UIColor.init(named: "CustomColor")
        navigationController?.navigationBar.tintColor = UIColor.init(named: "CustomNavBarTextColor")
        navigationController?.navigationBar.prefersLargeTitles = false
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    
}




