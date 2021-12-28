//
//  DriverTableView.swift
//  RoyalRace
//
//  Created by Юра Маргітич on 27.12.2021.
//

import UIKit

class DriverTableView<Item: Hashable & Displayable>: UITableView {
    var indicesOfDisplayedCells: [IndexPath] = []
    private var tableDataSource: TableDataSource?
    
    var items: [Item] = [] {
        didSet {
            print(items.count)
            updateSnapshot()
        }
    }

    // Setup UI
    override func layoutSubviews() {
        super.layoutSubviews()
        setupTableViewUI()
    }
    
    // MARK: - Configure UI Methods
    private func setupTableViewUI() {
        backgroundColor = Color.background
        separatorColor = Color.tint.withAlphaComponent(0.8)
        showsVerticalScrollIndicator = false
    }
}

// MARK: - UITableViewDiffableDataSource
extension DriverTableView {
    typealias TableDataSource = UITableViewDiffableDataSource<Section, Item>
    typealias TableSnapshot = NSDiffableDataSourceSnapshot<Section, Item>
    
    // MARK: - Configure Methods
    func configureDataSource() {
        let dataSource = TableDataSource(tableView: self) { tableView, indexPath, displayableItem in
            let cell = tableView.dequeueReusableCell(withIdentifier: DriverTableViewCell.identifier, for: indexPath) as! DriverTableViewCell
            
            cell.configure(with: displayableItem)
            
            return cell
        }
        
        self.dataSource = dataSource
        self.tableDataSource = dataSource
    }
    
    private func updateSnapshot(filtered: Bool = false) {
        var snapshot = TableSnapshot()
        
        snapshot.appendSections([.all])
        snapshot.appendItems(items, toSection: .all)
        
        tableDataSource?.apply(snapshot, animatingDifferences: true)
    }
}

extension DriverTableView {
    enum Section {
        case all
    }
}
