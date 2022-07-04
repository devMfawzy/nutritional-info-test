//
//  NutritionalInfoRepresenter.swift
//  Nutritional Info
//
//  Created by Mohamed Fawzy on 04/07/2022.
//

import Foundation

protocol NutritionalInfoRepresentable {
    var title: String { get }
    var calories: String { get }
    var carbs: String { get }
    var protein: String { get }
    var fat: String { get }
}

struct NutritionalInfoRepresenter: NutritionalInfoRepresentable {
    private static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 0
        return formatter
    }()
        
    private(set) var title: String
    private(set) var calories: String
    private(set) var carbs: String
    private(set) var protein: String
    private(set) var fat: String
    
    init(model: NutritionalInformation) {
        self.title = model.title
        self.calories = String(model.calories)
        self.carbs = NutritionalInfoRepresenter.string(from: model.carbs)
        self.protein = NutritionalInfoRepresenter.string(from: model.protein)
        self.fat = NutritionalInfoRepresenter.string(from: model.fat)
    }
    
    private static func string(from value: Float) -> String {
        NutritionalInfoRepresenter.formatter.string(from: NSNumber(value: value/100)) ?? ""
    }
    
    static var `default`: Self {
        .init(model: NutritionalInformation(title: "", calories: 0, carbs: 0, protein: 0, fat: 0))
    }
}
