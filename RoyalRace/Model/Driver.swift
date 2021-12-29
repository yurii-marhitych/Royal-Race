//
//  Driver.swift
//  RoyalRace
//
//  Created by Юра Маргітич on 28.12.2021.
//

import Foundation

// MARK: - Driver
class Driver: Decodable, Hashable {
    let id = UUID() // Hashable
    
    let permanentNumber: String
    let wikiURL: String
    let firstName, lastName: String
    
    var race: Race?
    
    // Decodable
    enum CodingKeys: String, CodingKey {
        case permanentNumber
        case wikiURL = "url"
        case firstName = "givenName"
        case lastName = "familyName"
    }
    
    static func == (lhs: Driver, rhs: Driver) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(race)
    }
}

// Displayable
extension Driver: Displayable {
    var title: (item1: String?, item2: String?) {
        return ("\(firstName.capitalized) \(lastName.capitalized)", permanentNumber)
    }
    
    var subtitle: (item1: String?, item2: String?) {
        return (race?.raceName ?? "", nil)
    }
}
