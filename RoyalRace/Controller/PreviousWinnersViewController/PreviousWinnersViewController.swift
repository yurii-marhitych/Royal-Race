//
//  PreviousWinnersViewController.swift
//  RoyalRace
//
//  Created by Юра Маргітич on 25.12.2021.
//

import UIKit
import BATabBarController
import iOSDropDown

class PreviousWinnersViewController: UIViewController {
    // table view
    private let tableView = DriverTableView<Driver>()
    
    private(set) var drivers: [Driver] = [] {
        didSet {
            tableView.items = drivers
        }
    }
    
    var selectedSeason: Int?
    var selectedPosition: Int?
    
    private var seasons = (1950...2021).reversed().map { String($0) }
    private var positions = (1...20).map { String($0) }
    
    // completion handler for fetch function
    private lazy var completion: ([Race]) -> Void = { races in
        var winners: [Driver] = []
        races.forEach { race in
            let drivers = race.results.map { $0.driver }
            drivers.forEach { $0.race = race }
            winners.append(contentsOf: drivers)
        }
        self.drivers = winners
    }
    
    // MARK: - UI Elements
    private let seasonPicker = UIBarPickerView(width: 50, height: 20, placeholder: "season")
    private let positionPicker = UIBarPickerView(width: 50, height: 20, placeholder: "position")
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Previous Winners"
     
        setupPickers()
        setupTableView()
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
    
    private func setupPickers() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: seasonPicker)
        seasonPicker.optionArray = seasons
        seasonPicker.didSelect { season, _, _ in
            self.selectedSeason = Int(season)
        }
        seasonPicker.listWillDisappear {
            self.positionPicker.showList()
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: positionPicker)
        positionPicker.optionArray = positions
        positionPicker.didSelect { place, _, _ in
            self.selectedPosition = Int(place)
            
            guard
                let season = self.selectedSeason,
                let position = self.selectedPosition
            else { return }
            
            ErgastAPI.shared.fetchRaces(for: .some(season), and: .some(position), self.completion)
        }
    }
}
