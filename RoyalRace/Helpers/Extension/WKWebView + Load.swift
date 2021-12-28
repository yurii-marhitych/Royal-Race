//
//  WKWebView + Load.swift
//  RoyalRace
//
//  Created by Юра Маргітич on 27.12.2021.
//

import UIKit
import WebKit

extension WKWebView {
    func load(url: String) {
        guard let url = URL(string: url) else { return }
        let request = URLRequest(url: url)
        load(request)
    }
}
