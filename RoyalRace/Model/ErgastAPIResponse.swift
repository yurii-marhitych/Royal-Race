//
//  ErgastAPIResponse.swift
//  RoyalRace
//
//  Created by Юра Маргітич on 28.12.2021.
//

import Foundation

// MARK: - ErgastAPIResponse
struct ErgastAPIResponse: Decodable {
    let ergastApiData: ErgastAPIData

    enum CodingKeys: String, CodingKey {
        case ergastApiData = "MRData"
    }
    
    // MARK: - ErgastAPIData
    struct ErgastAPIData: Decodable {
        let raceTable: RaceTable

        enum CodingKeys: String, CodingKey {
            case raceTable = "RaceTable"
        }
        
        // MARK: - RaceTable
        struct RaceTable: Decodable {
            let races: [Race]

            enum CodingKeys: String, CodingKey {
                case races = "Races"
            }
        }
    }
}

