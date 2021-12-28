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
    private let tableView = DriverTableView<Driver>()
    var winners: [Driver] = [] {
        didSet {
            tableView.items = winners
            print("Selected")
        }
    }
    
    private var selectedSeason: String?
    private var selectedPlace: String?
    
    private var seasons = (1950...2021).reversed().map { String($0) }
    private var places = (1...30).map { String($0) }
    
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
            make.edges.equalToSuperview()
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
            
            guard let season = self.selectedSeason, let place = self.selectedPlace else { return }
            self.fetchDrivers(for: season, and: place)
        }
    }
}

// MARK: - Networking
extension PreviousWinnersViewController {
    private func fetchDrivers(for season: String, and place: String) {
        let url = Endpoint.makeURL(for: season, and: place)

        showProgressHUD(withStatus: "Loading...")
        ErgastAPI.shared.fetch(from: url, ofType: ErgastAPIResponse.self) { response in
            print(response)
            guard let races = response.first?.ergastApiData.raceTable.races else { return }
            
            var winners: [Driver] = []
            races.forEach { winners.append(contentsOf: $0.results.map { $0.driver }) }
            self.winners = winners
        }
        dismissProgressHUD()
    }
}
