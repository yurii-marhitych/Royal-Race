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
    
    private(set) var drivers: [Driver] = [] {
        didSet {
            tableView.items = drivers
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
        ErgastAPI.shared.fetchRaces(for: .current, and: .some(1)) { [weak self] result in
            switch result {
            case .success(let races):
                var winners: [Driver] = []
                races.forEach { race in
                    let drivers = race.results.map { $0.driver }
                    drivers.forEach { $0.race = race }
                    winners.append(contentsOf: drivers)
                }
                self?.drivers = winners
            case .failure(let error):
                if error == .emptyResponse {
                    NotificationCenter.default.post(name: .emptyCurrentResponse, object: nil)
                } else if error == .badInternetConnection {
                    NotificationCenter.default.post(name: .badInternetConnectionCurrent, object: nil)
                }
            }
        }
        
        // NotificationCenter Observers
        NotificationCenter.default.addObserver(self, selector: #selector(emptyResponse), name: .emptyCurrentResponse, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(badInternetConnection), name: .badInternetConnectionCurrent, object: nil)
    }
    
    // deinit
    deinit {
        NotificationCenter.default.removeObserver(self, name: .emptyCurrentResponse, object: nil)
        NotificationCenter.default.removeObserver(self, name: .badInternetConnectionCurrent, object: nil)
    }
    
    // MARK: - Observer Methods
    @objc private func emptyResponse() {
        let alert = UIAlertController(title: "ERROR", message: "We can not to download an information about this race/driver from data base. Try later, please!", preferredStyle: .alert)
        alert.setTitle(color: Color.foreground)
        alert.setBackgroundColor(color: Color.background)
        alert.setTint(color: Color.tint)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func badInternetConnection() {
        let alert = UIAlertController(title: "ERROR", message: "Something was wrong :( Maybe you have bad Internet connection. Try later, please!", preferredStyle: .alert)
        alert.setTitle(color: Color.foreground)
        alert.setBackgroundColor(color: Color.background)
        alert.setTint(color: Color.tint)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
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
        tableView.items = drivers
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
