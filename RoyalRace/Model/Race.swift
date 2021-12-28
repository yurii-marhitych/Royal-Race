//
//  Race.swift
//  RoyalRace
//
//  Created by Юра Маргітич on 28.12.2021.
//

import Foundation

// MARK: - Race
struct Race: Decodable, Hashable {
    let id = UUID() // Hashable
    
    let season, round: String
    let wikiURL: String
    let raceName: String
    let date: String
    let results: [Result]
    
    // Decodable
    enum CodingKeys: String, CodingKey {
        case season, round, raceName, date
        case wikiURL = "url"
        case results = "Results"
    }
}

// Displayable
extension Race: Displayable {
    var title: (item1: String?, item2: String?) {
        return ("\(season) - \(round)", nil)
    }
    
    var subtitle: (item1: String?, item2: String?) {
        return (raceName.capitalized, date)
    }
}
