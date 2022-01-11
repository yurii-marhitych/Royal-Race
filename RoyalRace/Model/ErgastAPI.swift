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
    
    func fetchRaces(for season: Season, and position: Position, _ completion: @escaping (Result<[Race], ErgastAPIError>) -> Void) {
        let url = Endpoint.makeURL(for: season, and: position)
        
        ProgressHUD.show(withStatus: "Loading")
        fetch(from: url, ofType: ErgastAPIResponse.self) { response in
            switch response {
            case .success(let response):
                guard let races = response.first?.ergastApiData.raceTable.races else {
                    return
                }
                completion(.success(races))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        ProgressHUD.dismiss()
    }
    
    private func fetch<T: Decodable>(from urls: String..., ofType: T.Type, _ completion: @escaping (Result<[T], ErgastAPIError>) -> Void) {
        var values: [T] = []
        let fetchedGroup = DispatchGroup()
        urls.forEach { url in
            fetchedGroup.enter()
            let request = AF.request(url)
                .validate()
                .responseDecodable(of: T.self) { response in
                    if let value = response.value {
                        values.append(value)
                    }
                    
                    fetchedGroup.leave()
                }
            
            fetchedGroup.notify(queue: .main) {
                if request.error != nil {
                    completion(.failure(.badInternetConnection))
                } else if values.isEmpty {
                    completion(.failure(.emptyResponse))
                } else {
                    completion(.success(values))
                }
            }
        }
    }
    
    enum ErgastAPIError: Error {
        case emptyResponse
        case badInternetConnection
    }
    
    private init() {}
}
