//
//  Details + UITableViewDataSource.swift
//  RoyalRace
//
//  Created by Юра Маргітич on 27.12.2021.
//

import UIKit

// MARK: - UITableViewDataSource
extension RaceDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: DriverTableViewCell.identifier,
            for: indexPath) as! DriverTableViewCell
    
        if let race = self.race {
            cell.configure(with: race)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Results"
    }
}
