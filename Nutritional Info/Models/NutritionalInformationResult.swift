//
//  NutritionalInformationResult.swift
//  Nutritional Info
//
//  Created by Mohamed Fawzy on 04/07/2022.
//

import Foundation

struct NutritionalInformationResult: Decodable {
    let meta: ResponseMeta
    let response: NutritionalInformation
}

struct ResponseMeta: Decodable {
    let code: Int
}
