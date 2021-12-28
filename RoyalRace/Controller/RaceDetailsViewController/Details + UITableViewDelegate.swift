//
//  + UITableViewDelegate.swift
//  RoyalRace
//
//  Created by Юра Маргітич on 27.12.2021.
//

import UIKit

// MARK: - UITableViewDelegate
extension RaceDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailWebViewController = DetailWebViewController()
        detailWebViewController.urlToLoad = "https://en.wikipedia.org/wiki/Michael_Schumacher"
        navigationController?.pushViewController(detailWebViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView is DriverTableView<Race> ? 60 : 80
    }
}
