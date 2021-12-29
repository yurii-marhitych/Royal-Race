//
//  Result.swift
//  RoyalRace
//
//  Created by Юра Маргітич on 28.12.2021.
//

import Foundation

// MARK: - Result
struct Result: Decodable, Hashable {
    let id = UUID() // Hashable
    
    let number, position: String
    let driver: Driver
    let fastestLap: FastestLap?
    
    // Decodable
    enum CodingKeys: String, CodingKey {
        case number, position
        case driver = "Driver"
        case fastestLap = "FastestLap"
    }
    
    // MARK: - FasterLap
    struct FastestLap: Decodable, Hashable {
        let id = UUID()
        let time: ResultTime
        
        // Decodable
        enum CodingKeys: String, CodingKey {
            case time =  "Time"
        }
    }
    
    // MARK: - ResultTime
    struct ResultTime: Decodable, Hashable {
        let id = UUID() // Hashable
        let value: String
        
        // Decodable
        enum CodingKeys: String, CodingKey {
            case value = "time"
        }
    }
}
