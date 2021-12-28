//
//  + UITableViewDelegate.swift
//  RoyalRace
//
//  Created by Юра Маргітич on 27.12.2021.
//

import UIKit

// MARK: - UITableViewDelegate
extension PreviousWinnersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableView = tableView as? DriverTableView<Driver>,
              !tableView.indicesOfDisplayedCells.contains(indexPath) else { return }
        // fly-in animation
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 100, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0.6
        
        UIView.animate(withDuration: 0.5) {
            cell.alpha = 1
            cell.layer.transform = CATransform3DIdentity
        }
        
        tableView.indicesOfDisplayedCells.append(indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
