//
//  Endpoint.swift
//  RoyalRace
//
//  Created by Юра Маргітич on 28.12.2021.
//

import Foundation

struct Endpoint {
    private static let base =  "http://ergast.com/api/f1/"
    
    static func makeURL(for season: Season, and position: Position) -> String {
        var url = base
        switch season {
        case .current:
            url += "current/"
        case let .some(year):
            url += "\(year)/"
        }
        
        switch position {
        case .all:
            url += "results.json"
        case let .some(position):
            url += "results/\(position).json"
        }
        
        return url
    }
}
