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
    
    private var races: [Race] = []
    private(set) var winners: [Driver] = [] {
        didSet {
            tableView.items = winners
        }
    }
    
    private var selectedSeason: String?
    private var selectedPlace: String?
    
    private var seasons = (1950...2021).reversed().map { String($0) }
    private var places = (1...20).map { String($0) }
    
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
    
    // MARK: - UI Elements
    private let seasonPicker = UIBarPickerView(width: 50, height: 20, placeholder: "season")
    private let placePicker = UIBarPickerView(width: 50, height: 20, placeholder: "place")
    
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
        tableView.items = winners
        tableView.delegate = self
    }
    
    private func setupPickers() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: seasonPicker)
        seasonPicker.optionArray = seasons
        seasonPicker.didSelect { season, _, _ in
            self.selectedSeason = season
        }
        seasonPicker.listWillDisappear {
            self.placePicker.showList()
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: placePicker)
        placePicker.optionArray = places
        placePicker.didSelect { place, _, _ in
            self.selectedPlace = place
            
            guard
                let season = Int(self.selectedSeason ?? ""),
                let place = Int(self.selectedPlace ?? "")
            else { return }
            
            ErgastAPI.shared.fetchDrivers(for: .year(season), and: place, self.completion)
        }
    }
}
