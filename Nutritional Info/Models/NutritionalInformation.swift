//
//  NutritionalInformation.swift
//  Nutritional Info
//
//  Created by Mohamed Fawzy on 04/07/2022.
//

import Foundation

struct NutritionalInformation: Decodable {
    let title: String
    let calories: Int
    let carbs: Float
    let protein: Float
    let fat: Float
}

extension NutritionalInformation {
    static var Default: NutritionalInformation {
        NutritionalInformation(title: "", calories: 0, carbs: 0, protein: 0, fat: 0)
    }
}
