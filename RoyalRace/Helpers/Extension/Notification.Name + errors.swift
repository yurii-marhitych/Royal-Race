//
//  Notification.Name.swift
//  RoyalRace
//
//  Created by Юра Маргітич on 11.01.2022.
//

import UIKit

// MARK: - Notification.Name
extension Notification.Name {
    static var emptyCurrentResponse: Notification.Name {
        return .init(rawValue: "Response.empty.Current")
    }
    
    static var emptyPreviousResponse: Notification.Name {
        return .init(rawValue: "Response.empty.Previous")
    }
    
    static var badInternetConnectionCurrent: Notification.Name {
        return .init(rawValue: "Internet.Connection.Bad.Current")
    }
    
    static var badInternetConnectionPrevious: Notification.Name {
        return .init(rawValue: "Internet.Connection.Bad.Previous")
    }
}
