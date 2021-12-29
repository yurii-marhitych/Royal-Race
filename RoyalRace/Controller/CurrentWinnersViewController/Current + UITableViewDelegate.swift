//
//  Current + UITableViewDelegate.swift
//  RoyalRace
//
//  Created by Юра Маргітич on 27.12.2021.
//

import UIKit

// MARK: - UITableViewDelegate
extension CurrentWinnersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationItem.searchController?.searchBar.resignFirstResponder()
        
        guard
            let tableView = tableView as? DriverTableView<Driver>,
            let selectedDriver = tableView.tableDataSource?.itemIdentifier(for: indexPath),
            let selectedRace = selectedDriver.race
        else { return }
        
        let raceDetailsViewController = RaceDetailsViewController()
        raceDetailsViewController.currentRace = selectedRace
        
        ErgastAPI.shared.fetchRaces(for: .current, and: .all) { races in
            let filteredRaces = races.filter { $0.raceName == selectedRace.raceName }
            raceDetailsViewController.races = filteredRaces
        }
        
        navigationController?.pushViewController(raceDetailsViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableView = tableView as? DriverTableView<Driver>,
              !tableView.indicesOfDisplayedCells.contains(indexPath) else { return }
        // fly-in animation
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 100, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0.6
        
        UIView.animate(withDuration: 0.3) {
            cell.alpha = 1
            cell.layer.transform = CATransform3DIdentity
        }
        
        tableView.indicesOfDisplayedCells.append(indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
