//
//  RaceDetailsViewController.swift
//  RoyalRace
//
//  Created by Юра Маргітич on 26.12.2021.
//

import UIKit

class RaceDetailsViewController: UIViewController {
    var race: Race?
    
    var drivers: [Driver] = [] {
        didSet {
            resultTableView.items = drivers
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
        
        if let race = race {
            drivers = race.results.map { $0.driver }
        }
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
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(staticTableView.snp.bottom).offset(16)
        }
        
        DriverTableViewCell.register(for: resultTableView)
        resultTableView.configureDataSource()
        resultTableView.items = drivers
        resultTableView.delegate = self
    }
}
