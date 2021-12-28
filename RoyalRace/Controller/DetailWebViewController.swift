//
//  DetailWebViewController.swift
//  RoyalRace
//
//  Created by Юра Маргітич on 27.12.2021.
//

import UIKit
import WebKit
import SnapKit

class DetailWebViewController: UIViewController {
    var urlToLoad: String?
    
    private let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWebView()
        guard let url = urlToLoad else { return }
        webView.load(url: url)
    }
    
    // MARK: - Configure UI Methods
    private func setupWebView() {
        view = webView
    }
}
