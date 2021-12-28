//
//  PreviousWinnersViewController.swift
//  RoyalRace
//
//  Created by Юра Маргітич on 25.12.2021.
//

import UIKit
import BATabBarController

class PreviousWinnersViewController: UIViewController {
    private let tableView = DriverTableView<Driver>()
    var winners: [Driver] = [] {
        didSet {
            tableView.items = winners
        }
    }
    
    private var years = (1950...2021).map { String($0) }
    private var rounds = (1...30).map { String($0) }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Previous Winners"
        
        setupTableView()
        fetchPreviousWinners()
    }
    
    // MARK: - Configure UI Methods
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
}

// MARK: - Networking
extension PreviousWinnersViewController {
    private func fetchPreviousWinners() {
        ErgastAPI.shared.fetch(from: [Endpoint.previousWinners], ofType: ErgastAPIResponse.self) { response in
            guard let races = response.first?.ergastApiData.raceTable.races else { return }
            
            var winners: [Driver] = []
            races.forEach { winners.append(contentsOf: $0.results.map { $0.driver }) }
            self.winners = winners
        }
    }
}
