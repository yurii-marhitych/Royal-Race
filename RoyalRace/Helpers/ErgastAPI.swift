//
//  ErgastAPI.swift
//  RoyalRace
//
//  Created by Юра Маргітич on 26.12.2021.
//

import Foundation
import Alamofire

class ErgastAPI {
    static let shared = ErgastAPI()
    
    func fetchDrivers(for season: Season, and place: Int, _ completion: @escaping ([Race]) -> Void) {
        let url = Endpoint.makeURL(for: season, and: place)
        
        ProgressHUD.show(withStatus: "Loading")
        fetch(from: url, ofType: ErgastAPIResponse.self) { response in
            guard
                let races = response.first?.ergastApiData.raceTable.races
            else { return }
            completion(races)
        }
        ProgressHUD.dismiss()
    }
    
    private func fetch<T: Decodable>(from urls: String..., ofType: T.Type, _ completion: @escaping ([T]) -> Void) {
        var values: [T] = []
        let fetchedGroup = DispatchGroup()
        urls.forEach { url in
            fetchedGroup.enter()
            AF.request(url)
                .validate()
                .responseDecodable(of: T.self) { response in
                    if let value = response.value {
                        values.append(value)
                    }
                    
                    fetchedGroup.leave()
                }
            
            fetchedGroup.notify(queue: .main) {
                completion(values)
            }
        }
    }
    
    private init() {}
}
