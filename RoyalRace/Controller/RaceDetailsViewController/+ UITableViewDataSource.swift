//
//  + UITableViewDataSource.swift
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
    
        let race = Race(season: "1950", round: "10", wikiURL: "https://en.wiktionary.org/wiki/Grand_Prix", raceName: "Paris Gran-prix", date: "13-10-1950", results: [])
        cell.configure(with: race)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Results"
    }
}
