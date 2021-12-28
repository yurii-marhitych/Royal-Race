//
//  DriverTableViewCell.swift
//  RoyalRace
//
//  Created by Юра Маргітич on 27.12.2021.
//

import UIKit
import SnapKit

class DriverTableViewCell: UITableViewCell {
    static let identifier = "DriverCellIdentifier"
    
    private var titleLabel1 = UILabel(withText: "", ofSize: 22, style: .medium)
    private var titleLabel2 = UILabel(withText: "", ofSize: 18, style: .demiBold)
    private var subtitleLabel1 = UILabel(withText: "", ofSize: 20, style: .ultraLight)
    private var subtitleLabel2 = UILabel(withText: "", ofSize: 20, style: .ultraLight)
    
    // Setup UI
    override func layoutSubviews() {
        super.layoutSubviews()
        setupCellUI()
        setupConstraintsForLabels()
    }
    
    // MARK: - Configure Methods
    func configure(with displayable: Displayable) {
        titleLabel1.text = displayable.title.item1
        titleLabel2.text = displayable.title.item2
        subtitleLabel1.text = displayable.subtitle.item1
        subtitleLabel2.text = displayable.subtitle.item2
    }
    
    // configure UI
    private func setupCellUI() {
        accessoryType = .disclosureIndicator
        backgroundColor = .clear
    }
    
    private func setupConstraintsForLabels() {
        // titleLabel1
        contentView.addSubview(titleLabel1)
        titleLabel1.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalTo(contentView.snp.centerY)
            make.height.equalToSuperview().multipliedBy(0.4)
        }
        // titleLabel2
        contentView.addSubview(titleLabel2)
        
        titleLabel2.textColor = .systemGray
        
        titleLabel2.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel1.snp.trailing).offset(8)
            make.centerY.equalTo(titleLabel1)
            make.height.equalTo(titleLabel1)
        }
        
        // subtitleLabel1
        contentView.addSubview(subtitleLabel1)
        subtitleLabel1.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(contentView.snp.centerY)
            make.height.equalToSuperview().multipliedBy(0.4)
        }
        // subtitleLabel1
        contentView.addSubview(subtitleLabel2)
        subtitleLabel2.snp.makeConstraints { make in
            make.leading.equalTo(subtitleLabel1.snp.trailing).offset(8)
            make.centerY.equalTo(subtitleLabel1)
            make.height.equalTo(subtitleLabel1)
        }
    }

    // Register Cell with reusable Identifier for table view
    static func register(for tableView: UITableView) {
        tableView.register(DriverTableViewCell.self, forCellReuseIdentifier: Self.identifier)
    }
}
