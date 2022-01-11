//
//  RaceDetailsViewController.swift
//  RoyalRace
//
//  Created by Юра Маргітич on 26.12.2021.
//

import UIKit

class RaceDetailsViewController: UIViewController {
    var currentRace: Race?
 
    var races: [Race] = [] {
        didSet {
            
            var drivers: [Driver] = []
            races
                .forEach { race in
                    race.results.forEach { result in
                        let driver = result.driver
                        driver.time = result.fastestLap?.time.value ?? "(No time)"
                        driver.position = Int(result.position)
                        drivers.append(driver)
                    }
                }
            drivers.forEach {
                $0.race = currentRace
            }

            self.drivers = drivers
        }
    }
    
    private var drivers: [Driver] = [] {
        didSet {
            resultTableView.items = drivers.sorted { $0.position ?? 0 < $1.position ?? 0 }
        }
    }
    
    // table views
    private let staticTableView = UITableView()
    private let resultTableView = DriverTableView<Driver>()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        
        setupStaticTableView()
        setupTableView()
        setupBackButton()
        
        resultTableView.backgroundColor = .red
    }
    
    // MARK: - Configure UI Methods
    private func setupStaticTableView() {
        self.view.addSubview(staticTableView)
        staticTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(80)
            make.height.equalTo(120)
        }
        
        DriverTableViewCell.register(for: staticTableView)
        
        staticTableView.dataSource = self
        staticTableView.delegate = self
        staticTableView.backgroundColor = Color.background
        staticTableView.separatorColor = Color.tint
        staticTableView.isScrollEnabled = false
    }
    
    private func setupTableView() {
        self.view.addSubview(resultTableView)
        resultTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(staticTableView.snp.bottom).offset(16)
            make.bottom.equalToSuperview().offset(-80)
        }
        
        DriverTableViewCell.register(for: resultTableView)
        resultTableView.configureDataSource()
        resultTableView.items = drivers
        resultTableView.delegate = self
    }
}
