//
//  Endpoint.swift
//  RoyalRace
//
//  Created by Юра Маргітич on 28.12.2021.
//

import Foundation

struct Endpoint {
    private static let base =  "http://ergast.com/api/f1"
    
    static func makeURL(for season: String, and place: String) -> String {
        return String(format: "%@/%@/results/%@.json", base, season, place)
    }
}
