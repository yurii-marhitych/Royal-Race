//
//  DetailWebViewController.swift
//  RoyalRace
//
//  Created by Юра Маргітич on 27.12.2021.
//

import UIKit
import WebKit

class DetailWebViewController: UIViewController {
    var urlToLoad: String?
    
    // MARK: - UI Element
    private let webView = WKWebView()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Wikipedia"
        
        setupBackButton()
        setupWebView()
    }
    
    // MARK: - Configure Methods
    private func setupWebView() {
        webView.scrollView.showsVerticalScrollIndicator = false
        view = webView
        
        guard let url = urlToLoad else { return }
        webView.load(url: url)
    }
}
