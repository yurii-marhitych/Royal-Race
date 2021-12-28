//
//  Driver.swift
//  RoyalRace
//
//  Created by Юра Маргітич on 28.12.2021.
//

import Foundation

// MARK: - Driver
struct Driver: Decodable, Hashable {
    // Hashable
    let id = UUID()
    
    let permanentNumber: String
    let wikiURL: String
    let firstName, lastName: String
    
    // Decodable
    enum CodingKeys: String, CodingKey {
        case permanentNumber
        case wikiURL = "url"
        case firstName = "givenName"
        case lastName = "familyName"
    }
}

// Displayable
extension Driver: Displayable {
    var title: (item1: String?, item2: String?) {
        return ("\(firstName.capitalized) \(lastName.capitalized)", permanentNumber)
    }
    
    var subtitle: (item1: String?, item2: String?) {
        return ("Paris Gran-Prix", nil)
    }
}
