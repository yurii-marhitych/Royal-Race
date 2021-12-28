//
//  CurrentWinnersViewController: UI.swift
//  RoyalRace
//
//  Created by Юра Маргітич on 25.12.2021.
//

import UIKit
import Alamofire
import IHProgressHUD

class CurrentWinnersViewController: UIViewController {
    private let tableView = DriverTableView<Driver>()
    var winners: [Driver] = [] {
        didSet {
            tableView.items = winners
        }
    }
    var filteredWinners: [Driver] = [] {
        didSet {
            tableView.items = filteredWinners
        }
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Current Winners"
        
        setupSearchBar()
        setupTableView()
        fetchCurrentWinners()
    }
    
    // MARK: - Configure Methods
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        DriverTableViewCell.register(for: tableView)
        tableView.configureDataSource()
        tableView.items = winners
        
        tableView.delegate = self
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = .systemPink
        searchController.searchBar.placeholder = "Search for current Winners"
        searchController.searchBar.searchTextField.clearButtonMode = .never
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
}

// MARK: - Networking
extension CurrentWinnersViewController {
    private func fetchCurrentWinners() {
        ErgastAPI.shared.fetch(from: [Endpoint.currentWinners], ofType: ErgastAPIResponse.self) { response in
            guard let races = response.first?.ergastApiData.raceTable.races else { return }
            
            var winners: [Driver] = []
            races.forEach { winners.append(contentsOf: $0.results.map { $0.driver }) }
            self.winners = winners
        }
    }
}
