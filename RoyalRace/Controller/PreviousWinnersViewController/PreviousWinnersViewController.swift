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
    
    // MARK: - UI Elements
    private let seasonPicker = UIBarPickerView(width: 50, height: 20, placeholder: "season")
    private let positionPicker = UIBarPickerView(width: 50, height: 20, placeholder: "position")
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Previous Winners"
     
        setupPickers()
        setupTableView()
        
        // NotificationCenter Observers
        NotificationCenter.default.addObserver(self, selector: #selector(emptyResponse), name: .emptyPreviousResponse, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(badInternetConnection), name: .badInternetConnectionPrevious, object: nil)
    }
    
    // deinit
    deinit {
        NotificationCenter.default.removeObserver(self, name: .emptyPreviousResponse, object: nil)
        NotificationCenter.default.removeObserver(self, name: .badInternetConnectionPrevious, object: nil)
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
        positionPicker.didSelect { [weak self] place, _, _ in
            guard let someSelf = self else { return }
            someSelf.selectedPosition = Int(place)
            
            guard
                let season = someSelf.selectedSeason,
                let position = someSelf.selectedPosition
            else { return }
            
            ErgastAPI.shared.fetchRaces(for: .some(season), and: .some(position)) { [weak self] result in
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
                        NotificationCenter.default.post(name: .emptyPreviousResponse, object: nil)
                    } else if error == .badInternetConnection {
                        NotificationCenter.default.post(name: .badInternetConnectionPrevious, object: nil)
                    }
                }
            }
        }
    }
}
