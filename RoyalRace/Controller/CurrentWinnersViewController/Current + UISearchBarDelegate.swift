//
// Current + UISearchBarDelegate.swift
//  RoyalRace
//
//  Created by Юра Маргітич on 26.12.2021.
//

import UIKit

// MARK: - UISearchBarDelegate
extension CurrentWinnersViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            filterCurrentWinnersListFor(searchText)
        } else {
            filteredWinners = winners
        }
    }
    
    func filterCurrentWinnersListFor(_ winnerName: String) {
        filteredWinners = winners.filter { $0.title.item1!.lowercased().contains(winnerName.lowercased()) }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredWinners = winners
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}