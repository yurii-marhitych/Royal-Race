//
//  CurrentWinnersViewController.swift
//  RoyalRace
//
//  Created by Юра Маргітич on 25.12.2021.
//

import UIKit
import Alamofire
import IHProgressHUD

class CurrentWinnersViewController: UIViewController {
    // table view
    private let tableView = DriverTableView<Driver>()
    
    private var races: [Race] = []
    private(set) var winners: [Driver] = [] {
        didSet {
            tableView.items = winners
        }
    }
    var filteredWinners: [Driver] = [] {
        didSet {
            tableView.items = filteredWinners
        }
    }
    
    // completion handler for fetch function
    private lazy var completion: ([Race]) -> Void = { races in
        self.races = races
        
        var winners: [Driver] = []
        races.forEach { race in
            let drivers = race.results.map { $0.driver }
            drivers.forEach { $0.race = race }
            winners.append(contentsOf: drivers)
        }
        self.winners = winners
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Current Winners"
        
        setupSearchBar()
        setupTableView()
        ErgastAPI.shared.fetchDrivers(for: .current, and: 1, completion)
    }
    
    // MARK: - Configure UI Methods
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-80)
        }
        
        DriverTableViewCell.register(for: tableView)
        tableView.configureDataSource()
        tableView.items = winners
        tableView.delegate = self
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = Color.tint
        searchController.searchBar.placeholder = "Search for current Winners"
        searchController.searchBar.searchTextField.clearButtonMode = .never
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
}
