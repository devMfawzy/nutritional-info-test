//
//  NutritionalInfoService.swift
//  Nutritional Info
//
//  Created by Mohamed Fawzy on 04/07/2022.
//

import Foundation
import Combine

fileprivate struct API {
    static let url: String = "https://api.lifesum.com/v2/foodipedia/codetest?foodid="
}

protocol NutritionalInfoServiceProtocol {
    func nutritionalInformation(_ foodId: Int) -> AnyPublisher<NutritionalInformationResult, Error>
}

struct NutritionalInfoService: NutritionalInfoServiceProtocol {
    func nutritionalInformation(_ foodId: Int) -> AnyPublisher<NutritionalInformationResult, Error> {
        let url = URL(string: "\(API.url)\(foodId)")
        return URLSession.shared
            .dataTaskPublisher(for: url!)
            .map(\.data)
            .decode(type: NutritionalInformationResult.self, decoder: JSONDecoder())
            .mapError { error -> Error in
                switch error {
                case is URLError:
                    return .network
                default:
                    return .unknown
              }
            }
            .eraseToAnyPublisher()
    }
}
