//
//  Endpoint.swift
//  RoyalRace
//
//  Created by Юра Маргітич on 28.12.2021.
//

import Foundation

struct Endpoint {
    private static let base =  "http://ergast.com/api/f1"
    
    static func makeURL(for season: Season, and place: Int) -> String {
        let seasonStr: String
        switch season {
        case .current:
            seasonStr = "current"
        case let .year(year):
            seasonStr = "\(year)"
        }
        
        return String(format: "%@/%@/results/%d.json", base, seasonStr, place)
    }
}
