//
//  Error.swift
//  Nutritional Info
//
//  Created by Mohamed Fawzy on 04/07/2022.
//

import Foundation

enum Error: Swift.Error, CustomStringConvertible, Equatable {
    case network
    case infoDoesntExist(id: String)
    case parsing
    case unknown
  
    var description: String {
        switch self {
        case .network:
            return "Request to API Server failed"
        case .parsing:
            return "Failed parsing response from server"
        case .infoDoesntExist(let id):
            return "Nutritional info with ID \(id) doesn't exist"
        case .unknown:
            return "An unknown error occurred"
        }
    }
}
