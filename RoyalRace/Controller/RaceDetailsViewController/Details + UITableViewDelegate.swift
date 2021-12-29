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
        
        if let tableView = tableView as? DriverTableView<Driver>,
           let driver = tableView.tableDataSource?.itemIdentifier(for: indexPath) {
            detailWebViewController.urlToLoad = driver.wikiURL
        } else if let race = self.currentRace {
            detailWebViewController.urlToLoad = race.wikiURL
        } else {
            return
        }
        
        self.present(detailWebViewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView is DriverTableView<Race> ? 60 : 80
    }
}
